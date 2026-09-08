Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAD52BE4A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859303; cv=none; b=HyaNl+yNeK2Pg0PAxZd1jXR/DzbQYOzsjhZevmfahw+66uOkuh5/Puc59Z7FaV0i2sexTD4+b7u9I2VrmYzkGVSKWfhyBqpG7/LmiJAJukM0xDoA1nE13BL8uXhqPLCJKO1lQyufT9D4Sv78ztyCCZ4A+wbsEzuRC+5P8h9S/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859303; c=relaxed/simple;
	bh=RXK8oTCRm4Yuq6Lcxa9rWYKxxzwsmEi6LeINIvy3IdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppe6xx+wyPieN//hzAIkCWTrrn7aF72swebpvkSvqlA5GSvWeR6xJQg2OuCUYmQVE3BVc+2KsKh2tdVKC8ExyWIa9lXxgT4KG00hgKJEwhyg/5aBwXxzqFIQy3jbssKwyhvk0yWOdt0c5x/9SbXLjjGPlfa2lrYMBbd6lEJ60qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssZepTrx; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssZepTrx"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f48c750afcso3620150a34.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859301; x=1789464101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lo6Kv+8Mq0olob0y2rL6X3oYQWhxkTdzHEx3bYE1LX0=;
        b=ssZepTrxkSm/NbQVi+kIek7LErPb+ocQARdtlXYUJ8sgJvO2V97S1/uCaglpYKhu9k
         awULcKEeZi8tNg3Bb1UXyL7F0E3zDRSOc2CDViI1kpirxOgNNIwvnQx1xMQDBlRK8Jhw
         0/t4OcuID0KPUMo/buodiC9DhrgnJ8lLVfSeSwch17ctI1zZhYpaBaId4V19NCBEmjm2
         OJ+uu5/2dUp41JNpns6dZxkdgDXswbmikdEyF4u3QZfLbVhsKwcps55ATu62grD59duj
         b6hu19Fq5kEKghkJAB4knOcUsxTpvLzZBRonlXdsdarSKmqg0qt4dHmEP9iquhsDOSFD
         FqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859301; x=1789464101;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lo6Kv+8Mq0olob0y2rL6X3oYQWhxkTdzHEx3bYE1LX0=;
        b=FJs/wdZFGIJNTGzKs0VlmRteJuwHmPDRFLCmK/dt3EOORIRZgHnnOFID1k2y5VBub7
         LzC1Pl9jCohBMebPozlf2+M0GTounhweYdU6aCi+G2FbMrO6zWV7xHTNSRYXj43Birhi
         mh2wGv7A1zIeQ3Ib1kp3TmHbVuXRYQZJwOQwy/VVm/qyXGRoK3hY/1lHxarK7IObFLtF
         KZzSX7klUHu4YSQ/fG6FWwHwLub/iRfg0F5EmOUy95f8yRdQQjwdQGzp4w3YkAi+IVMX
         RsR3g+O9NUz4EmsPKCFBpz610z78J+9+IJx8ig6fT0DWc3OE4vpmfTiOroSSV1DqknFp
         j+yg==
X-Forwarded-Encrypted: i=1; AKwUvBxw1jgUBZYmkWKSkc1JUsKiygIM4Iq0PRmboptFZfmNPWs9TP4dszoHhujBsJytTfKhNvs=@vger.kernel.org
X-Gm-Message-State: AFuF++lyW2/9Zxd5R49TN7NjoPRt5gLZ9/oBq33adsjr9NiJfkrz4Rof
	ApOH2+NBTtJXZwDJlkacToQhH4b5AwdxYrqmzk2Eag4ZoCQKioG35r/I
X-Gm-Gg: AYBFou0CpK5JjalxtQ5oVrsKrxuX/FnfQJe81pX0pWCOzXXmPEskfxdrEVBup0WjQwc
	WG3J+55fHdI5xPsAAnpSWnKcF7nt/iITmN5J256ytvu0Kr22WZK1yd0lz/bzTlKdmRId6TEqbL8
	0BmANC4Qy9DB79/QXv+wZKTmrejd0e9e4bMzJVhv+w3e14iJgaxsKaXuCUjlQBoAMHtuoP+ifSU
	PoP+D+diKKfDTeyT0ssR+hJnCO4kWTpeQuEOhj07LY1X2oleLimSnf1aI1saG67yBgtiA1MJaST
	vh+SrLqWOOdzGn5nfJa+0iuNsIR0c8IVFtGG7C/fROqCKFkv0H/3Z+wXTMD2/A3Ms27Q73yYM6e
	jizIwCTGfcPU8MkCX0inTTRda6KQqSDmbNPH1L8HLWPfTU2SB3Sm1X5/2K4x51eE4bvF889Az1P
	QGNlAov/EQEV65+adurBGNyzy6w2aDpt0MDc/gg6/0k1iNJJdtqnx7CpAN+r7PqC+TNEx+6aIwK
	ewo
X-Received: by 2002:a05:6820:809:b0:6b7:83c5:fde9 with SMTP id 006d021491bc7-6b783c6033amr13430663eaf.42.1788859300695;
        Tue, 08 Sep 2026 02:21:40 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm28146252c88.8.2026.09.08.02.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:21:40 -0700 (PDT)
Message-ID: <1cbb335d-ed50-4e6d-9d11-bd09de1bcee3@gmail.com>
Date: Tue, 8 Sep 2026 14:51:37 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] builtin/clone: rename "--ref-format=" to
 "--ref-storage-format="
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-2-6733c90ca5b0@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-2-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5b25cca510..511fff9562 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -901,7 +901,7 @@ int cmd_clone(int argc,
>   	char *option_origin = NULL;
>   	struct string_list option_not = STRING_LIST_INIT_NODUP;
>   	const char *real_git_dir = NULL;
> -	const char *ref_format = NULL;
> +	const char *ref_storage_format_str = NULL;
>   	const char *option_upload_pack = "git-upload-pack";
>   	int option_progress = -1;
>   	int option_sparse_checkout = 0;
> @@ -981,8 +981,10 @@ int cmd_clone(int argc,
>   			 N_("any cloned submodules will be shallow")),
>   		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>   			   N_("separate git dir from working tree")),
> -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
> -			   N_("specify the reference format to use")),
> +		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
> +			   N_("specify the reference storage format to use")),
> +		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
> +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
>   		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
>   				N_("set config inside the new repository")),
>   		OPT_STRING_LIST(0, "server-option", &server_options,

Ditto here about either deprecating / using OPT_ALIAS.


> diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
> index 1ca245c732..5eaf689d74 100755
> --- a/t/t7424-submodule-mixed-ref-formats.sh
> +++ b/t/t7424-submodule-mixed-ref-formats.sh
> @@ -63,9 +63,9 @@ test_expect_success 'recursive clone propagates ref storage format' '
>   	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
>   
>   	# The cloned repositories should use the other ref format that we have
> -	# specified via `--ref-format`. The option should propagate to cloned
> +	# specified via `--ref-storage`. The option should propagate to cloned

s/ref-storage/ref-storage-format

Rest of the patch looks fine to me.

--
Sivaraam

