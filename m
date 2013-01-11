From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: Silence not a valid object errors
Date: Fri, 11 Jan 2013 08:45:17 -0800
Message-ID: <7v6233d5ya.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1301110304220.26739@antec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dylan Smith <dylan.ah.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tthjh-0005ku-9F
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab3AKQpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:45:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096Ab3AKQpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:45:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8A7DBEC8;
	Fri, 11 Jan 2013 11:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QMnjIdVKsl6UwCLNpibdlzVSVOM=; b=A8MdnW
	rk1uu0VunNflAT/MtfIf8SGKkH/H6NGkyqz9HS8cbl6kHohr+p1jhDcqyhYGm+jU
	/IWkw3A7c+rvHbV7WG/kGxgJ/g8Z7+MuS8AVubw5LrEP6i5t+QoUbGP/6JysMoJy
	1huk5V74kgmv8YnQbvE9s52arJaShnhmj7Eco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AhG/BehevksO+tkLC/Nxm5Xu1Fgz0gUI
	LqQrhIEbVvHpiJKL4+81Lj53SsJEH8ESb8npyt+x71yszWXAMWneQqLErgvbwUM6
	pAdPt/P/vHceaI7nXWT2Igy4+l9FYmJ68xFP4FKbwirf0MWE/IMqbah7AE8ZVXCl
	a1iwNfdySUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D88DBEC6;
	Fri, 11 Jan 2013 11:45:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33F12BEC5; Fri, 11 Jan 2013
 11:45:19 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1301110304220.26739@antec> (Dylan Smith's
 message of "Fri, 11 Jan 2013 03:06:22 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 489EC258-5C0E-11E2-9D7A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213225>

Dylan Smith <dylan.ah.smith@gmail.com> writes:

> Trying to complete the command
>
>   git show master:./file
>
> would cause a "Not a valid object name" error to be output on standard
> error. Silence the error so it won't appear on the command line.
>
> Signed-off-by: Dylan Smith <dylan.ah.smith@gmail.com>
> ---

Looks obviously correct.  Thanks.

>  contrib/completion/git-completion.bash |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b77eb1..d4c7bfe 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -397,7 +397,7 @@ __git_complete_revlist_file ()
>  		*)   pfx="$ref:$pfx" ;;
>  		esac
>  
> -		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
> +		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" 2>/dev/null \
>  				| sed '/^100... blob /{
>  				           s,^.*	,,
>  				           s,$, ,
