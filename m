Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32081E3DDF
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490418; cv=none; b=fUudJU8WVV+xD5ddEMcBsMOeU5sHs7q/k12ksyGVrtF8aFcuDhNW2oQ2WkHmmusez1alwT1FYUpLULcTZEbd07PhPKjaSwkVovExNp33/6SwU6d5xFLKRmiO/70GddQhBpIhSQEN5mDHI6SpSvZ+Kyc46GKxWvr/7F60COQ6SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490418; c=relaxed/simple;
	bh=UhfUm6SOz5rjvv2xeylpsRo3DNfNJh5W+vUsTNbcA9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=HeAPVHvp8BLPbHK6EC5BEVs/5umzRgM67245uIXIc22KuoFG6olMBhh9LanOMkyU6czF7Q8rTGqQfLlSOuqQMCtyhRDNg0WxyuYadcFOoGVKts/Smqn2x2nglZkUl06iCJyg3WEz4WcNv4rh00q0MepK3C7Mxf2b2A0qdbXGvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIxO3z8t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIxO3z8t"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so11063425e9.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490415; x=1729095215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5vREg5K4qsdrkAymmjyJQwlvm4/ZpG3c4ms6QUYaLfs=;
        b=WIxO3z8tYW8W1PQlRQmBWQKyYhwyUZUGH0UDPqI9+3L679mSswoMY/V3PppfRVINib
         SxeEalUpDUaoiqAGgnWjIz67iRaBq1ilCZwkkUYogeC5iRLYYHY5cm5H3HjOOM5dULxR
         IqT/xwDw3L6vH2VUaGVhlq1HwuS+T776aUANtCsis10CRb9K7mcLFIJAscpLy7FwjhR3
         cxksxGuRb/i+fZ3wlnyXo53IZdrH9c/srvtxF1/2GlMjICOKsjb/5ASK+WcmP2jjsfjK
         fLX4OxBfNWm0lYR/+4HTddRtOttQ9CdFHDBcyHP6hplIFgfMKUtETuDei1CqF3Gol3ef
         iz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490415; x=1729095215;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vREg5K4qsdrkAymmjyJQwlvm4/ZpG3c4ms6QUYaLfs=;
        b=b6YjvDkUvAoGD9fvg6QREKAPPTpV5czFDTsw36l6lTbWoyJCO2ywaz5UDoSCv9Jb7z
         tsEUnQXmzYK5U7DO2AmTr0xoR6zkfMynrC4ILuWHw/4k9Ofs23Vcn3Vz8XJjHUpfwflh
         caQP7KMYRn8dmOiFC8qQM1KAo1/RMB9YLnnnpRgylr9Ktw5lYlkl+ktUYLUlZy6ThklD
         FwyprN51ZZu9qA++fmRLxQOF3MQSBW+ytNmx/+QXrQCV8Jk7q6g6+Tdz6zDJF8Fs037s
         96N3FoOChYeHDYG7UaYkmqPdE7iawKBL3utiQNxT26ueB2kyITZ0rPtmwxU11UUOQw/D
         dxog==
X-Forwarded-Encrypted: i=1; AJvYcCVsf0rjml3/w58Z0Q4l1TV7M9MqsTO685AaarjIl7bi4CjDSyvejr7NrCyAgpC3NLyrBgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEemi5OpU9pFOFRpa4x5ZFajjtXclTU8U4c1GFdGEmlFiW1GLh
	6DsK5yQHIem3Enxju38l/6j3lPLCr5mt07IK+gT4UKKj1iUO6rMG
X-Google-Smtp-Source: AGHT+IG7SNfygMx+z47z5ujOHpx4M0dUUXA4pINHJZnO1UhAwhTR7pC8JNSG7K5TRKI8VZwAlyAE6Q==
X-Received: by 2002:a05:600c:3ac4:b0:42c:df29:2366 with SMTP id 5b1f17b1804b1-430d748cb12mr29577525e9.33.1728490414999;
        Wed, 09 Oct 2024 09:13:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d6eb5d29sm24538405e9.42.2024.10.09.09.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:13:34 -0700 (PDT)
Message-ID: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
Date: Wed, 9 Oct 2024 17:13:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] mimgw: remove Compiler Warnings
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>, git@vger.kernel.org
References: <20241009103541.2887-1-soekkle@freenet.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
In-Reply-To: <20241009103541.2887-1-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sören

On 09/10/2024 11:35, Sören Krecker wrote:
> Remove some complier warnings from msvc in compat/mingw.c for value truncation from 64 bit to 32 bit intigers.

Thanks for working on this, it is a useful improvement. It would be 
helpful to explain the choice of signed/unsigned type in each case to 
help reviewers check that the conversion is correct. I've looked through 
the code and there are a couple I'm not sure about. I'd also echo 
Torsten's code formatting comments.

> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>   compat/compiler.h               |  4 ++--
>   compat/mingw.c                  | 26 ++++++++++++++++----------
>   compat/vcbuild/include/unistd.h |  7 +++++++
>   3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/compat/compiler.h b/compat/compiler.h
> index e9ad9db84f..e12e426404 100644
> --- a/compat/compiler.h
> +++ b/compat/compiler.h
> @@ -9,7 +9,7 @@
>   
>   static inline void get_compiler_info(struct strbuf *info)
>   {
> -	int len = info->len;
> +	size_t len = info->len;
>   #ifdef __clang__
>   	strbuf_addf(info, "clang: %s\n", __clang_version__);
>   #elif defined(__GNUC__)
> @@ -27,7 +27,7 @@ static inline void get_compiler_info(struct strbuf *info)
>   
>   static inline void get_libc_info(struct strbuf *info)
>   {
> -	int len = info->len;
> +	size_t len = info->len;
>   
>   #ifdef __GLIBC__
>   	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());

These two look straight forward - we save info->len at the start of the 
function and see if it has changed at the end.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 0e851ecae2..dca0816267 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
>    */
>   static int has_valid_directory_prefix(wchar_t *wfilename)
>   {
> -	int n = wcslen(wfilename);
> +	ssize_t n = wcslen(wfilename);

This is ssize_t because n maybe negative as seen in the context below - good

>   
>   	while (n > 0) {
>   		wchar_t c = wfilename[--n];
> @@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
>    */
>   static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
>   {
> -	int namelen;
> +	ssize_t namelen;

Looking at this function I can't see why this is ssize_t rather than size_t

> @@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *cmd)
>   {
>   	static char buf[100];
>   	char *p, *opt;
> -	int n, fd;
> +	ssize_t n;

This is ssize_t because we assign the return value of read() to n which 
maybe negative - good

> @@ -1339,7 +1340,7 @@ static char *path_lookup(const char *cmd, int exe_only)
>   {
>   	const char *path;
>   	char *prog = NULL;
> -	int len = strlen(cmd);
> +	size_t len = strlen(cmd);

This looks good we're holding the length of a string

>   	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
>   
>   	if (strpbrk(cmd, "/\\"))
> @@ -1956,7 +1957,7 @@ char *mingw_getenv(const char *name)
>   #define GETENV_MAX_RETAIN 64
>   	static char *values[GETENV_MAX_RETAIN];
>   	static int value_counter;
> -	int len_key, len_value;
> +	size_t len_key, len_value;

This looks good too, they're holding the length of a string

> @@ -2001,7 +2005,7 @@ char *mingw_getenv(const char *name)
>   
>   int mingw_putenv(const char *namevalue)
>   {
> -	int size;
> +	size_t size;

This looks correct - another string length

> @@ -3085,7 +3090,8 @@ static void maybe_redirect_std_handles(void)
>    */
>   int wmain(int argc, const wchar_t **wargv)
>   {
> -	int i, maxlen, exit_status;
> +	int exit_status;
> +	size_t i, maxlen;

"i" loops over 0..argc so I think we want to keep it as an int. maxlen 
is a string length so should be size_t.

Best Wishes

Phillip

>   	char *buffer, **save;
>   	const char **argv;
>   
> diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
> index 3a959d124c..ab3dc06709 100644
> --- a/compat/vcbuild/include/unistd.h
> +++ b/compat/vcbuild/include/unistd.h
> @@ -13,8 +13,15 @@ typedef _mode_t	mode_t;
>   #endif	/* Not _MODE_T_ */
>   
>   #ifndef _SSIZE_T_
> +#ifdef _WIN64
>   #define _SSIZE_T_
> +typedef __int64 _ssize_t;
> +#pragma message("Compiling on Win64")
> +#else
>   typedef long _ssize_t;
> +#endif // _AMD64
> +
> +
>   
>   #ifndef	_OFF_T_
>   #define	_OFF_T_
> 
> base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2

