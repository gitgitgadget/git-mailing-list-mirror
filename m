Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B861F424
	for <e@80x24.org>; Thu,  5 Apr 2018 07:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDEH7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 03:59:43 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:45138 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDEH7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 03:59:40 -0400
Received: by mail-io0-f177.google.com with SMTP id 141so29486516iou.12
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ghxgqOAnTkvm4Yc4uUHmBwMe+zbcVAdrbtFJ0EL3Vso=;
        b=gx+H7rA16+IiYioCdQ9erzgG6GdeiZqIQbhnwu5tgNpzkNwcnZJeX1r8fm3XXfPz6P
         pSO2ut8fj/t4xWjiItKvsm5r0X6qvqH35QJPsfyq/X0rIPNT9IR/2Kpm5Z+EBNU2Wxkg
         WYzkgR7WsVLWdDnHiyvDzGISzrEST1T0m5nIkegHo7dQS3nAEnFyYqzetJSYS6xfGuR7
         luWpWnyLMQv4HtluthK2VON3bkB8LmqxMOTBIQLwSiA6hchl04NniwI881ZneZkb0GM3
         2IkTr5EN5GU5EnJFBN0NcIxWttAoDuZ3/rW7bndMigr8CvTtkaMLSGuMPr9stC1Rj71u
         PXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ghxgqOAnTkvm4Yc4uUHmBwMe+zbcVAdrbtFJ0EL3Vso=;
        b=a3feX8UMygFZbiix6YlyIrcoUht2ll9ZP2gRc/jIHBhn3iLUTrIUKt40d1KVT4KK4f
         XWaqA7b2FPdZ9epdJ2F4fXrpKM5opXyHNw7As3xDkw7hk+tRnsf0zJV5Zwan/GrMFHI0
         h1kmVZTLw4CyfLS0n87hCFI5nETae6dyaQWynoSHuAOukpuT4TilDdBLurk227Cxi5jo
         pJ4tPDg4cLTlkhJN74UKV2p22kpqN2U8Cps4WuUeeQT9vfDLCR2EVy1JwOI5yO03T+Pm
         TU9S36fy5dmgAm3Upsm+3rbQH+gLSIkhnIMzqCydwLfyEIDecboj+sALxU7RXY/feTW9
         dsBA==
X-Gm-Message-State: ALQs6tC7M4LeLxIFAI7XvgdI4iROxEqMXKqXdmEqPEdzGwsqFJZX45oE
        CWmTWYlrNZA7rG716Jd9j9wIkoD0Ar3KXy1pXPk=
X-Google-Smtp-Source: AIpwx4+u33WY6CwPwxcr8FC3c+OvygWveaR0fEBqFjhWHPEbLYqOnQ5yCpHDB4tjkSLDVMfgxlD64PsBXe7yXF5rvsM=
X-Received: by 10.107.144.197 with SMTP id s188mr20841905iod.147.1522915180037;
 Thu, 05 Apr 2018 00:59:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Thu, 5 Apr 2018 00:59:39 -0700 (PDT)
In-Reply-To: <CAP8UFD3SM9e+_VGpxVNzMoEYnyzkF0EzjAPjvbFakr9t9Z-muQ@mail.gmail.com>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-3-joel@teichroeb.net>
 <CAP8UFD3SM9e+_VGpxVNzMoEYnyzkF0EzjAPjvbFakr9t9Z-muQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 5 Apr 2018 09:59:39 +0200
Message-ID: <CAP8UFD0yz3yH7-fpxr=69z=wXAVjxraFWsuDVa7Ke_6ByV5B8Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 9:50 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> So maybe we can get rid of `result` and have something like:
>
>        if (argc < 1) {
>                error(_("at least one argument is required"));
>                usage_with_options(git_stash_helper_usage, options);

Maybe we could also simplify these 2 lines by using usage_msg_opt().

>        }
>
>        if (!strcmp(argv[0], "apply"))
>                return apply_stash(argc, argv, prefix);
>
>        error(_("unknown subcommand: %s"), argv[0]);
>        usage_with_options(git_stash_helper_usage, options);
> }
