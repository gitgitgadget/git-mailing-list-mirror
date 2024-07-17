Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0718133B
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227903; cv=none; b=cHd/0pCCuQJbdwGnoXiH6N/kei2UeHw3ItciMsE8iTJrbzq9ic4V6HPnNHJxxTdHWguZuaJJ3Wfmz6Pvi3c1hFJC/oK4s9P8aqQAE0NW/ZUd83y3sELDhnhPXtWxtohoAZy8ybrSpXf3qCFhHozauhSms4LiPTligoXK4xJX9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227903; c=relaxed/simple;
	bh=JOoNyEcu103uNxDdwNdNGLm4ooHgpENk9C43iyrgLRs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JueTddE9bzClfShDX2v9JxvK07wT8NesTbEW07BEoBO8m1w4NY3aTlY0hdmzw9NXpkoYhXKr7rLBAUol9iFeV5jcWoqxdmxLyEek1EfdFoZkdCtWy4McQ4X3KC+0HUQeBGdyKDPVp13X8VNTZAWUsL/yP4rCrCqrw7R88AyaE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkAFaG5p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkAFaG5p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427ad8bd88eso26576735e9.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721227899; x=1721832699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Us35F+QiL7hx/UcwWyHxULLiYGI+Z59IUJmooSnPkQ=;
        b=mkAFaG5pQgC44X/lD6or2GBlFf6bbJUNdUFY65TYcvI6YmOntdgjCvPvx/SzUgv+OE
         2SnMICtZavqi+87SXJ6IaWk56TD3jqT5anV/7yemrcmi2Hrz+5+cq9K9QEGBdK1n6UB9
         ka6k3wufHRgZSTr2Gxc+y8Beh3bmTodeaparEAa62FvUlx/rbHHPYDsmTl677J2uSOZJ
         mHnFgcBbbOAwyBZMhRcZlxdebtay4sUl8uOq9vKnYQd9SokRE2rsBU7QQmGj9pwwlWug
         cOxWfyB5BpP1rnySkMm0EvuSpMeX3CKoBbpS9bJbpBHtDJAd/vvPmeL7aFDOYND0FqPd
         GSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227899; x=1721832699;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Us35F+QiL7hx/UcwWyHxULLiYGI+Z59IUJmooSnPkQ=;
        b=oOnqG3aT3ZYvff4yaMl5lxO7shpd8zmiBtMSnx17kfKFQrDHMUlAH3c1lL+B2vBiUA
         /hkReOvkq2xIUiN5lJ6s6XEwu3loOUXvpuEhlQaf2fsqKNHDL99npBZMjtH/sDf7Aswu
         MnctIlodipYUf8g0/yDcxxRcVdUQrlJJl5/DXEszNHR/m4gHapJF+tKtce5j+6Axa0lz
         hwaIDd6V9gdqkp+jU6FZ4VpWARyOBuCaYfbgsk8dw87HOR7lRVddCEEhzqkyV2ofQdLG
         hhFWJXnlLfee6urmgUwbpZ+jb1PeHNht6G2GV1DsehNkkzu+LFfY6XGj0xW/ZeRRftQY
         hITw==
X-Forwarded-Encrypted: i=1; AJvYcCXA/eWvXjYULhETgys8wseQXFmKrhCsTCoc7olnRMLVLTn5zyy3x76WdmAFUVfKqxI6C7M+fRWOevmC4u96k2OoQUP0
X-Gm-Message-State: AOJu0YxfusRHYQR6IwlVB7mKctQQvDQfHXKgKYAG62/2OcjSInVf7PgD
	tnJCVbkInpEKbPO7yubXRt6B/5lG79/fPpo3CZVmhyqVe/Shkkd86f6o3ocn
X-Google-Smtp-Source: AGHT+IGx0yTNEkBabNa+tE1hHtx7c3Yji1PuvMmSjfuHE2ufg4aZHH0ak4QSVjufVLvaq4cmppUSuw==
X-Received: by 2002:a05:600c:4f91:b0:426:5f75:1c2c with SMTP id 5b1f17b1804b1-427c66af873mr6258965e9.11.1721227899245;
        Wed, 17 Jul 2024 07:51:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c786270asm414245e9.46.2024.07.17.07.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:51:39 -0700 (PDT)
Message-ID: <93ed998e-d331-4d16-a4e5-1ae449763205@gmail.com>
Date: Wed, 17 Jul 2024 15:51:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
 <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 13/07/2024 22:08, Johannes Schindelin via GitGitGadget wrote:
> Changes since v2:
> 
>   * Now fspathncmp() is overridden on Windows just like fspathcmp().
>   * The win32_fspath*cmp() functions now respect core.ignoreCase.

These changes in patch 3 look good. Thanks for fixing this

Phillip

> Changes since v1:
> 
>   * This patch series now shares the logic that determines the path of the
>     Unix shell that Git uses between prepare_shell_cmd() and git var
>     GIT_SHELL_PATH.
> 
> Johannes Schindelin (7):
>    run-command: refactor getting the Unix shell path into its own
>      function
>    strvec: declare the `strvec_push_nodup()` function globally
>    win32: override `fspathcmp()` with a directory separator-aware version
>    mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>    run-command(win32): resolve the path to the Unix shell early
>    run-command: declare the `git_shell_path()` function globally
>    var(win32): do report the GIT_SHELL_PATH that is actually used
> 
>   builtin/var.c             |  3 ++-
>   compat/mingw.c            |  2 +-
>   compat/win32/path-utils.c | 37 +++++++++++++++++++++++++++++++++++++
>   compat/win32/path-utils.h |  4 ++++
>   dir.c                     |  4 ++--
>   dir.h                     |  4 ++--
>   git-compat-util.h         |  8 ++++++++
>   run-command.c             | 17 ++++++++++++-----
>   run-command.h             |  5 +++++
>   strvec.c                  |  2 +-
>   strvec.h                  |  3 +++
>   t/t0007-git-var.sh        |  2 +-
>   12 files changed, 78 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1760%2Fdscho%2Fgit-var-on-windows-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1760/dscho/git-var-on-windows-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1760
> 
> Range-diff vs v2:
> 
>   1:  e0970381042 = 1:  e0970381042 run-command: refactor getting the Unix shell path into its own function
>   2:  91ebccbc39f = 2:  91ebccbc39f strvec: declare the `strvec_push_nodup()` function globally
>   3:  a718183bb3b ! 3:  f46315ac0b2 win32: override `fspathcmp()` with a directory separator-aware version
>       @@ Commit message
>            This means that the paths `a/b` and `a\b` are equivalent, and
>            `fspathcmp()` needs to be made aware of that fact.
>        
>       +    Note that we have to override both `fspathcmp()` and `fspathncmp()`, and
>       +    the former cannot be a mere pre-processor constant that transforms calls
>       +    to `fspathcmp(a, b)` into `fspathncmp(a, b, (size_t)-1)` because the
>       +    function `report_collided_checkout()` in `unpack-trees.c` wants to
>       +    assign `list.cmp = fspathcmp`.
>       +
>       +    Also note that `fspatheq()` does _not_ need to be overridden because it
>       +    calls `fspathcmp()` internally.
>       +
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## compat/win32/path-utils.c ##
>       +@@
>       + #include "../../git-compat-util.h"
>       ++#include "../../environment.h"
>       +
>       + int win32_has_dos_drive_prefix(const char *path)
>       + {
>        @@ compat/win32/path-utils.c: int win32_offset_1st_component(const char *path)
>         
>         	return pos + is_dir_sep(*pos) - path;
>         }
>        +
>       -+int win32_fspathcmp(const char *a, const char *b)
>       ++int win32_fspathncmp(const char *a, const char *b, size_t count)
>        +{
>        +	int diff;
>        +
>        +	for (;;) {
>       ++		if (!count--)
>       ++			return 0;
>        +		if (!*a)
>       -+			return !*b ? 0 : -1;
>       ++			return *b ? -1 : 0;
>        +		if (!*b)
>        +			return +1;
>        +
>       @@ compat/win32/path-utils.c: int win32_offset_1st_component(const char *path)
>        +		} else if (is_dir_sep(*b))
>        +			return +1;
>        +
>       -+		diff = (unsigned char)tolower(*(a++)) - (unsigned char)tolower(*(b++));
>       ++		diff = ignore_case ?
>       ++			(unsigned char)tolower(*a) - (int)(unsigned char)tolower(*b) :
>       ++			(unsigned char)*a - (int)(unsigned char)*b;
>        +		if (diff)
>        +			return diff;
>       ++		a++;
>       ++		b++;
>        +	}
>       ++}
>       ++
>       ++int win32_fspathcmp(const char *a, const char *b)
>       ++{
>       ++	return win32_fspathncmp(a, b, (size_t)-1);
>        +}
>        
>         ## compat/win32/path-utils.h ##
>       @@ compat/win32/path-utils.h: static inline int win32_has_dir_sep(const char *path)
>         #define offset_1st_component win32_offset_1st_component
>        +int win32_fspathcmp(const char *a, const char *b);
>        +#define fspathcmp win32_fspathcmp
>       ++int win32_fspathncmp(const char *a, const char *b, size_t count);
>       ++#define fspathncmp win32_fspathncmp
>         
>         #endif
>        
>       @@ dir.c: int count_slashes(const char *s)
>         {
>         	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>         }
>       +@@ dir.c: int fspatheq(const char *a, const char *b)
>       + 	return !fspathcmp(a, b);
>       + }
>       +
>       +-int fspathncmp(const char *a, const char *b, size_t count)
>       ++int git_fspathncmp(const char *a, const char *b, size_t count)
>       + {
>       + 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
>       + }
>        
>         ## dir.h ##
>        @@ dir.h: int remove_dir_recursively(struct strbuf *path, int flag);
>       @@ dir.h: int remove_dir_recursively(struct strbuf *path, int flag);
>        -int fspathcmp(const char *a, const char *b);
>        +int git_fspathcmp(const char *a, const char *b);
>         int fspatheq(const char *a, const char *b);
>       - int fspathncmp(const char *a, const char *b, size_t count);
>       +-int fspathncmp(const char *a, const char *b, size_t count);
>       ++int git_fspathncmp(const char *a, const char *b, size_t count);
>         unsigned int fspathhash(const char *str);
>       +
>       + /*
>        
>         ## git-compat-util.h ##
>        @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
>         #define offset_1st_component git_offset_1st_component
>         #endif
>         
>       -+
>        +#ifndef fspathcmp
>        +#define fspathcmp git_fspathcmp
>        +#endif
>       ++
>       ++#ifndef fspathncmp
>       ++#define fspathncmp git_fspathncmp
>       ++#endif
>        +
>         #ifndef is_valid_path
>         #define is_valid_path(path) 1
>   4:  f04cfd91bd9 = 4:  60fde81d35c mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>   5:  707daf246bd = 5:  797cf9094ea run-command(win32): resolve the path to the Unix shell early
>   6:  a74a7b4bb11 = 6:  7c53a4f4707 run-command: declare the `git_shell_path()` function globally
>   7:  8bfd23cfa00 = 7:  7c8eba5bfd8 var(win32): do report the GIT_SHELL_PATH that is actually used
> 
