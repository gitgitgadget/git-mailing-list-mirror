Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731213054D6
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152229; cv=none; b=gO6LZ7zFkHM5GazX3VwlTTHiHVNBak9KilHuCM4JDOdslG6BFj5DKMufkhJbHbq6ofDjobjxzB1DuCIWFKNsX+kfMS9e83y03NxImYiEk2sQO9weo9TGqmnp1t+6FXLizwYUWxFxaY5MGwc/Hl37DuVk2+SrpFf8Gkgur/OqlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152229; c=relaxed/simple;
	bh=BH/Wl9qvmB27ND2uMX+7zBDUrrJwyQ/axNgtg8FqsQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt4ddtx4deXxqH3wt6jafIqpt2v0cP4NYHWvm63YYU2BdGv98CSJ8E+I+PK7KDumomvECSE+2C9byYzHlDPj13A1TqXzbaEX4e77bsHVJoktyCFEUSiAFGfH894V3SXKNG+tU3TXXrSz0u4utE6KZvlU46GjLXs0ZuQ56r6o7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Y0nmRi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Y0nmRi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so4026386f8f.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759152225; x=1759757025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkm2TPMRDM0Oy2LxDNmclwJ3PUtD3RBoxnPDU4k9hqg=;
        b=h7Y0nmRi5QU5wU8ff9hx0+dMmhxJjsKUGFkok9UChxteqhcebIehCMV/EdIf/TD4p8
         7eCUz7A4AfJEiOHPaa2tFE37ZII9681st841HL68uFUkqzn/ZHJPjA94yZXmeSoQV/4Z
         g37dlHcZ1W7uE+puuc2WvH3DydU5l90V5nMeFGcsX4w8a9owSBRiYIWkvl5LFna6aw1A
         1B+8NCYZJMfwZ2GVzrNwY9z8VuSp+GkRFKYBPeAWK6g2HH4mK7J0nYh/37ytn0+ztc5y
         +hMS6WSgLt5vU7g8wlAqeqc90VwSbMIydpmNjR4mqUMiHi5jhPwFzx4jwW+s/RQmH/6Q
         MpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152225; x=1759757025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkm2TPMRDM0Oy2LxDNmclwJ3PUtD3RBoxnPDU4k9hqg=;
        b=LTOOYla9USUONgrk7FMUs1/eUnIBDAwpkzO9bHMhY8Wmygd6dUWq+XG4s7H0CK443a
         hZdNyjaxDYw72IvcdSzUpfRcHz9GRm0Ew43SUVYtug+cO2j2E3u1WpokdAnbw6e2TtVA
         zIenCCjs6OohF026NCKYLMFasrwOVUPCb4FSEEh/avsVkPWBdCkHUoX0WAuN//EJjx7W
         2Of0spXvdVpqH+IDO/GSXT8p58YI6pvLcWL6DVKxgr8ZN1EsZER4KD1/1YHcCsxX5wq+
         W/D8uUZqI81Tb0b3NRvNebiPnWFVC4x0dO3cMWlD4u53dQ+tLCOdhJx5xEBRuV3GI/py
         BbXw==
X-Forwarded-Encrypted: i=1; AJvYcCUFcX3pi/FeIXHSaPHIAEKIQbpSq402e6jk6tLBPBwjczvEWOK1TiTRrCQYPDXtSOHb824=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMLkgAqVMSOYehR5QMb65p1dkcQgRiY4xfXqDOTbttT/EOquU
	Mi2y3bqJSWG4+bOZvDcCkZ7iTgc10NM5N5frRosYGG0uly8CMY1LBFpf
X-Gm-Gg: ASbGncu0qK5t8+8Dqs/qpEDg1IZJc6nPKRqO4kcetcke6lUhT61Vecr+BGWqppddevX
	fUC4tRQ1aXvMc0r4TDgoGWjo8tLYwewXO2wgWdGqmwF42VJZJTUPfMFymV4h6kQKZbeC9lF9TYZ
	t3zgv1mg/xvDzAvIKipFscEJaf6pQWBQKapniZRFkSD1ckZR6GN0hn28d+dkrw0l7RYWTDiavxv
	OEqeX+ThdASSbv7nL37L8HsQTMboago3h+PvrahyrO4aqoBLhtMyzWesQxKVi6cprDqLDm1EVEj
	5qwsEqLXkxuRz58+JGKwxFGGCK9vQ5Pa3Q9s2dBTrOtCnD2TkSjqdLUvXJ72hEYn/+NEBChMtTD
	Y6J22BmvjKj8O4SyofnhVoozkoYg5qOy5CHy+J5KA9kjKy78wx5BCaX+shi1KqrFn/YX583/9iZ
	pTzNarXAYOo8M4ilE=
X-Google-Smtp-Source: AGHT+IHEkHL5ZQm38S3r8MlmBsYeGlu3UN/1Jre+p5x1hnjd45bgAt3PR7v4bJqTBaNKY3DFr/nglQ==
X-Received: by 2002:a05:6000:2907:b0:3eb:bbd9:9c08 with SMTP id ffacd0b85a97d-40e499acbc1mr14770101f8f.46.1759152224387;
        Mon, 29 Sep 2025 06:23:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871c811sm18358855f8f.15.2025.09.29.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:23:44 -0700 (PDT)
Message-ID: <a3febed5-22aa-41cb-a602-39eae148c131@gmail.com>
Date: Mon, 29 Sep 2025 14:23:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] libgit-rs: add get_bool() method to ConfigSet
To: ionnss via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, ions <zara.leonardo@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
 <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <479c263bc19aa5cdfe9d990b2521f88b1620759c.1758945111.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <479c263bc19aa5cdfe9d990b2521f88b1620759c.1758945111.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/09/2025 04:51, ionnss via GitGitGadget wrote:
> From: ionnss <zara.leonardo@gmail.com>
> 
> Add support for parsing boolean configuration values using Git's
> git_configset_get_bool() C function. This ensures consistent behavior
> with Git's native boolean parsing logic.
> 
> The method handles all Git boolean formats (true/false, yes/no, on/off,
> 1/0) and edge cases like "00" and "100" correctly.
>  
> Includes comprehensive tests for various boolean formats and edge cases.

Unfortunately when I try to run those tests with

    make INCLUDE_LIBGIT_RS=1 && cd contrib/libgit-rs && cargo test

I see

   = note: /usr/bin/ld: 
/home/phil/src/git/update-ref-date/contrib/libgit-rs/target/debug/deps/libgit-8c021564b9d1ec26.9j3smxv8a5f6u8czhaxq401mn.rcgu.o: 
in function `libgit::config::ConfigSet::get_bool':
  
/home/phil/src/git/update-ref-date/contrib/libgit-rs/src/config.rs:78: 
undefined reference to `libgit_configset_get_bool'
           collect2: error: ld returned 1 exit status

This happens because libgit_configset_get_bool() is not defined in 
contrib/libgit-sys/public_symbol_export.[ch]. You need to wrap 
configset_get_bool() in the some way that configset_get_int() is.

Thanks

Phillip

> Signed-off-by: ionnss <zara.leonardo@gmail.com>
> ---
>   contrib/libgit-rs/src/config.rs    | 26 ++++++++++++++++++++++++++
>   contrib/libgit-rs/testdata/config3 |  2 +-
>   contrib/libgit-rs/testdata/config4 |  9 +++++++++
>   contrib/libgit-sys/src/lib.rs      |  6 ++++++
>   4 files changed, 42 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/libgit-rs/testdata/config4
> 
> diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
> index 6bf04845c8..72ee88801b 100644
> --- a/contrib/libgit-rs/src/config.rs
> +++ b/contrib/libgit-rs/src/config.rs
> @@ -68,6 +68,20 @@ impl ConfigSet {
>               Some(owned_str)
>           }
>       }
> +
> +    /// Load the value for the given key and attempt to parse it as a boolean. Dies with a fatal error
> +    /// if the value cannot be parsed. Returns None if the key is not present.
> +    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
> +        let key = CString::new(key).expect("config key should be valid CString");
> +        let mut val: c_int = 0;
> +        unsafe {
> +            if libgit_configset_get_bool(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
> +                return None;
> +            }
> +        }
> +
> +        Some(val != 0)
> +    }
>   }
>   
>   impl Default for ConfigSet {
> @@ -95,6 +109,7 @@ mod tests {
>               Path::new("testdata/config1"),
>               Path::new("testdata/config2"),
>               Path::new("testdata/config3"),
> +            Path::new("testdata/config4"),
>           ]);
>           // ConfigSet retrieves correct value
>           assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
> @@ -102,5 +117,16 @@ mod tests {
>           assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
>           // ConfigSet returns None for missing key
>           assert_eq!(cs.get_string("foo.bar"), None);
> +        // Test boolean parsing - comprehensive tests
> +        assert_eq!(cs.get_bool("test.boolTrue"), Some(true));
> +        assert_eq!(cs.get_bool("test.boolFalse"), Some(false));
> +        assert_eq!(cs.get_bool("test.boolYes"), Some(true));
> +        assert_eq!(cs.get_bool("test.boolNo"), Some(false));
> +        assert_eq!(cs.get_bool("test.boolOne"), Some(true));
> +        assert_eq!(cs.get_bool("test.boolZero"), Some(false));
> +        assert_eq!(cs.get_bool("test.boolZeroZero"), Some(false)); // "00" → false
> +        assert_eq!(cs.get_bool("test.boolHundred"), Some(true)); // "100" → true
> +        // Test missing boolean key
> +        assert_eq!(cs.get_bool("missing.boolean"), None);
>       }
>   }
> diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
> index ca7b9a7c38..3ea5b96f12 100644
> --- a/contrib/libgit-rs/testdata/config3
> +++ b/contrib/libgit-rs/testdata/config3
> @@ -1,2 +1,2 @@
>   [trace2]
> -	eventNesting = 3
> +	eventNesting = 3
> \ No newline at end of file
> diff --git a/contrib/libgit-rs/testdata/config4 b/contrib/libgit-rs/testdata/config4
> new file mode 100644
> index 0000000000..c0755a32be
> --- /dev/null
> +++ b/contrib/libgit-rs/testdata/config4
> @@ -0,0 +1,9 @@
> +[test]
> +	boolTrue = true
> +	boolFalse = false
> +	boolYes = yes
> +	boolNo = no
> +	boolOne = 1
> +	boolZero = 0
> +	boolZeroZero = 00
> +	boolHundred = 100
> diff --git a/contrib/libgit-sys/src/lib.rs b/contrib/libgit-sys/src/lib.rs
> index 4bfc650450..b104fda8f6 100644
> --- a/contrib/libgit-sys/src/lib.rs
> +++ b/contrib/libgit-sys/src/lib.rs
> @@ -43,6 +43,12 @@ extern "C" {
>           dest: *mut *mut c_char,
>       ) -> c_int;
>   
> +    pub fn libgit_configset_get_bool(
> +        cs: *mut libgit_config_set,
> +        key: *const c_char,
> +        dest: *mut c_int,
> +    ) -> c_int;
> +
>   }
>   
>   #[cfg(test)]

