Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE0BC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A8260FEF
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbhESKhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348081AbhESKhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:37:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEBC061761
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:36:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c196so4499115oib.9
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2lQoJmyqPXidqAOcBBcNwRIq0kwpzYdhkbru7CuodSA=;
        b=XIeouVgunesgQtdxKNUlkSuYeyv0luViGzHZY9sY7F2YrCR4kPpPxRmts4xoGdKtG7
         Rl6jKF0eY4NsaN0wsGcM8BA8dIbEYZsw0wCt4ASvqfRjb9q4sG+5CVAcW7EPr2NbQK2A
         hETRV8oe+9AxL4bcH97cLWaeByfH5iwQDeiG1OtjnX8kVJ9QNSp3uFZsFksF/HQWAyzS
         gPbKUdsUaNoDvWb6BNtqEaoagvj0+UDZQ1vD6srM4jli7CFz2IiQeW2gB07lzYCTzLKx
         +hpPGIoyiFTqmHFuu9vMNAqLGEo0mCih3C69CTReRxygJuSWeQsI1rMyTVQyT5M45cbn
         Wiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2lQoJmyqPXidqAOcBBcNwRIq0kwpzYdhkbru7CuodSA=;
        b=Suc9/LOiK/dGtJ9ny4XYFNYZ5359aCpRQ4QNfxjJJVlYFoQ9FXhvYp4whLwZLdP0P1
         IoSxoWomrhcUz6BC0wFUzqfitdMi+3GHG9AqqORL9T9zryo7s+CLXQcaHp8iL6Q/8DM1
         imeQt+eRl05gT0j0xHiB54UBBAynBFSgOPSCMWWcdP9kV7whw3fyFK3kAxhXWlAWSNjj
         Ro6Sn+npwaGbu7UBxb0owP0R5/++xbc+97/GgI5xsOef+8vY8Ill4kI/3RnKA4fJhwSQ
         18znfC6iWOFdRhKiLB9Oer5M3Lb6eh9y0ZonZ6IZGzA4OrFhMs0QsWhq8K0l36K6PveG
         jjyg==
X-Gm-Message-State: AOAM531/qY4+MGup39p42/ZDdQ3QJQ0Ptr7rXBaH2z23Ry7NBhIGcRBN
        2/dHo4FVaYxJMWSd5MzKT/A=
X-Google-Smtp-Source: ABdhPJx7HHjNaND1FBACtptttm2+X7/RywMBuyyJ+BL+++liK9snfuYvc//q8VKbLQ9mpFfmjhkhpA==
X-Received: by 2002:a54:408c:: with SMTP id i12mr7650995oii.77.1621420586584;
        Wed, 19 May 2021 03:36:26 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id n17sm4022739oij.57.2021.05.19.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:36:26 -0700 (PDT)
Date:   Wed, 19 May 2021 05:36:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Message-ID: <60a4ea28a3807_86a8208d5@natae.notmuch>
In-Reply-To: <87lf8bqdv0.fsf@evledraar.gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This NO_COLOR=3D1 actually means something like "I do support colors, s=
o
> show them if it's important, but don't color things willy-nilly".

In my subjective opinion most of git uses color sensibly, so we kind of
already support NO_COLOR (turn it on, and you'd get sensible colors).

Except, my patch to colorize man pages can be considered to be coloring
things willy-nilly.

So perhaps that's the only instance where we should consider caring
about that.

Cheers.

-- =

Felipe Contreras=
