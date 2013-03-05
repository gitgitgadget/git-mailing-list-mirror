From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.zsh: define __gitcomp_file compatibility
 function
Date: Tue, 05 Mar 2013 08:54:40 -0800
Message-ID: <7vzjyhu6r3.fsf@alter.siamese.dyndns.org>
References: <vpqtxowp9e2.fsf@grenoble-inp.fr>
 <1362473035-5034-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	manlio.perillo@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCv8w-0000bl-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3CEQyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:54:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291Ab3CEQyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:54:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5B16A34F;
	Tue,  5 Mar 2013 11:54:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XmfBZFcfNz7qnPU7WOuy5yQaYA0=; b=Q/HlCr
	hRsjvmMyO/CpqNZ4hVmEa0ZXBHAvV9aEIC0z334amxDbgjRotDJOWyz6eJY5Q2ok
	W2mk3FGJ/69yxZUv/FtpMCyOxswEaFwfZIm2nxW2JmQCG5fHFf4guvir3UV+fmmP
	12YwmvoHrB7mcQQ+0Shn9zTQY8xuSBN325ZVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U0mjW4KdgAqQ+dYZCAV3mmlAOjRNyZfu
	+l70Mqa0LeP1flve+M2CU5qy36iatoG0FPtqsXzkEPP+WwEGndyHzdd6IQRZ9A1R
	iFQkP3TWCOPKzAx9yMJ9chGiM1HcdvKO8Onz/MeDYOnQ0inK6MKkA0eHc1dN8abh
	T28B+qD4L+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA14AA34E;
	Tue,  5 Mar 2013 11:54:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 418E5A34C; Tue,  5 Mar 2013
 11:54:42 -0500 (EST)
In-Reply-To: <1362473035-5034-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue, 5 Mar 2013 09:43:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 601F43A0-85B5-11E2-87E8-099C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217465>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Commit fea16b47b60 (Fri Jan 11 19:48:43 2013, Manlio Perillo,
> git-completion.bash: add support for path completion), introduced a new
> __gitcomp_file function that uses the bash builtin "compgen". The
> function was redefined for ZSH in the deprecated section of
> git-completion.bash, but not in the new git-completion.zsh script.
>
> As a result, users of git-completion.zsh trying to complete "git add
> fo<tab>" get an error:
>
> git add fo__gitcomp_file:8: command not found: compgen
>
> This patch adds the redefinition and removes the error.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> Felipe, you know ZSH completion much better than me. Could you turn this
>> into a real patch?
>
> No response from Felipe, so I'm trying my own patch. Compared to the
> snippet I already sent, I added the -f option to "compadd", which was
> there in the __gitcomp_file function defined in the deprecated ZSH
> compatibility section of the bash script, and gives the ZSH equivalent
> for "compopt -o filenames".
>
> This fixes an annoying regression for ZSH users, so it may deserve to
> be in the future 1.8.2.

Thanks, and I agree a fix to this issue should be fast-tracked.

>
>  contrib/completion/git-completion.zsh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 4577502..cf8116d 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -60,6 +60,15 @@ __gitcomp_nl ()
>  	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
>  }
>  
> +__gitcomp_file ()
> +{
> +	emulate -L zsh
> +
> +	local IFS=$'\n'
> +	compset -P '*[=:]'
> +	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
> +}
> +
>  _git ()
>  {
>  	local _ret=1
