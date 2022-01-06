Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32892C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 18:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiAFSxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiAFSxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 13:53:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEEC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 10:53:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a4-20020a17090a70c400b001b21d9c8bc8so5584475pjm.7
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=uzpqfjfjw0L8xRXodQN3J3sXyYkDwG1QXnyieH0vBMI=;
        b=BKKvc3ga0nC+Bf7k7PJqK2JidNuN6tODHxeJCuYD0IgLw2KgYlDSR7Wt7s8url0pPg
         trakOCesVlFNFE/2PB2SiaABGK8hP5QiJ6gxqvBRWdAIlWuWyqZCwNNqvISHjPPS5YFZ
         sLEDnr1BpSDRzAyZdtnw1Sk9ATWKdeiDj+zoav4YCHiUdRZTq7VLMvuR8nKpIJFfL7tS
         uwpXhrJJRiXbhtVEmFN/dYLVlj5SF3IyxoT0/9EtHJDbndExY5tO3oST03ELSchfqh2e
         ipfI3sdxaLuHRWGxGvcTx2HV4LDKH/gYoF7LcXZPr+7PR6AhuVIW8CQPJEcTHTAFYCi8
         m/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=uzpqfjfjw0L8xRXodQN3J3sXyYkDwG1QXnyieH0vBMI=;
        b=Jg1FWeNtSWMhHkLLbUTQywKM05aaeRC9outPIrHHcC9OZgYTDZzvw3QAPT3fm/bAYj
         Hb/I6EDaizT9MBq2rvzPqvP8Zu21MHQFdITJeN5S6FC6/nr9ES6LhrL2E/9mUlLh65Rq
         /MYsTfV1De47IRrnx9Yv42EcUpHIubTn7a8SyKPYALX0JlEujF4LXs9HO5DAKL/TqQ2S
         BuFrgVKp+/KVptwCQlh28z2PrWNpneGXPlpf/WGZSPOKyYSDbMT9fmNYXVuOjbgCkCQG
         Or2rtbuANNX8g1eD/K1b79+pSgQpSB28rEmwaWCHQAm+lNmy9nosSnxQP8oYq0D3QNxK
         Le2A==
X-Gm-Message-State: AOAM5310+tAJZbiXJ0iFu6yx/jNWXFw3u+Jp6V2TngcfGPrcB4plg+kA
        LwAw6SwKMery9ADf9fJoFkNn6dxyTIy9lQ==
X-Google-Smtp-Source: ABdhPJzq40o0kWTuqB/qI+czx6CQWvDPyrEjqOGKduQZJlIsq8D0vU8KZO9xqGxodcIM8Y8db4ZqoP5NUdc/3Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:148b:b0:4ba:98c9:5d6a with SMTP
 id v11-20020a056a00148b00b004ba98c95d6amr61804552pfu.69.1641495216612; Thu,
 06 Jan 2022 10:53:36 -0800 (PST)
Date:   Thu, 06 Jan 2022 10:53:34 -0800
In-Reply-To: <patch-v6-02.17-cfba5c139e7-20211222T035755Z-avarab@gmail.com>
Message-Id: <kl6lmtk87l1t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com> <patch-v6-02.17-cfba5c139e7-20211222T035755Z-avarab@gmail.com>
Subject: Re: [PATCH v6 02/17] hook API: add a run_hooks() wrapper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> Add a run_hooks() wrapper, we'll use it in subsequent commits for the
> simple cases of wanting to run a single hook under a given name,
> without providing options such as "env" or "args".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  hook.c | 7 +++++++
>  hook.h | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/hook.c b/hook.c
> index a0917cf877c..d67a114e62d 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -142,3 +142,10 @@ int run_hooks_opt(const char *hook_name, struct run_=
hooks_opt *options)
>  	run_hooks_opt_clear(options);
>  	return ret;
>  }
> +
> +int run_hooks(const char *hook_name)
> +{
> +	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +
> +	return run_hooks_opt(hook_name, &opt);
> +}
> diff --git a/hook.h b/hook.h
> index 782385cc235..9c358789958 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -48,4 +48,10 @@ int hook_exists(const char *hookname);
>   * error().
>   */
>  int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
> +
> +/**
> + * A wrapper for run_hooks_opt() which provides a dummy "struct
> + * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
> + */
> +int run_hooks(const char *hook_name);
>  #endif
> --=20
> 2.34.1.1146.gb52885e7c44

This patch looks good. As a matter of personal taste, it's not ideal
that this is dead code, but it gets tested immediately in the subsequent
patches anyway, and those patches are pretty clear.
