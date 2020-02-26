Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC17C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311A620714
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG90KjRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZIUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:20:51 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46142 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBZIUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:20:50 -0500
Received: by mail-ed1-f45.google.com with SMTP id p14so2636837edy.13
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTb8M7aI/MNx1rN6J2+v9oHylvIXYurTiGXYGydr8eE=;
        b=sG90KjRYaDjZw33eoCFbBzWGrgUZjcXG6PNTPDp2vAo6N933CGfSldbcxbWx8k70Or
         keQ67eSjHuY1kV5mlh9yWO9x7xEvTdkSv95SHBbtt7XLmvfQVsQCeNVTKWRMg2+qfmPY
         pkAsEZi/K/tc3dHafJ4jGxyJORFsc+QKLbA9PpD/3QoFu7h2bxMqdyW41TbcLmpnT4fI
         6ghiR6iPEeWrxMe1zu/b1NXi0dqnIWFWpGQ4hUBDF2cdvDuZPiHiusR9Qv1vqOJZRdnI
         i374TuQw7ytFUks7fEAa+fUKKCywjgm6TKlo5MZjSLd8PMwQ0fdtYUW1KSWpuOAF3MaF
         10Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTb8M7aI/MNx1rN6J2+v9oHylvIXYurTiGXYGydr8eE=;
        b=F7qPTIumCUpAhjajjJTNq5CAt0MKsHZ27JObvPwljS5XoBZ/i/SeRq5E2yzaxOYj6C
         7SPUWxxg8hgLMFgIFcKG40sh85WT2K3+CYDh9rvOoMDOd33u4iMFvGk5vTu/NfpcqKq7
         xZ+HBe2S95nwCqP3T28pWNo90ibt0XxgqegVx0K1SnjF/YgvMlmpVGsiYZgTotDX4BX9
         y0IxqnqZ+x4Nh7oIYI9Pdnr//v3xUg3qGcM8ScjP97W0BsfLEb3sEr92Q6P1QHEEt52r
         TSbuOzRllgQTVhWaZP3X6l2ZKrWiWfunULrqdA+vNUYDhhPUbC2MSDARf15NNQydYajY
         1bkQ==
X-Gm-Message-State: APjAAAVsxiPjO00Bg151PxDAU1GxqWqBrnXuQI8r8V9rqNQ5x/wtpHG+
        w0YxNrs+hrz90Z4KRlkFbkKjwORn+W9bxQIDspA=
X-Google-Smtp-Source: APXvYqybrU9wRl+RezSBmFrUhwVSq7vALMQwhDtLIyz5S932M4sm08gIEU+b08vwwwt+Gic/rDLU12Y9Mm15I81FlTM=
X-Received: by 2002:a17:906:4e07:: with SMTP id z7mr3287230eju.201.1582705248914;
 Wed, 26 Feb 2020 00:20:48 -0800 (PST)
MIME-Version: 1.0
References: <CANtBzp2-8D=FZ2Lgu2qpYbMoi_NK6-naj2_UG9=JDiwrxp=pow@mail.gmail.com>
In-Reply-To: <CANtBzp2-8D=FZ2Lgu2qpYbMoi_NK6-naj2_UG9=JDiwrxp=pow@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Feb 2020 09:20:37 +0100
Message-ID: <CAP8UFD1Bid5+93TJsSX6azu43sYVBd05D6DS2Ma8mJfXRv36TQ@mail.gmail.com>
Subject: Re: GSOC'20
To:     Priyansh Gupta <guptapriyansh1907@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Priyansh,

On Mon, Feb 24, 2020 at 5:24 AM Priyansh Gupta
<guptapriyansh1907@gmail.com> wrote:
>
> Hi Christian,
> I am Priyansh Gupta. I want to contribute to Git organization in this GSOC'2020.
> I want to proceed with the second project i.e "Convert Scripts to Builtins" but I don't know how to proceed. I read something like a micro project for participation is compulsory, Can you please help me in proceeding further

Please take a look at:

https://git.github.io/SoC-2020-Microprojects/
https://git.github.io/SoC-2020-Ideas/

Best,
Christian.
