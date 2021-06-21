Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06525C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EE261001
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhFUV4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFUV4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:56:31 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9FC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:54:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so19329193otl.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9DHlGJ74TF10USgrVrFGqH3tyCxFJw3rqgDfktnJsY=;
        b=X05Nu6PBm7hS+28R0bnzM52X9ywQ12vAtiflD7Q45cSiFqc7WHT1VgLM+sAzKz7ieX
         7vdsZ0JBAi80zeXOWhIYy8How9dSzHUwG5kHhO7env2Na3gD5guM6gnEOQHsZLBZEpNe
         QEqXmWd/MThtkK3p50w9m/uDA5vTiegvJFsrGPF1cUy7FKxzg/XUQ1WycW0GTLUzFGNw
         sYzYfJyhAqNOAwFs2nPlbxoWmA5nHHvOVnS+64y46+KN158ZNYxAcu1CryOA/ivTc2ru
         RvAqbCQTFj6GbaS52Kx3Az+4SNBdKltgr3uoFY5eu0w3IGESjoAcrtsMdoKnCBpfSnyB
         yGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9DHlGJ74TF10USgrVrFGqH3tyCxFJw3rqgDfktnJsY=;
        b=mIF8yFYXk7pikUsoEYG08XwiS2m6MHumi46bSIJfI3WmTkoYXAWfWzOB4m1pvAoms1
         zFl43IX7P/zdIvdFK66tFkKbrsU8qfJd4hKG6wra6aSsqAtx6/dGKhkUhVzrXUbzlBYc
         pccoekwI2UcsfCgD8LCsZEHU8IvqJ0NIfdIR8TnM9rJcF6tCRbvfekMTv9MtopwTr924
         GbS+4+SRkLzo/WTbl1q74soS30Qkxw+UNDmpLICVkznVq6zsImXOjsDXpzNUd8n0p/2x
         1Ot0FpRr7MhWMWwn/Fis6cbP/YKywoQtrzlbacL8/IBoXlms8CK78+1dmYTYO+xNXKVT
         erpw==
X-Gm-Message-State: AOAM5310ZFvsP1ny/tliQTe7s+Skfafwz3q7Ys4+edFP0KVZCJinieU/
        WZS0mw/Rc5Rfp8w/J8X9NDLMLRUxBQaqO+KtH94=
X-Google-Smtp-Source: ABdhPJzlb7pBClMz7+VSxoDuWdbXY3boMB5rziD/mTkYlOuukvLMA2Ore4zAEm92R59jJNjkECBocU+vV+t5d7kVVf8=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr191919ote.316.1624312454891;
 Mon, 21 Jun 2021 14:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:54:03 -0700
Message-ID: <CABPp-BG0a0OM7s7cmO8yCeyA5TOCD_yOSJJepQE8MFEHct4EQA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Fix all leaks in tests t0002-t0099: Part 2
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <andrzej@ahunt.org>
>
> This series plugs more of the leaks that were found while running
> t0002-t0099 with LSAN.
>
> See also the first series (already merged) at [1]. I'm currently
> expecting at least another 2 series before t0002-t0099 run leak free.
> I'm not being particularly systematic about the order of patches -
> although I am trying to send out "real" (if mostly small) leaks first,
> before sending out the more boring patches that add free()/UNLEAK() to
> cmd_* and direct helpers thereof.

I've read over the series.  It provides some good clear fixes.  I
noted on patches 2, 6, and 12 that a some greps suggested that leaks
similar to the ones being fixed likely also affect other places of the
codebase.  Those other places don't need to be fixed as part of this
series, but they might be good items for #leftoverbits or GSoC early
tasks (cc: Christian in case he wants to record those somewhere).

I cc'ed Stolee on patch 4 because he suggested he wanted to read it in
an earlier discussion.

Phillip noted some issues with patch 11, and I added a couple more.
The ownership of opts->strategy appears to be pretty messy and in need
of cleanup.

All the patches other than 11 look good to me.
