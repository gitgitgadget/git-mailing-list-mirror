Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA828137E
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537662; cv=none; b=Smq6tfofIJSZuYhvxSV09tDWtOz4U3HD1NAE4HaMhd8/Z98SHefMa1fXrWPJj09maTyT2CIfhBeUO5ixAx2+BBvfWdaeBxIti8p5ns5tk7h6UrUiSDcNqrumaWQoJl+tW+azw75fZzRNhtFTgX2eufw/o92Iq/RUar4788aNOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537662; c=relaxed/simple;
	bh=blpc/EfM/AvKb16A6XnTVjt6rebxb/6fjSfnA7JtkEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwTfCV/kfkSGkgxw8C6igX2gOHWPS2C8VoSPW7SUgQWeFB3Ekk+xFI++ulL66cwL3lnXNjvNjLfOaKmSkPbraeDVrojIQw1Uni4GkmM1LWicDWb2p07DVODJr+saRrUbS/YUvbwHGMeIq5xwLLdOr/WX6dxdgJwhCs9NITlx44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2s4+EBW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2s4+EBW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso4083412f8f.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537659; x=1747142459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWAnjkozbPlViBG+EZRvZbvKsy8xnjM0vMqVJUh5Wfo=;
        b=O2s4+EBWAiXgyial1GyHoJFfGFHz/zqSXemgwOiLnwl5kOC/s4ZNN0c7N9/QxztozQ
         ADya2O8kX+NDUfbjLIq0NlrwrmQzRAwmaWBi3pjNClby52SmMSup1BQt4F7/ieIvFbqU
         sUJKzl/zP49wnri5qhR8Hc3rIfT9tjFc3YmKc8UxrRGtS1BBLMjLrTOQcZqbf3CWqReM
         nowvkHuDHvysVP2UP5uLqIYNF91Vdk5srzmw89i6VFIIR/YQxyh5DSDZbR+mT6bmGKco
         Yh4oXhN564Fsul6NMIkdgI8ajIm9XqK1qq0lOofjTdddV5s2B7DvojNykTMVEv6t+mNg
         eLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537659; x=1747142459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWAnjkozbPlViBG+EZRvZbvKsy8xnjM0vMqVJUh5Wfo=;
        b=GLZuOWerQhINPXeXclnU66V5bIKBHaNUdoR/8ajqGoqALPMsCWnsxLfSRo7RmBCbR4
         Gzl0idqEEhfLCgtvVceOyNmrXOQAFLyaNx6CCDf9UyVDhI3+anHyEdPCRA5JdSBydhBi
         JGJyaHlTEyFlQFLz5vd6M4eG0JG1EpvX3VHDGdWyFVCrh6VoQYAw4eKfamolA6Kx3ftf
         SwNDb/EGJYHgNm5VLeb6hgO00tZ2NsXamvi2lq3sSEYC99hhm+HAkMHgQkiyZKpYG4IJ
         gju3SNQQZDrvF1ngAlFki1VZP7ZJAOyssrZIIUi/qTuNhs86JX8h6hEUtckW2HqUeZZX
         q0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWsCVes40U01ynkqWfB8zOAeqQcbs0ejIMnzj86fBXldBXttYLY9sUOocRJDudHppN1PIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXlsi+OYx463nU2djsIVQjoHqDPyLPEyPqg/+OBbbu50QjYnL
	R6wz8eS5RY7dAFJd4GRgh91hli22N/drk1SuRa1Et7ial2G0sDPD
X-Gm-Gg: ASbGnculrWd9MPtkD8u+FTGowntzE2HKhta0k9VjXRDrfortNkH64OeFim4RFL47QOR
	IBe/HN/LbtKGczjgXkEJQgxa8vRkYgmilZGOkCB1BUXyT+GXwcNSR7vO7nxFBGvCMSoRH7u3e21
	4/5hNLvuIx38c87SBBlu6oPGIrLtl2JeeW1tgGvRl3NSnlACfkBnNgZf61fpAMxRqd2O3ObMWqa
	cCq8hcAFVlPyLmhrwkthvTGo01SofQiMMbpubdV3XSdesi/xHEzL/kCMASPPlfyzM1qoZzDdVIA
	nzpVxo3aMWQ27TkGbvK4yyQ/U/RYlw0YnWqXmJiLqpF0cY7ptaYZmdrz0g7at2n96LYIleDEm8j
	viGndsTvlF3TQpET3ETN5Tt0=
X-Google-Smtp-Source: AGHT+IGkTxLGZQAeN2YoVqTibf0ocj9H3uAR6JBAOVF8j4l3o4AgVt3qqcUfEAeYC+DMD+Yi6GS6mQ==
X-Received: by 2002:a5d:5f41:0:b0:3a0:a8b1:cf17 with SMTP id ffacd0b85a97d-3a0ac0d97f7mr2220159f8f.15.1746537658675;
        Tue, 06 May 2025 06:20:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b107c4sm13704050f8f.76.2025.05.06.06.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:20:58 -0700 (PDT)
Message-ID: <f2b34e81-fb86-4a30-9aa7-67e6f5758168@gmail.com>
Date: Tue, 6 May 2025 14:21:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xdiff: disable cleanup_records heuristic with
 --minimal
To: Niels Glodny <n.glodny@campus.lmu.de>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, johannes.schindelin@gmx.de, peff@peff.net,
 gitster@pobox.com
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
 <20250429140949.2634935-1-n.glodny@campus.lmu.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250429140949.2634935-1-n.glodny@campus.lmu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Niels

On 29/04/2025 15:09, Niels Glodny wrote:
> The cleanup_records function marks some lines as changed before running
> the actual diff algorithm. For most lines, this is a good performance
> optimization, but it also marks lines that are surrounded by many
> changed lines as changed as well. This can cause redundant changes and
> longer-than-necessary diffs.
> 
> Whether this results in better-looking diffs is subjective. However, the
> --minimal flag explicitly requests the shortest possible diff.
> 
> The change results in shorter diffs in about 1.3% of all diffs in Git's
> history. Performance wise, I have measured the impact on
> "git log -p -3000 --minimal > /dev/null". With this change, I get
>    Time (mean ± σ): 2.363 s ±  0.023 s (25 runs)
> and without this patch I measured
>    Time (mean ± σ): 2.362 s ±  0.035 s (25 runs).
> As the difference is well within the margin of error, this does not seem
> to have an impact on performance.

Thanks for adding the performance information, this version looks good 
to me.

Best Wishes

Phillip

> Signed-off-by: Niels Glodny <n.glodny@campus.lmu.de>
> ---
>   t/meson.build           |  1 +
>   t/t4071-diff-minimal.sh | 14 ++++++++++++++
>   xdiff/xprepare.c        |  5 +++--
>   3 files changed, 18 insertions(+), 2 deletions(-)
>   create mode 100755 t/t4071-diff-minimal.sh
> 
> diff --git a/t/meson.build b/t/meson.build
> index bfb744e886..8f2e9d2c50 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -501,6 +501,7 @@ integration_tests = [
>     't4068-diff-symmetric-merge-base.sh',
>     't4069-remerge-diff.sh',
>     't4070-diff-pairs.sh',
> +  't4071-diff-minimal.sh',
>     't4100-apply-stat.sh',
>     't4101-apply-nonl.sh',
>     't4102-apply-rename.sh',
> diff --git a/t/t4071-diff-minimal.sh b/t/t4071-diff-minimal.sh
> new file mode 100755
> index 0000000000..4c484dadfb
> --- /dev/null
> +++ b/t/t4071-diff-minimal.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +
> +test_description='minimal diff algorithm'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'minimal diff should not mark changes between changed lines' '
> +	test_write_lines x x x x >pre &&
> +	test_write_lines x x x A B C D x E F G >post &&
> +	test_expect_code 1 git diff --no-index --minimal pre post >diff &&
> +	test_grep ! ^[+-]x diff
> +'
> +
> +test_done
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index c84549f6c5..e1d4017b2d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -368,6 +368,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	xrecord_t **recs;
>   	xdlclass_t *rcrec;
>   	char *dis, *dis1, *dis2;
> +	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>   
>   	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
>   		return -1;
> @@ -379,7 +380,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>   	}
>   
>   	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> @@ -387,7 +388,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>   	}
>   
>   	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
> 
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3

