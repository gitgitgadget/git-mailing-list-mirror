Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A4BC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4F3207C3
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 12:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHKwMQqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVMV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIVMV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 08:21:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DDDC061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 05:21:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gx22so13495289ejb.5
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=68U8YQjWcrtWc7RRiPOVWehQesL8LjaHPxGzDBH5Lgw=;
        b=AHKwMQqkMB5etc95HVDS7Ft9Lu2gsbJbddrCEoDnA0YPDISkofywhR25h7K6v9kcO0
         Yw74yBPBkY578BBCLHuCUz+8Hlg1Pm+UDopVb2IRAgazf4Gy/GRManUPXOesOUqjvKSR
         nfM8+fbA8hQ+AL7FNPiofVeexN2gyjQWoyE+RE3Attm8PPVgKlvSgljbcCwvuG2P+tuA
         ZnjxZaF000IwNsF7ZOoAnQuKKjmoYMhgloYaWajBq7+Bspk3bKhmzS+JzL1DNbH51tRd
         DdTZ7B/LcDxKKe4+XXILOXUp5wC6p8XWi5oDFXl9dh2bhS1vK3HJ8pjSpHuRkL66wh1O
         +amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=68U8YQjWcrtWc7RRiPOVWehQesL8LjaHPxGzDBH5Lgw=;
        b=i9zrofOHQsCco0KCpr7D5xBHrpd3Gj8r850NRdWAi6ac3z+qD9r6aGFF5NfwZAXULS
         d7+ju91gE+jTrhPJ+DRheQmCzkbvraXRXIdGAmZh1hayAIo7xPmy4pcae9Nso8q/HIC1
         wGuHFXxNwWdC9zMW9uIXv9Qcxws1TdnMfn6wx4kaC62M04GfPVgBP6Q7Zk4FmsdGtF+L
         SgqOe9H4dd7pcRjANzLHAUbmJt/yQGpsKfRnOhwDa3A7z7jrQ1lhpSbceLS0NSJjs/fD
         s58VT0YAMBERg0ttQsxUV9owTC5HY8rJKnOfxMcaxt11LwWrKzfQdkSXURg0gQRYZYrl
         mw/w==
X-Gm-Message-State: AOAM532zBRqbzHdNPkJc16m4edvi5QZcS3WIr6kdjw9GEXjoeUGFfw//
        VKC+8wc2R66dx0byzgQxTk2+Q2Zp/ADJZw7yuxix/Z14JhFtOQ==
X-Google-Smtp-Source: ABdhPJysAlwm6EiQy1nVlsTy5UyP+ZizrqQm/RTkcG+OqNPpEkWPuBdIeaVIHFWxpwpByLUYGcphe1TxXpmtgiA3RqE=
X-Received: by 2002:a17:906:819:: with SMTP id e25mr4749134ejd.211.1600777285981;
 Tue, 22 Sep 2020 05:21:25 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Sep 2020 14:21:14 +0200
Message-ID: <CAP8UFD32jLuyq4izahdMwaYmKp2mTmHHTxQD68PqjA46Pc32xw@mail.gmail.com>
Subject: Draft of Git Rev News edition 67
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ethan Rahn <erahn@arista.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git-inclusion-summit@googlegroups.com,
        Carmen Andoh <candoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-67.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/455

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

I would like to talk about Git Contributors' Inclusion Summit that
happened earlier this month, but I am not sure if the notes have
already been shared with everyone on the mailing list. Any information
about this would be very appreciated.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
September 24th.

Thanks,
Christian.
