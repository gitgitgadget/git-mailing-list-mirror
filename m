Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5042DECD3
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709323; cv=none; b=OFwVJ4wCQkAqx358AYPON6wvV32YtwMP5nrH0Ofgq/cFK6HipzqI1pHX2UEdT3Erb1UNgG9hqLFx2jLVa/vjCk3LACLZAoWwUqtHOEOgX2z2InZmj68cUVRX77l+DPVivOhlmZ3FW/LY+4lkhd/ZlJz5GO/PSFQRH7dfC+rWbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709323; c=relaxed/simple;
	bh=koChYTBc8Ev80td7RjG10VOCJwOjidTEiJ5aFe/FrMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdUx3/S0ngp0N63DUxmr6TLQyNO9njiE4tondcR3vh9hqtAwUOdlQ212QH6oMltBF99nrWlolVjNCBKdLKtFw7CKNIwkOFRFjruiRd5AQPMkm+vqNrFvkp4GuZi2Cn2IhB1s0g8bJ7DVVpt7m9XCbawxdcibQPS2OEtgKhBNpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnWlOFZd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnWlOFZd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso4197235e9.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709316; x=1759314116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNuvz16jb48lSwD6HvUeVn3w29xeLPlOp8ZRF3U87Q0=;
        b=LnWlOFZdZfyT/Y1gp8cy0R9xU4SobRmkyg7YUCJMaO1tnPZV3lwtUnPTUNr1x2gsxo
         Khbua3K1KpAxIpR158gHmpInueUD+PAEKPJIEAKYOLnIVMJhCfhj/mmJuO2eiumZx9XG
         WLz1e5sRFb6ffCdcKRq7qGNYajss7mk8MERTKYZBckhEwIwtzp6RWo6ENyagcZUxXCgg
         TmXH1FUb5BmG4+5tECwbvHF3+EXc1FhIj68RVeKRM6OlRxuKtOOS9kZvMsCm/Gvtx7+e
         BDldHjyeTTrYhHJZ57p8S5LZWU2/xjmxI+3cnUZH4pyezJUWACTeEVxloX7Yd5QDC/4A
         /31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709316; x=1759314116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNuvz16jb48lSwD6HvUeVn3w29xeLPlOp8ZRF3U87Q0=;
        b=f3NW08PVemHhtBjytMqTzTALxVJAd0/T+E6IGXckc7gqBIz3UCuE4yblW5mECZcJ/v
         TBpNzfDE2xWDoTY4r2NIvT5UFoWx8MjeVrueSBFUIfE7FDyF6ky9miu3TVeZjKirUt7l
         0ad9QDixyawLmwlr3Y0XUuH2eFdTIHxJBplFGx323AGjG/KJW2HBSEOiicFVjprQzysc
         +2eD53Oc/0N9ZzZnTlwHn4NJadEjWmCN8F8IHPKMfD/RRRBr0mrxhNjkVldvlAPEbjSv
         MNs1dsiIKDR5eSn/oZM7nIMlA0R1Qa3nJ8JagrDulfL6GGh8mcRZDkYaA4V/HCS53UbM
         8GDw==
X-Forwarded-Encrypted: i=1; AJvYcCU19HWlj8dEuI/sH8lt/b4VHsMIScHtAgzXwlEuxL7gUbRFZJBihdX9/EIrROry4weGGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvizADWeRdls3A83yi+KWCJgz6ZEfm62CsZpjDTRJtMqn4yUn+
	lR5OpQz74D/nFFYqaQQr02fUwRwInmfbNAWoG1KyCuR8Y3Z+RTSr+/yB
X-Gm-Gg: ASbGncslufPveRpA0aedWykceei8nNDnU+K54ps6UJMNw3Ejfhrs9K+1TyqdGPGbHaF
	CF3WAYiZRl85ZCbIcZp/7Fk7mkj98vd7KwPv4VjGUOBkxYqLyqF1nFqBrDMRqiaOtwKpWPGXHiY
	UKsFKnmC//F83rZ1Y7WA43695kOhplogEer+GX1zqnXvHu8VSieGS9PIZvjY0CAP9NlgDZ1UYrc
	9vJpGnbbuZoXwsQqiAvKGx9OXzQMxrZxDy7/khqja1lnzwjrFeNCHnmC22pcHM4hzPo8XkOFmjc
	c+nJ6ZyPHMocOvSCQ0XG/GR0BNZFcp1NqKM3BCOywRgYvfzJ0OdXtsm9uxzQXs6vuYyPeBGjc0I
	/30JbRQDQSFFRx6rERlsC8x/P65VbIhE6Y4vtRsELce68a8he9Z3zcWJ1f33z2nouVbUdmNMUJl
	UHvW+r1Y2leHbO
X-Google-Smtp-Source: AGHT+IEirQs3UmrDur1OYucQ0XyEYogVUEMI4q/EkygKZFbE2FYQjqQFM88iMgH1FzZxOk9KUFhvgA==
X-Received: by 2002:a5d:5885:0:b0:3ee:1125:5250 with SMTP id ffacd0b85a97d-405c5052405mr5241039f8f.24.1758709316216;
        Wed, 24 Sep 2025 03:21:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:5052:777:6f22:7bc0? ([2a0a:ef40:62a:101:5052:777:6f22:7bc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2c0203a1sm9445235e9.9.2025.09.24.03.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:21:55 -0700 (PDT)
Message-ID: <3d03290e-bfad-41de-9735-91b126ae9e57@gmail.com>
Date: Wed, 24 Sep 2025 11:22:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] xdiff: delete superfluous local variables that
 alias fields in xrecord_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <1d550cf308a189721ba089443f29678ead0344e5.1758662670.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <1d550cf308a189721ba089443f29678ead0344e5.1758662670.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Use the type xrecord_t as the local variable for the functions in the
> file xdiff/xemit.c.

This explains what the change is but not why it is being made. Commit 
messages in this project are expected to explain the reason for the 
change so that future readers can understand why a change was made.

Thanks

Phillip

> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xemit.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 40fc8154f3..2161ac3cd0 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -23,12 +23,11 @@
>   #include "xinclude.h"
>   
>   
> -static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
> -	long size, psize = strlen(pre);
> -	char const *rec = xdf->recs[ri]->ptr;
> +static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
> +{
> +	xrecord_t *rec = xdf->recs[ri];
>   
> -	size = xdf->recs[ri]->size;
> -	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
> +	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
>   		return -1;
>   
>   	return 0;
> @@ -111,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
>   static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>   			   char *buf, long sz)
>   {
> -	const char *rec = xdf->recs[ri]->ptr;
> -	long len = xdf->recs[ri]->size;
> +	xrecord_t *rec = xdf->recs[ri];
> +
>   	if (!xecfg->find_func)
> -		return def_ff(rec, len, buf, sz);
> -	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
> +		return def_ff(rec->ptr, rec->size, buf, sz);
> +	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
>   }
>   
>   static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
> @@ -151,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
>   
>   static int is_empty_rec(xdfile_t *xdf, long ri)
>   {
> -	const char *rec = xdf->recs[ri]->ptr;
> -	long len = xdf->recs[ri]->size;
> +	xrecord_t *rec = xdf->recs[ri];
> +	long i = 0;
>   
> -	while (len > 0 && XDL_ISSPACE(*rec)) {
> -		rec++;
> -		len--;
> -	}
> -	return !len;
> +	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
> +
> +	return i == rec->size;
>   }
>   
>   int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,

