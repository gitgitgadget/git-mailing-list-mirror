Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB1F513
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063833; cv=none; b=OAAim2tELj8GhHAICEkl9QvFsFMG92lNJVDg/bF1GZn/lBrnLPKk1oLRXvXoLiUjQvkAkp96itULZlBYTNSkA5ryW9Nat04+pY1fF3+xnlxjEk/LifQcQeA792k9lY1rTN4tc9gLWp93smnvUzSTDCb8XNTn0xwRyKddGeUTAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063833; c=relaxed/simple;
	bh=FUvUhZ+/p2Z+mkb01+cHd/9v9N3KouMuf16ObWPlSgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ltMja9gKnjYHcEDWBgw1prV5sFASuj6C3SMtxtl+OhXAyaOukNxTq5X70PYKWnZuc+PEAt8TCWnieIOEN/1euE8Ec1bnxSDtSfqG1gcNHbYr89iLbreUMJWHeURo3kukAyoK6lb2EAuactQOj21YpTgGmwqpVOui0vj2rwdwyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNnX2OkI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNnX2OkI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AFDD323D89;
	Thu, 25 Apr 2024 12:50:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FUvUhZ+/p2Z+mkb01+cHd/9v9N3KouMuf16ObW
	PlSgo=; b=UNnX2OkIzaXtmIEhkQHFkhz+UjB1F+YYkNyGnWkBuOWFlJAmY7FCP7
	7rh4ksEwBX1rsNzocZfmbnDAB/nTQc480taJKsbwyug2Y5EEsOR+4ug+vmqxnp2L
	R8G8/chsffaem+Gp+r2wqTu2rgKWiYJmkptWrMFKfYGQ3olw5V4rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A714E23D88;
	Thu, 25 Apr 2024 12:50:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06DB123D87;
	Thu, 25 Apr 2024 12:50:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Roland Hieber <rhi@pengutronix.de>
Cc: git@vger.kernel.org,  Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
In-Reply-To: <20240425101845.708554-1-rhi@pengutronix.de> (Roland Hieber's
	message of "Thu, 25 Apr 2024 12:18:42 +0200")
References: <20240425101845.708554-1-rhi@pengutronix.de>
Date: Thu, 25 Apr 2024 09:50:28 -0700
Message-ID: <xmqqcyqdgze3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ECA12B0C-0323-11EF-8D32-25B3960A682E-77302942!pb-smtp2.pobox.com

Roland Hieber <rhi@pengutronix.de> writes:

> Even 'symbolic-ref' is only completed when
> GIT_COMPLETION_SHOW_ALL_COMMANDS=1 is set, it currently defaults to
> completing file names, which is not very helpful. Add a simple
> completion function which completes options and refs.
>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
> PATCH v3:
>  - make use of __gitcomp_builtin instead of hard-coded options, and add
>    a test for it (thanks to Patrick Steinhardt)

Nice.

>  - add empty line between test cases (thanks to Patrick Steinhardt)
>
> PATCH v2: https://lore.kernel.org/git/20240424215019.268208-1-rhi@pengutronix.de
>  - no changes
>
> PATCH v1: https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/
> ---
>  contrib/completion/git-completion.bash | 11 +++++++++++
>  t/t9902-completion.sh                  | 23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 75193ded4bde..4d63fb6eeaf7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3581,6 +3581,17 @@ _git_svn ()
>  	fi
>  }
>  
> +_git_symbolic_ref () {
> +	case "$cur" in
> +	--*)
> +		__gitcomp_builtin symbolic-ref
> +		return
> +		;;
> +	esac
> +
> +	__git_complete_refs
> +}
> +
>  _git_tag ()
>  {
>  	local i c="$__git_cmd_idx" f=0
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 569cf2310434..963f865f27ed 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2518,6 +2518,29 @@ test_expect_success 'complete tree filename with metacharacters' '
>  	EOF
>  '
>  
> +test_expect_success 'symbolic-ref completes builtin options' '
> +	test_completion "git symbolic-ref --d" <<-\EOF
> +	--delete Z
> +	EOF
> +'
> +
> +test_expect_success 'symbolic-ref completes short ref names' '
> +	test_completion "git symbolic-ref foo m" <<-\EOF
> +	main Z
> +	mybranch Z
> +	mytag Z
> +	EOF
> +'
> +
> +test_expect_success 'symbolic-ref completes full ref names' '
> +	test_completion "git symbolic-ref foo refs/" <<-\EOF
> +	refs/heads/main Z
> +	refs/heads/mybranch Z
> +	refs/tags/mytag Z
> +	refs/tags/A Z
> +	EOF
> +'
> +
>  test_expect_success PERL 'send-email' '
>  	test_completion "git send-email --cov" <<-\EOF &&
>  	--cover-from-description=Z
