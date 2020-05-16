Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB154C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4B6206D4
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8WMI2DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEPKlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEPKlO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:41:14 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006DAC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:41:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id l15so890289vsr.3
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgNDPu7vp/sg6+5+JrjM2pIW42Ml89mmQcDgjc13sd0=;
        b=W8WMI2DA9HnU6F0BpAbgnzLVZNbKfO25qpTPlFwgSRSNsy3UMDaSEF0iHM/4P9RKoU
         wX5yhpFTAKGFG23HKKGOyOgDbWVzesMKOepL0sCIy9BX+eealOSDvZD2ydwPO49ly/db
         lEPFIFoypKjEhmSyQMbdDiAPB4XutA12Ley+Wwb0Zb0qOPW3QJaNN3Tg9bxj7vvuETqa
         u2u5M1JBULRE3+IgDq/OjxCOR+pvXfmx8BanpF0YSnra1E7L4K7VVwI2FFEi8oi3CI2H
         DXN8PV/yHXHp2X9PO+1eME8kdHQFZMthYH2AsYoB8FlZv0ysWTDB+cDg8sx67vgKzyeW
         g0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgNDPu7vp/sg6+5+JrjM2pIW42Ml89mmQcDgjc13sd0=;
        b=Q5YGhlVKnwNbC8GNqZVaBIkiYV/K8xF4h78atEvXkB9e3m0wXuoa8iNzCGp3939MIL
         eC9uS7fwhEFYs4nYDD2MKcKd2x8JtzWn98QqRRoatxO8jg/o+pqWnCVR8EkDtT3SFTaK
         MqAdosY74+WxOdq1mce0PxFsOSytapE/Qn8yCSxFewJFwnvoAH5Ale6dSv4ZHEHAfKTo
         7iGGOFRAzjIIusmg+ZV51dzlbVZsZXuPMYC0Ieo7+tKLoktOnr7L55xKXayS5SkgIPvY
         wBHJaX+LOxHn7mIHHYdrOwGXRr6zjCO4jcF4Tw83ZunDhyqKAQFB1XtuDzbUHGyGjdAL
         Lbbg==
X-Gm-Message-State: AOAM531FBautjr1jquGRds+dnv/f9Siz8za/tfIJ6JZtXPUHasbFwLX0
        4B+gNcYWsqUsiwcARuBYi5L07xi6OePvek+dg06Vtw==
X-Google-Smtp-Source: ABdhPJxr8gZcr5Ic/x2zYKhhls9kptXHi2XQ5r3sz1RaJoYa0IytW87fSmAi0jLkqBJBFCr4WEbIWiXzNiAbtZJrcjs=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr1163072vsp.118.1589625673216;
 Sat, 16 May 2020 03:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-16-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-16-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 12:41:02 +0200
Message-ID: <CAN0heSr3eAZrXnp8OoA6m1Hmfcgno7Dr2VK8m4jQqGHmgYySLA@mail.gmail.com>
Subject: Re: [PATCH 15/44] builtin/receive-pack: detect when the server
 doesn't support our hash
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> +                       const char *hash;
> +                       int len = 0;

Micronit: These new variables are used in tandem. I could see these as
"NULL, 0" or both uninitialized, but this is a mixture. That's a really
small nit, of course. (Maybe you needed to fight a compiler warning?)

> +                       hash = parse_feature_value(feature_list, "object-format", &len, NULL);
> +                       if (!hash) {
> +                               hash = hash_algos[GIT_HASH_SHA1].name;
> +                               len = strlen(hash);
> +                       }
> +                       if (xstrncmpz(the_hash_algo->name, hash, len))
> +                               die("error: unsupported object format '%s'", hash);

Ok, this is a familiar pattern by now: if we get nothing, behave as if
we got SHA-1.


Martin
