Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F29D1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeIHSOT (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:14:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54854 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHSOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:14:18 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so24098728ita.4
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lbXN/h0PjZlQmtv+oogqhBGt9oFF2t7fkSjWKB1XjY=;
        b=MUX3wKSR6TE1Z/xsCbfCcy2OgXR7CB4h5bLUsLt/YryduNLiCKfNm5PXBKuRTy3S/I
         a/xypiz3/97YDbMKXI2aApPwB/tXkHCic+D41Up98t/BXpYrnoqkD60zRJTct9NcJCMD
         XHcUAHjacBLvMsXe5k2x7uGoGWCRlPOLJpRx/DMIj+Jmitk1dHlfFB7wQ4a//TgzDWAV
         6hnO1RGg/c1m6uk+CJa8s9qUIioyIt74b2x2bXIFHl1Mb2PMRCLVS6s+3e/Ld+VeCVPD
         2N2Kvu3kwdGHta3JRnPVls+7F+/MWZo9GCO8LLxblPxdBHsuWUounqNa5VpXSTcoVyC7
         76BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lbXN/h0PjZlQmtv+oogqhBGt9oFF2t7fkSjWKB1XjY=;
        b=PMkmXB/T5OGEW5PYW1qDSEw7hW8pl9ja/4hVOFniGZSyrt0eys4zumQ+NXiWq3fl4I
         dBNytOXF2ULI34N1giQMN+rCGj/FKss62mzB1dv8i6kMRiyQR64+b9lMOxBHOLVZ2o7t
         wT7tnfqthEYPOgeYoKeAlG3VhLR9V8gZr7/1T+1y6ajLk3JH8S6v4edDuEv0bJiTHzcW
         vAvgiOxrIiJtXnX3+PSi+KSFig7QXAIRo7R1BZBkD4Sn9rFj9eb9g4QtXk30cTImYFAD
         S1nnqoXgjKRs/Fwml1EkSNmqNVdZS7P3qZ7hnRxqeGHmp+RiitVhGoVsswDUJQq160zD
         xFwg==
X-Gm-Message-State: APzg51DSR2W7/3VWkZVqHQuKzMwUyMVMx/xT5nRUVYLjf9/y4c+7vUY2
        v7iw3kvDptyUZJUD20o5K0fZ3CIeV5qROI3qVxc=
X-Google-Smtp-Source: ANB0VdZ46MRH1RbBqAES5dGLK4XCEeTCmDO2QKJBIYfJ6BR83ReY0lV0cCJiyLYwCTEmXpdc2TapEA0yRdrsAhS48v0=
X-Received: by 2002:a02:b006:: with SMTP id p6-v6mr11316759jah.97.1536413311148;
 Sat, 08 Sep 2018 06:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180905085427.4099-1-timschumi@gmx.de> <20180907224430.23859-1-timschumi@gmx.de>
In-Reply-To: <20180907224430.23859-1-timschumi@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:28:05 +0200
Message-ID: <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] Add support for nested aliases
To:     timschumi@gmx.de
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
> +               /*
> +                * It could be an alias -- this works around the insanity
>                  * of overriding "git log" with "git show" by having
>                  * alias.log = show
>                  */

I think this comment block is about the next two lines you just
deleted. So delete it to instead of fixing style.

> -               if (done_alias)
> -                       break;
>                 if (!handle_alias(argcp, argv))
>                         break;
>                 done_alias = 1;
>         }
-- 
Duy
