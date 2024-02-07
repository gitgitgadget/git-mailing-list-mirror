Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961C149E0D
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343925; cv=none; b=snCMFAinIu2+MeEVtpFK9tQ2M63Tj2p/XzVUbSj3K0Gl0AgmDuFSWyNAICja7hfosI7GrTnk9SvG/If6yiPkoeKnH/gajSUFbtZt+dohiu0oStVwd/bGErA+qdFEHuDNdxMx/F2p2pTRN6cmj+PA5PWEAaSjJ8mEtH6R1Z4JcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343925; c=relaxed/simple;
	bh=5zeC6k5TzdFLjfaP1k5QnZb54QJ3IgBOs07buG8qUKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYuUgySk7m1S5eAlcXVgBjsXPzNeUnt4pmC29JuUhqQIcsETFjJ87MGEWbpWi6lOJoJ1XESIlF1+LOdN2eEV4IjSXeBShicWaLLmvpsX5+aBU8qOYqe0ZRCgOwJr3hzQ8d3GwbwYzBhUk64cuNyZ4sM+PRTbNIs6oW7ApPUkR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sHzXaUU9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sHzXaUU9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D67E71D9F05;
	Wed,  7 Feb 2024 17:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5zeC6k5TzdFLjfaP1k5QnZb54QJ3IgBOs07buG
	8qUKM=; b=sHzXaUU9jkRufQKZSf/kvCGfkjC7AkC8pBPYBJwVvYBM1fRzpIY9pR
	NC1QlpTe1pATpEzn1VszvpC42T2tHNAiHp0AdHMV74bCB9dMAsycqvdw6EZY2pU4
	6/Fxslr8WQjwF/LXjM9KjDJoHLeKDTnkYfwzPFpHFkMTVfqw95FG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF17B1D9F04;
	Wed,  7 Feb 2024 17:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FCB71D9F01;
	Wed,  7 Feb 2024 17:12:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: "Britton Leo Kerin" <britton.kerin@gmail.com>
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when
 --no-format-patch
In-Reply-To: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
	(Britton Leo Kerin's message of "Mon, 8 Jan 2024 16:08:30 -0900")
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
	<20240109010830.458775-1-britton.kerin@gmail.com>
	<a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
Date: Wed, 07 Feb 2024 14:12:00 -0800
Message-ID: <xmqq4jej6i1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB6FFE12-C605-11EE-8862-25B3960A682E-77302942!pb-smtp2.pobox.com

"Britton Leo Kerin" <britton.kerin@gmail.com> writes:

> In this case the user has specifically said they don't want send-email
> to run format-patch so revs aren't valid argument completions (and it's
> likely revs and dirs do have some same names or prefixes as in
> Documentation/MyFirstContribution.txt 'psuh').
>
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Any reviews people want to offer to this one?

Thanks.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 185b47d802..c983f3b2ab 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1242,10 +1242,12 @@ __git_find_last_on_cmdline ()
>  	while test $# -gt 1; do
>  		case "$1" in
>  		--show-idx)	show_idx=y ;;
> +		--)		shift && break ;;
>  		*)		return 1 ;;
>  		esac
>  		shift
>  	done
> +	[ $# -eq 1 ] || return 1   # return 1 if we got wrong # of non-opts
>  	local wordlist="$1"
>  
>  	while [ $c -gt "$__git_cmd_idx" ]; do
> @@ -2429,7 +2431,9 @@ _git_send_email ()
>  		return
>  		;;
>  	esac
> -	__git_complete_revlist
> +	if [ "$(__git_find_last_on_cmdline -- "--format-patch --no-format-patch")" != "--no-format-patch" ]; then
> +		__git_complete_revlist
> +	fi
>  }
>  
>  _git_stage ()
