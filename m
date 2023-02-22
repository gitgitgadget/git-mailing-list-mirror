Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639CC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBVTWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 14:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVTWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 14:22:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F13C7B7
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:22:14 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536b7ffdd34so136058587b3.6
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RF2YMicF6YlLgEJXPHjJRlw93NG2JDVSyQTbHRQb5tE=;
        b=PPZxh1L0A5vyzwrpQ8Hfq74zFXPDRJCFbcRnK/ASElhgIp018ONr20jP894Hci7Zgt
         Q8D5cw3G7LTbef7kBQwF6ow9nOYGuIxEzYF/d9f8/6JkqHIO4xFHkxUm3VZNlPdRyfV6
         xFArlvMxOMrvDD7B2gYtvFj4o3nJK0sloG3bDaSJOAufygbuOOpGKcaqn49UAPJ5g4UD
         QcTAt8fbNA5RAlcdjIG/eM5h/Zjte4FHxzjMwf0QpuJ9nu1V0rP7tVPJ2lico2S1QZf3
         PvyFGwhwVkSLQ11YbFvRj2++srxuxHAcD4e15xzWVWi36Jsf4DZz8uhnNoMf3wttnF2B
         QyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF2YMicF6YlLgEJXPHjJRlw93NG2JDVSyQTbHRQb5tE=;
        b=p7jswhZpKUnFzxBq0fAxn+II/OVJ4XwcxAPlvW7ysWOvaWD8BwmFUi8HuUTcNJ0IJg
         +eoWBfyt+z/Tbib0wrDRYhgz++Q56LLV7X2PzyLUe+8oCpKgNAl60BPcP0/QPsDMpVsH
         Xc0Ekwaw9WY/QQYzXpBU/xtSo2JZH5K0sRSces8o12FPyfUu35zzaNLyvGh0gh72NOTQ
         GObhA6dYZbdHtPCEMXpL/mo6e2lPOQxHNLUNneVjdgS58H2Ob9uCz7HN349VFD1cFc+q
         xqq0YA90NI6UpHS9Fpo7x07tDIuTkWHd729ac7It+5nRUb7Q+D0K8W+hJyrtdY4Qua28
         k1UQ==
X-Gm-Message-State: AO0yUKUhx1tG8wXWLudZkyyuYtYSXlWaKM2qID/3bt9vBxSCnXEF2Rpo
        vQmwgandIJXQBVDpdwzA3T8DJptXCtVftHPL1vFNdw==
X-Google-Smtp-Source: AK7set8tXxWkbV1pUSQrjGMBO//+THzf46rUfFbO/erE8/m3iZmjGRjtUkJPNWJehzBXO42JnYbM3xbKW2nMIrYyuu4=
X-Received: by 2002:a25:8e0b:0:b0:86f:211e:5e74 with SMTP id
 p11-20020a258e0b000000b0086f211e5e74mr801155ybl.3.1677093733884; Wed, 22 Feb
 2023 11:22:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.v3.git.git.1675545372271.gitgitgadget@gmail.com> <pull.1443.v4.git.git.1676701977347.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.v4.git.git.1676701977347.gitgitgadget@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 22 Feb 2023 11:22:02 -0800
Message-ID: <CAFySSZA-f+Qgs2bT_Vkj79PvXqGarBLtqeyEN3vWCj44no6Eig@mail.gmail.com>
Subject: Re: [PATCH v4] credential: new attribute password_expiry_utc
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static int run_credential_helper(struct credential *c,
> @@ -342,6 +353,12 @@ void credential_fill(struct credential *c)
>
>         for (i = 0; i < c->helpers.nr; i++) {
>                 credential_do(c, c->helpers.items[i].string, "get");
> +               if (c->password_expiry_utc < time(NULL)) {
> +                       /* Discard expired password */
> +                       FREE_AND_NULL(c->password);
> +                       /* Reset expiry to maintain consistency */
> +                       c->password_expiry_utc = TIME_MAX;
> +               }
>                 if (c->username && c->password)
>                         return;
>                 if (c->quit)

Thanks for clarifying this block!

Overall, this patch is additive and shouldn't cause any
regressions for current users of credential/credential-helper
so I'm all for adding an expiry attribute to alleviate the
use case pains you described above.

Reviewed-by: Calvin Wan <calvinwan@google.com>
