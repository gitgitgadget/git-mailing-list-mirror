Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732D3054D6
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152238; cv=none; b=YEjoT2Z//JNp29a00ZpAa+AXUsevrhfOHuW2qktBOM/hRb43/zCKwONg8Hc7W6cZki/84Ue2wBremRIvnEAs01TIrKN3+ENQ0gHbjzjMduOs6GTUcccJMKLZqCCGS7JE3U+Y8LJXJIsioFIDCQrnD9oZiYBq5dUxh2W0mImePi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152238; c=relaxed/simple;
	bh=BKGDouGzMB58iVCYznN9+t8P4IeGy5alxrNBQfSkOQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kaexo4/zeb1KDYcw28p7BgDzF68oxfeRQUS/Mo1PJ2DqGezxfFQcXjjcg5LZNwA3Kr3aVzYu7K/8D5gAoyAz+O8Iaq0AfIC3iA2yu8fCqqrdSsQY1f2nx4Y6zGTPqlrTdwnd0G6epFE/X4YwIcEbMHVv598aM+q2AAEFcgLg1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpUBmzy4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpUBmzy4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so2867719f8f.2
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759152235; x=1759757035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eys/vBOU68D4tCWraukA9HlZeE46mGyR5PZSj4rRASM=;
        b=IpUBmzy4Eow9lYGFCGdHspMqHhGSKtz+vkkBTl76E+F2S49WHMgCInP7STOS1M1had
         PjxUVPoe5zP+JFh3AEWIZBEjBOg3DZO9j5b+ZAHu7qmSgx6xBR+EOvwndtt7dcddAU97
         ETGBOrESzwTcq0mNFlUT/JUGf1c50E4L1ZrYOMfPlPGPYHOSk13OKdstABeT3GnwnEVj
         TmGTHUsAnVwq4dxtdDRpuH89YAOFwpdNZCtl9zAIfJMOL3dG81QhwXXfgENg5x7kKOq8
         7b1waq4PbKBgH92kdVXSn/tluCEsfuJ6osoyaEnaae1Y1HJSWV2f7T5n3Exd57Vx5kvx
         ZyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759152235; x=1759757035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eys/vBOU68D4tCWraukA9HlZeE46mGyR5PZSj4rRASM=;
        b=cIlcIWyfUavA5TWCfkACHO5W7Mm2/Epuqyrt0HrBW9hdajyvbVDP19wElk/4sgTj4X
         1B5tZBqAKIQkzJAHyBS0LMRrfAFRhDBqiHkbhDmGn5u75fn57dlj/rWnMwGn38AzdEB0
         hIppqJ8gjFDEj/ZKd3ztHLtq9VtoULjmlTyoe3nK5WuBqjJY4UvSUi+AsYj38YBnQhFq
         8Gqvj4Yr96XWFczXELttYo8UVT0SrJkGHjo/SnfKnDISDFgDP47OEdIpDHngrapqNbOw
         ZcB//RKklLmsGVuPaYZJrU/gCv+wpEyHnmJ5fpENLSMhH0pjNInBYW5PVM4EsewSBugr
         qrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWL30SNwzlCt8cs4iF07vTQbQxjjJwJcVht4W9y/eanXuGJsx1yn8bQ96Ub/OMX3s8DTKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLp5EJSWSActlLUqhzkuXS+aMsn4vCG2YgrABjVlfv2nthyCC6
	6rvJkndZTogda8oAf53pjI223d+bVFlPAmlfoB8bh1pKApX5cgu5TJom
X-Gm-Gg: ASbGncvwgafWgscYs/Z3sizLxuRUfz+JGOGtxenulYjE591Iw7PTL22+lYR/Kp7xnsc
	4lRhCoIHZgUBOBHCMgRzwXE1LfS3soo2TcU/0coObRkV0LOJh7b5L0zq0ZzbJ2kOVsPd+zcGB6b
	g11FRbnVLlYWgFpSbLyMwVHwsZZPA9zGoiDjOAm9AKiWagLaTiyTqCVUP0S6Xwt8gmcbbvLZTXg
	MbnSjuDmyf7COClI15UYY01G09QudBGj705IhLt9pC6A6aHguvrMQpVR16yDZJMld1gFazwij2A
	3I+biGnsyRQc7e403FQIZXBlb8noo5iFKMHykal9Qvcx6EC7cpV/YdehY4VTWqFQH1XdqYEjKib
	XaJjX/mWvrdXF3T/934jL763FzqiKrW0XvFqHTbCiTnq5Aodf4QH85o5p+/Fay5Vdg02myKTaX/
	h6BaJN
X-Google-Smtp-Source: AGHT+IHQWJS4/JRkfeYqktQ0SCtHbCTNB3CesKOhAGuCYpd+RUME9NWuE9SlVkmeCYfQe1Yv91nVRQ==
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr15237179f8f.29.1759152234858;
        Mon, 29 Sep 2025 06:23:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48b40sm224319725e9.19.2025.09.29.06.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 06:23:54 -0700 (PDT)
Message-ID: <9e7da34f-8d1d-4223-a160-e0223984aeaf@gmail.com>
Date: Mon, 29 Sep 2025 14:23:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] libgit-rs: add get_ulong() and get_pathname()
 methods
To: ionnss via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, ions <zara.leonardo@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
 <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <1ac8d768194b15eaf536000ed5f76f36dd0a39b2.1758945111.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <1ac8d768194b15eaf536000ed5f76f36dd0a39b2.1758945111.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2025 04:51, ionnss via GitGitGadget wrote:
> From: ionnss <zara.leonardo@gmail.com>
> 
> Expand the ConfigSet API with additional configuration value types:
> 
> - get_ulong(): Parse unsigned long integers for large numeric values

I'm torn as to whether we should keep the same name as the C function as 
you have done, or call it get_u64 to avoid the name depending on a 
platform dependent type. It is very welcome that this function returns u64.

> - get_pathname(): Parse file paths, returning PathBuf for type safety

I'm not sure why these two functions are in the same commit, it would 
make more sense to separate them out I think like you have done for 
get_bool().

> Both functions follow the same pattern as existing get_* methods,
> using Git's C functions for consistent parsing behavior.
> 
> Add comprehensive tests covering normal cases, edge cases, and
> error handling for all new functionality.

We can debate what constituets "comprehensive" but it is good to see 
that the new functions are tested.

> diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
> index 72ee88801b..ffd9f311b6 100644
> --- a/contrib/libgit-rs/src/config.rs
> +++ b/contrib/libgit-rs/src/config.rs
> @@ -1,8 +1,8 @@
>   use std::ffi::{c_void, CStr, CString};
> -use std::path::Path;
> +use std::path::{Path, PathBuf};
>   
>   #[cfg(has_std__ffi__c_char)]
> -use std::ffi::{c_char, c_int};
> +use std::ffi::{c_char, c_int, c_ulong};
>   
>   #[cfg(not(has_std__ffi__c_char))]
>   #[allow(non_camel_case_types)]
> @@ -12,6 +12,10 @@ type c_char = i8;
>   #[allow(non_camel_case_types)]
>   type c_int = i32;
>   
> +#[cfg(not(has_std__ffi__c_char))]
> +#[allow(non_camel_case_types)]
> +type c_ulong = u64;
This is a bit problematic as the type depends on the platform. I'm not 
entirely clear why the current code doesn't just rely on having std::ffi 
define these types.

> +
>   use libgit_sys::*;
>   
>   /// A ConfigSet is an in-memory cache for config-like files such as `.gitmodules` or `.gitconfig`.
> @@ -82,6 +86,41 @@ impl ConfigSet {
>   
>           Some(val != 0)
>       }
> +
> +    /// Load the value for the given key and attempt to parse it as an unsigned long. Dies with a fatal error
> +    /// if the value cannot be parsed. Returns None if the key is not present.

Please wrap the comments to 80 columns

> +    pub fn get_ulong(&mut self, key: &str) -> Option<u64> {
> +        let key = CString::new(key).expect("config key should be valid CString");
> +        let mut val: c_ulong = 0;
> +        unsafe {
> +            if libgit_configset_get_ulong(self.0, key.as_ptr(), &mut val as *mut c_ulong) != 0 {
> +                return None;
> +            }
> +        }
> +        Some(val as u64)
> +    }

This looks good

> +    /// Load the value for the given key and attempt to parse it as a file path. Dies with a fatal error
> +    /// if the value cannot be converted to a PathBuf. Returns None if the key is not present.
> +    pub fn get_pathname(&mut self, key: &str) -> Option<PathBuf> {
> +        let key = CString::new(key).expect("config key should be valid CString");
> +        let mut val: *mut c_char = std::ptr::null_mut();
> +        unsafe {
> +            if libgit_configset_get_pathname(self.0, key.as_ptr(), &mut val as *mut *mut c_char)
> +                != 0
> +            {
> +                return None;
> +            }
> +            let borrowed_str = CStr::from_ptr(val);
> +            let owned_str = String::from(
> +                borrowed_str
> +                    .to_str()
> +                    .expect("config path should be valid UTF-8"),

As we're returning a PathBuf it is a shame that we're restricted to 
UTF-8 encoded paths. Unfortunately rust's standard library does not seem 
to provide an easy way to convert a CStr to an OsString on windows as 
one needs to convert it to a UTF-16 encoded string first.

> +    pub fn libgit_configset_get_ulong(
> +        cs: *mut libgit_config_set,
> +        key: *const c_char,
> +        dest: *mut c_ulong,
> +    ) -> c_int;
> +
> +    pub fn libgit_configset_get_pathname(
> +        cs: *mut libgit_config_set,
> +        key: *const c_char,
> +        dest: *mut *mut c_char,
> +    ) -> c_int;

As with the previous patch you need to define these functions in 
public_symbol_export.[ch]

Thanks

Phillip


