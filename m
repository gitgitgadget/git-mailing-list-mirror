Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5D7C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54B360FE6
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhETED6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 00:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETED5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 00:03:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F35C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 21:02:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i9so22289913lfe.13
        for <git@vger.kernel.org>; Wed, 19 May 2021 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qevZ8ejH0FOimheHqlS+ZW5vC6or9f2QEQlElGf1Hwk=;
        b=mwb69iFOSqperu5NODE/cAUvqoYM2k5k1BswPBJZqJNvUn3d1WsC8iWYUZWN7bgyZL
         a37KkcryVtDjR3xSrbD0TWbef0+QHJIPXGS5p1E/2ECoTg8OZRmJGUcKFZW2UHPsU9mS
         5YWMoUg596/U+N/5vp9tqMV+WGCIWUlJX0X6yCFXMoaIEq+5gyBN6dQ0+8lVFYINo3zh
         JMzi/kiI4jGAheU3ho2od695zo+UeNwb1vaMIUHphBbjZE/Q2rWN5YAQpFJacAd9Ndnf
         WVl5ctHsR6ecWHn/6ntIyk7YkP2KnPQ3OQLowZ9hUopeo/ezr43Ss93rfi4zHFonTyOm
         qEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qevZ8ejH0FOimheHqlS+ZW5vC6or9f2QEQlElGf1Hwk=;
        b=m3Yie3hrr62gAAg3ru15+lqFQ/XXsuzwmLYrdA7edsLQeuJ9MrBw/H7V/SeBpuzv1B
         1WL5XHy7hPMHNInTWv/NRCiXHvGkLDT8Z1oob4kyffEdYN6osy/AX0T0uMwk38yQfL6f
         uYva6YFOZDqqR2fyjkvKohE15Vc3ZQ25Y4h0BzCO4o0sAMDCYb/W4UNMd85H2igHViP/
         O49XXwugPYXgb0zwtYu5SzOu5nPeyMieMtsnfvV6Slui4DaPE7cweVM256XUhd6EJDOH
         WWgjit4Cb8rA3a275TbidEKlcH0NRtaTzWageMdyudptdwAgnYmvklui1QB4PEeNu66h
         VvwA==
X-Gm-Message-State: AOAM531KD9tvP7oqdcqSJ/wOd9l5lx9xBR1JD3hZ7d76r5uNCOht/HfB
        iSC27T4WCxnlnhn/jHBfFC3aQmfuF4rsVGakmpM=
X-Google-Smtp-Source: ABdhPJwMsbIwI3CY4UFpVC8/NHp9zf/N+6YZSDYmeteRH3ovjATbE2c5Zso17LHJqOfBTvlv66RerrZdp20dkYK0sTU=
X-Received: by 2002:a19:8c15:: with SMTP id o21mr1890639lfd.221.1621483355240;
 Wed, 19 May 2021 21:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210518061855.57478-1-alexhenrie24@gmail.com> <626174ae-ff25-8f07-4d67-705bbe3f7d68@gmail.com>
In-Reply-To: <626174ae-ff25-8f07-4d67-705bbe3f7d68@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 19 May 2021 22:02:24 -0600
Message-ID: <CAMMLpeRxoakadrXUVGSkhP0K71GHXxt4sXvSKrB5rx8oFH60bw@mail.gmail.com>
Subject: Re: [PATCH] fetch: improve grammar of "shallow roots" message
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 8:22 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 18/05/21 13.18, Alex Henrie wrote:
>
> > -                                     warning(_("reject %s because shallow roots are not allowed to be updated"),
> > +                                     warning(_("rejected %s because shallow roots are not allowed to be updated"),
>
>  From descriptive to null-subject past tense, right?

I'm not sure what the best way is to describe the grammar here. I
would say that the "ed" makes it clear that the message is a
description of what did happen rather than an imperative command
concerning what should happen.

-Alex
