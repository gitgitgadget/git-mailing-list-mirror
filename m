Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F746C433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 17:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiDBRrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiDBRrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 13:47:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF2107812
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 10:45:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq8so11968651ejb.10
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Eg/kfpnSKDrmH3zeeXwn144EXKpBz0jJ3lJX3jEaq0=;
        b=iVSAJq+dmSiAPbKfpm79Qzu0pXA3p6VsojQogmBNIO8T58EdWtAOBLi87ZhzX1jefG
         YvYQ8Vlg3Sfn6FJzIb0n3kExgW0lXhGR/P66fRohLq07xz0WdOLMEPLgdZiljwICazDS
         tvKBnIla1g6QzJ2xN5r7FvjpIYnB1TRvGWR+7ydEQkhzFQf6vkk3Zgb+PkskPKgqby2o
         aGAN4AZTXWk/HU5iF7ZB90D3u5sXOrx59gkRK7yY4qGTL+68GDlLGaOkv6FNKZgHUS03
         hVHWaF6KoLNinSTLzFNF5Alec9sphi5z2gsp9HZzFK5HDPY9+cnc9/3gnXhoR4Qtnf4p
         4bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Eg/kfpnSKDrmH3zeeXwn144EXKpBz0jJ3lJX3jEaq0=;
        b=Cf3J/+xnDuZtRAeL3+dN9kl5Jqq1emZwi4n711SDLfY9wVkx5YuLSyJ5MX3Udb71rp
         9BKsF/wL9PFdBth+HCAkr/an1DB9Rb7kkXfvCDqzMsff1DfqYQd4E/S0PM8gO3GHCGZ1
         C0sOSaf4QAOlnYjELrehHNOHLRnXMQVNrSoDaQKAqde7FyagNz7dXv/8nH9vh3+U8M9H
         DJGKx6BYfF8Cs2fnbWKkgKCsNSu/t8hm1Y/2jHLLmLlyMYvyWXRhjScWjIl/mDoswngR
         jwDJaXRKac781/FmD2CeVnTww4I1Gk/S0u07+Zc3+x3ft5P7Q2I63nx2OzVcrW4e2sFt
         iUrw==
X-Gm-Message-State: AOAM5323+E3G/D5U/ScyuExYqQascuHSG56LRWOOuCWDBop1wedXy0rF
        MD3/oo5Eda/vLqpfMhCWj2JtI520eSAFJ6Mx3uNCsQ==
X-Google-Smtp-Source: ABdhPJx9v04ccBDIMYwS5VxoHenZSlLlA31mo1Eam7sH61wOdcgT9/vVyO7/66dkjF10nMEk4D9pQYD/mvBY12IySew=
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id
 nd41-20020a17090762a900b006da79534df0mr4445449ejc.316.1648921542629; Sat, 02
 Apr 2022 10:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com> <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
In-Reply-To: <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 2 Apr 2022 19:45:23 +0200
Message-ID: <CAPMMpoj6PG7QxDbYq=Qv047WL0gQLCTDNmqV75v+pw7LpYcBvw@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 2, 2022 at 2:14 PM Tao Klerks <tao@klerks.biz> wrote:
>
> 2) What is the relationship between "git-p4" and "git-p4.py"? Before
> this patchset they are identical except for the shebang line, after
> this patchset all these fixes are applied only to one of them. I
> assume the changes should be made to both files in a coordinated
> fashion?

Please ignore this question - after some playing around I finally
realized "git-p4" is a build product, and ended up different because I
had not built yet after applying your patch.
