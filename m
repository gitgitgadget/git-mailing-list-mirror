Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A633C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C18F61058
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhI1FDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1FDW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:03:22 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67BC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:01:43 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s24so25954021oij.8
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLZ4X/omdtAIBSW8vVCPbpTJFhzDY2JgOQU85eB06LY=;
        b=nT2MRXsNgqxA4TPnCuvmRcoRsqYXMTfU8RiXVcDisnNqtvOlDpSmrAHFh1cUOo7QV2
         yvVKwvuOrfhA3xEDF4rajzRVaO6TXnKu1vV4o4MqOPpnXOgrrqRUOuuXLRJTVIpjChsF
         Ungn0nG+QJzd65i3pxMCWCERK1+cXKMeaZR5seJSQupUKZUy5LbYQ+H9O/tALTxSNRb/
         7b8kGZw6+gyb6vI9YXnkxTrU5M4Fa9bMZVnRqKwZnn/vXxHUidTY5nk3ijKlcRgQ8quK
         IrTXy1GtoZtSurs4yiMztvVEZIrbVfHy3QX9kxk93Ac11ufmBTDxwLKEGz0EIzxaauSw
         guOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLZ4X/omdtAIBSW8vVCPbpTJFhzDY2JgOQU85eB06LY=;
        b=RljB6cTec+YfJyU/DU8qeBVoBVdiWKdRYrJDNheJzdpJVsJzvW3HF6jxqhaKl3Q/Vb
         EySnAsSuVvWV1ZTpZLkkZOZ+Wd3TP4CNb65a+qeke5wiaOlUeuCm+yjrB/jjlwMfLHzD
         P4XpIk00QzcTe7ErJ9TB0GIt/KpxrrsQGYKVCP+JFyhcZgF7mHQdSgIvCynTg4QDU57v
         M1m29o9zHj+LDDK4uAhz6xUlW7/Ewrpzy3NVD9vNf7ucERBC7d8kLMCZil1Ea0ijrW1t
         CV3MovT41u+NNi75e3Dc8LKuczBXwsZznBw8tNO/zm1pd/gmT091lyrPFqejxcHB7e7v
         jWKQ==
X-Gm-Message-State: AOAM531279HtOzyOPYoiC9hTudetRbc+JuvWnuvq/AK+/wvRZFfPFmrA
        miCM2a2J11nAYsN+2eqNMvRVTvBkFBQ+ExI8H/U=
X-Google-Smtp-Source: ABdhPJyNmd3rrRNBf8LE2/1yn2EADazYB0nv8Lp5Ds18tSkOALTEYIO6zXMUExNJ+cBuUJe30v598eOUR0JJYAg2tPA=
X-Received: by 2002:a05:6808:1a29:: with SMTP id bk41mr2121501oib.167.1632805302517;
 Mon, 27 Sep 2021 22:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <bbbc4c3339043bcd718dd2defcbaaaac2092227a.1631630356.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 22:01:30 -0700
Message-ID: <CABPp-BG_wupp1o5bBSYOJSvF3eJjf=TbX0RBHqqKuD+3F8s6hw@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] scalar: 'register' sets recommended config and
 starts maintenance
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
...
> +static int set_recommended_config(void)
> +{
> +       struct {
> +               const char *key;
> +               const char *value;
> +       } config[] = {
> +               { "am.keepCR", "true" },
> +               { "core.FSCache", "true" },
> +               { "core.multiPackIndex", "true" },
> +               { "core.preloadIndex", "true" },
> +#ifndef WIN32
> +               { "core.untrackedCache", "true" },
> +#else
> +               /*
> +                * Unfortunately, Scalar's Functional Tests demonstrated
> +                * that the untracked cache feature is unreliable on Windows
> +                * (which is a bummer because that platform would benefit the
> +                * most from it). For some reason, freshly created files seem
> +                * not to update the directory's `lastModified` time
> +                * immediately, but the untracked cache would need to rely on
> +                * that.
> +                *
> +                * Therefore, with a sad heart, we disable this very useful
> +                * feature on Windows.
> +                */
> +               { "core.untrackedCache", "false" },
> +#endif

Interesting.  (I'm somewhat leery of the untrackedCache just knowing
that it used to operate despite an exponential number of visits to
files (exponential in depth of directories) and getting different
answers with different visits, making me feel like it was black magic
that it ever worked and wondering what kind of corner case issues
still lurk with it.  See e.g.
https://lore.kernel.org/git/CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com/)

> +               { "core.logAllRefUpdates", "true" },
> +               { "credential.https://dev.azure.com.useHttpPath", "true" },

Not only opinionated, but special configuration for certain sites?
I'm not complaining, just slightly surprised.

> +               { "credential.validate", "false" }, /* GCM4W-only */
> +               { "gc.auto", "0" },
> +               { "gui.GCWarning", "false" },
> +               { "index.threads", "true" },
> +               { "index.version", "4" },

I take it your users don't make use of jgit?  (Users aren't using jgit
directly here, at least not to my knowledge, but multiple gradle
plugins do.)  I tried turning this on a while back, and quickly got
multiple reports of problems because jgit didn't understand the index.
I had to turn it off and send out various PSAs on how to recover.

> +               { "merge.stat", "false" },
> +               { "merge.renames", "false" },

Is this just historical and not needed anymore, is it here just for a
little longer and you are planning on transitioning away from this, or
are you still set on this setting?

> +               { "pack.useBitmaps", "false" },

I don't understand anything bitmap related, but I thought they were
performance related, so I'm surprised by this one.  Is there a reason
for this one?  (Is it handled by maintenance instead?)

> +               { "pack.useSparse", "true" },
> +               { "receive.autoGC", "false" },
> +               { "reset.quiet", "true" },
> +               { "feature.manyFiles", "false" },

If you simply set core.untrackedCache to false _after_ setting
feature.manyFiles to true, would it make sense to switch this?  (Or
does it matter, since you've already individually set all the config
settings that this one would set?)

> +               { "feature.experimental", "false" },
> +               { "fetch.unpackLimit", "1" },
> +               { "fetch.writeCommitGraph", "false" },
> +#ifdef WIN32
> +               { "http.sslBackend", "schannel" },
> +#endif
> +               { "status.aheadBehind", "false" },
> +               { "commitGraph.generationVersion", "1" },
> +               { "core.autoCRLF", "false" },
> +               { "core.safeCRLF", "false" },
> +               { NULL, NULL },
> +       };

Are there easy-ish ways for other groups of users to adopt scalar but
change the list of config settings (e.g. index.version and
merge.renames) in some common way for all those users?
