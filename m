Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8136F1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 22:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeFAWlM (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 18:41:12 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33585 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFAWlL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 18:41:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id e8-v6so34131812qth.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UpkpWfz7SN64AiqToWqCeLietGIs2TCctUF0DxvZoKI=;
        b=t2AKpXejkLQXUYBHyG6AvBxuDxqrSWvqGO/fodA3ok2xkp6PK8t1jF4eJ904FbrNu6
         76yqjf3XrthU7F13u0C4Rkb+Qn8PN4DQiBC9qJZOcFhHwFJO/JGAPw1YIT/uMtxrC6Re
         8V3XiLr9R7RXHC8PXNGhSwGIzujiXZPFwsVg9mIPgRCD1Xmot+7payaEvOa7oubYj3RS
         iOVWwNfb1Q503WtiZ2RGDBtes+8N3JjGeScNYKRhjb8SDBERws4AyBh8KxUrbdYc/W+C
         bGhq9In5XqMbXQmiWqNzPDzObygoNuSQE0rRqZKV2iTITZfXc/O6KhfsdAWuaJYoYLvJ
         Vg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UpkpWfz7SN64AiqToWqCeLietGIs2TCctUF0DxvZoKI=;
        b=Wilkvc0cZ/qTDpd4PEJ62Euwcf0SY4v5u9Pyhf8OP9MTf02ob5hBVdvPmtQAl6srYS
         7mh2wiPXVakkpjdGJpsuO/4njxZHDWx99vBVrap7tkW1Ll4CbMQZF0uu3d1dSQ59uPY5
         EljmDvjyVpSjFp8x4hgs+fnuVMwWulSut0Te1q1paFmRqQwIAQBgt/53IHJZZPQ4SYxh
         LvZs9ReMjtPLopzS84GYNieFfUSwjMyUfGqgDFVQdnBqGpseNSAeWJFrBl3USOhuPmxv
         GjVppSPFwpblyrU4EQF533vQy1a6+zUO/nvf3DnIV1P8UolmJpesSyCLmC2zuGvN3NEy
         UtUw==
X-Gm-Message-State: APt69E36XvqAJp4femSB5nTG30uMYrzbU2UvmUv7O/9o1/h/DaYareA6
        R0XBR1tWqhZ22CJf95C5MK3xkvnKtaQdRPEMHcQ=
X-Google-Smtp-Source: ADUXVKJVkBhracI4jQtyH142IMWACTAgPKHdzNL9korFdbvYOvuKnuOfYwgdm1o5oIMmRG8HoGQJbepC/6vPN7HBTcQ=
X-Received: by 2002:ac8:678c:: with SMTP id b12-v6mr12240500qtp.314.1527892871228;
 Fri, 01 Jun 2018 15:41:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 15:41:10 -0700 (PDT)
In-Reply-To: <20180601211015.11919-5-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com> <20180601211015.11919-1-avarab@gmail.com>
 <20180601211015.11919-5-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jun 2018 18:41:10 -0400
X-Google-Sender-Auth: 5bmUrv8JGIZ4ZPE9cc8-L6mVoNE
Message-ID: <CAPig+cTVRk-fGZiGDx=D6JmyDUDXFEaQ=JTBYX97e9VJOvxafQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] checkout.[ch]: change "unique" member to "num_matches"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 5:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> checkout.[ch]: change "unique" member to "num_matches"

    checkout.c: change...

> Internally track how many matches we find in the check_tracking_name()
> callback. Nothing uses this now, but it will be made use of in a later
> change.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
