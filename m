Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED3C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9475D2064B
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 20:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fptl94Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI0Ufa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgI0Ufa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 16:35:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD3C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 13:35:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g4so9680186wrs.5
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muS1RsD43WLNEEFuECsptXYqBTNvQzODVlmZVqlNR8g=;
        b=Fptl94Voat/3OnrCl7KpBJZPAEAebSj/Rk9Faj+lExs4oo4Tyg2K1RX8yvsdxANong
         jW9s5TV3n8mJxVgovX91Uu/TArTxdEcgx0s1fO7kjzRgHia71IneSw5mTX1n0GytsC3T
         QaQ0PWKsMSDYr1xcieGq1e5mKVFDGGVHx3HkcYumqjdUE+zxZVN1HuyLWm9j06f+QJ0x
         Xv907RWahtpeOXmi/XQjvijoXKEpdv438eJyGta8Irump4xD6R8yk+NdqK9PAGKeIPXO
         +itswxTgTY0X1C3o8+ulzGR2XWcue3cLxkbFYOfQx+ytl9xvXECIfdpXtZxCJryhV/g3
         a0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muS1RsD43WLNEEFuECsptXYqBTNvQzODVlmZVqlNR8g=;
        b=EvVjrZSsuI8Nixw2P8cwjtBdjAPypn6oodaVEhfmoVjdKoxIcHJOXtCAppfXGJd11u
         XdhWDY2wCwC2QxZGVWZtTygd4krWdYxrTxpw6I8z1oMnoOJ8Qe33bCP8s7nwyO8zB59d
         A9GqyUxB5WjCAZuCBP9X3AOKYW/AL8QyXYaQ8vfeH+QgE1nB1qXJ9MZKFzRHLd4LtYeT
         jy9hCg6cutF/AsSvlMPJg9mp0sf8ecGP/yeHg8Octm2XVLKhjaO9D0R7HPbmk2ZnTqZo
         yjXi34THDzbp5i9PVa5Jsh6quDqgVZq/pfDs6uxhLfW7x+iGy6b4Z/QlVqtQkcijgyqe
         d1nw==
X-Gm-Message-State: AOAM5339bRskXnO5qfaZCuQLzxiCjYLtFFbKuZxm5lG7MEvacARpjfpd
        lcqPRY8mzvO/NLtHS97h7tiq41JFiUB2WpyuOe4=
X-Google-Smtp-Source: ABdhPJwKjllPl0Ej5bcw5EhGDsw+09IiYVlm5VJR9j2nti30i+c0SMBITI1CG7KJ37iXnhszSAyUf3xvrwrUqp3Jx74=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr15749087wrv.156.1601238927558;
 Sun, 27 Sep 2020 13:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
 <877dsffaq0.fsf@kyleam.com> <CAKqNo6QCa2bGF3Uj-0ewh-_O+_qTOeOFYOM2k_daXw-vGg+xVg@mail.gmail.com>
 <871rinf0z5.fsf@kyleam.com>
In-Reply-To: <871rinf0z5.fsf@kyleam.com>
From:   Matthew Timothy Kennerly <mtkennerly@gmail.com>
Date:   Sun, 27 Sep 2020 16:35:17 -0400
Message-ID: <CAKqNo6T2RMCgEhTcweicN9w0+tCDKcnsJ93vLKTQem4Sc6-qcw@mail.gmail.com>
Subject: Re: Differences in compound tag sorting between 2.27.0 and 2.21.0
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 3:56 PM Kyle Meyer <kyle@kyleam.com> wrote:
> (Also, I'm not sure
> what the wider context for this sorting is, but perhaps just
> --sort=-version:refname would do what you want?)

Unfortunately, I can't make any assumptions about how the versions
look. This is for Dunamai ( https://github.com/mtkennerly/dunamai ),
which computes a dynamic version based on the distance from the most
recent version-like tag. Although it encourages a reasonable default,
the meaning of "version-like" can be configured to handle arbitrary
versioning schemes.

MTK
