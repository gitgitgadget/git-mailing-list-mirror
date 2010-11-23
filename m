From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Tue, 23 Nov 2010 12:14:30 -0800
Message-ID: <7vfwurvluh.fsf@alter.siamese.dyndns.org>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <vpqoc9hsemy.fsf@bauges.imag.fr> <201011221414.15982.trast@student.ethz.ch>
 <vpq8w0lqyf7.fsf@bauges.imag.fr> <alpine.DEB.1.10.1011222103290.17721@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:14:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzGM-0007ub-03
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab0KWUOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:14:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0KWUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:14:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95A3023DB;
	Tue, 23 Nov 2010 15:14:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UED+MXtd5dVrJ3vu4Y7akzSQvKw=; b=u6qM6p
	1Ic4De44dpR0M3lEe5uoOkmKhp+EInQL/FC5m7JVz2+Y7f13t9miCqhT0/XsGW8S
	XDvj+fa8+2CHC2i+3p4bv29WxTiFB8aD36q8JYpeLT5pcTno4OUvriKAyhLsXal1
	rQ3QT4dQ0n/7LssvgOSWh5DnTvUTaY0FibmUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YiygrhIReyuizON5ioHJoOU8xtSruUa6
	7ToNQSq4yeQ85+uUA7yMMg1Ik2upxSnY72zPxJwOShhCixcNuupQHLd61RqTUozr
	47qspbQnWXgZ5JvOgl/aqO6H8odxxhKsGiPw9+JvVfX1m1wW+6SgN4XAe4O4Sc47
	m6MSkOUpLsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5597523D9;
	Tue, 23 Nov 2010 15:14:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6F22123C9; Tue, 23 Nov 2010
 15:14:46 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.1011222103290.17721@debian> (Martin von
 Zweigbergk's message of "Mon\, 22 Nov 2010 21\:21\:01 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5527C308-F73E-11DF-8BAD-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162021>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> (I hope this is the correct way of including a patch. I have only used
> 'git send-email before'. I noticed that Jeff seems to remove the first
> three lines and put a '-- 8> --' before, but others do not. What does
> the mysterious header mean?)
> -- >8 --
> Subject: [PATCH] rebase: support --verify
>
> Interactive rebase allows the '--verify' option to be passed, but it will
> be ignored. Implement proper support for the option for both interactive
> and non-interactive rebase by making it override any previous
> '--no-verify'.
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

Sounds like a sane thing to do.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f3753a8..1f5ce74 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -279,6 +279,10 @@ which makes little sense.
>   --no-verify::
>   	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5].
>
> +--verify::
> +	Allows the pre-rebase hook to run, which is the default.  This option can
> +	be used to override --no-verify.  See also linkgit:githooks[5].
> +
>   -C<n>::
>   	Ensure at least <n> lines of surrounding context match before
>   	and after each change.  When fewer lines of surrounding
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a27952d..4eabe54 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -28,6 +28,7 @@ continue           continue rebasing process
>   abort              abort rebasing process and restore original branch
>   skip               skip current patch and continue rebasing process
>   no-verify          override pre-rebase hook from stopping the operation
> +verify             allow pre-rebase hook to run

Somehow this patch seems severely whitespace mangled---please check your
MUA.  I think I've seen Alpine send patches sanely; there should be a way
to tell it to behave.

No need to resend; I can unmunge this patch by hand.
