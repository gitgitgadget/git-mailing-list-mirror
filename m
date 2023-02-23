Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB50CC636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 15:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjBWPSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBWPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 10:18:48 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470A4FCA6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 07:18:47 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id ay9so10939590qtb.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EQpkcUyVT5bSVKPx3BtWEfoXSsVt/cwY9qAK3fnEGg=;
        b=Xfn9Wca4rRFCpc9G4tz0XWEe94PxAn3p28b0EsVUx2s4dTFe904IY5zoCD6GhyZDX6
         UzzmPHZgLrRXVB7iP9f6jGVPywUeC5RHkstvboSSS1sM/0z2uByaRspeA0oeQji3tmf6
         H71Mi/uJyb3/rezGFjI58Jq8TiZUaVJqVVkyG45YQ3Ad7kvDddDX/JXsfImCkGG5w0ZW
         Hmc4WHHMaFzzL0I9ks5tK+agOnaGXofv4e6v7kTbP1VS/Od2YVVms8gJZaKqrY4lu+lP
         AHWepB4JaJWdCLgbdUjF5Fup8q9imSuSMPgQ2y3fqF/zQJ6BQyNwqRQ0ICwoF2AigH/F
         LYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EQpkcUyVT5bSVKPx3BtWEfoXSsVt/cwY9qAK3fnEGg=;
        b=1sa6P3ah+FZhSsYqvcq+6bP3DRp3i7FxOnXdwGDUcfUNcX34JGOqLdIR9lM7tyBGbh
         K5uZESgF2aTj7qRWPg3MOjIh0PUo1gJFhDuwvxE7/8pPBhw2wilaO1c0pz2U4iRe9h3E
         5QftL8Z1uNRTc3afbxKp29F2hPb5MIPlNiIo0S8cFf3rTVKewIkX4txcfpY97e9rNTTM
         XO7vo6chd3/9E6Ywz7Wlob4jT1j3fncLthL9eYkOjCMmjxTIoQU8vfqWyaoty9+w4HIW
         krTGQ0oDrTvyyNqzMFchgODhw00oR0jzAN3E+sd/Lth0hFPKo0Y1mbyPSxSeb2x9V0WQ
         jfaQ==
X-Gm-Message-State: AO0yUKX5DMx0eGmq5owZp3HFcKqzVAG7D9SNZyn79bs8KFequEgjSPHs
        IaDAwgeXzARGBD8Ed1tjAWab
X-Google-Smtp-Source: AK7set80QMtX5DtBlne+NpdIH8OlzN2x9EFn/nKzkc5JZI1KUMIkDmwIAaNh3DK/9x//m3juU3FUdw==
X-Received: by 2002:a05:622a:4d:b0:3b0:e83e:4331 with SMTP id y13-20020a05622a004d00b003b0e83e4331mr22733096qtw.44.1677165526702;
        Thu, 23 Feb 2023 07:18:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id n17-20020ac86751000000b003bfb5fd72a7sm514794qtp.86.2023.02.23.07.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:18:46 -0800 (PST)
Message-ID: <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
Date:   Thu, 23 Feb 2023 10:18:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 4:14 AM, Elijah Newren via GitGitGadget wrote:
> This patch is primarily about moving internal-only fields within these two
> structs into an embedded internal struct. Patch breakdown:
> 
>  * Patches 1-3: Restructuring dir_struct
>    * Patch 1: Splitting off internal-use-only fields
>    * Patch 2: Add important usage note to avoid accidentally using
>      deprecated API
>    * Patch 3: Mark output-only fields as such
>  * Patches 4-11: Restructuring unpack_trees_options
>    * Patches 4-6: Preparatory cleanup
>    * Patches 7-10: Splitting off internal-use-only fields
>    * Patch 11: Mark output-only field as such
 
> And after the changes:
> 
> struct dir_struct {
>     enum [...] flags;
>     int nr; /* output only */
>     int ignored_nr; /* output only */
>     struct dir_entry **entries; /* output only */
>     struct dir_entry **ignored; /* output only */
>     struct untracked_cache *untracked;
>     const char *exclude_per_dir; /* deprecated */
>     struct dir_struct_internal {
>         int alloc;
>         int ignored_alloc;
> #define EXC_CMDL 0
> #define EXC_DIRS 1
> #define EXC_FILE 2
>         struct exclude_list_group exclude_list_group[3];
>         struct exclude_stack *exclude_stack;
>         struct path_pattern *pattern;
>         struct strbuf basebuf;
>         struct oid_stat ss_info_exclude;
>         struct oid_stat ss_excludes_file;
>         unsigned unmanaged_exclude_files;
>         unsigned visited_paths;
>         unsigned visited_directories;
>     } internal;
> };

This does present a very clear structure to avoid callers being
confused when writing these changes. It doesn't, however, present
any way to guarantee that callers can't mutate this state.

...here I go on a side track thinking of an alternative...

One way to track this would be to anonymously declare 'struct
dir_struct_internal' in the header file and let 'struct dir_struct'
contain a _pointer_ to the internal struct. The dir_struct_internal
can then be defined inside the .c file, limiting its scope. (It
must be a pointer in dir_struct or else callers would not be able
to create a dir_struct without using a pointer and an initializer
method.

The major downside to this pointer approach is that the internal
struct needs to be initialized within API calls and somehow cleared
by all callers. The internal data could be initialized by the common
initializers read_directory() or fill_directory(). There is a
dir_clear() that _should_ be called by all callers (but I notice we
are leaking the struct in at least one place in add-interactive.c,
and likely others).

This alternative adds some complexity to the structure, but
provides compiler-level guarantees that these internals are not used
outside of dir.c. I thought it worth exploring, even if we decide
that the complexity is not worth those guarantees.

The best news is that your existing series makes it easier to flip
to the internal pointer method in the future, since we can shift
the 'd->internal.member" uses into "d->internal->member" in a
mechanical way. Thus, the change you are proposing does not lock us
into this approach if we change our minds later.

Thanks,
-Stolee
