From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 08 Feb 2010 16:23:55 -0800
Message-ID: <7veikv2r50.fsf@alter.siamese.dyndns.org>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nedtl-0003rv-Ko
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab0BIAYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:24:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0BIAYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:24:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EDB698E67;
	Mon,  8 Feb 2010 19:24:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FA67IaWb4WTBkjR+4uMzc6b76JI=; b=wEUUTh
	2BdK02LD0UMcSI0uztApOj5UgUIaGhXpz3+CySqnK6+Qh9x5jFntwXAYFin1JdfK
	o5aiA6dbI+Q6FX3/9Tn/KMfq6EzShDot9Jrsz14IeIP2x5CIu/6deU76f+8peD3r
	NqOmH+07QS0p1FiD1YhSCA1w4oTWwXC5Yqvcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o3K90xSZhaT4TWciwS8gxE/ZaEKLOmvz
	LRZi+a4UtTwiiNwl2ZnQCGf6iupRajqsiVpnnp09qC+2gYeUjRKKSI0/X6OLVILs
	QHtj1eQ/pjotTHMXHtj1rn9kUaWUnnhNyj2c+fSNVt/aiZtYULgUf1J5Qkk39Ywa
	NJozIxNjMhU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7318C98E63;
	Mon,  8 Feb 2010 19:24:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C1E698E62; Mon,  8 Feb
 2010 19:23:57 -0500 (EST)
In-Reply-To: <1265672654-26511-1-git-send-email-larry@elder-gods.org> (Larry
 D'Anna's message of "Mon\,  8 Feb 2010 18\:44\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B4F0A7A-1511-11DF-9CFC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139339>

Larry D'Anna <larry@elder-gods.org> writes:

> git-push prints a flag indicating the status of each ref that was pushed, or
> attempted to be pushed.  The documentation did not correctly list all of the
> possible flags.
> ---

Thanks.

I assume it is Ok to copy your sign-off from your other messages ;-)

> @@ -176,12 +176,17 @@ If --porcelain is used, then each line of the output is of the form:
>   <flag> \t <from>:<to> \t <summary> (<reason>)
>  -------------------------------
>  
> +The status of up to date refs is shown only if --porcelain or --verbose is used.
> +
>  flag::
>  	A single character indicating the status of the ref. This is
> -	blank for a successfully pushed ref, `!` for a ref that was
> -	rejected or failed to push, and '=' for a ref that was up to
> -	date and did not need pushing (note that the status of up to
> -	date refs is shown only when `git push` is running verbosely).
> +[horizontal]
> +	" " (space)::: for a successfully pushed fast-forward

Both [horizontal] and three colons are something we never have used in the
existing documentation set.  How confident are you that various versions
of deployed AsciiDoc people would use all support this?

I am not _complaining_; I am just being cautious to see if I have to look
into the issue myself (if your answer is "not at all") or not (otherwise).

> +	"+"::: for a successful forced update
> +	"-"::: for a successfully deleted ref
> +	"*"::: for a successfully pushed new ref
> +	"!"::: for a ref that was rejected or failed to push
> +	"="::: for a ref that was up to date and did not need pushing
