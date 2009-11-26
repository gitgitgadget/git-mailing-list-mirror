From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] builtin-merge.c: call exclude_cmds() correctly.
Date: Wed, 25 Nov 2009 21:36:01 -0800
Message-ID: <7vpr75hmpq.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 06:36:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDX1e-0006cx-59
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 06:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbZKZFgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 00:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbZKZFgE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 00:36:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZKZFgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 00:36:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 181F6A1996;
	Thu, 26 Nov 2009 00:36:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ekU4KA5d5ZIERC6ANrDoiMmqS0=; b=MPZb2Z
	WJttFgpJgCyTexn8JvcTWbFOvPSkUQXC0Ph5+5kEO25PDg3zLw6yvbR826PuWX67
	uJ2EZy16zMNYTQoTl6NnNDihNf+zi77KaKBxkB962ou2jcEcpJAGz4BKk8vVnol3
	G7V+Fx6TSbJVV1hVgnnd81jOJ26P6tLK6/3lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Av9gA4+G3BJyqGAAKVxtZsJ4bakC+9Ta
	Du2+9/6Q9t70a38TpRaYnWDaxizdZ1pIMthHYvKH0elnh9zzpJGjGQ6onzJK5ut5
	JohVj0h9euPQI8sD+qMB+M0j+l2WzEvVb4T0blJAVbvNLNj3eVtwNdTTumxp/y0L
	1V/SUhuFFhI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAFEAA1995;
	Thu, 26 Nov 2009 00:36:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08CF1A1994; Thu, 26 Nov 2009
 00:36:02 -0500 (EST)
In-Reply-To: <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 (Avery Pennarun's message of "Wed\, 25 Nov 2009 21\:23\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97A4FD0E-DA4D-11DE-A8ED-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133764>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> We need to call exclude_cmds() after the loop, not during the loop, because
> excluding a command from the array can change the indexes of objects in the
> array.  The result is that, depending on file ordering, some commands
> weren't excluded as they should have been.

As an independent bugfix, I would prefer this to be made against 'maint'
and not as a part of this series.

How did you notice it?  Can you make a test case out of your experience of
noticing this bug in the first place, by the way (I am suspecting that you
saw some breakage and chased it in the debugger)?
