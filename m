Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536F5C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB6360FEE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 06:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUGWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUGWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 02:22:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D02BC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 23:20:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i4so4249047plt.12
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 23:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M3SGRlz3cgxHLk1U2FHJHU+p47XjTic5hh7NDPfFHQ4=;
        b=bRrhRl3R8wTac8mrlrWuLGK0Vh7SfglqlIP2DVE1ZkwE2T2rrRofdHoT3ygVf4XK1m
         65VpD8+szOrtnjrxZgaa4uGCZFvH5zTJv0FFBZyhKe3NRibfsLlIFeRKm0f60OKQR2+J
         2qrZAwmTLMxhe0MELXw33tWh+ljwa75CiTjBluE+xQwHITgp+Ttj9Auw+WxKFWj5sAEb
         IfQER/ZVNpXETsU5C2Ssom302RFTZ9niFKD2hKqpJyDEqUGZZOJow1Ngs3vBk6fmZJpe
         eGGTFi/UXhd5QNTG6x0xv3D3HFM5hTwnWe4B/Z7JQiPZ08mzQE9uxZsO/E7PGuPlM0o8
         wFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M3SGRlz3cgxHLk1U2FHJHU+p47XjTic5hh7NDPfFHQ4=;
        b=jgISxHhetCBj9nvZ1HtX/Fd8NrKC6ckQJTNO89ky/ZDvKFCSt4bcKd/38l8o/p2svB
         edcuO9RqUeVO08DTRdmkQzBU/ZtjfL+B2zH+wR2OP3Ie7btG/lq0OoES8EX+JFtSS0a1
         gwSpKxMUWfZLZubjZFId3qfmcawDgdd6Z2eO8mEnrvBTskag/v7r4VSPKA1Lrk9SbM12
         dG4Rc70+omZcdbnYDyZonAIlAI+ue9hB+KmbVFl8hTqbOytXQ0IItcJRb3Juw+SJSll2
         B6jWzRLvEZH8ClCXVXPuTCmmfrHz92dxi/U3xrxPmqIKPdxV65sPMPy69GhFYoghzA3G
         zdIQ==
X-Gm-Message-State: AOAM5315lHTXEGAFYlJZ5R38/HzXiBu4xTdWufRFZgm9pOpOxzJyn56q
        XFldBpIr6lOAouJ+FWEDFkg=
X-Google-Smtp-Source: ABdhPJy1vFZ3NF/YfPJbwDUzNC1BSb1eLUKZHUE7lb/gnrquGIn8LhM8VGCoIBNDoGzXa4Fem64NnA==
X-Received: by 2002:a17:902:c403:b029:106:7793:3fcc with SMTP id k3-20020a170902c403b029010677933fccmr16428759plk.81.1624256430695;
        Sun, 20 Jun 2021 23:20:30 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.172])
        by smtp.gmail.com with ESMTPSA id o16sm14101994pfk.129.2021.06.20.23.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 23:20:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] My Git Dev Blog - Week 5
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD2sXjRgn6FqOcBor=Q_PXmy+xL4mHmV7Qy_fSrc0q+O9w@mail.gmail.com>
Date:   Mon, 21 Jun 2021 11:50:26 +0530
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19DC5989-2AB9-4349-815E-631CC7AF0E91@gmail.com>
References: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
 <CAP8UFD2sXjRgn6FqOcBor=Q_PXmy+xL4mHmV7Qy_fSrc0q+O9w@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20-Jun-2021, at 11:22, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Sat, Jun 19, 2021 at 3:32 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Here's the latest instalment of my weekly Git blog:
>> http://atharvaraykar.me/gitnotes/week5
>=20
> Great!
>=20
> Just a note about:
>=20
>> if (ps_matched[0]) {
>>     if (!force)
>>         die(_("'%s' already exists in the index"), path);
>>     else if (!S_ISGITLINK(active_cache[i]->ce_mode))
>=20
> The "else" above is not needed.

Noted. Thanks!=
