Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CDFC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 18:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiAFS4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbiAFS4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 13:56:30 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C130C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 10:56:29 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l8-20020a17090b078800b001b1ea649932so2480022pjz.7
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vKTxjLfj8tqvSzrRH8CLGF1Vzh+TQY07L+2NtHZbJzU=;
        b=Jkye3HU1h1T/y7D/WuasJkGFjxR9WRxK3oL5m/H4B9fDyZN7lCl/d8zHkyRX51RxCl
         TNp9dbMLPdSZ2s76pY/Ooa6RYZ5Zdl3t86QZdt2hiq71ML4TxEVVMl7r7IfDNEK8P4Up
         Gn6lc01c2qQOrgvhDburapcwKR/eW30HXrwPjVFwZVYXMh6dB5+EhIX22OKmC3Uny52A
         nE0eYMZ3W+rR76jCzqvog+li+vRrxMKNOPB5CTAlbOqa0xZT2hk4xz77EbDOFNN3IGY0
         GmkXYBiV8uxD0+oZmhFfI/mKWp+RXM2QGvs1l3Ou5LOCtZMH21v+GLoZyn07XQQq+f6z
         KDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vKTxjLfj8tqvSzrRH8CLGF1Vzh+TQY07L+2NtHZbJzU=;
        b=od/f8LJ9TBpfSpWkmStaetzLGlI1sg7v6hRXMKxoO8sC9nwQQtz2yDhdNrsYi9ezKT
         H8xzMshy7aeSYW2XXFZA8GSTLOzN/e8ZTBZsnUuhuMpWDeTYs6Vd8VrCl2N57fmbTXPX
         dHzxwmwJVFbx5XMbZEr1Sn50ZQssmwtzCWyI8MIC1XspXNsgI5nzLfDtduiIcKGX9WOu
         47tDpe7Q7anqNYkJmzHdJV4fqUGODStgT/W4CJgtY2xpPWQ+r4mP7jH0dPaQZjQkVqq+
         R2n50k00G+3Z5iMUFrYsdDv/4Te51Bn28zdaJbZQoqoO+ubSF2my62wsJ2Gvuug3nVpy
         keFA==
X-Gm-Message-State: AOAM530XALFGMlcfCTejryBIfGsaw+NCTDpI78Y8R4tvyFk93TfIKfFx
        /6uCP19GYgWbh9XJ2Jx3jlQ5RUWjkcNxTg==
X-Google-Smtp-Source: ABdhPJw1/wgzxmWdbMcmvuujLAOtXST5JdTsxnRZ+G/khMM+BFis5S1kJwTge/v/xv9pz7I1drPdIfavl5aplg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d4c8:b0:149:c99e:dd83 with SMTP
 id o8-20020a170902d4c800b00149c99edd83mr9922114plg.146.1641495388893; Thu, 06
 Jan 2022 10:56:28 -0800 (PST)
Date:   Thu, 06 Jan 2022 10:56:26 -0800
In-Reply-To: <patch-v6-05.17-d6162fbef80-20211222T035755Z-avarab@gmail.com>
Message-Id: <kl6lk0fc7kx1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com> <patch-v6-05.17-d6162fbef80-20211222T035755Z-avarab@gmail.com>
Subject: Re: [PATCH v6 05/17] hook API: add a run_hooks_l() wrapper
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

> Add a run_hooks_l() wrapper, we'll use it in subsequent commits for
> the simple cases of wanting to run a single hook under a given name
> along with a list of arguments.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  hook.c | 14 ++++++++++++++
>  hook.h | 10 ++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/hook.c b/hook.c
> index d67a114e62d..1ad123422b2 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -149,3 +149,17 @@ int run_hooks(const char *hook_name)
> =20
>  	return run_hooks_opt(hook_name, &opt);
>  }
> +
> +int run_hooks_l(const char *hook_name, ...)
> +{
> +	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +	va_list ap;
> +	const char *arg;
> +
> +	va_start(ap, hook_name);
> +	while ((arg =3D va_arg(ap, const char *)))
> +		strvec_push(&opt.args, arg);
> +	va_end(ap);
> +
> +	return run_hooks_opt(hook_name, &opt);
> +}
> diff --git a/hook.h b/hook.h
> index 9c358789958..54528395953 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -54,4 +54,14 @@ int run_hooks_opt(const char *hook_name, struct run_ho=
oks_opt *options);
>   * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
>   */
>  int run_hooks(const char *hook_name);
> +
> +/**
> + * Like run_hooks(), a wrapper for run_hooks_opt().
> + *
> + * In addition to the wrapping behavior provided by run_hooks(), this
> + * wrapper takes a list of strings terminated by a NULL
> + * argument. These things will be used as positional arguments to the
> + * hook. This function behaves like the old run_hook_le() API.
> + */
> +int run_hooks_l(const char *hook_name, ...);
>  #endif
> --=20
> 2.34.1.1146.gb52885e7c44

Same comments as patch 2 [1], i.e. this looks good; it's technically
dead code, but that's mostly a matter of taste.

[1] https://lore.kernel.org/git/kl6lmtk87l1t.fsf@chooglen-macbookpro.roam.c=
orp.google.com
