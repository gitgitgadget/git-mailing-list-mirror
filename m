Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAEAC433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE382079A
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgL2Idv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2Idv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 03:33:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4DC0613D6
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:33:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jx16so17177260ejb.10
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrRlymDlJlsRhgrlyRmMQXaP+O1HAhPFhjoRVuRIHLU=;
        b=EKbuMYLeOBrvDF1fahCMUYotdYxgJgY9BUz3ANmBkehQ6OgxFBs3d5vxn4LUNnr7hU
         75uj7qCwnl38x4ZY2UrgwuYi9duI2NkC/PLYwbAe3wvwFa8sjgJnKan68urcCw1e5A7A
         YQRtmWnW+EdRUkfpAcLsiVW9lwmapb7HV8w8HE12YL7qlA140mqj4nEBLr0Rgkvp1hzl
         DQFg4O8itCV24n/xTi3sRMpCACDuDis/jbkURcKEJwhKokUfGZNtW5gLDZ5Ks/rQ1p8m
         8nbU1/ZjO/vkgX+huqZjV4BYffB708n+KZWFlMJkbXe+3eAEKnhto6YD37jZuSS5xCgP
         SggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrRlymDlJlsRhgrlyRmMQXaP+O1HAhPFhjoRVuRIHLU=;
        b=NMCqb+A3qSQy2aDL/0kMqg577VO0bhhFl3EW70Jg8Eg5P+C5ClpBehesod6VDEzEAz
         CJAQK8adxn2vU56sRrM5dnW+JZf8/yioIQxn8hDIPycR/q1twgrR4abekMxQWKKeeCAI
         LUTVhO2agnaM4tEGGt/N7qvaVicMt56saibF6m57t5e5CZx1KO4oFRM6V7P2wOXVIWTy
         HTDyiFh2cy7x16F3ZY1lPozYl+5gkl7adq5j1oqUzzOQdTV9XMsS935rXjf7Zg5EjUYF
         AWQ199Yi537vgb4HZJEx7oYRBXesl5RLiXtyZUXDRgMqmWX7IKQQLPpMAAywcM4T44J3
         +YyQ==
X-Gm-Message-State: AOAM533yg1lNeEcAdna/gz5H2Y+5SZVLvk3JZE51JX0JSu2rtDtZs3sB
        0xDH6Rofxk4d23U8/KDKxiTnDVgOQSUseBSff6s=
X-Google-Smtp-Source: ABdhPJxS/tpycVoFuoCyXa0oC9IbPW69DJn5yTL79OUuiUABwitRxIJs7w4cJnJggLFu3qFItVyh+omU1aN6uvq5Hc8=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr44525285ejd.160.1609230789674;
 Tue, 29 Dec 2020 00:33:09 -0800 (PST)
MIME-Version: 1.0
References: <xmqqeej9g325.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeej9g325.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Dec 2020 09:32:58 +0100
Message-ID: <CAP8UFD3=G7jxtJ4xUuh8v7Tqip5uzhBn4nmBEDZWJwgNZka40Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #05; Mon, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 2:26 AM Junio C Hamano <gitster@pobox.com> wrote:

> * jx/pack-redundant-on-single-pack (2020-12-16) 1 commit
>   (merged to 'next' on 2020-12-18 at b819311529)
>  + pack-redundant: fix crash when one packfile in repo
>
>  "git pack-redandant" when there is only one packfile used to crash,

s/pack-redandant/pack-redundant/

>  which has been corrected.
