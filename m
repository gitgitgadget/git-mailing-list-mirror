Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BC284690
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950259; cv=none; b=smnTDddP55uTiXN4EKu3ihCMO/fYIusbIoOHR3SwaG0pS+bFMql6NESynle1kE6ynQvc4Q/iw7n3u5hSw5A4MrW+78yQZl0XeK3CKIExXLxkYgqKXmvNJ4WMR41mbKir6sVun6N/u4CVi0xMbX0lu4RQHJO6UxoD9hgRsOhQ5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950259; c=relaxed/simple;
	bh=nwfCqr4Z1W9DJ713pdkfvL83VxVChy/CjN1x2XeGFYs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PfiLSFaeYdftUDsVs7sGbnFuWMt28q/sDSIcNk9ODr8MptykgthzRX8uhII07TRcXMqr7A1pwxfeN2SmyvUzoitrTjHNCjXKX39fm5ifzX4b2cRRwgx66wwQmh7rWZ1H4OEdEPQM19p5QcQyTlgeiI3T0FcW9ytImXzIW/PbZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiKWYNUu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiKWYNUu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso3166468f8f.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774950257; x=1775555057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kz7snUpdJTbWrV3J6Sw4RAP3EZ6SRo3Vvw4SISqLLdA=;
        b=SiKWYNUu/BoMgcQ4cyiwmx5fFduVCWMLF/nd2xpM9yYtWps6lFEK0UB8ryXprpQzn4
         rJERiLxRkVbiAm8EjkTuZXifv5f4zMRpEvG1S02I3BJyYXM5/F1/UchOdfl4O6r3SEwY
         Q3e1XrVMENrc9T4ykC3Y5SYzdN/KBDrj5A3Hw/4iWJhVuRI8cGlgNXWpYoF63f9bJ0BR
         k/F9dSMRXz2E8N3RCc+3Zs3JaqpiROR2gQ/xMmZ1QdxvCCwDTXC7qHG7WbtWg5nQoDEN
         j1Y8X79rI/ObRiF5V/MilsgIMZ6AH3XYpc7tFouny7PnAaGAWkQwjl75iZHAFAZ/KaLn
         nD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950257; x=1775555057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz7snUpdJTbWrV3J6Sw4RAP3EZ6SRo3Vvw4SISqLLdA=;
        b=WyZKR6hPwUNQ8DzhG69z0/nXPCUz7Z6GOhh/KscW8tcgvRQxx6YJ4Q9TAOc4SX9nhy
         8NGcgtUvKcVw5jG3ug+9Nz12vHLSlmFmjc1pH4YyNjQsu7TachrvvN5zAxpcWlqhHX+H
         4dA9nZzx/PzwtfPcp6NeaEVz90vF3+r1R1E8k6ixt8sD7kBDUOj1UdYdnvB7PGeJrq3p
         j+1IsS3QFAw6TW60WzbDWYhOykkNIj94pLDDLgLaleiTsEKP2gVeKpRf3dHOWbDaSgKr
         JgzROHEQgGVMZnIVav2gaBTZSOCrhT+iHchzVBuZ+/r3h1EyaVaUbxDy20+fMwSwYyQI
         kubQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZJYv1ApWt1kLAn+8rLRFH1MVIuOmQQA8ZJ04Cv5aT1Aa3R2It6pF7UmDWBVvfzi4pOlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtpoqFrArXx3oflaZpYkGgoMlBCA16H9GfNNHhZ6b2WAGstjg
	UICFiZcrau5jIYTnFEEBkrFxvyAR6ONt2H1HOHcZGUXMf8y+ZS6S0/u+
X-Gm-Gg: ATEYQzxM+9ORT/njw8t21zhq8xqM2qxaDMfjcIcEH3/2gjKfLT+Prxi1c+QcsjT1BMV
	mDL6nwWzFgeeoPE5khrPDyTrhvkXV/zQiOh+Debi4v5QC4cf4nrGhsQMMq1cdDGUUP72DiebMaO
	hqkhpPkfb34VivjhruQ191iYkJEONJp/D2n/OiF9PqqHRGmIs8XJi5tqQ2cI95/Rn8PZrE0Xuvd
	JhHOSQAaRyy+xUU9aOxIKCChaIotwCyPhDDnbIDBDNgzBNNXoyhD2nTH/NDd9M33YLoMxfaDkvv
	czk2qWPknY6+teXnW06mVcfnS4I8LRqe9sKYFSkRq8Av+mb43AqEusclW+69rEIV0ZuxyKRAshe
	jkJ4YXdnfRtvdUvvQYxTE31u6jYkGpbGd5EkmuWujQ+ubKkdonP2uHpxsw8Lh3VBasFm9TC38vS
	rWTAUwk8qpJwV8NM0fMPPJpEu4JekFo1EibPEWb+q5g411C92hh2HkYHDRxjNSy8T5Tr0RCY7vR
	Zc=
X-Received: by 2002:a05:6000:1ac8:b0:43a:c70:6f0d with SMTP id ffacd0b85a97d-43b9e99039fmr30089383f8f.20.1774950256964;
        Tue, 31 Mar 2026 02:44:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21f173dsm29501341f8f.15.2026.03.31.02.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:44:16 -0700 (PDT)
Message-ID: <32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
Date: Tue, 31 Mar 2026 10:44:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 30/03/2026 18:00, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Make the handling of per-file limits and the minimal-case clearer.
>    * Use explicit per-file limit variables (mlim1, mlim2) and initialize
>      them.
>    * The additional condition `!need_min` is redudant now, remove it.
> Best viewed with --color-words.
> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 386668a92d..bd8baf214d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
>    * might be potentially discarded if they appear in a run of discardable.
>    */
>   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -	ptrdiff_t i, nm, mlim;
> +	ptrdiff_t i, nm, mlim1, mlim2;
>   	xdlclass_t *rcrec;
>   	uint8_t *action1 = NULL, *action2 = NULL;
>   	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   		goto cleanup;
>   	}
>   
> +	if (need_min) {
> +		/* i.e. infinity */
> +		mlim1 = PTRDIFF_MAX;
> +		mlim2 = PTRDIFF_MAX;

This is a nice improvement as it simplifies the checks below

> +	} else {
> +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
> +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);

As Junio has pointed out we now evaluate xdl_bogosqrt() twice which is 
unfortunate. It would have been nice to mention that in the commit 
message and explain why it does not matter. Personally I find the old 
code that set the limit just before each loop quite readable, the new 
version sets mlim2 a long way before it is used.

Thanks

Phillip

> +	}
> +
>   	/*
>   	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>   	 */
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>   		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
>   		rcrec = cf->rcrecs[mph1];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
>   	}
>   
> -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
> -		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>   		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
>   		rcrec = cf->rcrecs[mph2];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> +		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
>   	}
>   
>   	/*

