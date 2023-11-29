Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AbmD0q97"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4610F9
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:25:26 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1f0f94943d9so105909fac.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 14:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701296726; x=1701901526; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=urFzGsiv/uqpok4HRg17NTt2OwBGFDrrcJsRYX5C2jw=;
        b=AbmD0q97W0zEX+k1qsRCzKLXD7KGkEjzAeG4b40ewlHR+MUnlFU3b2AGK9tCAG/1l5
         71dlrIzoxYEx8XscLbQ22e+ImLZo7CTkRosn7HxwrvodDeaGTeeFikdMYyB+XsARTAe2
         nXpFzqt8Ecr5cIBNt7IbuvINYOKuu+rb8SMsoON/4oVY3P48uY+Cj3gcdgr9g5ahGw39
         /IJ9U3Oo4a+cQqg/zo2t0lHXoKv20ZAu7mpnj6sQc/PZT+l2JUJSxuL5YWsTNA0VCWlJ
         8a8NnC7JBiJVNlM/PdF/VGPzIuGhX0kaRlfblj4V7IdsL7iN5axKMjavuhoVHcjyFYOO
         Yd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296726; x=1701901526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urFzGsiv/uqpok4HRg17NTt2OwBGFDrrcJsRYX5C2jw=;
        b=ANxMz5qS3yVaajcq2VYrscG/vErGrdHzGrMXHlc2Y45xv3uOw/qgrmWbD3gV3piZ8d
         VsMCW9VV7OXI6iT0xdNGfC8BhZbvv1ZYcRjSf+fhx0BVX4UB6Pof6YcdWX12xjxb6USJ
         S1ewQjaV3kBmyVTbrQpe8KAybGvNqAWJ8wltvLfmxAvVHFP36GqG+tNZw7UFIi7kSP3i
         7UqVEDi1/7u9PNhUUirPgbjGOY49vXjx1SGupIJhRZe87zC4rZIIoCabtPkxTmJwAmg8
         xTupjhy12mD9UtQcA55lCfAbc5za7UTJj7EIezOSpN+YlTiTXiP55KrykOWHcH0zOva9
         uonQ==
X-Gm-Message-State: AOJu0YwEZTPuUCk+nAA2yy7ZQH3rE+sHo/WR1m0XKJRLFnwYikGwY0HP
	bY11EUncODXxJSQfS0b53ebhMZnTSMmfmYXAqlM=
X-Google-Smtp-Source: AGHT+IET71z+qGAXxlTxNA1BKgm4Ar4cWrATdasPh/aXYKcXETko+dAzr5dR5aX+O5zgpUNVuqtEgA==
X-Received: by 2002:a05:6870:5716:b0:1fa:14e8:6291 with SMTP id k22-20020a056870571600b001fa14e86291mr17337471oap.58.1701296725785;
        Wed, 29 Nov 2023 14:25:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h7-20020ac87447000000b0041ea59e639bsm5963823qtr.70.2023.11.29.14.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:25:25 -0800 (PST)
Date: Wed, 29 Nov 2023 17:25:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] t5401: speed up creation of many branches
Message-ID: <ZWe6VDZqW8zCzMNJ@nand.local>
References: <cover.1701242407.git.ps@pks.im>
 <f674119c7801e355cd08a651450abd67947d7456.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f674119c7801e355cd08a651450abd67947d7456.1701242407.git.ps@pks.im>

On Wed, Nov 29, 2023 at 08:25:09AM +0100, Patrick Steinhardt wrote:
> One of the tests in t5401 creates a bunch of branches by calling
> git-branch(1) for every one of them. This is quite inefficient and takes
> a comparatively long time even on Unix systems where spawning processes
> is comparatively fast. Refactor it to instead use git-update-ref(1),
> which leads to an almost 10-fold speedup:
>
> ```
> Benchmark 1: ./t5401-update-hooks.sh (rev = HEAD)
>   Time (mean ± σ):     983.2 ms ±  97.6 ms    [User: 328.8 ms, System: 679.2 ms]
>   Range (min … max):   882.9 ms … 1078.0 ms    3 runs
>
> Benchmark 2: ./t5401-update-hooks.sh (rev = HEAD~)
>   Time (mean ± σ):      9.312 s ±  0.398 s    [User: 2.766 s, System: 6.617 s]
>   Range (min … max):    8.885 s …  9.674 s    3 runs
>
> Summary
>   ./t5401-update-hooks.sh (rev = HEAD) ran
>     9.47 ± 1.02 times faster than ./t5401-update-hooks.sh (rev = HEAD~)

Very nice ;-).

> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 001b7a17ad..8b8bc47dc0 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -133,10 +133,8 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
>  	EOF
>  	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
>
> -	for v in $(test_seq 100 999)
> -	do
> -		git branch branch_$v main || return
> -	done &&
> +	printf "create refs/heads/branch_%d main\n" $(test_seq 100 999) >input &&
> +	git update-ref --stdin <input &&

Not that it really matters here, but you could pipe the output of your
printf directly into git update-ref. I don't think we rely on the value
of "input" after this point, and git is on the right-hand side of the
pipe, so this is safe to do.

But it doesn't matter much either way, just something I noticed while
reading.

Thanks,
Taylor
