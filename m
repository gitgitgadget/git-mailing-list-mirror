Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A025C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDRXWR (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 19:22:17 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:45522 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeDRXWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 19:22:16 -0400
Received: by mail-yb0-f182.google.com with SMTP id r13-v6so97111ybm.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wHMFLZVM9pHRE1/lC41tqglAdBcGQuebtDXPJc6Xavw=;
        b=fCy/wvCGgZOBEVnYGP0w7zOirZqTJR+zn6fUwfIqA0SUNCyA+LsFAYoe11X7xVok3c
         OLDa5y3ff96aVLpQGjuhnHjQLEjbDGHLUvTCsTiJdMfiQ4hc1Qx84s1SEFJj2Wsrv4b4
         pVuALkPX4RN7k6Fq/zRYzSEQ3RflJd2BKfOw2xqoqB9/fTkBRTl4JP+VgRqATlLK2NDK
         aNKNwuJlTdRWqJM2wGRMoCUMVau9H7cAlfc0JFvkp/FIfX9Tghn1veD10IzZSNi/98WR
         4j8w8l/EKH2jbY4f6LGdXHw5c0R4oibBLfk3cMHhziyVKz5f5XyQjsfPvQstCx6YSOp9
         swMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wHMFLZVM9pHRE1/lC41tqglAdBcGQuebtDXPJc6Xavw=;
        b=e4T2kpYuMOTo1etxXTeaxI1dYYGyxesNh+s5XGMLD/LWogr/zAhFVvk2eJPcYTHTRT
         knWuZUlCcPTRaFL2Ke7i6Of6/FqVXu8qzSUi67+vB/iOue9QGZZ7P/Xx4Q++GMqnJr8k
         ebwWS0KJBZkKLq6stZpOcziTLbuTIq3cZrDaftAvg1DAqh+F1eCMo7KOWVFQGCDTDiaX
         17RLluNoKxwmN/VOFyAmLVO60zTFPLbWfIVVLA8V0XxuflpLv68zNBClG5Qcw6YgypAP
         K/BOmHibKIyDdePaP7ufnQBFbER3S2sH+V5q3pUUAaKxOrTG7BgIjrQA19NAzzsukuuv
         ea5g==
X-Gm-Message-State: ALQs6tBv9Ki3ZS46klGjft/9EfE/iUy7Mvj91AEL4jn+LVGMEplwLVUe
        JxzH3fdIgVXq1z93CmqbD25oZLqHn16j5ENVQxTuiA==
X-Google-Smtp-Source: AB8JxZpDEJQc8MAnyB6v5uR9iSX5EJRgb16QffBld/JgBoO8dQgjcKNy7cA0VkIu7YrlpfSnirxP3UHvMxV+p4XzgfA=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr2675897ybb.334.1524093735801;
 Wed, 18 Apr 2018 16:22:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 16:22:15
 -0700 (PDT)
In-Reply-To: <87sh7sdtc1.fsf@evledraar.gmail.com>
References: <87sh7sdtc1.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Apr 2018 16:22:15 -0700
Message-ID: <CAGZ79kak57D2_9bx5KwefFEZ0=Dk2bbZ=n8YFnByChK=6Hj2HQ@mail.gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 3:48 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> We have a -s ours, but not a -s theirs. This is a WIP patch to implement
> that. It works, but I haven't dealt with this part of the internal API
> before, comments most welcome.

I hope reference pointers are welcome, too.
https://public-inbox.org/git/xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com/
