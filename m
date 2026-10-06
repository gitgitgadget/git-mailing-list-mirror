Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37046AEF1
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300677; cv=none; b=tgJNg3Dav060nwvMIY7zqEa7EhcMnsPRtE0RZZEy5xZNTll7cmqSwpeLba3khmNcYNaFAhw6RjCuK95IfnLlmuy4rqPUKfGoKFYkecIIxIrPaZo13oU3zoQIA0XXhu5Z8yOa6zLMDJyTY5awgE/Z/d38JppC+Ts90TIopKeiDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300677; c=relaxed/simple;
	bh=J5XriwVQg+pPS+2jgRhMtBZ11npL5Bl8/4v8yee4YqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om9+pj5Yim1oJKPwSEGYaZr16ZGJLjy3XBRllZ8hu4dMikFSS/mzJkba3IB2An4HsQLhVAvPrLdXkhlFMNKn0g1ycAK82uGGUz6L/97VUNDtHFUIrmosLSD2RXTysDE8ZMff+cqRmFeWxOv0bOElR3l15Hewcu6Ub16oz+WEVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbSvTLxf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbSvTLxf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso6553915e9.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300674; x=1791905474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jyc2UbklVGESq4BmOuqKYM9LvE2XEzx4edUcLtrT3sw=;
        b=nbSvTLxfDIWl/3W76TbhBWTrojg5E+aBsRHJsBL9TPjkgRgUNmxDEl/P63Ls9/LNqc
         aMdrBNErs4bZKOzy6OauF4UKj7k8GVdNWSJWeyQ67prg00xFnh1OrV9npoWlRk+wggbh
         EcUxEUkilIqEy82Xm8usN6XJk0bjA+RX3e7do0GtdppqhJ2z1+Vl3dzWT7g0kSbxyoBv
         T/y5j/j56WEmMtHNyuPcd61Y79EOdvE71vJVL+JM6A2X/3i9MQ6zhn77bDjMeSiloISo
         8oATqmQN6es513zm7coJxruenUl1D+IK1Ay44IW2bmTwT2n2IuhWWWFxu1oZ7haaAP/Q
         0GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300674; x=1791905474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jyc2UbklVGESq4BmOuqKYM9LvE2XEzx4edUcLtrT3sw=;
        b=CAIJW/zWXBdPupl9OCtCd2UdOH7MYW4z9rFLSp2kPASEdQAqMjGBwD1qXEsmMMT+JP
         xg8+L3CFaAAVfylt3VgwjISGdzMxitLp69ZaoWtrXu1TPOj2t2AstKjLCetYULm1BxPq
         IepHtTMokdKHPf5am4c995DGxiQVhymX6XSSb9XoJleQ0yTZ/6Z7A0tLWmJ/marvhgAE
         /Wg7IVnnp9mjezHF0sysuTeTt6NdPMLdkguYxqz23e+HWnX0d9PeDFYJQP3Af2ImN7vd
         gLlQT5wNTsaCx0XYispveGrKPM/nk+trAUtReIfuas0+C2nXkpmlrv9RSq1cpu8XBkFe
         ajlQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0+oWYQDR5H/6IstSnUwGBWDf3jkBcnXhEhBwnSdzOgBVuL/uXWR+rnhx5PgRuoiUYLNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lehRILyE8+cA7TIbwr8Lq4hy1Pw6EfPMR53vLQPCgTtkRFAn9E
	WBaebsUG74yGaIlrKKtHXBM7aIfg0DaaAGwH98/bz26q3fBrxzsZYL5p
X-Gm-Gg: AYBFou3yF6Ks/oUIsJVPu/rimI0ElZWlYWt2yBM+clI7xrJFpsSZ5K+YSvYP0ZVNm+r
	gWW5FbYSanLpdokBs1IYoHm9R37ItRYYwSPTzPdOcjEeSOSbLL1TlxH371DLCKQiZ8eaiZzzLMf
	Jqy5BQ9S2YfEjn7hXhSipDlmqYdfC4LgyFKc+RdtivzEGghzRZNXX8F04O+2Zm8UFnt3BUGl3eq
	oL6uNQJiuRp5tZa8l5DTk0SVAhdZyO3OSyL9B2RIg1L/CykhWlJJHmAC5r1mw4GKgYA64khH/6d
	qiF1rFMhabJhRrZEuIw1f28d/xNnsbXjKCxh4Vxus4oJSoJd7jt15xAUULUMBH5igZztseDd9O5
	z4aXcp+fWsniwlbwdRvezt70UUaSrNY5+5WIHoD2+wWyHxJAY4L+oWLwsIP8RZVG8p4wMWSddX2
	YPuc8N6d4S8GIFrZKJiYyfuSV8Hjqjhz7WZoFkzOuVgwaK/+t6qTJLDHxST1nOjfdk+835KhCP3
	EI87rWHav9HHa/dwYe6J1dL9dzbHjrgsLlnVaDvpraIfSay5HTc
X-Received: by 2002:a05:600c:6986:b0:4a1:6811:8d with SMTP id 5b1f17b1804b1-4a17b526bd6mr27085285e9.11.1791300673667;
        Tue, 06 Oct 2026 08:31:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03043fae5sm259451795e9.0.2026.10.06.08.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 08:31:13 -0700 (PDT)
Message-ID: <3a716db0-4c40-4407-9237-f83c0dd37ad8@gmail.com>
Date: Tue, 6 Oct 2026 16:31:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] status: suggest `git merge --continue`, not `git commit`
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julia

On 06/10/2026 14:02, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> During a merge conflict, we suggest using --continue to continue the
> merge for rebase, revert, and cherry-pick.
> 
> Change the `git merge` advice to be consistent.
> Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that

When we use the output of "git show -s --format=reference" when 
referring to previous commits, so this would be

367ff69428 (merge: add '--continue' option as a synonym for 'git 
commit', 2016-12-14)

> `git merge --continue` is intended to be a synonym for `git commit`,
> and the `git merge` man page already suggests to use
> `git merge --continue`.

This looks like a sensible improvement. I wonder if we should fix the 
grammar at the same time so it says

     (use "git merge --continue" to conclude the merge)

rather than

     (use "git merge --continue" to conclude merge)

Thanks

Phillip

> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>      status: suggest git merge --continue, not git commit
>      
>      We discussed making this consistent in another thread:
>      https://lore.kernel.org/git/623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com/T/#m4bdcb555cbdff4132fb1a678594f26b598e0b38f
>      
>      From some research:
>      
>       * git merge --continue was introduced in 367ff694281c in Dec 2016. It
>         says that git merge --continue is intended to be a synonym for git
>         commit. (thread here:
>         https://lore.kernel.org/git/20161214083757.26412-1-judge.packham@gmail.com/)
>       * This line of the advice was last touched in July 2016, before git
>         merge --continue was introduced.
>      
>      So I don't see any obvious reason not to change the advice.
>      
>      Translations will need to be updated, I still don't know how that
>      process works. Updating the translations should be straightforward since
>      it's just a change in the command.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2249%2Fjvns%2Fadvice-merge-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2249/jvns/advice-merge-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2249
> 
>   t/t7060-wtstatus.sh    | 8 ++++----
>   t/t7512-status-help.sh | 4 ++--
>   wt-status.c            | 4 ++--
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index 942ddbbf0e..a9b435b5e3 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
>   	cat >expect <<EOF &&
>   On branch side
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -141,7 +141,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
>   	cat >expected <<\EOF &&
>   On branch main
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -174,7 +174,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
>   	cat >expected <<\EOF &&
>   On branch conflict_second
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -198,7 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
>   	cat >expected <<\EOF &&
>   On branch conflict_second
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Changes to be committed:
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index aca4b6d332..776a0dd5b8 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -31,7 +31,7 @@ test_expect_success 'status when conflicts unresolved' '
>   	cat >expected <<\EOF &&
>   On branch conflicts
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -53,7 +53,7 @@ test_expect_success 'status when conflicts resolved before commit' '
>   	cat >expected <<\EOF &&
>   On branch conflicts
>   All conflicts fixed but you are still merging.
> -  (use "git commit" to conclude merge)
> +  (use "git merge --continue" to conclude merge)
>   
>   Changes to be committed:
>   	modified:   main.txt
> diff --git a/wt-status.c b/wt-status.c
> index 57772c7501..f7b0dc29d5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
>   		status_printf_ln(s, color, _("You have unmerged paths."));
>   		if (s->hints) {
>   			status_printf_ln(s, color,
> -					 _("  (fix conflicts and run \"git commit\")"));
> +					 _("  (fix conflicts and run \"git merge --continue\")"));
>   			status_printf_ln(s, color,
>   					 _("  (use \"git merge --abort\" to abort the merge)"));
>   		}
> @@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
>   			_("All conflicts fixed but you are still merging."));
>   		if (s->hints)
>   			status_printf_ln(s, color,
> -				_("  (use \"git commit\" to conclude merge)"));
> +				_("  (use \"git merge --continue\" to conclude merge)"));
>   	}
>   	wt_longstatus_print_trailer(s);
>   }
> 
> base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90

