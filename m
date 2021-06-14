Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6017C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA0D61370
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhFNIvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNIvn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 04:51:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87178C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 01:49:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t3so45462136edc.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PFGUo9USKuUIs35Q73VVoJeZxgd+EPCkDsBD4KF8ho=;
        b=oQqLamQQCBCiEQ1ghc5uNQ41DcOMcfmQH6OmAlUfHtyuBfoX+AihvSK37IJl3sJTql
         JVs+I9vz4YBBkxGJAHtMPFiKw0fCuo56AhyHjbWSswWlRQGCvSxL3lDeWvgOhzsa/q27
         IdhmC4zIKQ+V9tYodWHNbISrZU8uzojNkqt3Hb0Lum72rvB8CKodLKrZEM+b20ozuK8m
         C5bhK8MnCvDOoq1l1QRhHct4Kfc+yNMdSiDi8S+d05OLOxmDHMeMiR1+OUZoecO9el6j
         Oni1WpTHkg2a3dD4+o4uxfZHgftmmPTxBLMf5TimMywkx6BkeeYr3N0pagKw2xSsvo0c
         HzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PFGUo9USKuUIs35Q73VVoJeZxgd+EPCkDsBD4KF8ho=;
        b=UlAiQ4bRgXRhsEQf7qkICevmZx+4dPwLoyhbZQsRFqrKmBiYFmSh37oNw/BAPFVBaC
         6qOPVX/FSDY92rUGjHkpm8Z3QaE7bxWxJBmRzR9i8uBIHlQq14KT5/IhFaSsFiviu6n5
         sj69lc16XFbH0Io2MdLQFJ34V+XxVDQ0+a6G15JbaKlwjwqGCmM5MS7/Dq7dnmbaCded
         zo+BuRPmXyE6+Rrrq7xw3O0PBQzG79M9tiXwJyfZ1QS/nJirpLrt2oASgOv+Wnq91R9l
         GWcqiigfU44ji9m5QoGqAMq52QjjlOrs/Z3bM2WkiNv31VzLO2HOmqA+cb/iv6XSgiM6
         WjgA==
X-Gm-Message-State: AOAM532EJ0pwiLVymVnhCswtId75WdfrfZIgNCgbc+SU0yn8o/1kRCxU
        IPTkBq3ljCfhQoHWAIGxX6LORuXTI64K3U+nr/k=
X-Google-Smtp-Source: ABdhPJwuSBFQi/ZTyY4YjfUD1WIpK8jQuTkMW/bCp93ao/77+xBq8Gd6b2r3rC82TaxOi3Oj5ELZJs5P+rDxS5/ddCE=
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr15713997ede.142.1623660579153;
 Mon, 14 Jun 2021 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <155ED50C-F11A-4ACC-A8A5-C31896449348@gmail.com>
In-Reply-To: <155ED50C-F11A-4ACC-A8A5-C31896449348@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Jun 2021 10:49:28 +0200
Message-ID: <CAP8UFD32_Mh_TBb4cJGSRFCNqiXZx3BrU-_s2GWYLszByL3r7g@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog - Week 4
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On Sun, Jun 13, 2021 at 3:38 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Hi all,
>
> This is the fourth instalment of my blog series:
> http://atharvaraykar.me/gitnotes/week4

Great, thanks!
