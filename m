Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2058BC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 13:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBFNER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 08:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBFNEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 08:04:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076F326AE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 05:04:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527501b56ffso59978787b3.15
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdsF1YZAjVkrIdh9ocnZqmn4Shf8h8e6uoHOCqwfHGo=;
        b=NkzAuM3U0PTDa8fdPHKHQY+ObSmbEgF+rYeqRCUgkk+PZD6PX4lTF6ffmEx6QW+P0J
         GDoEEkNPKZKQP+292/JfKaGhohGRugmy7cSlgn08WLYEnGvmC4WDNRAvcuntEGJ46/mD
         6OL5djFRafxNBukXLdKJQTVUeesiGZ/NbW31csqV9FSNDJIDdLOOFZpMa3QWvy+O3whD
         +h6Z8izhvCpac0Ig84wAfCebwfa5s1Q5sqtfrRmpxGxSUz4IH+lvKcE8GdnZK7jVaWFm
         RSeE2SWy6h1Z7LHv2CWMHH38hCbKwaHvcUBYJzzZVBV3roMC55PO8cjdqRTRZ/8WFvwt
         yUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdsF1YZAjVkrIdh9ocnZqmn4Shf8h8e6uoHOCqwfHGo=;
        b=oLE59XGn5oTFpP8X5ZcQ+q6h1km71Mp1tI9Kwvk5snQbpRymCNWsbwptyUKbG5tlHg
         m66oFIreDydat+VSJyzyXKgS5mUcCNYGewCGpmd6r4uvm1LLt9Ajjh2YYnPTi4+UqmyA
         endhM2UDJFZ0ajDlB9+WiIxkiqzLAkCBpAg2EE1e3eUaWRzRVZYsv3IiiRUZwbmYfGSj
         699QfaR5OfKz+GwRtJ6wA55gYFK/mLLNCny2ifA1p5+T6o4RSeJQTK61cf0M0nFGQruU
         WCl05chTRaO6I+T7z2rge0Y/lVv9iqshMJcdIwLzO76fPOVi1qClX4al7mCmEsL3DDYK
         ZAjw==
X-Gm-Message-State: AO0yUKVVmpWh7zVVmAyk16Nk24GXQhd8pOJ0RQzLGFRfw7w92W7o9xfr
        F3kBW4GymVDTnVtqTVUMWQ90ERQ+JO++Eg==
X-Google-Smtp-Source: AK7set8nlx6b/xL1O9TuEsP7soPb5pgaE06ioZDqn7YtQ7FYXctFZBWhJvPt/Wt+XiAyghb0+AM41UrYZh3dKw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:4b4:b0:7c8:ba83:62de with SMTP
 id r20-20020a05690204b400b007c8ba8362demr2140458ybs.114.1675688654220; Mon,
 06 Feb 2023 05:04:14 -0800 (PST)
Date:   Mon, 06 Feb 2023 21:04:12 +0800
In-Reply-To: <patch-v4-8.9-a391ee17617-20230202T131155Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <patch-v4-8.9-a391ee17617-20230202T131155Z-avarab@gmail.com>
Message-ID: <kl6lmt5rgd2r.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 8/9] config API: add "string" version of
 *_value_multi(), fix segfaults
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> There are now three remaining files using the low-level API:
>
> - Two cases in "builtin/submodule--helper.c", where it's used safely
>   to see if any config exists.
>
>   We could refactor these away from "multi" to some "does it exist?"
>   function, as [4] did, but as that's orthogonal to the "string"
>   safety we're introducing here let's leave them for now.

Maybe I'm mistaken, but weren't these removed in 3/9? I couldn't find
these calls any more.
