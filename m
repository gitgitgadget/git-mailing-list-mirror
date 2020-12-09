Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D9C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5823B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgLIKkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgLIKkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 05:40:16 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E032C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 02:39:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so1007547wmd.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 02:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a4KMF/p6KOTzrVNohfXBAaf5m5gXNye4whvYq/DQ2E=;
        b=Yhh7zarn3H88aOW5VLIqj5cmIU2xvHBRGEsaUvNN8LNGM9M1ALIzUMiKLCkdn/sbDH
         BVBVySeFgP4+i2efO1v9+j3KnmW0cPs7dswdjXZ1vCRFrbWbhnX38tfX6eoDbUZYvAbU
         PDzjNjqxxTaq5Peo/NoXaT7LDYaiE+nySFFk2Ct8bgix81QunDgmpKLkUevuLv3DDE89
         3ABNNR7fI3VDY4Wc26crgFpJ55Jf73CzaPO7LS+Xm3MbGEehMC2L+Vk4IDfSANV6Zn33
         3e293LQEsYxCCGVxKXbN8RXpg3nEguYjidu+xeAzBJiSsoBh8XxxfG3DicprhJEojchX
         uRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a4KMF/p6KOTzrVNohfXBAaf5m5gXNye4whvYq/DQ2E=;
        b=XXFckl7m5XY4u/LGSqPmEa/ohuQlhgIgaEoWxEzHJJwtxuauLIGH895ollU7jEsh2E
         SrZHL4oEDhmkKka7wHvd7DwEeQqf7buR/bQd5oLEffywuXo+43f2dbpUMlOnoWymYW4K
         05CRldK1rCG6TV3GltGV1AHeh2uUSaW6nKYfj7qwGhySKaxiH+ByV6Z7bQPJENOVdlJ+
         zbQqWLqjLbSo1n17BiSAlFEiRJaqsVE+ZKFysTNH4t5lwKXnK3hwfPRrv8nbdyNoDcZr
         xHK4qJpvi3EBeL38PdV4pM8tcwBQiarAenylpT/OVmRmOZL5aDUj8InXhpMAMH4wDSy/
         H5oQ==
X-Gm-Message-State: AOAM532Q3kxyfFGz4bmkUdSfZeA26D2d8fbRaGUACKW+qaJN+jV0i6CU
        sUVDCQs2AHVczA/Q/7JA/1HXmqRLWgdx9Mg1NTE=
X-Google-Smtp-Source: ABdhPJwQ10naii6qYtdT2yBvSCrH9yUfv3J1XwhON8J2SaIBoBCd9mQHTMI/iJuGVQb8HVvNV2L9WrVYV0/r97wqNmk=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr1965487wmb.173.1607510374995;
 Wed, 09 Dec 2020 02:39:34 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-3-felipe.contreras@gmail.com> <CAPig+cRmCV23BjN0t3jF+VtxNS2a=E3Tr=x53DPn46qM15uMng@mail.gmail.com>
In-Reply-To: <CAPig+cRmCV23BjN0t3jF+VtxNS2a=E3Tr=x53DPn46qM15uMng@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 04:39:24 -0600
Message-ID: <CAMP44s1FD2aBej3GMOQ4pWSga50uCwR3GBXfHL2KQLu3FSKLNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] contrib: vim: add sharness syntax file
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 1:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Dec 9, 2020 at 1:56 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > It gets a bit tedious to see all the tests in the same color, so I
> > wrote a vim syntax file to relax my eyes.
> >
> > I've tried to make it work in as many situations as possible, yet there
> > are still some issues with HEREDOC strings.
> >
> > Much better than nothing though.
> >
> > This can be enabled with the following pattern:
> >
> >   au BufRead,BufNewFile */t/*.sh set filetype=sh.sharness
> >
> > Whoever, that's already added to the project .vimrc.
>
> s/Whoever/However/

Oops. Thanks.

-- 
Felipe Contreras
