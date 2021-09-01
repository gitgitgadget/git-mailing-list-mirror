Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA86C4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26DD61056
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhIAFNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbhIAFNj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:13:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B86C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 22:12:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a13so2483864iol.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r90tr+cdqmzcZxmBvCAHkQ1MZLs2Ixf275dNbLdylPU=;
        b=Kxlci2PHSrHGz9lPm2tNaQVp7ijCI2T+25iZbocpGjz6xxZsjX0+muWHR1VKFVYZHc
         RyozE3koPcBB1lCHNDcnsFHZy9tF2ZmpC0I25ejjXDiviknltcTK+BaaPC5J9HDtbGNj
         H9nTo7/U69XRX3Y426Q1oEbyHQ3xLvrUEclEt3CDZHQBgR2+Es+rfVHQ64cjrcpmbyZU
         hrWm6dmSCbnHlm+xzjKLLSFIF2Bsn5NFOw0rB7Bz9vtOQb9Qb2fLXVhCZXjnA/wU5I/T
         7iWtzjVPByjPpSzI+6Pw4rad9qNsFgVgsdIiJ9ctAmjZ7laGcboyCh04tS/7WofrjvDp
         8aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r90tr+cdqmzcZxmBvCAHkQ1MZLs2Ixf275dNbLdylPU=;
        b=FliminXa0v0g02GtOxZ9iw3CFSqTNZqKow11+MLXHrl0HAQJb5/iQWlGBGKRzkvU5f
         boxenP4BUogdDUW2CdOukI5ee9FUqEtKdurElAPVL6rPA8HAVJzuC53lSJFSk4OvDTc1
         aCl8QQ/7v4LiNrE+MDol6cj0aVaiIVzC9wsdbqb8XbmxdNhcWXcKww3TTb+C9OZtdlV9
         9TbNhHQqIMx3LVQLf6BQ2PgBtIIGYu85aod+DzIEl2gtuvCvfDVDGUu0KHiaEUYnwZ0v
         +xMBKE4nkFAb/vzqwX5zI2cmSqqiYIUpG+CXw4ORqg0vPNrfYXpVxHfjRPvLkEkL1pXJ
         jP8A==
X-Gm-Message-State: AOAM533kYzwwoHoyv1kbrFKJ+N+kYZTnBSu+SPrOMwnAKb6lpchw+9p7
        XT82KQh3DbJ7q/0VpDV19nVfpBk/oEwsPDQd
X-Google-Smtp-Source: ABdhPJyZC2Sij+d4++RE+bEjvvb7IaXEKT3aevmR1RaYSYGVbJ7A/hFLjfo8YOakcKThLBANK6ukmA==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr25539824ion.72.1630473162392;
        Tue, 31 Aug 2021 22:12:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g23sm10709231ioc.8.2021.08.31.22.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:12:42 -0700 (PDT)
Date:   Wed, 1 Sep 2021 01:12:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS8LyanAqro3PDlm@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <YS75P7r33NIBmFh2@coredump.intra.peff.net>
 <YS8BwgfurPzhT4xh@nand.local>
 <YS8IqxNbxy0YrXSe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS8IqxNbxy0YrXSe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 12:59:23AM -0400, Jeff King wrote:
> So anyway. I think we definitely want the index-pack.c change. We
> _could_ stop there and change the read side as a separate series, but I
> think that until we do, the ordering changes on the write side aren't
> really doing that much. They're shrinking the race a little, I guess,
> but it's still very much there.

Yeah, now that I've had a chance to look at it it seems pretty
straightforward. Probably limited to checks in prepare_pack(), and
add_pack_to_midx(), which are the lone two callbacks of
for_each_file_in_pack_dir().

I'll make sure that I'm not missing anything and then send a reroll
tomorrow.

Thanks,
Taylor
