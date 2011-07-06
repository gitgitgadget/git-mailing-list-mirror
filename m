From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Wed, 06 Jul 2011 16:25:20 -0700
Message-ID: <7vei23htzz.fsf@alter.siamese.dyndns.org>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
 <4E144B55.8020907@elegosoft.com>
 <20110706175803.GB17978@sigill.intra.peff.net>
 <20110706180026.GC17978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 07 01:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QebTD-0006jh-TM
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1GFXZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 19:25:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1GFXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 19:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 933AF56C2;
	Wed,  6 Jul 2011 19:25:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zAuC78jf5s7PPR6X3TJQWqY1sCA=; b=pVWkQ/
	BBD71nfgcof37uF4OpPUUDDMMR30NxRvVFf7OLl/AMGFQBdiDlBhxofqS+2pcmIo
	yPhQqlGa1j2vDQlBMNNpzjhXAYJjUBZoGRpIWc4HiR6iS4RxMddqM5pDPGf6VqB6
	330AbTJNUDReI/YUchU59c60fIhkHCJ/fx53Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5xp3AyDtlJZUKeMBqv0HWeCUAcYV3nd
	WeKFoIKzIqjV/v+2pdqk0+5T6Q4d7sUhMvMGUgciHH6wkTbxhI6J3HpeJFEdzOdn
	GZ8ugzvqNu/pkKRVX5cF2r1o41KfnT1YZUJcrpoMrvvKrDn0YJYHWmJytXHnZgG/
	QsYHCeK8kDg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D30156C1;
	Wed,  6 Jul 2011 19:25:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E77CC56C0; Wed,  6 Jul 2011
 19:25:21 -0400 (EDT)
In-Reply-To: <20110706180026.GC17978@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Jul 2011 14:00:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 381A9F16-A827-11E0-8589-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176736>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 06, 2011 at 01:58:03PM -0400, Jeff King wrote:
>
>> > Like this? I've replaced "Check the #!-line of the git-%s script." with
>> > "Maybe git-%s is broken?" to be less technical and specific..
>> 
>> Yeah, looks good to me (unless somebody wants to do something more
>> elaborate to catch other exec problems, but I personally don't think
>> it's worth the effort).
>
> One minor nit, though. I haven't been paying attention to the progress
> of the gettext topics, but should this message:
>
>> +static const char bad_interpreter_advice[] =
>> +	"'%s' appears to be a git command, but we were not\n"
>> +	"able to execute it. Maybe git-%s is broken?";
>
> Actually be inside _() for gettext?

I would mark it with N_() and then the calling site inside die() with _()
if I were doing this.
