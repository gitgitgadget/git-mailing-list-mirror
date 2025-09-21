Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C42D3A65
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758460013; cv=none; b=Q2Bda0PYlLIHUWzjV/qWr9Ajo0ZwG3A1rK7V1hzxnTYorr1cAVH2yla5UQl2V4na4Y93y5v1M9d0m4Fng9NyBgdBk+bFzDUqW79TiM/tNKkWHNwUG4cIwq+Hkxzhkf8dq1T3mlr+tuQ0lAfheJWsjLfVXIVIy38kd0Iuw0SrwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758460013; c=relaxed/simple;
	bh=CJKxg7zD93RNrG20NjWhjkOtjKuXaVaf3s4G25fPPyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te/69GzhU9nlnZywiSrR96BBI6nB/c2XdEPnfSAHMNbnkEMDYBsMRYXRHNFV1Bm2ExLxqC/7GpGfI25u/JnwIeRNSn1sXZyaPJwCRQ+3vtYiXkVcxGOICEJVah+ItmTmZcw40NPit2tjphRyTBGUIck7vc5Yh6ng6n+cuPHjZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8Qjnci0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8Qjnci0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso31493185e9.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758460010; x=1759064810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c9lb4pmy8u6P2qTqzpbhpSN126h1Y/KlIHYXZDx7HM=;
        b=a8Qjnci0vyGQzEjW2HTbBUEdwbQ6kAsjS+KpCZHZjQqmeCqDxW9XPG9uMxLfv7asv0
         nE0rkZYd4qG/OnZtK4X6BvPSBlPd/xAa6n6SW5t4G0oyCosL2rOCDVm4DLGfgwJzfF62
         /QEtXHROGuTc0to07I6Svv5gnF4z1EV2mkJ9PHG7BFO5ChQd8AQwkkjQF4lDgsjFl1S6
         tnzvW73LnggpCpaBtgb2XvOQwWUTu9QPSsmFVUxzsMfvD6Tld3wkz/pDicdVQUTWOur1
         /oRd45KOZjyiP1yNIocC9LuvGqgggp3vRrCBul9icRXF8LvG2RwTU8MxJHPrLHB4p6KJ
         lAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758460010; x=1759064810;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c9lb4pmy8u6P2qTqzpbhpSN126h1Y/KlIHYXZDx7HM=;
        b=M//o0DFY5f8HtX3lFp2sJCDg0Ae6hZcYwGjP5bQAp2QQmSO8LhPgxf8v/mSq9uHaxg
         XpFLmWQY+f9V4zKwJKnGbjI4YG52fMlhT3ZQikYmGW2PHLT33AP4DOg80aqNzbDaI8AU
         3GQFndtx4kO0h/H06EZT+v8fKr9P1cVqvtqOMFMcibXKeboDUwua0nzpDsXsfhi/Kxxh
         OXWF1K1mQJoCSGYrZGl8ce7bN0nJb4fbpB9WWXWYil4QRmPEJoq8XyVQJ//7xUUgwX/q
         QE4oBGEvOSv5BZrB0k0+Hi2Kfm2saqKVVbs6D4bjjNYTIts3uvRNBokt4E+3y8N2Cw+7
         qO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXb9IMAIbKVERHytVxfgADoiRbVEhzZOO3wbq8shTNVIFUM82bEyyuhdR71i9odHK68NjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUY2RA9WeqR5XlnJm0CDzHNdX3xErqYVNJSLZEh5QvYK8SHyUE
	/PYulHRaDp8DYmi68Xh3p1OQ9LLrxc84BsSdMtvVJS6bkOomMqFasUWS
X-Gm-Gg: ASbGncvs9t5+So/AN0UvxVcJutGMR7KVFzsFci1tUk4sbuCZzrqFg53AgKKMC6jmSMi
	5ec4/QhabTwB/TBYZIyFwQhvozQTPWxYDHKUzcnzTCuhwW4EiKgK/heQCsiz8nrdowRkItexS4r
	iXpgFoEsbPj5q89lUeE01WXmb0uj8DDZcRJlh+6fNU8Qiqyq9Nzs/OmDwE8CHD3VM2IKO1F8XBA
	/pMMzRP55csWL6vAiShUf6Hh20O7URNy9+gZmpVdrX68AuRnKQHX2VbYcWiNdLYJLzOWuXd7qTg
	4ZAMXb1SdCGbdL0EB0anGpWnRAU7glNm8wpJmh+vYoeoKCPgiwX0pkZLdESk/BMF59Vb4xF+bZP
	FGYCSMcdOEfq5aHgnT6S4tCV14KHbGHjv2MGjvwwn2nBZlZlAbeucLq3Ntb618v218qe6rn1rH0
	LRZTV2
X-Google-Smtp-Source: AGHT+IE8Oh9TiOO/qae6M1h50KeS0zbmEXP4GLIEOK+amNLV3s/nCiF7qt2pZ7rowCIW6TBg6COt+Q==
X-Received: by 2002:a05:600c:35ca:b0:45d:d0d6:223f with SMTP id 5b1f17b1804b1-4682c93f43emr109978075e9.0.1758460010051;
        Sun, 21 Sep 2025 06:06:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:600d:1d53:febb:27a5? ([2a0a:ef40:62a:101:600d:1d53:febb:27a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122cb5sm198337805e9.8.2025.09.21.06.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 06:06:49 -0700 (PDT)
Message-ID: <daad78da-752b-40f4-9c69-d6f6597ca258@gmail.com>
Date: Sun, 21 Sep 2025 14:07:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] xdiff: delete rchg aliasing
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <fd541355609b715ebe94f9e025450165bd91d170.1758294992.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <fd541355609b715ebe94f9e025450165bd91d170.1758294992.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

What is the purpose of this change. On the face of it it makes the code 
more verbose and introduces an extra pointer dereference into the loop 
condition. The compiler may lift the deference out of the loop but it 
would be helpful to know why this change is useful.

Thanks

Phillip

On 19/09/2025 16:16, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Best-viewed-with: --color-words
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index a66125d44a..83c4cff6f7 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -932,16 +932,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   
>   int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>   	xdchange_t *cscr = NULL, *xch;
> -	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
>   	long i1, i2, l1, l2;
>   
>   	/*
>   	 * Trivial. Collects "groups" of changes and creates an edit script.
>   	 */
>   	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
> -		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
> -			for (l1 = i1; rchg1[i1 - 1]; i1--);
> -			for (l2 = i2; rchg2[i2 - 1]; i2--);
> +		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
> +			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
> +			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
>   
>   			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>   				xdl_free_script(cscr);

