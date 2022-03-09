Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044AC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiCITJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiCITJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:09:57 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74313982E
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:08:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id j83so3648729oih.6
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KJxBWI0SAyXSYu3C95LIXEaxsGO3WBsVAARbRWODP0o=;
        b=WuYqMXR3oTKTICiLQ4J70ZpLBr/ud5dIbGEr0W3KpQCUiiOki9XtF2SyY7Tl2H0jT2
         rBJcBnEJLoD7qyLKXEPLiVjh8uhr0AeXHgCX79XrFu6aM8YseE7LB2At2I9rV/eeynjk
         nlZqiBHTtmWyptxj1cp6XN0ZzLwqxIyGtV7+S/ZZUWP50Ltdn0R+rm+cjLiptOrYf26R
         nyEbBFO3JfTOD+VrIxz+D3qQFFcvqUfv9bCN8dVB5lxesJhC3bbfAXz8kCkrwF6S4jGb
         dj7tmeJ1dNa+2O2iCDM2S/ywfZptpdCzHHHZlOrdEz/ItPFBy6VCB0ShszfTkwHWuKqM
         nOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KJxBWI0SAyXSYu3C95LIXEaxsGO3WBsVAARbRWODP0o=;
        b=fqGi2ntfAYkE2mY9oN0DPgXz5zglQWvhHX+kBwZSclC0FMIho0NMpv5wL/TnxB5Juf
         m1T17iZiVrY8ICqLnvnjOBgqIs0x3cAO5BAYR0D94luirB9L6t8B2jVM1p9vNzWkxBNz
         irgeZ4xmRKoQYPuoGcEfGG+oHXow6PBpVrrvHf/C+m/U6CH/xLCZ4Hujy4RzP1EX7oRq
         QmKzmURjL5F39U9HqdUFJ0XGWChK/q0VSYRnthQ+qJGhpCWzVZQVHK+9dsa2tnMViB2g
         c4UWDnU94/vQuWMDiquF4UFdekZuzo0BaVC6RhTfFr2u8vcrzfOJuAXjO4RCjLvPImPI
         qvzA==
X-Gm-Message-State: AOAM5310lYJbP4WfwyTGqr0d7FadqmpAHzqik/EKq0PQAdgFF4Eilyn/
        e3jt/yW6/R+0XR5POQXbm6FG
X-Google-Smtp-Source: ABdhPJxhvDl5Dh8jRCeKq9iZe+wOfms+c/yjJg5YWfnKlbyT1+31Sj2TwE8jcm8meTJsrf/i37oQ+Q==
X-Received: by 2002:a05:6808:228a:b0:2d9:a01a:48de with SMTP id bo10-20020a056808228a00b002d9a01a48demr7039779oib.297.1646852937581;
        Wed, 09 Mar 2022 11:08:57 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s62-20020aca4541000000b002d7823c8328sm1348633oia.4.2022.03.09.11.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:08:57 -0800 (PST)
Message-ID: <3a89df25-8bfe-ba17-415c-3e2f14e17d61@github.com>
Date:   Wed, 9 Mar 2022 14:08:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 08/24] revisions API users: add "goto cleanup" for
 release_revisions()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-08.24-0f9d313b338-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-08.24-0f9d313b338-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> Add a release_revisions() to various users of "struct rev_list" which
> requires a minor refactoring to a "goto cleanup" pattern to use that
> function.

A straight-forward refactor. I have a couple nits on this one.

>  static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 09db2620829..19393da4e31 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1222,6 +1222,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
>  	struct strvec diff_args = STRVEC_INIT;
>  	struct rev_info rev;
>  	struct module_cb_list list = MODULE_CB_LIST_INIT;
> +	int ret = 0;

Since we initialize ret = 0 here...

> @@ -1259,9 +1262,11 @@ static int compute_summary_module_list(struct object_id *head_oid,
>  	else
>  		run_diff_files(&rev, 0);
>  	prepare_submodule_summary(info, &list);
> +	ret = 0;

... this is extraneous.

>  		die(_("unable to write %s"), get_index_file());
> -
> +	ret = (result.clean == 0);
> +cleanup:

Here (and other places) I feel the loss of this empty line
above the goto label. It just seems helpful to help see
these labels a little more clearly if they have an empty
line first, instead of immediately following a statement.

Thanks,
-Stolee
