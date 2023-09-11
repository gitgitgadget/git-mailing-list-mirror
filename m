Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F49CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbjIKVcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjIKNXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0012A
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:22:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so46930455e9.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438576; x=1695043376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1i/UMYAOL3DurVo4sDIJlx9aj9FjKGekYneJDRYlj0=;
        b=kdpOgLYBk2oN2fHBm6z0wk/dz4TBTxAvEBxPV3lQm5wth+7/iuxEYAj/g1OOAf17sl
         nzox+RDMFFvM+vLjToX05L4V+KT63nIiDMFfECzmuI1AKCOyE9NIESiK3l32T3Okz2MC
         0pwXCN4j45iSZ3BwInOUE1AkR67F+ePtOoAWpU/MFYeym/3Mk67tTdNcWXk4ZCEL2gIr
         gliBsz5eDKIkrah8azbsTen/mAe1ErnbJk4TPXo5jD1EzlirfArbipmKB/xJSzTS3kFx
         M19PbUG9PFCd50B+lNvN9mvLc4Ba113QcypNvyQxZKhMcESnQzaOhVshPS0uitIaXW6R
         2i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438576; x=1695043376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1i/UMYAOL3DurVo4sDIJlx9aj9FjKGekYneJDRYlj0=;
        b=UxdrIkP1J0aHUYGjiGYWAUiyt7IfWaXhkc7K6q5jcjdZ03DkJPoYImQLpt0eMxg/d2
         RFnKhZux0oda2x/Z5qmDmJTXw8ja3yRXOZDTI0bTZRYJOFq5S2sjFUMsZgL/tZEL/dZr
         bqejXHpEG3ZsNtpBktEv/QeWiNqYybh24s7c8juF7NhAQ8uMdnamz5qQWkd1tdDEuqUo
         QTk2qTFmw0YuAn3GDGfeclfsuCLJbHgE4k9JPRV1IbbnVHXIBfsZwzQMOSjI2E7rgzR7
         ZkCRWjPeX9uDBl1LYFlh35DWdJ+FlpolnBBPhrAXkamc31i0bdCeXYvuIhoi843CO7a1
         qG/w==
X-Gm-Message-State: AOJu0Ywc/5Pb8n/h1RlR2FiIJzANx6CwL+U4LfwQkKzTlotBoS4NtXSi
        52xskTbiwsDbfGfldeGVbL0=
X-Google-Smtp-Source: AGHT+IGGRxzQshZgwuBWbFiejGFyTit3CO4xNKN1ffvC0JHSdDozHD2RT9FSzOf2HG+9lvxBm2N5rQ==
X-Received: by 2002:a05:600c:2943:b0:3fb:feb0:6f40 with SMTP id n3-20020a05600c294300b003fbfeb06f40mr9138031wmd.11.1694438576246;
        Mon, 11 Sep 2023 06:22:56 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id c10-20020a7bc84a000000b003fee0741b8csm13303558wml.23.2023.09.11.06.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:22:55 -0700 (PDT)
Message-ID: <4cefe4f8-04ee-48fb-aee4-07342b7a062f@gmail.com>
Date:   Mon, 11 Sep 2023 14:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] git-std-lib: introduce git standard library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        vdye@github.com
References: <20230908174134.1026823-1-calvinwan@google.com>
 <20230908174443.1027716-5-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230908174443.1027716-5-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 08/09/2023 18:44, Calvin Wan wrote:
> +ifndef GIT_STD_LIB
>   LIB_OBJS += abspath.o
>   LIB_OBJS += add-interactive.o
>   LIB_OBJS += add-patch.o
> @@ -1196,6 +1198,27 @@ LIB_OBJS += write-or-die.o
>   LIB_OBJS += ws.o
>   LIB_OBJS += wt-status.o
>   LIB_OBJS += xdiff-interface.o
> +else ifdef GIT_STD_LIB
> +LIB_OBJS += abspath.o
> +LIB_OBJS += ctype.o
> +LIB_OBJS += date.o
> +LIB_OBJS += hex-ll.o
> +LIB_OBJS += parse.o
> +LIB_OBJS += strbuf.o
> +LIB_OBJS += usage.o
> +LIB_OBJS += utf8.o
> +LIB_OBJS += wrapper.o

It is still not clear to me how re-using LIB_OBJS like this is 
compatible with building libgit.a and git-stb-lib.a in a single make 
process c.f. [1].

> +ifdef GIT_STD_LIB
> +	BASIC_CFLAGS += -DGIT_STD_LIB
> +	BASIC_CFLAGS += -DNO_GETTEXT

As I've said before [2] I think that being able to built git-std-lib.a 
with gettext support is a prerequisite for using it to build git (just 
like trace2 support is). If we cannot build git using git-std-lib then 
the latter is likely to bit rot and so I don't think git-std-lib should 
be merged until there is a demonstration of building git using it.


> +### Libified Git rules
> +
> +# git-std-lib
> +# `make git-std-lib.a GIT_STD_LIB=YesPlease STUB_TRACE2=YesPlease STUB_PAGER=YesPlease`
> +STD_LIB = git-std-lib.a
> +
> +$(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
> +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^

This is much nicer that the previous version.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3e7a59b5ff..14bf71c530 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -455,8 +455,8 @@ static inline int noop_core_config(const char *var UNUSED,
>   #define platform_core_config noop_core_config
>   #endif
>   
> +#if !defined(__MINGW32__) && !defined(_MSC_VER) && !defined(GIT_STD_LIB)
>   int lstat_cache_aware_rmdir(const char *path);
> -#if !defined(__MINGW32__) && !defined(_MSC_VER)
>   #define rmdir lstat_cache_aware_rmdir
>   #endif

I thought we'd agreed that this represents a change in behavior that 
should be fixed c.f. [2]

> @@ -1462,14 +1464,17 @@ static inline int is_missing_file_error(int errno_)
>   	return (errno_ == ENOENT || errno_ == ENOTDIR);
>   }
>   
> +#ifndef GIT_STD_LIB
>   int cmd_main(int, const char **);
>   
>   /*
>    * Intercept all calls to exit() and route them to trace2 to
>    * optionally emit a message before calling the real exit().
>    */
> +

Nit: this blank line seems unnecessary

>   int common_exit(const char *file, int line, int code);
>   #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
> +#endif
>   
>   /*
>    * You can mark a stack variable with UNLEAK(var) to avoid it being
> diff --git a/stubs/pager.c b/stubs/pager.c

> diff --git a/stubs/pager.h b/stubs/pager.h
> new file mode 100644
> index 0000000000..b797910881
> --- /dev/null
> +++ b/stubs/pager.h
> @@ -0,0 +1,6 @@
> +#ifndef PAGER_H
> +#define PAGER_H
> +
> +int pager_in_use(void);
> +
> +#endif /* PAGER_H */

Is this file actually used for anything? pager_in_use() is already 
declared in pager.h in the project root directory.

> diff --git a/wrapper.c b/wrapper.c
> index 7da15a56da..eeac3741cf 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -5,7 +5,6 @@
>   #include "abspath.h"
>   #include "parse.h"
>   #include "gettext.h"
> -#include "repository.h"

It is probably worth splitting this change out with a commit message 
explaining why the include is unneeded.

This is looking good, it would be really nice to see a demonstration of 
building git using git-std-lib (with gettext support) in the next iteration.

Best Wishes

Phillip


[1] 
https://lore.kernel.org/git/a0f04bd7-3a1e-b303-fd52-eee2af4d38b3@gmail.com/
[2] 
https://lore.kernel.org/git/CAFySSZBMng9nEdCkuT5+fc6rfFgaFfU2E0NP3=jUQC1yRcUE6Q@mail.gmail.com/
