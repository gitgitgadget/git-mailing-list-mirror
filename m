Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646CCC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 15:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiBWPlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiBWPlk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 10:41:40 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76CC0862
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:41:07 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id q9so3627745vsg.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIZW5w/Ggqa6XUU95RGlhjfKKidw7VS6bP2bDXUMgFU=;
        b=3E5vEvnkViG6c1qmsI6CDuPoG39TauQcL+M/SSwmuoq5G5cH8QbrMYpg8JQWJ20x8I
         HlzvPG6X+2EMeIqNZ994caK0DTd28NwL8D/Sv1Z2JIZXE2NYwcUJJGSbQM2tPnMpwi35
         acxMu0s3p0WwtPbUm7Q2XZ4FGFF5dMCg4BsgjdXCTHJqzp3A76ZdeaYcr95+tgOtiT2S
         ovRdTk+8lOmDvsQs6sI7UcPymRb4+Qmihx7+139HvmbX5f7/oblSiydfaKhVxBXbfs7m
         Ha9lyqpV4sZR4gUCkWCP0T5yQSWHi0tr9b8AuJSstfMciOi9HI8E8MauTMc6AwgCgXgT
         DCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIZW5w/Ggqa6XUU95RGlhjfKKidw7VS6bP2bDXUMgFU=;
        b=uFLUeH81oSbo7bIXAHec6zAbQA+nKBQNgkkIlOUqb07p2XFkznhhB2VcAYKRPanleF
         HjnaXtiY5kZ5cQd7g4Lbr63AlnMWkb6W9jKxPO/93Pns6d6Vh4L4lGTJVwR+Df8Kw2At
         jAIDJrStYXDfP0yt4w6OF9zcONKBAT+N4QKkamTm8k10idV/fQJRrxrqDlIqM1xNEq9z
         yfYH0C1G/TW3FKx7R5IcK02URvimC8Gv/Emz5Xv+FiAaiHGlT/oHSCO7OHXr/R4AGBSC
         z+uw3RpgAtBsfPRsy0uNHNeSACLW8bOld+1guRkD4tBxAF2YfOpkxpN+OV1/Dy/d+SJi
         dvpQ==
X-Gm-Message-State: AOAM530KMrXvNjJpEJJWt2IhA4ZiC5AhKdXFoSi1/wS+OBimA/lrtjI1
        lrv1gN5A011B7EEcOhr6CzBo20vFicRIo+0eXgDSBA==
X-Google-Smtp-Source: ABdhPJwpN9ZrvtxY5KYgvj2FDtTlTOE5WvhLmo1fqyC/gp6mmOxFB3xFIygD/2nio0iJZkbm/8mwo34xuK7VSqq1e8o=
X-Received: by 2002:a05:6102:48e:b0:31c:2105:21e9 with SMTP id
 n14-20020a056102048e00b0031c210521e9mr143838vsa.32.1645630866958; Wed, 23 Feb
 2022 07:41:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com> <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com> <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local> <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Wed, 23 Feb 2022 15:40:50 +0000
Message-ID: <CAFLLRpKLSxLV82SCr8x=BBRBybxj1XOxb=Srs5_X2idvvb1YEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Tue, 22 Feb 2022 at 17:11, Christian Couder
<christian.couder@gmail.com> wrote:
>
> In some cases we just know the objects we are removing are stored by a
> promisor remote or are replicated on different physical machines or
> both, so you should be fine with this.

From my point of view I think the goal here is great.

> > Another option would be to prune the repository according to objects
> > that are already made available by a promisor remote.
>
> If the objects have just been properly transferred to the promisor
> remote, the check will just waste resources.

As far as I can see this patch doesn't know or check that any of the
filtered-out objects are held anywhere else... it simply applies a
filter during repacking and the excluded objects are dropped. That's
the aspect I have concerns about.

Maybe an approach where you build/get/maintain a list of
objects-I-definitely-have-elsewhere and pass it as an exclude list to
repack would be a cleaner/safer/easier solution? If you're confident
enough you don't need to check with the promisor remote then you can
use a local list, or even something generated with `rev-list
--filter=`.

Thanks,

Rob :)
