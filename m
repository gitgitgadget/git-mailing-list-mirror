Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B8DF20248
	for <e@80x24.org>; Thu,  4 Apr 2019 18:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfDDSZO (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 14:25:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37002 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDSZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 14:25:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so1641901pgc.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xtxajJT/IITLi72630l41RU8NM75A9B+SVbRzitn00E=;
        b=gvMT7kRirPcpQYI46U4BX9fQlRNhmW7AmJqxkwqmEuFOh+KN7Oauw6qZiQXsblbwIN
         0V5qCzmrIBV1qnEUYazZZdiSsc3SRmTCNKHOEAWopFucle4hKB5HzBWzZicziAfcBaYw
         A4/8C0pUwSSd4vT3cK1viN4oBvJX9u4095/qK7qHHvmxLCXT8rQD2ZcH5snU88hNUAKR
         y/MqqqI8CnKFKdP6DG07033MSdhId25hzDIxEUO65czGsOoTuErR0NiEV629RHrexdg3
         y1eRC603oOJ0g1ScMJHHtRFM+Do8bGcbqLopHiMHtlv0Yl0LHk+hAvew4bakEJlnDrgN
         3Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtxajJT/IITLi72630l41RU8NM75A9B+SVbRzitn00E=;
        b=Jzj0ikH8t/AccEmXgjnOihn6GUO+pPIC4ufI8i4Bdnyphs1zriBd2Yd3PaDnEDYypT
         RttcLWAStEegpVau80p6eUCKq/63IPbzOrosxrUYfpRWy+svLWXouHFY/hpL8G9dXift
         R72onssyL+zez1ozE7SRY5v97zC3KQCirboJff28WkjA/ZNlwI7Zs+AxzhiTuyTjrkkF
         1GkEdUgJruhNXG/Bhi0gy1gej4DuT7JeCw4d8GyhxlUNtsT1fH1n6sCkR0a5X+AiqZfJ
         24K/i488Da+fAU7Iy0LbeZqRyurrh3XDHlW4UDGB0sT95LOi8aAk5CZ17GP4b+seMoIS
         Ps0Q==
X-Gm-Message-State: APjAAAXEMxB/wJ6n55zv7rANOiSgvs0N5ZkSP/jc44hdU2PXQ1p3qXQg
        fennOvSKfkxP2YLHfpmv6SoplEhA
X-Google-Smtp-Source: APXvYqwd5ahU2T/TC7j4qRYXHyZmJQV6AR4bSPTA7TurmZfs+/shXcBLeHa2dKlCWlDXZmfo0VHKIw==
X-Received: by 2002:a63:114d:: with SMTP id 13mr7456358pgr.216.1554402313659;
        Thu, 04 Apr 2019 11:25:13 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i135sm28566798pgd.41.2019.04.04.11.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:25:12 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:25:12 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] tag: advise on recursive tagging
Message-ID: <20190404182512.GA29737@dev-l>
References: <cover.1554183429.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554183429.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Sorry for the spam, I typoed the mailing list address the first time ]

Hi all,

I've been following the discussion and the tl;dr of it seems to be this:
Junio wants to keep the long-standing behaviour of being able to git tag
anything while Robert seems to believe that for most users, it is a
mistake and even though Git is able unpeel tags, other tool authors may
not be aware that this is even possible and not handle the case.

I've tried to compromise between both sides. Now, we keep the old
behaviour but instead of silently ignoring nested tags, we print out a
hint that the user can act on. Hopefully, this should address everyone's
concerns.

The added benefit is that this won't break any existing scripts' unless
they are parsing stderr for whatever reason, but no one would do that,
right? ;)

Denton Liu (2):
  tag: fix formatting
  tag: advise on nested tags

 Documentation/config/advice.txt |  2 ++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 builtin/tag.c                   | 23 +++++++++++++++++------
 t/t7004-tag.sh                  | 11 +++++++++++
 5 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.21.0.843.gd0ae0373aa

