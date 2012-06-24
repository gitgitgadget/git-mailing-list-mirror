From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] Extending the shelf-life of "git describe" output
Date: Sat, 23 Jun 2012 22:30:03 -0700
Message-ID: <7vk3yxjmzo.fsf@alter.siamese.dyndns.org>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <simpkins@facebook.com>,
	Allan Caffee <allan.caffee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 07:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SifOo-0006ML-PU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 07:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab2FXFaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 01:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56921 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab2FXFaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 01:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADCEF9A98;
	Sun, 24 Jun 2012 01:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hQrk7HtbBa5QHW5TG6dukQXjLVo=; b=EoJrlQ
	len/0wDZniPNBddxtZSJcSlNYfeuStAesTBJ+ey/f19xqLuMJ0wv7ZX4Q1ZKNFGW
	6c/i1lAy0TgYYFPVP7MJ5URg2TO8/As5gfn0lu4K7VVe9ixkrk3me/NuOJWqZibx
	BJRL7OjN+fqr3dyPBqFHY9F3yO9t4TKTmTvx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZlEhqLIDI0vohGwinlh1a1dZwjW1adm
	DCgAedzKFeNlIIm6iBtb4SxeE4VzErlUCYjzHvWtI93CIKPPSp9beFi/xUPC17kn
	tPQaZw5ubPI8E2tbYs/sNnz7uR7CMsEPV1R9rVP6ZT56gyx+uc8jOTqIp6b3m4ip
	icK1eWwFwDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A35169A97;
	Sun, 24 Jun 2012 01:30:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39BD89A96; Sun, 24 Jun 2012
 01:30:05 -0400 (EDT)
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sat, 23 Jun 2012 17:11:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A761C384-BDBD-11E1-95BC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200516>

Junio C Hamano <gitster@pobox.com> writes:

> This is take 3.  The earlier rounds were $gmane/200165 and 200387.
>
> Only the [9/9] is different.  It adds a test that creates a history
> with many objects whose names share the same prefix, and tries to
> check how the implementation employs various possible
> disambiguations, e.g.

By the way, I noticed that "log --graph" is horribly broken when
used with "-p -m" to show a history with a merge.  For example, try
running the following:

	$ cd t
        $ sh t1512-rev-parse-disambiguation.sh -d
        $ cd tras*tory.t1512-*tion/
        $ git log --oneline -p -m -M

and then run the last one with "--graph":

	$ git log --oneline -p -m -M --graph

Two people who worked heavily on the --graph option in the past
CC'ed.
