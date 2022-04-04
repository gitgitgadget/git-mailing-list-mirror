Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C7AC4167B
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379704AbiDDVUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379698AbiDDRyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 13:54:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33587245BD
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 10:52:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p21-20020a631e55000000b00372d919267cso5974110pgm.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=//beZQhxq5Yy0yjJ+JkEVjjOo7Uzc6KLG2XvNFYXzdQ=;
        b=SXNixwNukDWuQrdaVq7hSiFmevl7Q1h5YpzrT9FTy8EduWpshfGgya6oKKuINoMeqD
         9+w8cVooduNUE3KLwQkMpZ+hbZ5YOuchjA5QoDu6lBVbMlNN6X4AZ1iZvPwNy3odkTau
         sBCAZd4/yCcsztnX858KixDaG9CuK1j0u1IQLnhF7ITeMLgPmdg1oYYMoEdP2w4SAZhT
         6a1dxgmunPru3y0ubvLOut9rldDxp4LYsrkOFKPIT8CWa6heshsevrYPQRwArNSlhf4u
         9T6HrAqsj5HvPJPKVZTEiShVtrfxt+Nic/uN4qfk6LhXKd9RW8r2SwCjPSXF2kNZ6LeT
         ReiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=//beZQhxq5Yy0yjJ+JkEVjjOo7Uzc6KLG2XvNFYXzdQ=;
        b=fshFiRv7rWLr3z7vwpqExDhaSOwaEVBjHtnof3oSM8kRoXfnoKlIw3zuarZCIf0kND
         56R4kAQsT1/7lYAw7YMo5SwZzz8v7KkiO2hWymhrU6IMpVX33eYEpSmCvfJglpTqz8/4
         TBY2Jn5dtzk8qok/8AC/G3vGB4c2bX+NZIokPm1e7AubvrxYqJnBt5D0NOIK/A3sqDnz
         Wpl+tooo6l3p6nHRfqz9df22+kHJse/vJrRc8AEPXvrRuaapfIe0mns3Igc1JN8hKsPp
         D5f20fwGcCgo0kGfsZZXDLGdKZ8E9hSdr+lGtUF6hqnIUQvCG0OmxqdcDtBwniygwdmV
         VYxw==
X-Gm-Message-State: AOAM53232sNXMpkYrQHlobFkL6HQeCKF/eRpfNsbRVGQSU8+YqUIvUXA
        m4wFlftwTj6VOod6JhmCZFB6Ea7BbKv8zA==
X-Google-Smtp-Source: ABdhPJwGdr/m/Miiu3aQtuQJvvr4LMTyoAI4zkJs/aMN4eSdKNbbSqVnSGRtO67Hpwj+cBjgsjAQIIRmQuciBA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:c8e:b0:4fb:18a6:18f9 with SMTP
 id a14-20020a056a000c8e00b004fb18a618f9mr861634pfv.47.1649094756519; Mon, 04
 Apr 2022 10:52:36 -0700 (PDT)
Date:   Mon, 04 Apr 2022 10:52:34 -0700
In-Reply-To: <pull.1111.v2.git.1649092211419.gitgitgadget@gmail.com>
Message-Id: <kl6lv8voybvh.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com> <pull.1111.v2.git.1649092211419.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] submodule.h: use a named enum for RECURSE_SUBMODULES_*
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Using a named enum allows casting an integer to the enum type in both
> GDB and LLDB:
>
>     $ gdb -q -ex 'b wt-status.c:44' -ex r --args ./git status
>     (gdb) p (enum color_wt_status) slot
>     $1 = WT_STATUS_ONBRANCH
>
>     $ lldb -o 'b wt-status.c:44' -o r -- ./git status
>     (lldb) p (color_wt_status) slot
>     (color_wt_status) $0 = WT_STATUS_ONBRANCH
>
> In LLDB, it's also required to cast in the reversed direction, i.e.
> cast an enum constant into its corresponding integer:
>
>     (lldb) p (int) color_wt_status::WT_STATUS_ONBRANCH
>     (int) $1 = 8
>
> Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
> debugging easier. For example, when stepping through a part of the code
> where an int is compared with a constant in this enum, it allows casting
> the int to the enum type or vice-versa, after quickly checking where the
> enum constant is declared and learning the enum name.

Makes sense, and besides just making debugging easier, this would also
make code easier to read once we use the enum in more places (instead of
just int).

> As to not make this patch a debug-only change, convert the
> 'fetch_recurse' member of 'struct submodule' to use the newly named
> enum.

[...]

>  submodule-config.h | 2 +-
>  submodule.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/submodule-config.h b/submodule-config.h
> index 65875b94ea5..55a4c3e0bd5 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -37,7 +37,7 @@ struct submodule {
>  	const char *path;
>  	const char *name;
>  	const char *url;
> -	int fetch_recurse;
> +	enum submodule_recurse_mode fetch_recurse;
>  	const char *ignore;
>  	const char *branch;
>  	struct submodule_update_strategy update_strategy;
> diff --git a/submodule.h b/submodule.h
> index 6bd2c99fd99..55cf6f01d0c 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -13,7 +13,7 @@ struct repository;
>  struct string_list;
>  struct strbuf;
>  
> -enum {
> +enum submodule_recurse_mode {
>  	RECURSE_SUBMODULES_ONLY = -5,
>  	RECURSE_SUBMODULES_CHECK = -4,
>  	RECURSE_SUBMODULES_ERROR = -3,

Like Junio, I think it would be nice to use the enum in more places, but
frankly there are so many sites that would need to change that I don't
think it's reasonable for one person to change them all.

So I'm happy to take this first step and do the rest of the refactoring
incrementally. I still think the enum's values are too disjointed and
should eventually be broken up, but that's a refactoring for later.

Reviewed-by: Glen Choo <chooglen@google.com>
