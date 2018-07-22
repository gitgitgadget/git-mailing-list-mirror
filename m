Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93A31F597
	for <e@80x24.org>; Sun, 22 Jul 2018 06:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeGVHRp (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 03:17:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34337 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeGVHRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 03:17:44 -0400
Received: by mail-ua0-f193.google.com with SMTP id r10-v6so9866083uao.1
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 23:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WyFhH4NBcbUgKKsEgAlw2FPJjq4gKLsc8F78vcJgM/Q=;
        b=hIstofz3Z/du3G+nO45zUBWtMj3+y1zie0HSiW4tCU795AJw7UWDGY1NSTfchA2vRU
         kXcczxeEQIrNqVIMh2VhIs0++SNheGO2bGeN68GJW5msRwkDJDnzhPJb+rri5VFb5EPr
         qeyuZOex3BB3PUehIXlRSdJQuw5VRnsFL4AcG2/tIh1MxeUVBxNJgRJf/qArglGOGcON
         XgSIxQxGeBxft/chbRaRuu6boIlt9EnwdQznbI4fXF86HUZTbkwnY5UXLl97m15xeVu3
         eQ03tNfUbASH0RNLZPMjSHOAxASvWwkmqEHCNjCeTsA9n3FUHhugDRbdUefxUrfaJxF0
         2fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WyFhH4NBcbUgKKsEgAlw2FPJjq4gKLsc8F78vcJgM/Q=;
        b=iPkupX/gyYHJgrpqk2YQTWBMTOHN9ZuYzcCzZ6Q6hDpZqT8+9lLwMDi0oF1dzZ28ct
         YLUoC545TofnA5IYWQPeW+gTX4WFToHFjN9yyWHB8Y2mE6C1i5avpe5DTthIzeUr2bn9
         y6lo3pdzkOkeCQy7Zz59CIe0jzC6OdNYEXABX2rVAsJAFyohlX3hMoGb3+uR7Ckdrqym
         au1+A/4mwjN98Ry8js88XpcDI2j+h4Bk1Z6S8E3DmZm0cYkTH+mLQ5iL5L5xxpz+Wl/x
         SmrGltqya2IveAlr7kBCtHE1HGNOaHw4ZBqdW9XNId8DFwR//vqFd7Koa4X30SOtAK5V
         ffbQ==
X-Gm-Message-State: AOUpUlGKZruH2wW69QvBhQnVhcGXdp+ucY1EgR/pzO5Fb3kbPSwRhf28
        VVU+dTtehOEJKLgSG63X8v8NqN7dhJGuLrFGoTM=
X-Google-Smtp-Source: AAOMgpcF5p1SgBrFlxM05y20RIAiyTANFIyz4alMqhMcGLSpdc+xELyENtBMjwz1qz6Sp0yChv+oWkjTRuv/FvoutVw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr5458091uaf.199.1532240531274;
 Sat, 21 Jul 2018 23:22:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 23:22:10
 -0700 (PDT)
In-Reply-To: <20180721044711.GA31376@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com> <20180721044711.GA31376@duynguyen.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 21 Jul 2018 23:22:10 -0700
Message-ID: <CABPp-BHecS-TewK=tCxEZkCiM_QF=Pj3LkDWOT6+2F1VCu-KcQ@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 9:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jul 20, 2018 at 10:43:25AM -0700, Elijah Newren wrote:
>> Out of curiosity, would it be possible to use the delta_size_ field
>> for deltas that are small enough, and only use an external data
>> structure (perhaps a hash rather than an array) for the few deltas
>> that are large?
>
> We could. And because repack time is still a bit higher in your
> linux.git case. Let's try this. No locking in common case and very
> small locked region when we hit large deltas

This one looks like a winner.  Labelling this as fix-v7, this rounds
out the table to:

Version  Time (s)
-------  --------
 2.17.0   621.36
 2.18.0   621.80
 fix-v5   836.29
 fix-v6   831.73
 fix-v2   619.96
 fix-v7   622.88

So the runtime is basically within the noise of different runs of the
timing for 2.17.0 or 2.18.0 or -v2, and is much faster than -v5 or
-v6.
