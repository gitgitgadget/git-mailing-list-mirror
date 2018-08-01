Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5171D1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbeHARH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:07:56 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37904 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389627AbeHARH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:07:56 -0400
Received: by mail-it0-f43.google.com with SMTP id v71-v6so9825760itb.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/3OAr3Tzyl6jQasqEXX5/Sn2+WmjkigcrsrDMdvSAI=;
        b=bKMYRBtLwrN7XtqtS+0P6w9UKHkrHtlX8ET815jfkJtjx1yajYKCphhZLZDUjT3u0M
         /2t7fvDI2y1mWyzs1ugAXNalG8RnPCCqiVTcANuXLPuuVPWyZ39CiQ4DQzEJoGvwn7Et
         LIn8YevO1CFVPcsL6UYSgdWHq0R6HATZFNzMMNGaCbtIIJ826ycjU/mfa7z7E8J5XihU
         kuZkg4DDAaxqHVulsQDKoWl4TfZinTDqxTcNnFXdhzQtaURWZR1Zovs+KajlfHMDHvzJ
         z5w/9ZdCDLqiY0F2cQaTViPidcPWuplRH3uZ1n5/gv+gotHz1++FhKvgrZPiZTSFN6yB
         GFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/3OAr3Tzyl6jQasqEXX5/Sn2+WmjkigcrsrDMdvSAI=;
        b=QbziapB8QDUkXIYosnUSNie7gGE2zXqyWz9s161vs6o7xTrbqO50a4zMTf5hMZugat
         Mmhr5J3JDf/dXhAAYaSbj7RCyO0H5o1tzqI1tVpwEUahjmxqXMxzvTTEvtWgpG1J/lbh
         igMK8qAuUcj/k0NEUKdzHBTIWv8883rEEsKWtLJkSnI2OUdgfgeiCO2Jfz14ALcxy1RP
         tCsGk6T1HBNp3YJqqddaT82fe37t1KgwmMpjZHmLN9cFPEgoMtkGd50Ilf8gxoZwk8q1
         tXzLq+V1EywqumZ5Er0y1dszUCaIpDhWJYKYfCXzOvYZuZSHy0+6FD20R0Nc9/Aiw7+X
         ZjVA==
X-Gm-Message-State: AOUpUlGh+gXX0DhATf3Vqt0IG/PMHmEqgWjgjM1oeik9IMEmzI7g9WRh
        vg/vr4DwVAr1slkBOLTuB3dI2+sNQ0RSif3RwUE=
X-Google-Smtp-Source: AAOMgpcbjTz3nkClJ/oPnRPIDl5i2e4yImEv5nOTN87WEQmRLoblWkorjOcWhdA40GIEhYrCXI9cV39mOrFJYMKA270=
X-Received: by 2002:a02:59c9:: with SMTP id v70-v6mr23468606jad.94.1533136904344;
 Wed, 01 Aug 2018 08:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180729092759.GA14484@sigill.intra.peff.net> <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
In-Reply-To: <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Aug 2018 17:21:17 +0200
Message-ID: <CACsJy8C4znRAiQMUt_t85EUCad3HJUeeHd0z2g4uKZDfjWs1OA@mail.gmail.com>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 8:44 PM Elijah Newren <newren@gmail.com> wrote:
> Is it worth attempting to also warn about paths that only differ in
> UTF-normalization on relevant MacOS systems?

Down this thread, Jeff Hostetler drew a scarier picture of "case"
handling on MacOS and Windows. I think we should start with support
things like utf normalization... in core.ignore first before doing the
warning stuff. At that point we know well how to detect and warn, or
any other pitfalls.
-- 
Duy
