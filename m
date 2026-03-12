Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39631B4F1F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291798; cv=none; b=rODuG/LdA/BCY7Wdj3fkRWOIziIfIwgZmiwC/J8fdvdzglX49eiuO16xnRNiEHiSsyZcYqw4GxJIdCP6nIVnzKK1aKbk4QQjKgeeCm+mke94R0IF0fukRVEOSpn4Ag/I+u5jjRxyiXMW9gXNYFXNcb+ijmszcJc3XtD80aeLOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291798; c=relaxed/simple;
	bh=1pJHyRtUospuQxSJiRI2l7EpaGo6pD+dUq3tUv16aFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey1lxxuQzTposJ+IJJaQOz3cCgasW3f8UtnbDNnWXcRSjt0DlkekDF4ifiAbC5hTW33lfcpd6LVLGBeh904S2dj1Ob2x9q9hZc+xT0gZOfjbipc9lVn1pPRfq2nMz//WzRwzxMXXOQjZ3FPchYqboNSqRIJfyYN73m/+XKRdTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqfP3Rme; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqfP3Rme"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so330455ad.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773291797; x=1773896597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zQjq4qR2gKW60KWKVxhElXcgVrUF0DzWE/68u1/3Ws=;
        b=WqfP3RmenaxKVmwSN72vISQ/f/WZPpODv88WFTUT+BpqNmbeTrIhORCYGqTGCOGqyW
         oYu+Fhmtwd6sjU/ySu+hYqMQRkt57qC1mPEDSjMbhn/Gq+hLSMIvlqW+XYF36tYq2We0
         0s4pTL18kAsKyYlZULmwIqhYV/LWx409HQ0nilfNf1dMEaSJXTky6GWbcdN6QAjURgrN
         mYsS3owTM40QMuFjqVR4SDaCEOEswm26j/bALc0Sl0TFm01tvQ+3Oi019RcBzpXm2J73
         +EVxNR7ObNiQCYBxoBstzckJpeTnaZ4+kXOrHIvjtcKtqgcKqOw+2RUze+aNgsWD0Z88
         zkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291797; x=1773896597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zQjq4qR2gKW60KWKVxhElXcgVrUF0DzWE/68u1/3Ws=;
        b=RjIFxFf/ECHEDFW95OEV70LWVrA/GqNuMgoDSb0blLXbhq2OxfLizvNLRJLrZBxMNO
         kGU9AyHsumtECTifY1xyeTZo27iTkK+5HH8wHefy60AxDkCC7898sMBxja198RqJ7c9T
         WRZlpWBDfRAm5MPIXZ0g6K2Hv448W9Yggcgf4VXIYa8/lyin5j4nDz9t1SnnfoZId5wg
         G/6F8Iejct9GhwdGEp3LaWm8w/cDjCCF0z+9q4MgYA44vyijj67cM2BNGtUffLVs6+u+
         sktHZhvzq88YnLKxDHqtj87Wv957saVJwmghp/SX4vxmqo73jOoEgsJxtPX/k25iQWCB
         RU7g==
X-Forwarded-Encrypted: i=1; AJvYcCWTVV7PLNLh5ZxcA8W2NZ+SZN8+w4qAjQvb7CIGxpxoeDMjyRbd2mt7rrNYL17vd74G0Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPpusXU3hBnHXADoWutjAsbS8TcmBwTM8i6Tgo1adRVuslCG5
	ikAJ0TcdyelJlfWLg6D8qyug99dGO7Br0TBAsgssOIJE56yBTNw8bTjI
X-Gm-Gg: ATEYQzzPvLuhuh5B4jKPEVYCOtOF2OiTVDrXMJImNAo5xBZOoWs+hncjRjpQGt2tZiv
	j4RfGFt2ddSSv/CyMpQ24hzU4oqIT7A9pOqpba6q9H75jBIWBDLAxjzvRJY2kGLXJVWJLXDDYOu
	FEQrqEKrIVCWW3Ly4MaK1ZtGtedv+8K0PwJuNi5iXqLGCNtKzd6zy98d3glK+MNKoTQLF4oT5oP
	EVKQNsUwy9ewQzrsdcVF2ga17NVa8ES0diC3EW/eBhk40xnhiN9RIPwJCJ/tAc0W5zoAjn6JqoS
	yIn/TN1pA+c788JgIb6lplSRuNY9Ykm6Owpo7sJSV9ZRqQbJ7J/7LBZQpuh7zDBJf2NaHvCQPF9
	1p/nw9h14nL40UnK3ZZyh+EL507eBKPH5xMYc3aMBazd2iAHdGr//ndNXaOAwSf0fNjgOSZxouC
	lYY570qNH2xPAfSYefBTGnut/pZJQuNtWkrHjiHX3LgoXxmeY5Cdwnphx5uzNjwtAT2t604XlOo
	hDwVT93DQuj
X-Received: by 2002:a17:902:d4cb:b0:2ae:8252:d670 with SMTP id d9443c01a7336-2aeae7a30demr38816225ad.1.1773291797118;
        Wed, 11 Mar 2026 22:03:17 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aebacfc71fsm15468245ad.21.2026.03.11.22.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 22:03:16 -0700 (PDT)
Message-ID: <9f9a2e8e-6db7-4105-ba2b-7e42bff2ad1a@gmail.com>
Date: Thu, 12 Mar 2026 13:03:11 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] repo_config_values: migrate more globals
Content-Language: en-US
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, phillip.wood123@gmail.com, gitster@pobox.com,
 christian.couder@gmail.com, usmanakinyemi202@gmail.com,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
References: <cover.1773127785.git.belkid98@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Olamide,

On 3/10/26 20:06, Olamide Caleb Bello wrote:
>   	int status = Z_OK;
>   	int write_object = (flags & INDEX_WRITE_OBJECT);
>   	off_t offset = 0;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>   
> -	git_deflate_init(&s, pack_compression_level);
> +	git_deflate_init(&s, cfg->pack_compression_level);
>   
>   	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
>   	s.next_out = obuf + hdrlen;

I didn't look closely at the other parts, but I have a small question 
about this section.

pack_compression_level before this patch is a global variable:

	int pack_compression_level = Z_DEFAULT_COMPRESSION;

and struct option  in cmd_pack_objects contains its pointer:

struct option pack_objects_options[] = {
	...
	OPT_INTEGER(0, "compression", &pack_compression_level, ...),
	...
};

The reason why functions such as do_compress, write_large_blob_data can 
work properly is beacuse they all read the same global variable, right?


However, in this patch,

> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +	int pack_compression_level = cfg->pack_compression_level;

Here, a local variable with the same name was created via value 
assignment (I also find the naming a bit odd).

> @@ -383,8 +383,9 @@ static unsigned long do_compress(void **pptr, unsigned long size)
>  	git_zstream stream;
>  	void *in, *out;
>  	unsigned long maxsize;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>  
> -	git_deflate_init(&stream, pack_compression_level);
> +	git_deflate_init(&stream, cfg->pack_compression_level);
>  	maxsize = git_deflate_bound(&stream, size);

But then in the do_compress() function, the variable being read is still 
that pointer, cfg->pack_compression_level. The expected input wasn't 
*written back* to this pointer, right? If I understand correctly, after 
parsing CLI, the output is written to the local variable rather than the 
cfg. And that's why the naming is a bit confusing to me.

struct option pack_objects_options[] = {
	...
	OPT_INTEGER(0, "compression", &cfg->pack_compression_level, ...),
	...
};

I think change like this is needed. Of course, you'll need to 
double-check it. _(:3 」∠ )_

Regards,

Yuchen
