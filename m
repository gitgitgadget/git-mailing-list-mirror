Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DBECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiITOGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiITOGT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 10:06:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142795808D
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:05:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so6488513ejc.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6bciQfSlCbg0kIed8twu/eXLKyQSsN7uvgIWbOlneQ4=;
        b=bqoE+90VbczaD0sgpm+skvnBmBZXSF+1IJ7W3PifTE9UJdm6wTimzHT+njIwJs5/u3
         5l/A1eH/AsQUe7UJI1L7hTjY/1vSJYDeAIcqfnIc/P8tLPhF6L1yBHmg3rMb7ebdlNrr
         Zpk7mwX4MzMrf0DTCi72dk5gGf3J8z8WYAgBxKWXtLp8OBmhwZEHar57a4dzCuomn0hU
         CJHAuO9e2k49D14S3PXiOdIiBnDs9vwUdvbehMxpAK1Ep5ASVhBjKz5YVCVuT5rTtv9o
         I5OuqO6kmHdLqn+6ikF7qz5pElOP66in1cobv0H2kfmTUbXwTyaOBt2zd3iH0XBSo0BP
         E/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6bciQfSlCbg0kIed8twu/eXLKyQSsN7uvgIWbOlneQ4=;
        b=5fZI2qEMjEMFU72WHti1cWGQk9cyPdlWTV9u9UqlmtYMz4a08X2opSDLxasHyXAzC4
         t7hyxSN944wMGz5mDQzY2pLTNURpjKa7tq8nNhflKMWYP4TzIDrfovWN8wou1p1Dkndw
         PVIwvoX6Be0rmMvJxL4SMZ9FnHlENNWRXSokm/cqlzGcybjYaAZk8JUTkZ2ofoDn7weI
         S7Ys7MCjIhuW5MS8VgNhms7wRyBfmc9yGUrRrxuVUtOpfeUjT8TrymKEtaS4jDQ3pOK0
         uW1Ad86yOgApVp8PMvtfclTJx0qjkYj/aHpIdF2hAmsd7j+BG9L0V3rQCk3tu6NtfgQf
         kQSg==
X-Gm-Message-State: ACrzQf3Cr6qrr8MLYOOEyLcDFRYHlo15T4VoLNqtkjXMrq84ZQpd/uvu
        dyGlJ8YPBHXnh8DDM6WC1WK9IdulHheN/ASOQ1I=
X-Google-Smtp-Source: AMsMyM4+EDtoYE5BIvTuvVA0z0evPGV0D8kcvCMVoXypTfyjmat3du4kBa++veP/WNNE6YKuLUrnSDnOJWVuqJKRadk=
X-Received: by 2002:a17:907:1ded:b0:76f:af8f:942e with SMTP id
 og45-20020a1709071ded00b0076faf8f942emr16916372ejc.120.1663682750087; Tue, 20
 Sep 2022 07:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com> <97a8eb90-06c2-f79e-fc9b-940ae89b88af@github.com>
In-Reply-To: <97a8eb90-06c2-f79e-fc9b-940ae89b88af@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 20 Sep 2022 19:35:38 +0530
Message-ID: <CAPOJW5wkXrV8eOysz6aJ5jN2u_u-iTX_3om3tSDKw+EmfCJBEw@mail.gmail.com>
Subject: Re: [PATCH 0/5] [RFC] introduce Roaring bitmaps to Git
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Mon, Sep 19, 2022 at 11:48 PM Derrick Stolee
<derrickstolee@github.com> wrote:
> I look forward to your next version. I hope to see some information about
> the performance characteristics across the two versions. Specifically:
>
> 1. How do various test in t/perf/ change between the two formats?
> 2. For certain test repos (git/git, torvalds/linux, etc.) how much does
>    the .bitmap file change in size across the formats?

Yeah, sure. I will be including the performance test result in the
next version :)

> >  Makefile                   |     3 +
> >  bitmap.c                   |   225 +
> >  bitmap.h                   |    33 +
> ...
> >  ewah/bitmap.c              |    61 +-
> >  ewah/ewok.h                |    37 +-
> ...
> >  roaring/roaring.c          | 20047 +++++++++++++++++++++++++++++++++++
> >  roaring/roaring.h          |  1028 ++
>
> I wonder if there is value in modifying the structure of these files
> into a bitmap/ directory and then perhaps ewah/ and roaring/ within
> each? Just a thought.

Great idea! Thanks! Will change it in the next version..

Thanks :)
