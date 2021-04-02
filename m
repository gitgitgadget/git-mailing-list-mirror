Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1921C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E746108B
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDBLiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBLh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 07:37:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088FC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 04:37:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h13so55094eji.6
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xvhgYPb9sbsRew8JpCDyrnt6gga5fH/7ugXLB3zKrGU=;
        b=rZAnZOMAWGnKhEOwdH730A+AL1PQEEpNquJrnGuhcqyStqrhuvWegE2QBTcnwDvwCL
         E7u01qqw9wcxpmRh+4UkGMcvUuvkmEzhoakRMKPGi03RzpQt+dk9X0P3W53QzbDxIHDW
         nap1JNG3RojYheQD7e3dAGD42Vkv7/TJj3Gye31QQ6dN89eZU21WnzQofIEu97NVpRHI
         rSaT5PFdKMgzc9Et9jHIqmNcidVx7CbFlWStZuiZYFlEe21Vd1gZSvIWlWoo9B6xki9S
         BqzuNbmiUMBzh8Sq8PYuS+RXWgA9/THpgMjBcnKlSviSSPloM3I1b6Ylq1PWIwlcJWCl
         I//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xvhgYPb9sbsRew8JpCDyrnt6gga5fH/7ugXLB3zKrGU=;
        b=qd7aChPHRxHUhX/NfjOSqtag5KdXDOTYY/tToAJyg3w7Wi/vvwxV5k3nhEbe+e1r7C
         OGJd4B09nLib7yrvSa7OL6nb92RZaBcCXN3mWaqRIXPJPUT8rGLhU3MoSlmMK+o0XWmd
         /VAE0DIam1e1TZSCPkdLvwUB3QImd6Rvg3Xzo+RnEVPMAVfcY6qXYeNE51BukVHSEJd9
         ggqawJ1Luu6mTN9V5fZtgSsNSDuzKaQCZzps2zA0/6XAkUxAUW5nyIcHpOW7CTkLg3HE
         6VMUivY5wTxgFMNpJyGZBp04yxj+Ibsbd0khf/VhH3tfCg2HKZ9Pb9GoXDWjltwc8Oeu
         OpkQ==
X-Gm-Message-State: AOAM533r8x3W8HtUblEadZan78a4UJ0IAQq8Z+T79MHbf2FVLdjcRE52
        dJmaamOfKqmkW0M/Ps+eMKs=
X-Google-Smtp-Source: ABdhPJzp5ltgjOk7Niq5uFQ3R7NV06aZ4+uXDHF8G9CRxVjzfXMFBvovFeArq9HhcdmiavbX/Q1HEg==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr13307321ejb.282.1617363475777;
        Fri, 02 Apr 2021 04:37:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id lx6sm4017377ejb.64.2021.04.02.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 04:37:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 0/5] mktag tests & fix for-each-ref segfault
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
 <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
 <xmqqczvd3hkb.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqczvd3hkb.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 13:37:54 +0200
Message-ID: <87wntkkjcd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Here's a proposed v2. We test the same case, but I thought it made
>> sense to test this more exhaustively.
>
> Let's first make a targetted fix that can be applied to maint and
> below.  After that is merged to 'master', you are free to add more
> tests on top,=20

Makes sense. I based Jeff's patch on top of mine to demonstrate that
those tests also catch the segfault.

> but let's avoid to have more and more topics that go overboard.

So "submit a new version on-top" or "maybe deal with your existing
topics first as you're overflowing my inbox" ? :) I suspect the latter..
