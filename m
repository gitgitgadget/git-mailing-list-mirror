Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A742DFF3F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071755; cv=none; b=LnVynlrYr46qK8RK60lOKeno3Y1yB7h9sSeEDqpWON/TkhCz+9NkVm18EgcdXfOshJAlSRG7LHkN6jUSckr3vaSArf8VZGMipQPk7Wn/RjV0JSL3SodW4GeGSO8bYco09LjN/g8Pl8P4rt8DcIZC9BWQdyhkP6UMEAI5laELtE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071755; c=relaxed/simple;
	bh=P5tg6GUugn9zkuGE9fBkBYNgqWQ/RspsulVa4+aBIh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe9cHdQnX+ZE3+XzfKm7qGtQj2Y7T17FJJyqn6FAk1EMQRid8tUsVpCjVT903BDFLTCTo3ziuhbQtDLYMSmsU7Tjq0MiqeaY6lFO/2CkHwZK3e1yvq5e8kBJzBCj1GCCoVQz3ex7e3KzLWyuyUkNRUJ9jA1Zu6ELlHXSq4Pnk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUw2Qarv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUw2Qarv"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40a7322f081so1577b6e.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071753; x=1752676553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZU8Fs57MpLoJTFENT1wxzkJ4u+Hp6GbAqzXv10d2CU=;
        b=TUw2Qarvlk00kcaKoAGkFYoUItt2SZqstUZQ2Wv/o2GVaciQmZGlCQNxu/OUW4Qmbq
         ki7vhf2x0p6GgaE0Uc+9Zss24ifT6gIbWmCjvKsjIZk+k1hX0OPlNyN2W2t6KHbTnlSL
         by3MMAnLHIli9zy9bq+itieMB0BQSizn5iqDlTndJivhZMxYmIxBb0Gwvvj0v/5p3Arr
         ZzCzenj+uAc7WU0OqwuL4xWmPElcrUboO9qnqkbMhmRvIOtrMvAJJdP5Ppvg4vzkBmKP
         qZe6hICrBKNrsOQpNCHUSGhhrDfWnAzgOONbMr/KZfYVMxqDBQsqX7Gn/bFHlIQoD/QS
         xcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071753; x=1752676553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZU8Fs57MpLoJTFENT1wxzkJ4u+Hp6GbAqzXv10d2CU=;
        b=nCjVBOd81Unt8+xgpD5kGmvrUGQvbRgLTgKvwfEqSrrVcEQMzny8it8QvTVqxMnI5e
         lI3vYYyr7c7Cr3UBouAaUFdFNFEKd+ttDKyw8bnjMLG2gX0SwGGbQwKvjvdWPAoNjMiX
         tjCHT9FdrR7U2TO5r10Bav0kCmH9wlCBvHf0T57P+G/YBZsSslSWtIWd64d8X22EyuCr
         w7SFqyoYvOjKYXop5AcUQ7ngpPtnUfgRXLnS1Do8zD5FqfTB0+gz//v1UtslQ1iAGaJ0
         3YeIeEriV3FBXxUby4PVFy4YyT/K5jEKn8cg+MztnBMpeEy6LMae+C6x1Vb9vSVNVaMx
         snng==
X-Gm-Message-State: AOJu0Yw62V7apQt+ytY1Q9I9It7Cdl+88GRgY6aLgGi4AuwStzL9pKdr
	B0o1ofJH4SkWrMOrO44ycIqyL05u6+/PFjegGxtkc7x/Ho5XKursw3CO3nBeeg==
X-Gm-Gg: ASbGncs4BihiilmHBnmpzRi8rV4aTeljI1V19wOuZ8fj9/4JuPgjSN7Pl/Zg3R/5YmS
	MaJLZOiZ3XmpsUp71AqS2SKbAxrb0E8v70Lk8NswnhBhWTvUShSoQIt5raREXh5nm6wtHGMvwAL
	IButVNDPZcrsoLXaSZiQqXwoXPtNpAB0Xtmtr+92PEAup6saOd/su+MNHNNAKZLIREzrLQqlcS7
	OiDQuvgY+VoBJ0bq2iVO3k1nJscPsPorrnA2vo5L5FIB3oCTIAOb9weLtGJnQGWE6hWCWNA8mfK
	3I5WkQygXjv0yRXdUVgjB81rMxOnQCeB+hzMA88Oa4pi9MEGyWbfZoI=
X-Google-Smtp-Source: AGHT+IExV1SEiKmYYW0fYLCEFMrOuoyo6UOnfdjhRJpejsiOi3MqpTfsbe4PGQ9a1ntQqtgJtbA1Ug==
X-Received: by 2002:a05:6808:1205:b0:406:76e4:c4f with SMTP id 5614622812f47-413adeca2ebmr31128b6e.18.1752071752896;
        Wed, 09 Jul 2025 07:35:52 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40d02a4f87fsm1939427b6e.22.2025.07.09.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:35:52 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:30:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: avoid git config syntax from newer releases
Message-ID: <iuravzuqoqagie37is72e773zufuxcedwnc4i6ehhklpszg25t@bzu66havljcq>
References: <aG1_eqSpH46UddZJ@teonanacatl.net>
 <20250708210529.1214574-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708210529.1214574-1-tmz@pobox.com>

On 25/07/08 05:05PM, Todd Zullinger wrote:
> In a recent security release, 05e9cd64ee (config: quote values
> containing CR character, 2025-05-19) added calls to `git config get`,
> `git config set`, and `git config unset` which are not present on the
> maint-2.43 branch.
> 
> These subcommands were added in the following commits, released in
> git-2.46.0:
> 
>   4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06),
>   00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06),
>   95ea69c67b (builtin/config: introduce "unset" subcommand, 2024-05-06)
> 
> Revert to the previous `git config` syntax for older maintenance
> branches.

Thanks for raising this fix! Apologies, it slipped my mind that the
config subsommands wouldn't be available on older versions.

The changes here look good to me. :)

-Justin

> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> 
> This is based on maint-2.43.  I tested that it merges cleanly to 2.44 and 2.45.
> I have only run a build with 2.45.4 so far.  I pushed this to a github fork,
> which looks like it will run the CI for each branch:
> 
>     https://github.com/tmzullinger/git/actions
> 
>  t/t1300-config.sh           | 4 ++--
>  t/t7450-bad-git-dotfiles.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 1010410b7e..baf9b48231 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2595,8 +2595,8 @@ test_expect_success 'writing value with trailing CR not stripped on read' '
>  
>  	printf "bar\r\n" >expect &&
>  	git init cr-test &&
> -	git -C cr-test config set core.foo $(printf "bar\r") &&
> -	git -C cr-test config get core.foo >actual &&
> +	git -C cr-test config core.foo $(printf "bar\r") &&
> +	git -C cr-test config --get core.foo >actual &&
>  
>  	test_cmp expect actual
>  '
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 2026285566..d1546e3311 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -362,10 +362,10 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
>  	git -C repo mv sub $(printf "sub\r") &&
>  
>  	# Ensure config values containing CR are wrapped in quotes.
> -	git config unset -f repo/.gitmodules submodule.sub.path &&
> +	git config --unset -f repo/.gitmodules submodule.sub.path &&
>  	printf "\tpath = \"sub\r\"\n" >>repo/.gitmodules &&
>  
> -	git config unset -f repo/.git/modules/sub/config core.worktree &&
> +	git config --unset -f repo/.git/modules/sub/config core.worktree &&
>  	{
>  		printf "[core]\n" &&
>  		printf "\tworktree = \"../../../sub\r\"\n"
> -- 
> 2.50.1
