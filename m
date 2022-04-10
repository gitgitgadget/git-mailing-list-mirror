Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD9EC433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 07:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiDJHey (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 03:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiDJHex (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 03:34:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AB546A9
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 00:32:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so25007328ejb.4
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky9yQGtC2eDpp8RW7suGsfPREmlYHoJSOwcK05Z8m68=;
        b=6aiJ1XqfoEKK/Cpjqe+K3Mk8Eu9n2NCIsQM5kh50SVnq7ES5Lr2ih0Ik3Kz9TsjZBH
         MzejJw+qBGJlcuREEkZOmdRC8vXv98kAaAmLyT92e/uaircanuGUtQsrd5CMlbndFsEq
         /5pnLMHB+Uiwc7zBapHfncDpHmI8bnq2RXnMJ7AgdLr7iBqryA2tUKdGFbrMyT7uqILK
         wtVcapMLropUbLApvMJ9cYTJJvachtm4Ye9LOU5jAnyblqtR8ilbSg4h6acWAiyYWx5F
         PRX05ew/XBHQtIHb6vRWtIl517WWLRKhz49BNZN7dgAAIAi34s6CMFAb/jFDkZuhkuvv
         C7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky9yQGtC2eDpp8RW7suGsfPREmlYHoJSOwcK05Z8m68=;
        b=gIbvDXVXjRJCucLoN+8zRZRXVgGhZrkMXvCK0EWYVF5eloWCQM8Tj+g06DRbjjAgV7
         bVIqZtysQ7CB2q/JdlRbj9ycGkqmmSo5bI3rck3ADMYzKFTssMU9IYJQQb/CubAC3hlB
         lvvoz041SCPbmJpfFAlnCcemenu5YIvZy+og1YsTINUTLXP40XRRRTdlXKc4U4w+isS5
         X754u2l35xhVIKFlun6bf90ulOo+GI4oyPO+JHYOvPBLYD/Iw4dcmtqqHwuc8g5hdyhS
         ySvTNJ8BuDpVHsQSCoYiOtl2aLVw89SxTLv+OtASNa009UhAdyHg0c4H/wqmTIAUBg23
         j5/g==
X-Gm-Message-State: AOAM532pt85Uf09esWvPnK8P1mu7tIX9bKjBEWk8uo05JIyxGpwNjxAJ
        Vs+gDnnPc5uPAj3EDbkBv0G5Ofk3SSIlw2ASzd/4Vg==
X-Google-Smtp-Source: ABdhPJyitJV5fibYc3GWRTujHXyDr6+HvzboI5j8GGh8z8Y2DIyzdzXerI1WukKQ9eX2QhL2UORcFbWvSfmP2PvANUE=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr25691123ejt.558.1649575962235; Sun, 10
 Apr 2022 00:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 10 Apr 2022 09:32:29 +0200
Message-ID: <CAPMMpoh769htwJZ65FRHeLx=KEbxGPKo8CFJCQ5phCXNaNEhDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
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

On Fri, Apr 1, 2022 at 5:04 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> This patch set contains multiple patches to improve consistency and
> tidyness of the git-p4 script's code style.
>

I'm not sure my review counts for much, but everything I see in this
patch makes sense to me, and I've tested it under python2 and python3.

Reviewed-by: Tao Klerks <tao@klerks.biz>
