From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Wed, 10 Feb 2016 09:35:46 -0800
Message-ID: <xmqqpow4zcwd.fsf@gitster.mtv.corp.google.com>
References: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
	<alpine.DEB.2.20.1602061708220.2964@virtualbox>
	<CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
	<32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
	<CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
	<20160208141552.GC27054@sigill.intra.peff.net>
	<20160208150709.GA13664@sigill.intra.peff.net>
	<xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
	<20160208195230.GA30693@sigill.intra.peff.net>
	<xmqqziv939ir.fsf@gitster.mtv.corp.google.com>
	<20160210161548.GC19867@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:35:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTYgJ-0006EY-4x
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 18:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbcBJRfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 12:35:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751961AbcBJRfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 12:35:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FEDA4360C;
	Wed, 10 Feb 2016 12:35:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jj2SxtkbxMdIbr0ZJOfOnKow7EI=; b=NSXZpO
	Pwittk9T7Jc42T4uLEz8xhjuRWyLvheqpA4DD0LzRVwrkZzb1xPLpXNsBXTn55h1
	euKFsQdK1bZPz0ft+griX8ATmbj76pZmT+DG/jbvxOmVIBT4RNjG2mAq0RNv2SqQ
	GdFVs4tMJ6kzGLN00DQfbuYMI5vgdqHaRINuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I1jdrk1sIvM34X4C3kYSOOc7H6c7o2JO
	f1jAtfHPysscB3ULBDzrYJeDx/OcGZORpr1TcokmzUakZ7AFrasqdlJ9Z71YIs4h
	fTcXj8TW89It5L3ROjN65TnLFMTrVA9AamO0gDgWKnORlovQYTJeVjxe2vJwLhLz
	Op5XrMz4yV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D6E84360B;
	Wed, 10 Feb 2016 12:35:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2E9F4360A;
	Wed, 10 Feb 2016 12:35:47 -0500 (EST)
In-Reply-To: <20160210161548.GC19867@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Feb 2016 11:15:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8900EDE-D01C-11E5-B042-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285916>

Jeff King <peff@peff.net> writes:

> Yes, because ":/" is treated specially in check_filename(), and avoids
> kicking in the wildcard behavior. That is certainly preferring revs to
> pathspecs, but I think preferring one over the other is preferable to
> barfing. If the user wants carefulness, they should use "--"
> unconditionally. If they want to DWIM, we should make it as painless as
> possible, even if we sometimes guess wrong.

OK, I think that is sensible.

> But I have a feeling from what you've written that you do not agree with
> the "err and allow something possibly ambiguous" philosophy.

Not anymore ;-)

>> I actually think that no_wildcard() check added in check_filename()
>> was the original mistake.  If we revert the check_filename() to a
>> simple "Is this a filename?" and move the "does this thing have a
>> wildcard" aka "can this be a pathspec even when check_filename()
>> says there is no file with that exact name?" to the code that tries
>> to allow users omit "--", i.e. the caller of check_filename(), would
>> that make the code structure and the semantics much cleaner, I
>> wonder...
>
> Yes. After writing the above, I was envisioning pushing the "err on this
> side" logic into check_filename() with a flag. The main callers are
> verify_filename() and verify_non_filename(), and they would use opposite
> flags from each other.  But pulling that logic out to the caller would
> be fine, too.
>
> IOW, something like this implements the "permissive" thing I wrote above
> (i.e., be inclusive when seeing if something could plausibly be a
> filename, but exclusive when complaining that it _could_ be one):

Yup, I think that is probably a better first step.

> diff --git a/setup.c b/setup.c
> index 2c4b22c..995e924 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -139,9 +139,7 @@ int check_filename(const char *prefix, const char *arg)
>  		if (arg[2] == '\0') /* ":/" is root dir, always exists */
>  			return 1;
>  		name = arg + 2;
> -	} else if (!no_wildcard(arg))
> -		return 1;
> -	else if (prefix)
> +	} else if (prefix)
>  		name = prefix_filename(prefix, strlen(prefix), arg);
>  	else
>  		name = arg;
> @@ -202,7 +200,7 @@ void verify_filename(const char *prefix,
>  {
>  	if (*arg == '-')
>  		die("bad flag '%s' used after filename", arg);
> -	if (check_filename(prefix, arg))
> +	if (check_filename(prefix, arg) || !no_wildcard(arg))
>  		return;
>  	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
>  }
