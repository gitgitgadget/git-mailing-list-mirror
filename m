Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF2ECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 13:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIQNQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQNQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 09:16:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF1D36DE8
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 06:16:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 138so18569143iou.9
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Fxmw5/3bkNwkMQidE7zYUjFtb7fXq8RW2W2eHXbTVUA=;
        b=khz4XEYY7ztGbkcFh8LK39LLuT3ePD317+MTuTmRiccODXO8TaowdujG/pV5Z0VEvE
         CI5TPnjI2u8PHIFEAtUlStT47YLFbNJ/7/k02Og/WRZfDsyrGXZKEYmqjX3gCAn9SBGv
         fke7tL3vUBhSWTP00quOaptbOEDEbNt0l9hiXhcxtvBEqlHOst5zL8E/7NPTRpK6nPGt
         /w2bh0mZ+OzhM1rNKJEb4DPOwgmR2hcGUn3I++KtjAES5mORB1sUz6guss3iNVppwFdu
         iBCf5RxETzRGHg01/lI4iFv5+2DAPNwzJAquSi2Tx4fW3rUklsV8v9xa4/hrAh4MV9RC
         9XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fxmw5/3bkNwkMQidE7zYUjFtb7fXq8RW2W2eHXbTVUA=;
        b=zci7xKTADwKXp1abAXuBJkenw+k+3M226DKdWUJyjvtSGGDq+M92mc/XpX6YMSUG7K
         4mgboknza1AyHj5Oi1+r6WTRPhB2yaWRsvRwfSKJvD03bfnS6GkZbMCeGwoP9hP7suUt
         6rA5LToPLfBTuc+7dxXJObhnj4/w+3hyCm394Nh7k3GarJA5UBZ3xtWhcp1NM209JJKm
         8H9LjRAFcsoLE99xarFdD8r6onZjGSXlDl9CFtDQwCWu8CeMLsvfPv/yJtAAkAWgSE/X
         oHXiPc++nboo0N3v13qKf2eJQ3U7IXLt4ZgbDOhBgNY8ahO99YstNsu3VYc0aKjzjSTV
         GCEw==
X-Gm-Message-State: ACgBeo3xYUbkx57+ZoJjRKSkR7RhcsGd/siKDWub0ZerhdodJkGnNBVr
        13XG3JbguS6eHPo0jcHZWUnYKaFlaGmzIM6h/hZAzRWhHV6Txg==
X-Google-Smtp-Source: AMsMyM4DiFDribe1mvuSMNl7teWorQnhOzPg9QKDXDpO0C3/5SISKeYndOM8gd6kxRrIE/Q0hLgDAfkEeAU8Zu4JBwM=
X-Received: by 2002:a05:6638:1683:b0:35a:4772:edc2 with SMTP id
 f3-20020a056638168300b0035a4772edc2mr4531562jat.128.1663420607212; Sat, 17
 Sep 2022 06:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1350.git.1662904997760.gitgitgadget@gmail.com> <xmqqwna8ftm5.fsf@gitster.g>
In-Reply-To: <xmqqwna8ftm5.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 17 Sep 2022 21:16:36 +0800
Message-ID: <CAOLTT8SJ_DoPrw7uu1wHnJTT5FukAJmHmWfjEAYYOY8BfSpuVQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: fix black space in error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:24=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> > Subject: Re: [PATCH] ls-files: fix black space in error message
>
> "black" -> "missing" perhaps?  I'll queue with the reword for now
> but if you have a better alternative please holler.
>

Use the "missing" is ok, thanks,

> > ce74de9(ls-files: introduce "--format" option) miss a space
> > between two words incorrectly, it leads to wrong i10n messages. So
> > fix it by adding a space at the end of the error message.
>
> Thanks.

ZheNing Hu
