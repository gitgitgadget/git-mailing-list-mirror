Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62AFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 06:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiBWGwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 01:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiBWGwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 01:52:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0824BD9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 22:51:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so50212214ejb.13
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 22:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KgDRzmgQ2AUB59vloj2md8HqW6XxVBKhBWD40J22mtM=;
        b=j7fUyw/J/4az2QNv9stClUdrW1jV66ZykiTAaGKEXfN9Us+JZVKrNI5WtH86ToZVzP
         1clG/gBVg5JPylY4/zu21QvFTFgTtv3F2XZb/xrRWo4WaGuBm7bsV3JietS80LFMMeXn
         4lFBh8h+8vlEcmZ+CCJIsWDiI+QBqKHXf5lDmH7ZNikQxoegFcYxdTPKwK4dDLu5zcfv
         sCBKI9dcL/3fbKYD45OHu3MgXcdxr5YhJDyLk4XxhOHlGx9VaNPGA9zEY6+qZ9NCUEsr
         4fdy+KyPWHMir3x3MOvBnfNLFz2rcmuPF/MIwh08ez6KxLQcWqWR5OvRXg3egD0ZAuC0
         tCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KgDRzmgQ2AUB59vloj2md8HqW6XxVBKhBWD40J22mtM=;
        b=1KQNFIbfCWZ6X+/Jb7K7vyffQ5GpGHl5yIkaeygAIg1x2+3ZYdrbrWZD6A3S3WaLQv
         npAlifEz+Av+ui4yIy+e9XyxxktZ15oRF444UMFeZhl7vyKfpHYyL6Dw2bCZPFnvSLO2
         N/82YeuS+JOOm3jhJHy3GhPv2vNEFCsKfcyVn/W3WDMpk5tYIl/V3Z3c9kOWEDy9eJBz
         ZuHKdcHfW5Ejb8CERRk5I+ZhX5n+rdhIXP+PMpxKfxnBaQxtv3GHl0TgbDzqZzEnMlyx
         UXZ9Mu3buXks7gepwQoY5OKNbWVzVMYlpW5tTsrDDVrM+2Orv41h8a8eazRvzwU82Q08
         RXtw==
X-Gm-Message-State: AOAM5300iIEivcEBpdrXRv7FSvUfcv/OVRZoP2rwxToDUgjMv3NAlW55
        NnuO4MMWt1C/HS8DSHQz/5w71T/CiaGVfrqYfIc=
X-Google-Smtp-Source: ABdhPJxoVRP4PlWAsuI7Ah220/lWMwE5MPkyDFEpCn9yj3NlVUgJMpefupYQ6BNFIhSjcDroHp9peV/7CRShIozLsgc=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr22604558eje.328.1645599099950; Tue, 22
 Feb 2022 22:51:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com> <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 22:51:28 -0800
Message-ID: <CABPp-BFPND3kCkHGxztpXRJRLeu=BJPFm7tbCrr0rVp4M0rHeg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Updates to worktree code and docs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 4:18 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is built on top of ds/sparse-checkout-requires-per-worktree-config a=
nd
> includes some forward fixes for comments from that series.
>
>  * Patch 1 combines two translatable messages into one. (Thanks, Jean-No=
=C3=ABl)
>  * Patches 2-4 extract methods from the already-busy add_worktree() metho=
d.
>    (Thanks, Eric)
>  * Patches 5-11 update git-worktree.txt to use 'worktree' over 'working
>    tree'. This involves some rewrapping of the paragraphs, so the diffs a=
re
>    not obviously just a find and replace. I split the changes mostly by
>    section of the file to keep the diffs from being too large.
>
>
> Updates in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Based on Junio and Taylor's review, I updated some language in the docs:
>
>  * Some uses of "worktree" should have stayed as "working tree"
>  * Some adjacent wording was improved.

I read through the series.  Looks like the only thing I caught was
typos that others caught -- though one of them was a typo flagged by
Taylor in v1 that went uncorrected in v2 ("metada").  Otherwise, looks
good; thanks for fixing this all up.
