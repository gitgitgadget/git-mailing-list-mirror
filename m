Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB80C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BE064F05
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhBEQqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhBEQn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:43:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B4C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:25:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p20so13376375ejb.6
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kujECtnFlOV9wFhar8jRUEZJHV5FVGQZSSUbsfO52Cw=;
        b=S51XHgLbVUnyxFHR60X/EwJ4R8YsqRi1cAYJF8dIU40o/vfNm9hk9LdJU728OE/cSO
         dg0duRDfYlICnowcVi358XCua4f8d3OicDrdydLybwY8GKPvce7B1k07r1FYGYK/uzbz
         xGi93hqm+lFe94FfJFi0vPC9n1ATNHu0LY5pkaeF6sZVEo3BgGjFPwFsqtkfL4RDPlzM
         34vGWVQHIFo4i08VOVgZjHfmop5/9SbzyXyzYN+u2jrNG18TFFtHAKrC2GoSgRv4WhXF
         zyAC1H/kexwj8br4PIvj4MiOE4YssKFryQ0VxMHmqNbJhENFj09LMCw4xuCm1wRrEv2Y
         GOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kujECtnFlOV9wFhar8jRUEZJHV5FVGQZSSUbsfO52Cw=;
        b=qod3k9UwPc4JgfbpIAyavFjQuCJ9050cwS0nOs/L4Qe9NwVOVvGskFgLxZ8r8zDB9E
         qZ+We/YMFJ3cJjSIf5xYq5PZoxlTEE4wvJygeLcvcBqhyaDU2p2lAOGm7aV8RRAnkZA0
         OAC7qS8MoWpjcCLIKcVGqVJxqNcsjeMOyZevCp1F3VUJTyBIcFa+vOQdNKZPGXdxnDl4
         2UvJm915JL9YLa8lezvVrQ/5VaQUyDuw5OwjzdEtRcXWP5UiSi3B67Zuymax+c8w5wGh
         E5PxoXTFA1nkLfs2j/mi45x446/AoN9kCs03vrhNQjXpOiSDDpoJ32AzTFtjiCfk7Ad0
         M9xA==
X-Gm-Message-State: AOAM531xi6I4hHCJIKTjBVjohe5zwkEKvXOz7lkS/Cw6X6wR7tiuwjBO
        tUQPb7cY0i5yhsQbFcTz2SpktuEjTlGIw6KVpgM=
X-Google-Smtp-Source: ABdhPJz9RwSfwkuSdxVLArLa/H27fxoBu1HyzaaiOVufUCsPIlZNNgGWChbAQp+CwpfGcAoSgf3XIiECfBfGraUpNgc=
X-Received: by 2002:a17:906:8410:: with SMTP id n16mr5322598ejx.551.1612549538837;
 Fri, 05 Feb 2021 10:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
 <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com> <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
In-Reply-To: <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 5 Feb 2021 19:25:27 +0100
Message-ID: <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 5, 2021 at 10:42 AM Charvi Mendiratta <charvi077@gmail.com> wrote:

> On Fri, 5 Feb 2021 at 13:00, Eric Sunshine <sunshine@sunshineco.com> wrote:

> > > * changed the flag type from enum todo_item_flags to unsigned
> > > * Replaced fixup_-* with fixup-* in lib-rebase.sh
> > > * fixup a small nit in Documentation
> >
> > These changes are still worthwhile and can easily be done
> > incrementally atop what is already in next, I would think.
>
> I agree, these fixes are required. So, I am not sure but now to do these
> fixup shall I send another patch cleaning this patch series(v4) and rebase the
> patch on the 'next' branch ? Is it the right way ?

Yeah, I think you can send each of the above 3 changes in a different
patch on top of the 'next' branch. That would create a new 3 patch
long series, which you should give a new name and not consider v5 of
the previous patch series.

Best,
Christian.
