Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6FC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532A6613C5
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhEEEII (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEEEII (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:08:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B6C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 21:07:12 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i67so396539qkc.4
        for <git@vger.kernel.org>; Tue, 04 May 2021 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R179q5XpyN7195ajo67OK6ZD3Em6Jo8NWwh1cLE5d0A=;
        b=YWKtP5r5wNbGEWXLlkkWNOALXnEjbdHbsY/1LfgdZM9B+lS5aNhBWrZ9hdGkU6Rvd3
         qipiXQ6lJlFP/JOy8jzOVJ/4zVJX0BjEME4OU0ZoLZ0UwERZ9zF5F4La//St3w7xc8XR
         SclwO+PBDHOlvA3TEwt86cnscp9z/5oXmbsLaRr0GoS7oDUBTwkEwWqW5++Z1VFriBUH
         CSAzioW/1Ke9lsH23xZSPxH/ko77KN1jldeku0bGQEJyCl4kLcgWqYL8HYBgudM93uXl
         bSPHFtBWp4Aa+SfkYoNSXDf1R4KZ/HdOzCURA9CpZV1//pkCNGii1386O3vcBq8h1ocv
         fxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R179q5XpyN7195ajo67OK6ZD3Em6Jo8NWwh1cLE5d0A=;
        b=E2nv6cHtA1IDWdxs64ot+cOy43lHShdUt1mWGh3xmrmKEAofljxsZfbGwPWw+PKkr4
         7FZBCCe9EB4tmxdzuhX0RaGte/G2XTqIzI4ArFh/qKOpWVi+e9aQnj9W0gz+VwPsZWZi
         wXMszar8rojk9pl9Y+U3CmxroXv8f1tmGHYc9adXR1aYOiaG0hNn+SHflQU/7RehtE2y
         /qD5iRggFmxWDl4Zk0fEUR/ae279avYSfd4fsdvuYFAW+1vuOanp9Vau2aCbbaq/amEd
         m0Z1SPACrhbyOUKv0dk3YZIOBht7fqQohs5IahzAhylY8GstsigXm6qzOUvYzm8CR6I/
         3UTw==
X-Gm-Message-State: AOAM531H8hQBUxeuF3XONgI3OVgaQqzmvvBe0jTw9RDJGfoMtMO0swWs
        An5cnYYsQwbs3dgqPdamp509DuCqOvicnzaBQYE=
X-Google-Smtp-Source: ABdhPJyHHlMk00ddNhedPvcKyO9RcftFi6mEXhZ7rzH79I/lqyWzj9hIkt2YBunNgbHbbDVL5EdqRwk5qCaSeVKQ5fU=
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr29790923qka.231.1620187631385;
 Tue, 04 May 2021 21:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085251.51475-1-andrew@adoakley.name> <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr> <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
 <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
 <20210504220153.1d9f0cb2@ado-tr> <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
 <xmqqczu656iv.fsf@gitster.g> <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>
In-Reply-To: <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Tue, 4 May 2021 21:06:59 -0700
Message-ID: <CAKu1iLWHBgG-9RkAeDRUUQwdjTeY00gxtDC_K+e1bGvRh4ZktA@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Luke Diamand <luke@diamand.org>,
        Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops, noticed a typo.... the paragraph should read:

I'm not sure I understand your scenario.  If the majority of commits
are in UTF-8, but there are 2 with the same *non* UTF-8 encoding (say
"cp1252"), then just set "fallbackEndocing" to "cp1252" and all
the commits will display fine.
