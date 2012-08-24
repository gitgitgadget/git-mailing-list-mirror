From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: GnomeKeyring support + generic helper
 implementation
Date: Fri, 24 Aug 2012 11:15:36 -0700
Message-ID: <7vfw7cyx4n.fsf@alter.siamese.dyndns.org>
References: <1345741068-11004-1-git-send-email-pah@qo.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: "Philipp A. Hartmann" <pah@qo.cx>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4yQ6-0001ty-4i
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 20:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab2HXSPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 14:15:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323Ab2HXSPj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 14:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E18F8AFB;
	Fri, 24 Aug 2012 14:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=GZxZIwHi2Qq7MBYQAxo6QINwEO0=; b=Z+bpYOIquEhAb0AUer6c
	+oLIXS72dX077qdyziZnesC149kEuAYjn9STgTy6owKcEcLFn//kz/zbCh/Sj7wa
	Fi2PECIH+64zsk8xYRgn1II+/n8mRfa4v2qF+uaDxS083cyGN2VP45T4HFze8gK+
	8BpHTwgM5vhi05zKnOw1BZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Wnvav6wF5JvBHWCKAMO6A9ZSXzXJGfHK8Q3u6/LlZnmhZR
	k02N7rMcqA3iGba6evIL8nzaI20DRD/1zwYX/CZm6za1FiabFh+heN7yfPsvqFs6
	W5EFwCX0jPMXE3WFiFRRx6iXW+7W7UnkE0JMv6LvWfjm6wxm7TQBeQPQUUlQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A4258AFA;
	Fri, 24 Aug 2012 14:15:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DDD98AF9; Fri, 24 Aug 2012
 14:15:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B46D4B40-EE17-11E1-B4FF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204224>

"Philipp A. Hartmann" <pah@qo.cx> writes:

> All,
>
> the following patch series proposes enhancements to the credential helper
> implementations in the contrib section.  The detailed development history
> can be found at GitHub [1].
>
>   The first patch adds a GnomeKeyring credential backend.  The GnomeKeyring
> specific parts are based on the work by John Szakmeister, who wrote the
> helper originally for the initial, unpublished version of the credential
> helper protocol.
>
>   The second patch adds a generic implementation of a credential helper
> based on a simplified credential API and common helper functions.  Helpers
> based on this implementation do not need to worry about the credential
> protocol and only need to implement callback functions for the different
> credential operations.
>
>   The third and fourth patches port the existing helpers to this generic
> implementation.
>
> Looking forward to your thoughts.

It struck me somewhat odd to see a new one added as the first step
in the series, and then "the generic", the third patch only to lose
code from the first one, and then use the same code reduction of
existing one with the last one in the series.  A natural progression
would have been the introduction of generic infrastructure
(including the tiny bit this series had to add as part of 4/4) as
the first patch, update existing OSX one to it as the second, and
then build a new Gnome one on the infrastructure as the third and
final patch; that way we have to review less code, too ;-).

I gave it a cursory look; other than getting distracted by
inconsistent coding styles here and there, the patches seemed
reasonably clean and well thought out.

Thanks.
