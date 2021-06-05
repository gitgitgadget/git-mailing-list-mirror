Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F6FC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E9B6135F
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFEWY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:24:57 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38836 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEWY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:24:56 -0400
Received: by mail-lj1-f171.google.com with SMTP id a4so16545114ljd.5
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skt5SxW+ApCNiHT2TZVw2MX402mtO34f1OwM2EUTW0E=;
        b=Zo8f4Swlkot1ekQJkztIkkGYJ3G3JGENOW0ob1150yptECTX+0wfbHi60/mMq4n3+W
         z5w0hNjHaU565AoPEMWKJnahJxRw5XQF+kFxZqfVHiimZ35oVW4Cq7IDBuwS8JIu4ovh
         zgEd2dmUSWdhjcbI9EG7gDeJ3FVv8eMVSE+HTD1itf7CLFTG1Z5zKNsIxnARRVP20Iez
         NpR3NIqrearRF+jserhJPloysp9nPMwMg+LXdPvE+rfY1sbq+rY7IN32yE5Etp/p3M8E
         x0ddAojNfzD4qXXhuoqH0pmacE9a4XGZL8Mzds6xVtRAiDs9VpN577MQyGVERc4DxVgN
         +Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skt5SxW+ApCNiHT2TZVw2MX402mtO34f1OwM2EUTW0E=;
        b=Gi6PBDEoKHBPjZOXyj7dh9nMszqijpi8nzDs7eRGE3vNJBCf7HMxDHJIxwQWWgFDV0
         /ckSU8kG0VSNCnKIy+4TOPuETB36LI63+zZ/Halte1kFaxoD1lvissXf1KtO+Rl9R1Zw
         AGBhGBQ4nHpXbQiwEobEfT3o7DnpHArpquKqDfD9vge++RHYcVxe8CJ3L9k1pTS5Srav
         qkcYJMmLdRjzRcCeVBpNMAQ+0ljNNFnewOm5aa/gHjfuxUewZ1YntIVNgTe+zMbSptsu
         xipIt4SxDkAVrImi8uo7W8JxN2YJK/VWmT9ElNIZL/9QJPqx9q+KmtrkJ/O/sQoaSL2n
         urnw==
X-Gm-Message-State: AOAM531Z5VrbdXjkLq1WM/Egk4AB27JJnAwZIlr8Au25dW1yCUsooLhE
        BdhCPDko6PUJXEiv+WUBtH8m8shvWbw2o1iB1wnH0w==
X-Google-Smtp-Source: ABdhPJz0Pr2DyhQuPS2ourrB5Sg0hIWjn61Nq660rkSL5BmHF+ESowwxTBf+vJohlD6+55BflJ0uQSmwy0tazKOnQNs=
X-Received: by 2002:a2e:7e06:: with SMTP id z6mr8789028ljc.55.1622931718841;
 Sat, 05 Jun 2021 15:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de> <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
 <87fsxw5bav.fsf@evledraar.gmail.com> <CAHd-oW6_29y90Ui-2mKjoyjZS0n9tyBY2a5ON8shEyddM0t8pQ@mail.gmail.com>
In-Reply-To: <CAHd-oW6_29y90Ui-2mKjoyjZS0n9tyBY2a5ON8shEyddM0t8pQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Jun 2021 19:21:48 -0300
Message-ID: <CAHd-oW4zZmk-_h7Ah0W5434v3bKJkoTfRBZB79Et0XW+T=PfTQ@mail.gmail.com>
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 5, 2021 at 7:17 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I don't have any strong preference, but if we are leaving the "grep |
> wc -l" -> "grep -c" conversion to a followup patch, perhaps the
> simplest change focusing on the dash issue would be to quote the
> right-hand side of the "local" assignment:
>
> -     local workers=$(grep "child_start\[..*\] git checkout--worker"
> "$trace_file" | wc -l) &&
> +     local workers="$(grep "child_start\[..*\] git checkout--worker"
> "$trace_file" | wc -l)" &&

Oops, sorry for the odd line breaking. I forgot that Gmail's web
client would break these lines.
