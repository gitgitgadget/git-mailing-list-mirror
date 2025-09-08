Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B6208A7
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341399; cv=none; b=OXbH8+OiM3ek+cq0dxIf6Nr8QU/eZN0f9T1Ykaio5C2R16PYXWVg905eSeNznYBadcrLq2vEIsKDkeoyFC/DbiRFRsI8gNVlFzQckxh+edJUZ0lpfFcV6/6p5bgDJ+w2GTz4amFP/KntwyhvNC2Kr5s7/KGVr1ZCk5Uw6gyGZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341399; c=relaxed/simple;
	bh=dNk691WwCIjcaIQvwO4TE5JPICWX2OUBfKnQsOrzFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMN+9JFGyxsoBhq2KWEUGzbZP88dB54DYgViwxiUD+J92onsz/CKQ7uJEqtdZ1b359vIfTW9Sk5JutVZGICdCfq9/vW28OAmPNt+hfVOeijooG4ASxpUL+pJOaHnb5BqH/2RTC6dcsK1f3uCWjH7Tmykri4Air+Hox0X9Uc+xiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk0U5hwe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk0U5hwe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb659e858so30866955e9.2
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341396; x=1757946196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z+ybVOOjUNJLVknDeBtp6P1I8RHKXdXc6mQcLlaR4Yo=;
        b=Kk0U5hwewvFbcSRIPUWHpT/+Fvv+oRZpRQDy2FPjIJ1ZLPK7Ds4vPe8zKYvSkF7ER/
         +4eRuYRKDlu9uB5PHIdTAcxGUfw8Kv+04GsApQ0n5TQ3K8kA9VvIQqXkjyywEIXi1cPY
         EPechNSN2mW8PHf11oZSFQATSOwtIzUlcW3INbFwBp9D6zkYCKyY7tpFfGC7prsp1+ru
         pjbMUrCKE3KYK3LWzZRVkRHFqVQeXJ+yRqz8VLuxXrxap8U1HSARrQ7mLLhqlSziKkWr
         TM3zx7toyu1pKAyUDeyd5jRotpYfFIpQXXKFIStnvz7wbau/E/9xig6GA0tJvJ0CKmS9
         nxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341396; x=1757946196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+ybVOOjUNJLVknDeBtp6P1I8RHKXdXc6mQcLlaR4Yo=;
        b=f3k2jl5Rix5l+zFe7wW6X3y9HC66VQtUhTMIZCOnEu0SAHNI5C7JX1mdTkiBngjNvx
         7UAqDoWASjrqX3ZkEzlK0ytALhABX3Rg8CHziH5QpmX/B8gwd8ecgpC6u86mDV0wBPga
         bhx5YIr3ZK/Z4rEjSsYlodwh2apsGuo5++vIUIc/y7ldac0SEJgOGd5atxGXhvSZKiLQ
         3kV4r7B3HnUhMwy5husrEXvqq+PEacmoGvJMAue9TwaLiN+jIKZMwAsH3jwEy+EI36B2
         Kj+nj1eH7Zqb9Ush6xIvYS0j68LqAJhzAaI7cNqd9fJtTM97zEpS3bjty0cWcmvKBocZ
         w//A==
X-Forwarded-Encrypted: i=1; AJvYcCUOqH2Sm1WgJnTyr2rzgEGod1ke6l68Ei5ifROSSO/j4H1m+rSqEuvfqVr8vhbqs8KfZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy44FvEm0OBW+S7bG4F9MKgBpXWG7HnhxwEr9m6nGZ60Tu6Gbl
	SKxY59mUZuXv5hnzfXCvFkC6H/PK2JcpCU7c1lJTPIHwhmqpVcPAZzAC
X-Gm-Gg: ASbGncvBPo4XTwoFYdj6AFTXEVG7K/Q7nn7G5XrS16y81peDtRmqtSpsbI7IqbhKr/W
	AtqFS0M9291S2Dq+m47h1UnzAf7+iZ9Bh6rfG8WfAU85ZFXcygBLXlWzuXgVteitW9uXXzrKSfS
	/EvO2J0+tIvTmz3SiDjbN0TovnrgNZ8pEtKAbya8ufdviUZIVHvBGTgqFQNbjjiTCi4Yf/vdv0/
	GRJWr4vB8KfWIRLrbpU++23+qA10mLSxQO9qdjYVP15cnAE4MMJDl7y209D+1ncmisTqDwHZZaG
	ARfVYHVetgaxxHc10vT3LLMBsweddx6kD2PScR7JKqkmSNrdMe73JduHHKu+30joOI5Ncg0nyZw
	oV1CXIe3XcKC+KNKZYnNzz6gGisszLPYMn4ukBKSq4EU58aNJHkARF7PhB2Ho3rQH1rFy7VIyUX
	+VsMnRqZJ5oCTVYGs=
X-Google-Smtp-Source: AGHT+IE2Ld2+iFRriIaVi2a+KSW0yVCAgJDbW05GZhzZadE/DxRTLCB1AcavGUvwHK1TPSPRM76AQQ==
X-Received: by 2002:a05:600c:1381:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45dddee9e66mr84601485e9.17.1757341395809;
        Mon, 08 Sep 2025 07:23:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm41711800f8f.15.2025.09.08.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:23:15 -0700 (PDT)
Message-ID: <c64c8c73-13db-49c8-a3d6-a4ce8b554867@gmail.com>
Date: Mon, 8 Sep 2025 15:23:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/9] submodule: remove validate_submodule_git_dir()
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-8-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250816213642.3517822-8-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian

On 16/08/2025 22:36, Adrian Ratiu wrote:
>   
> +	/* Trigger a BUG if these invariants do not hold */
> +	p = buf->buf + buf->len - encoded_len;
> +	if (buf->len <= encoded_len || p[-1] != '/' || strcmp(p, encoded_sub_name.buf))

if buf->len is less than encoded_len then the pointer p is invalid. As a 
valid program cannot create an invalid pointer the compiler may assume 
that buf->len >= encoded_len. We should check the lengths before 
creating the pointer as the original code in 
validate_submodule_git_dir() did which looked like

 > if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 > 	    strcmp(p, submodule_name))


Thanks

Phillip

> +		BUG("encoded submodule name '%s' is not a suffix of git dir '%s'",
> +		    encoded_sub_name.buf, buf->buf);
> +
>   	strbuf_release(&encoded_sub_name);
>   }
> diff --git a/submodule.h b/submodule.h
> index b10e16e6c0..0b7692bc20 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -137,11 +137,6 @@ int submodule_to_gitdir(struct repository *repo,
>   void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>   			      const char *submodule_name);
>   
> -/*
> - * Make sure that no submodule's git dir is nested in a sibling submodule's.
> - */
> -int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
> -
>   /*
>    * Make sure that the given submodule path does not follow symlinks.
>    */

