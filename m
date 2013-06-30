From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Sun, 30 Jun 2013 12:50:41 -0700
Message-ID: <7v4ncfjs32.fsf@alter.siamese.dyndns.org>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de>
	<51C8BF2C.2050203@ramsay1.demon.co.uk>
	<7vy59y4w3r.fsf@alter.siamese.dyndns.org>
	<51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk>
	<20130626223552.GA12785@sigill.intra.peff.net>
	<51CBD2FD.5070905@alum.mit.edu> <51CCC643.1050702@ramsay1.demon.co.uk>
	<51D06AC8.70206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtNe5-0004Tp-5w
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab3F3Tup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 15:50:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab3F3Tuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:50:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E818F2C7A7;
	Sun, 30 Jun 2013 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uDlOk828Oo70TiA38KqEpB5fWtU=; b=efE92l
	097+IO4yJch5IQTOsJzyweUrBbyz6nev/C9XA7HK8cT/i2YXQUTkq6UeZPZmBewL
	ekOooTnA7yqVC5FVQK/zBmLdnAs83lY7NXDQYgK0s017/fQpPkm5TGVJ8O9fXPs4
	93VMd9f7ZAsFR6AHGUDEAqq4lM6ti+6j3k7GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YyXveUC0MtzTgxyHBHZqzSIvlV7EqytP
	0YELYIwXbyut2BEvvWQiyadQLLvPIEY2Jne5OGe45RlpWRYZq/L7GMooBgfjR7dc
	xPMgpunovqvSagfaAY/coNK5dxgXPlDx552tQpImK0KsArQXcgz71D+N5EmBYE8K
	g8TdCDNHvL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC5142C7A6;
	Sun, 30 Jun 2013 19:50:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F1D82C7A5;
	Sun, 30 Jun 2013 19:50:43 +0000 (UTC)
In-Reply-To: <51D06AC8.70206@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sun, 30 Jun 2013 18:28:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59581410-E1BE-11E2-A85D-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229288>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Ramsay Jones wrote:
>> Michael Haggerty wrote:
>>> On 06/27/2013 12:35 AM, Jeff King wrote:
>> [ ... ]
>>>> I think Michael's assessment above is missing one thing.
>>>
>>> Peff is absolutely right; for some unknown reason I was thinking of the
>>> consistency check as having been already fixed.
>> 
>> Well, the "cygwin: Remove the Win32 l/stat() functions" patch *does* fix
>> the problem. :-D It's just a pity we can't use it on performance grounds. :(
>> 
>>>> [...#ifdef out consistency check on cygwin when lock is held...]
>>>
>>> Yes, this would work.
>>>
>>> But, taking a step back, I think it is a bad idea to have an unreliable
>>> stat() masquerading as a real stat().  If we want to allow the use of an
>>> unreliable stat for certain purposes, let's have two stat() interfaces:
>>>
>>> * the true stat() (in this case I guess cygwin's slow-but-correct
>>> implementation)
>>>
>>> * some fast_but_maybe_unreliable_stat(), which would map to stat() on
>>> most platforms but might map to the Windows stat() on cygwin when so
>>> configured.
>>>
>>> By default the true stat() would always be used.  It should have to be a
>>> conscious decision, taken only in specific, vetted scenarios, to use the
>>> unreliable stat.
>>  ...

I like the part that gets rid of that "get-mode-bits" but at the
same time, I find this part wanting a reasonable in-code comment.

At least, with the earlier get-mode-bits, it was clear why we are
doing something special in that codepath, both from the name of the
helper function/macro and the comment attached to it describing how
the "regular" one is cheating.

We must say why this "fast" is not used everywhere and what criteria
you should apply when deciding to use it (or not use it).  And the
"fast" name is much less descriptive.

I suspect (without thinking it through) that the rule would be
something like:

    The "fast" variant is to be used to read from the filesystem the
    "stat" bits that are stuffed into the index for quick "touch
    detection" (aka "cached stat info") and/or that are compared
    with the cached stat info, and should not be used anywhere else.

But then we always use lstat(2) and not stat(2) for that, so...

> +#ifndef GIT_FAST_STAT
> +static inline int fast_stat(const char *path, struct stat *st)
> +{
> +	return stat(path, st);
> +}
> +static inline int fast_lstat(const char *path, struct stat *st)
> +{
> +	return lstat(path, st);
> +}
> +#endif
