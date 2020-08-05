Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_20,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ACBC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9122CA1
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWVpV6JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHEVZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHEVZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:25:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72455C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:25:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o18so47964129eje.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sS5QFld63S8PBTdBJNtUnMbMTg+LLnctZtkX9/v8BPQ=;
        b=cWVpV6JGNLavNYcrDkOlep4wtKOQ15AbiuBVxhGwcSIUqitaDHEu/jfm4mWo2UtD3B
         c1r0FZvNzfnC/xNVXPGuCrO0OSsW0NuHFNEoqbTtzdfNHzPYm1yBchW571x4exwF3sWj
         JVpM9stF00Pm3oFRWE5XSMmMpHoW6cviKTwa8+Kk10raEfRqiM2l1tFI1Bc8UU+EWs/j
         KkzAwp0389BCxDZvqz4uwSVpdt8XIAP1cyp5t+ubs5OSelYTU5oV+D0T65Ot56MKKxHr
         s+2MsGzd+OtnHRcTLmuoImhUwNBRL/IFPyAjeZN1JjWVOvlboG99vnRInKWH2erqCbyt
         mx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sS5QFld63S8PBTdBJNtUnMbMTg+LLnctZtkX9/v8BPQ=;
        b=pTfNgECBJCXpqX3RI1rbXlCQY4m0tl2B8rH3sAur/zF4LsAM6lQHOgDbdGDQXwKs3u
         f6om0p1k+jPcTfzpN35dH66JFMFAkRHHOwBxOe3a9OV0cvwMN47uz6bOHWdG26L6M7gI
         xwlqeig4in5xCwD9aprdmg9V/fPGz10idgkFZJVUKkRxjwJXoQV0bOjofdrrTCdCEQ5L
         VPwubeQhzdQ0Z+xn5/iyLVXogiGvoCrIcd2SgvU/Z1NHl6pZVtPPRKhWmPgWvMAIJByg
         8rXelUfSlXKTdadoNomNKNY5Nfyzm4/WW5ZFnMpiaKf02LBoLuiERl+xuetpIyU441xX
         Sc8w==
X-Gm-Message-State: AOAM533zoxuirnffQ/cRVSvjL0w71GVZtJIEX9hVnY1K2GDCstvyWwoY
        sKErlD5W8EgHWoZKZ+f60unGZCrefZiD0Tlv19EJ5dY/J4dn4Q==
X-Google-Smtp-Source: ABdhPJy9sWC6wLfty/4C1NEYL+8rZyEh86qhDgXAmqMSgdfqsp0fbIJcU4yTl4aKehK45M4dPfIncl/mTRkSewlo4nE=
X-Received: by 2002:a17:906:3b91:: with SMTP id u17mr1211713ejf.305.1596662705550;
 Wed, 05 Aug 2020 14:25:05 -0700 (PDT)
MIME-Version: 1.0
From:   Carmen Andoh <candoh@google.com>
Date:   Wed, 5 Aug 2020 17:24:54 -0400
Message-ID: <CA+TwhoJdMEZv_9KSCujwLk0LcYYyCbNiQuKwSVDM2RXoPy=y8Q@mail.gmail.com>
Subject: SAVE THE DATES - Git Inclusion Summit
To:     git@vger.kernel.org
Cc:     git-inclusion@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello All,


The whenisgood poll results are out.  The most popular days and times
for the inclusion summit are:


Monday, September 14th 9am-12:30 pm PDT [1]
Tuesday, September 15th 10am-2pm PDT [2]


This would mean the summit takes place over two half days.  Please
save these dates in your calendar. We'll open up registration via
Google Forms  on Friday, August 14th.

If you're interested in helping out, please email git-inclusion@googlegroups.com


[1] https://www.worldtimebuddy.com/?qm=1&lid=8,0,4990729,2147714&h=8&date=2020-9-14&sln=9-12.5
[2] https://www.worldtimebuddy.com/?qm=1&lid=8,0,4990729,2147714&h=8&date=2020-9-15&sln=10-14


Thanks,
Carmen
