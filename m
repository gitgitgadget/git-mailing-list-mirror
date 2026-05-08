Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C33CBE9C
	for <git@vger.kernel.org>; Fri,  8 May 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234831; cv=none; b=tOJ0M1NWd9Y6LtHb77f6p1fKE5fUPwKENfF1t2tTp6vAr6rnWvrn6H4acMnTLtU/vjENhAdERdHI4Mqnh1KHMRZSpHeQ+hk/iYZX4f0RgbeEOKQl1elsXP304kJNYU6/V695OWKWU6G65PZbjcmfiIrNZg6BnzGFxmYBG5TrtCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234831; c=relaxed/simple;
	bh=MFrZuIMQ+++0EMN5MFDu+IsqDtaM49yFh/6InwbavSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBQVnws/nN0dd39IxT8ZtnGYopbBwHOeYjXaxAnHcMeDWyhw32wYQWRItBG8dpo8ey2G1t7q2eJoZ/4NxcoLGrkV5NF6ltI/HZWG3w04C3d4W6f14a6tsCn0bMTyH0w+CuxZQUj0KHoSckGPBJ8hH0KLutxhL0/T23Il7MDaB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtxrMUWp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtxrMUWp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso11336785e9.3
        for <git@vger.kernel.org>; Fri, 08 May 2026 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778234823; x=1778839623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPmobnhxQlb/t3wuHufHRH5vGQ/hhZRtyn76J9sHDlU=;
        b=mtxrMUWp4WWS+vzKS3rZF53odIF7zV1MDJLCGXqZZYo6xItc/jv/1H1F5FnmYRqqWU
         jnuIKd7eVG6fm6nq68/6QXeHAdiqDT4F1g/BKvNSWjv4PjWFzM4+7ClTb5X7sb33NQqN
         H8zwE9t74s5n//3zXIqpVXlDMLEw0nTq3f3oPa1THbAErQ2HdGnYOldHtFTS64fxHym/
         cLtwtajBU6a6atr4fwOTzCusN6+rfOm/JBaWgT/et5nX+sZRe7Yr96IYlQrJwiqpnlUi
         8i8SPt/1iRk/jff3qEuKxOjvDU3U2Yl/g46a7ycpBIHCPoVQ1tLEkw+uzc0IodRk0rI8
         CC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234823; x=1778839623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPmobnhxQlb/t3wuHufHRH5vGQ/hhZRtyn76J9sHDlU=;
        b=mn585brxhPs3eCMb2rjEp5soRkthxpnvoEbl63FxkoSvCwX4OgHhdEeP/MP3zNwwzU
         xMheuABeE/+QZo93Ul40basio1WU7JKxy4FPSOIR2+w6+i44KLtmwoZ/D6vnLpSO2Xcy
         AUBVhmbB/8HHag8r2LuwsAarujeLw0A+jy6NK350GCq0dhyEaL/kbOuYOjnYNP2wm9+m
         zJxd9ztr9BWHCP3uEZYcFuiTwOTg8RRPJZyQ6rux2ft0eUxMG76k6vYGr8bTSu9efMLG
         /gHf4/JHjbmoLiJcqPQuGYAzyG5adEvyEq5uiUGI3xI9ofIuVSSEEBonf56OIVrQ9ozC
         vxxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S5v+wtP/5qtk9/CQAe95hSUtCNSIMFm9/KrAvZkILQo5b40E7yI0FMhy5ffLvzsh5NCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JFTH30WLiMwBaMk9VZzpf1MpW5ubvVg8YvJnt0r+L9YFGxTY
	j0e8NXmyW5Ct2qAhdTVgrRp1C63TCZx4lO+cUlhgR1k/VxSpWaVpQfTo
X-Gm-Gg: AeBDievfNr49mlJHNhBPOiTh/YsOac67GeuDKABKoZyVE21x+iXlPxr7EOiNUhdKXa+
	b30ciSfrw7rS/6R8AZMCxE32c8YSFod/cYTxA02HMUdouWDsSwSSgEWgekZ+fEXNGIXSJwlSIQE
	PUyz00Wqwv6YI7fzayWg5nOVvNGF7QR26lpFdrLjikXl7MOAOGUpOM9MAc/fXjg8s0FIfY35aC9
	a5oyaX3jxInV2QJ7aQcuoTIcX7/5r+QMYHyYwDuJbcl2ofS7Pp/+HKQm+cq6sim5zroRI56TNP5
	BRhJQ4MQkolRSl/dyr2oQRD1PR2V1u1TCHh9gHaBPLL5/TuDhw8DI+s/XMwF7DtVIx7UcFSrF9D
	BM93tVe4fuU3cta4CvHk6Q9Y3Ve1gyq9y+M5IB0Zsz8KBy6pw29mVfJllEyA29GSQMNhjSmZV9d
	ET5lBTRZDrCQIkcauBvO7c8KHl3Og1GHcl7JH+kJFbGJz03WPPi/X8uTUfzfGI5dOC8AQZVlQik
	VnIdpv5FB0=
X-Received: by 2002:a05:600c:8012:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-48e5fb8fac9mr95928495e9.24.1778234822191;
        Fri, 08 May 2026 03:07:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731? ([2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edca90sm49960925e9.5.2026.05.08.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:07:01 -0700 (PDT)
Message-ID: <d9128068-d5e3-4a81-a4d6-b94bfc7d3717@gmail.com>
Date: Fri, 8 May 2026 11:07:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rebase: ignore non-branch update-refs
To: mail@abhinavg.net, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <20260508015817.86177-1-mail@abhinavg.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260508015817.86177-1-mail@abhinavg.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abhinav

Thanks for re-working the test - this looks great.

Phillip

On 08/05/2026 02:58, mail@abhinavg.net wrote:
> From: Abhinav Gupta <mail@abhinavg.net>
> 
> The following Git configuration breaks git rebase --update-refs:
> 
>      [rebase]
>          instructionFormat = %s%d
> 
> The '%d' format requests all available decorations for a commit,
> filling the global decoration table with all of them,
> which --update-refs then uses to populate 'update-ref' instructions
> in the rebase todo list.
> 
> Specifically, this results in the following instruction:
> 
>      update-ref HEAD
> 
> The todo parser then rejects the instruction:
> 
>      error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
>      error: invalid line 3: update-ref HEAD
> 
> To fix, ignore decorations that are not local branches
> when scanning through the table.
> 
> This matches the documented contract:
> it moves branch refs under refs/heads/
> and leaves display-only decorations (HEAD, tags, etc.) alone.
> 
> Verification:
> A regression test that fails without this fix is included.
> 
> Signed-off-by: Abhinav Gupta <mail@abhinavg.net>
> ---
> Updates:
>      v2: incorporate suggestions to simplify the test
> 
>   sequencer.c                   | 10 ++++++++++
>   t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b7d8dca47f..25bcfc5da0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6428,6 +6428,16 @@ static int add_decorations_to_list(const struct commit *commit,
>   		const char *path;
>   		size_t base_offset = ctx->buf->len;
>   
> +		/*
> +		 * The global decoration table may contain names loaded by
> +		 * a previous pretty format such as "%d".
> +		 * This will result in refs such as "HEAD" being present.
> +		 */
> +		if (decoration->type != DECORATION_REF_LOCAL) {
> +			decoration = decoration->next;
> +			continue;
> +		}
> +
>   		/*
>   		 * If the branch is the current HEAD, then it will be
>   		 * updated by the default rebase behavior.
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3e44562afa..58b3bb0c27 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1960,6 +1960,24 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>   	)
>   '
>   
> +test_expect_success '--update-refs ignores non-branch decorations' '
> +	test_when_finished "git branch -D update-refs" &&
> +	test_when_finished "git checkout primary" &&
> +	git checkout -B update-refs no-conflict-branch &&
> +	(
> +		set_cat_todo_editor &&
> +
> +		# rebase.instructionFormat=%d loads normal log decorations before
> +		# --update-refs adds its branch placeholders so we must ignore
> +		# all non-local decorations.
> +		test_must_fail git -c rebase.instructionFormat="%s%d" \
> +			rebase -i --update-refs HEAD^ >todo
> +	) &&
> +	grep ^update-ref todo >actual &&
> +	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success '--update-refs updates refs correctly' '
>   	git checkout -B update-refs no-conflict-branch &&
>   	git branch -f base HEAD~4 &&
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0

