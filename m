Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6019470
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317946; cv=none; b=Ufp6fToWMkXi7BI4ortaWW4HcnFnJv2YAbAVWI8zstcl+9hWqhXlPdDHa1BkuBTUzuIae2SD0XOlwTnDi6p0LgOVkXILPwnqj4DBBZfHzO+ESL+BaYC2fWnuLuvn/NosUYt3MUS3JoSeOGH0PzlYmyYVoMelNpO/dZeJTsWy7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317946; c=relaxed/simple;
	bh=oOOhbNhkcpSwlh7MsdNPIBmxzvSQ1f/U4nea7nIC0Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUaw1NORy0ItKg058kO9gBMfHvpIHoOU5ZeaH1qF6JyY4Lj0geBaD1btmdxZIm221P5py4tFUc3d6OGWA4h7q1Wplo44r3KYGrt6XrT5eY5Qm5C47TcWWoc1PVlQy+ljItjbv1GT8DZ2D3GUGbMVhMvzpZOZyxl6Oum2k42itDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVVvGknf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVVvGknf"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334adf7249so802231e87.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724317942; x=1724922742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IHB1szAbSia3OZ5xVbYHkaD5WA0wgMQ5dqoMwztv7T0=;
        b=fVVvGknf+u46jzlPR393oYt93UlnRVLuYw0BRZoT7xR2psepMuGGVCZGZFT5j8TR0O
         oMjv1jYrA3aSaDI7+Cj44WexCr/c2RWTkX+27nyWHjd+vmJbMyBBTjVwagqFCLH9IL25
         BFNjSk9U41N6l1AP3ReMgD0XeYkc4BzdQhTiFE8XVS9K8kWk2991pApnw9eKP3lLu3cr
         VU0Wq98dWZ6KuTPnfezRnj6jMsJeLBjkyh2sIn8cxtHwVwNGex8wbg8RkATy4HDnUF+s
         6kliR+CDJpeKYKA0FueraHAQdBxVSsaqZ5/HWz4/2pKWnp0H0vUfEdXdlQ+HiuQFMGvz
         i92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317942; x=1724922742;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHB1szAbSia3OZ5xVbYHkaD5WA0wgMQ5dqoMwztv7T0=;
        b=XH6IGukvwEUuCZn9bDxAFhYU1vWuQKW7aTGr0ZB1KLFS08FhfeuujFUPKWz4kG2NW3
         ctmzwn/KAGpEhTuVMn5cZaaScWbRayhrYDCdsWVoJ+h5YWpXPwxMx57DYcYXub8ADwpQ
         aoarBKUdJMfK/iwIDHziREiK1Smrk2NqIwbIh/ynpbgsR7SgsFf86S2HG2Cglc9SLF3Q
         oNZgyotohVFm7AZYUPGmNiYJAI2MnErPdn9xMZmsZ11zIhWGG6jYZpE8RyhTS0iDxr5A
         u2voS93LrP+l9lW3VahHrRZlT8sPTJ+JTeu2UDU+Eb5aFSLKUlMtii6G1PUn1nvHOol0
         Kn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYt2eT1k1OL9BV2ywQpboU2D/+ydf2jduBcsOU8zxgMYdgn+59mPEZlqM9rcjfVLv4ECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVyJeG7nIKj6lkCn8AYuiewrno32nB9EeWn8J5H7sVOPA5+7K
	nHDLMA5LFuKZsvoYYmG/vP63stcZPRCs1fSe3BItQ8JD/OWQ+ZMR
X-Google-Smtp-Source: AGHT+IEE/J0b1GAKb1wgYK+OiiN+sMbCU+KyK4xvD2JEgR5LhIq3zZr3sl/vJsWHbSR+7zZlnC5+aQ==
X-Received: by 2002:a05:6512:15a9:b0:530:ad8b:de11 with SMTP id 2adb3069b0e04-533485650bbmr2796497e87.9.1724317941820;
        Thu, 22 Aug 2024 02:12:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f433671sm89045666b.128.2024.08.22.02.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:12:21 -0700 (PDT)
Message-ID: <9c6d8fea-997e-49d5-9195-e1721a750a36@gmail.com>
Date: Thu, 22 Aug 2024 10:12:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
To: Calvin Wan <calvinwan@google.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 spectral@google.com, emilyshaffer@google.com, emrass@google.com,
 rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org,
 sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
References: <20240821184605.341205-1-calvinwan@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240821184605.341205-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Calvin

On 21/08/2024 19:46, Calvin Wan wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
 >
>> before the function declarations. As I said in my comments on the last
>> patch I think we'd be better to namespace our types as well as our
>> functions in this library layer so this can be resued by other language
>> bindings.
> 
> Are you suggesting something like "#define libgit_config_set
> config_set"? I wouldn't be comfortable renaming config_set in git.git
> just yet until config/config_set can be a standalone library by itself.

I was suggesting[1] adding

     struct libgit_configset {
	    struct config_set set;
     };

to public_symbol_export.c and rewriting the wrappers in that file to use 
this struct e.g.

     int libgit_configset_get_int(struct libgit_configset *cs,
				 const char *key, int *dest)
     {
	    return git_configset_get_int(&cs.set, key, dest);
     }

In public_symbol_export.h we'd then have

     struct libgit_configset;

     int libgit_configset_get_int(struct libgit_configset *,
				 const char *, int *);

If we want the symbol exports to be useful outside of the rust bindings 
I think we need to namespace our types as well as our functions.

[1] 
https://lore.kernel.org/git/5720d5b9-a850-4024-a1fd-54acc6b15a74@gmail.com

>>> +    pub fn get_str(&mut self, key: &str) -> Option<CString> {
>>
>> If we're adding an ergonomic api then having return CString isn't ideal.
>> I think the equivalent function in libgit2-rs has variants that return a
>> String which is convinent if the caller is expecting utf8 values or
>> Vec<u8> for non-utf8 values.
> 
> Having both get_cstr() and get_str() makes sense to me.

Just to be clear get_cstr() would return Vec<u8>? I'm far from a rust 
expert but my understanding was that crates that wrap C libraries 
generally avoid using CString in their API.

Best Wishes

Phillip
