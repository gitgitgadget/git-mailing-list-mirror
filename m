Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2AC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 07:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiDPHFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 03:05:37 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3C51302
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 00:03:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id 14so5849269ily.11
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1SHJwfmBOOu2mno0LcacizaEpz9/BQ/XsJ1Pb+fosU=;
        b=OllhqnQrHAr2BSBBpBrKNnPo3DZp+GBI66+lT0B7KxUZTzSOWVPqm9xdx6O4fxRIX8
         yF4DqdPO6j7cBy6IqxDagbAM0KIoeVwtaoY2Qps81A0T27Tep+BJXSz+UnbI26qcX1rJ
         VC+RX2G9+A366KagI3hHFk6jKwgZnuxltS1vWRUm0COShnRPVvuTpthD8jlKb45VCcc/
         Os8XfdqdYvJhRPHPStG3JEpJpQerhYW3AEch8MaxW3MZmRuDiP0RoxDHj+g8zA4/EdcI
         /vA3uMtb3XwsTGYOqu+U5aRup+DpHZvdmW29gIGkHp8esPMjr3lotdkFh3MYbT19JvOB
         byIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1SHJwfmBOOu2mno0LcacizaEpz9/BQ/XsJ1Pb+fosU=;
        b=7fbjQkn1/lBo1kWi6WgfdKejImS0DLME/x72DhMcmwt4aPA9P1UbuLAHSYatGW/44a
         nLK2k4zHMpBYJg/AJeZ2CWIHiEnfV5LQdS1ORfox6Uw6WtUwipftb0d5kcYF68446F0O
         KHkBJsSYIE45tfu6T3LdfC5vvK54rc+YKTP2l0I30v/shtJ8HM8H06TqDR7JyXoZ2AjD
         NRO+oVY0RwDjgYBMriA07dkAW9036OMFlxi/MbxqRs4kB6hBbWBgztCWelJ0CmSOgNWJ
         RS/GdctezUM7MPEM21ffLm0qyEKpCDZ0zyUPtQ+InIOiVEbN2doSAdlMe6YgbXSNJPfZ
         4zBQ==
X-Gm-Message-State: AOAM530F1ZnPqwX5WsA/XVVs/zotrH5bA8DYoCdYKMXZq2dlGiygMJEl
        2BfwwQVqPNnB6aHd6KsoLOfCsvaVwl9h7AiSL1PSCAONQvL2Ng==
X-Google-Smtp-Source: ABdhPJy66btuUhukhihOorUMmnH3L4HwaM/IDNm1vgbA3CDepRyXrT6ip+BYPOZpv403/lkDW6updByluknOIM0H7yI=
X-Received: by 2002:a05:6e02:1ba3:b0:2c7:e022:6801 with SMTP id
 n3-20020a056e021ba300b002c7e0226801mr891990ili.157.1650092585692; Sat, 16 Apr
 2022 00:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <xmqq7d7p7cs8.fsf@gitster.g>
In-Reply-To: <xmqq7d7p7cs8.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 16 Apr 2022 09:02:54 +0200
Message-ID: <CAOc6etayh+OtusrFgAXjR=w_DmhzCQxws2cvJVJoyoH=uPEbbQ@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2022 at 8:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>
> > Let me work a little bit on your workflow to see what I can do. Tip:
> > It will probably come out in the shape of a script. We can talk about
> > what to do with it later.
>
> Heh, I have a script to do what I have to do every day multiple
> times already, can be viewed in my 'todo' branch.

:-D I thought you were in desperate need.
