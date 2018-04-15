Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE771F404
	for <e@80x24.org>; Sun, 15 Apr 2018 13:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeDONfu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 09:35:50 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:51368 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeDONft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 09:35:49 -0400
Received: by mail-it0-f47.google.com with SMTP id b5-v6so8337897itj.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u8vLOTQWqqwY3YVALVdscpFVZYMMYO2WvDiKxYz1+Jw=;
        b=K8ApGgDwwyxuJ56qAlgNHqCBTgtcCuLJ9VmiIzbNSNGXjvzWf5r35dUygq1wxLcka5
         8o7y6Z7h9RTWOqHjZZ0oHAKIYTlheC+5TaZ+0qmnMeGzQGLYrzv23LQoMXATt+dXJh5s
         CO8RZio5C3vyhUnJnB7kGiL0YG5EPOn0RB/3jdG2tHlhUWJraUDPtyCV80Ek9Hba4cTt
         i86sO+FIfbUaUUUnGGHGpqQn0huCCiq27IqZYEkEUAg2UXACqAEtvRUNJMmCFBO9sSsP
         J3stRCpI/Z9ZLJfk+UdCUJpOYnayJSiNz9NCLyhQxda8ydJOuItIyo/V/kSxDH7kghTq
         WgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u8vLOTQWqqwY3YVALVdscpFVZYMMYO2WvDiKxYz1+Jw=;
        b=I7vSxjZ1a+8YvsBMgXBVqd4ayfawW1T4esZOenGehDumRkXQzScPsEC8oO2HJhxsuE
         f59D0R14CLten15yxSqLPiDLM+8kkBKAKuMHJMnNKUPYiN1IbVsFHzGw9jFJ6rXfhooJ
         JbvalYtgnOltrlpyOqy0Y0LHl5oG/s2W2Swih/xXMZiPyREQPnt0Vq2q5kCBpBGh8zDb
         DWGKakEQJxUIX2aqEAVraVFDLExrY4RWHdIjXRxD4SJY1NtoyV3eXxZz/xO5tL8aEXc7
         tHJaybrDR8bJJlgUMPKZff2UqCUsXb1rae6Jrap4fGdSlR7/zcyjxrzH4qs9EiSg3Sfy
         faEg==
X-Gm-Message-State: ALQs6tA1sIeXKslWfuHb6qNDcIU7ib7xfwJaYVKjlFXU61sDwmEtGKEh
        IddnecW3fQS1CnkkyHrBn0EGUWoFhdgh3WEwT1g=
X-Google-Smtp-Source: AIpwx49bOoQL0DNBJFEXUQYooftFwYC4FSSASmxK192wzYuRHxRtgzSvxXYb9xyWUimvK1SiZ9eP4duLu9KE6mqEwDY=
X-Received: by 2002:a24:fa89:: with SMTP id v131-v6mr11393545ith.40.1523799348759;
 Sun, 15 Apr 2018 06:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Sun, 15 Apr 2018 06:35:48 -0700 (PDT)
In-Reply-To: <20180415104438.2046-1-haraldnordgren@gmail.com>
References: <20180415085841.1269-1-haraldnordgren@gmail.com> <20180415104438.2046-1-haraldnordgren@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 15 Apr 2018 15:35:48 +0200
Message-ID: <CAP8UFD0gwLZ8NzpRKb3qz=QkKbTNLjwBVnEd0QGCxAGtCDo=Xg@mail.gmail.com>
Subject: Re: [PATCH v2] Make it possible to implement bisecting only on first
 parents or on merge commits by passing flags to find_bisection(), instead of
 just a find_all boolean
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tiago Botelho <tiago@gitlab.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 12:44 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>
> Notes:
>     Updates according to Christian Couder's code review

About the commit message (its first line and its body), I was
suggesting a patch like the following:

From 3a0ced0953ccc6038a43885d98a507eb18c19e42 Mon Sep 17 00:00:00 2001
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 15 Apr 2018 12:44:38 +0200
Subject: [PATCH] bisect: create 'bisect_flags' parameter in find_bisection()

Make it possible to implement bisecting only on first parents or on
merge commits by passing flags to find_bisection(), instead of just
a 'find_all' boolean.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 bisect.c           | 20 ++++++++++++--------
 bisect.h           |  6 ++++--
 builtin/rev-list.c |  6 +++---
 3 files changed, 19 insertions(+), 13 deletions(-)
...

The rest of the patch looks good to me.

Thanks!
