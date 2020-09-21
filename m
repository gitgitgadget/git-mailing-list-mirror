Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95476C43468
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383DA2073A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 17:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PemtK9Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIURFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbgIURFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 13:05:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD2C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:05:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so13489040edo.10
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PxeqWjMhd26jfxLp3fmtvtraCOS5QFHMN5Oc5jKVmk=;
        b=PemtK9Y6+C9BSrn72pLfLF+3vjfwnBpadPnE7VdVeC/qPn+VoQ1d1IgZoN6dRLlAkf
         PDynLLC3KXS8cFMZSfBQzTRUp3/mLcAH3UgbLIBSf+UUoCyj536N1rolEXmbC0cFEY63
         wANGEM8/21YV8FA77J7PezlqPPYukJMZ1dXMjm+TJYzHuBUizw5bDZvRelpLsSuKOJHV
         YrgDC7F2mNliSWFMIY9ajYJ2LB/qtR8zWu059OptiMcYDWNWVchUzHmuaW/gYawUlW6I
         9aUve8445uMGE8t9TVj4LyZDSy/26ckzNnzQUJw+Y9SAISlwWtMlhIac9bFv+fBiH7do
         m7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PxeqWjMhd26jfxLp3fmtvtraCOS5QFHMN5Oc5jKVmk=;
        b=FeJ28wr130O/TY4EpP2676nOvx8gB2cSJvXJIFK2i5srDHJXBQGYdWxNz9DAaj+W17
         VTQRQIO6DcsvitIiRx+vuEGyapI6EbwZxsmAs2t1yKzgzAjrgh2o8RqYEhTePKxVjXWd
         JJuEyNrJiu8TqSbWKz4OcTs8kZwnEW8Pf8BC/EIZVRXgfIfmYnuguma59STumZYDLl7K
         5mBLJicmbAbyY2js2geZLWlJa74x+9hYmmLeM8pNOOZUuyGQSiRpser9qmM3Z0FPGqHk
         jOgzUK9KLB9aiRT5pieztzHMzVr8uYFEaLLSkYTBw+9XX/SzJxIcv8N1w5nsWR8imR0v
         UepA==
X-Gm-Message-State: AOAM533YMjMzl5T8w/OUMqjQeXX1WKM2NvF72TjjRLdl6r2a4qtGRXpa
        BK5K6IZatjppWGsOxWuCW72FSqy+s2UkKaME3Jx5yv2Qrsi2oQ==
X-Google-Smtp-Source: ABdhPJwdU67XqfJ83KjqpiJwD57ZZ7yjC4WIR9RRDK4mBdc/tcm/lcKvxWoU5qVDdU9DO1QHIGJ+CUBAfm7zD1zo1Q8=
X-Received: by 2002:a50:c8cd:: with SMTP id k13mr595575edh.387.1600707905859;
 Mon, 21 Sep 2020 10:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.736.git.1600695050.gitgitgadget@gmail.com> <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
In-Reply-To: <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Sep 2020 19:04:54 +0200
Message-ID: <CAP8UFD1i-zOPx6xrEFUVH1of8hzdHxO_jTOZ3fEjSXa_TONdvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 3:33 PM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> If one notices a typo in the last commit ...

In the title "commit: add an option the reword HEAD", I would suggest
s/the/to/ :-)
