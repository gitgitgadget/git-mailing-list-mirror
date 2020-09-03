Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CDC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A041206D4
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVvOiRK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgICVIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgICVIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:08:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29204C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 14:08:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k15so4632409wrn.10
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6rWLvs+hf7XbiWG07ngD3w6gYMEXLER42A3qlEIkXI=;
        b=qVvOiRK85luYHpwLCv4uWIr1/hZ/MvXypENHgr48hmbrWmim3NW2Zu0DFMtUiQeeWE
         gtoHIj9Em96yikGNx3J6+e3h+4ayYZML9Z22SpD5lbplDXomIHiLxCon3L69IDpUQqQx
         VPS6xlBEskaQdyUz0UY/uDhH006SDoGg1ZjPoRN/2GVMm2D6hh+Bm4RSNRyRxUj3Muyc
         9YijFJQlh2IqFeQ15Xf2y4f3iXQrII3Jf8NUiHuXXyMav5BV6tZwiKJazHft1QCdXRVf
         Ys/PKrtnNWjTbgL56sd7da5DH+W0hDmraIo7Z0ulIiiszHzqQVZ8pSqZKIZR/5qw3AaO
         IKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6rWLvs+hf7XbiWG07ngD3w6gYMEXLER42A3qlEIkXI=;
        b=WDU3fmeiL6QJzSgs8/X3MhtxhNccCywJb7lTh/LA9el6oP6BOYL4OlcscdCFEcRWNG
         gbOhUeHgNCYLzFWZMjbqoYV8qk3agA5oEINnk3X3GBBzR+N127+KCf/NtNiObbukkXKZ
         V1C2Bo7Fve1mPCYcmksCgW91dDh7CsrB8x0dapbE4nGcezAwMOfaSEB0lB5EpFgXCWlz
         P5vdfkDOts5oaFjhkUnutU9+5wofiVew1aQ8Z10Lp/u/JrtE31fdoBan16n20feMzCP5
         OCEwRmw+stf/by0xsfO/io5n/vuLuVoXof59Nh+xtJ7/kLPxW77I5ZpVdRtUM/WSjo7F
         HkaQ==
X-Gm-Message-State: AOAM533Ili9qOQn26J2JyoiAOslJgOjPScSUwFMqZSgjaB/6jEaoZclv
        TfgxXcPawQicopsViVFRDNGy90r2jwufloCvFs4=
X-Google-Smtp-Source: ABdhPJxsdRe46oMeq9pK8G1eclpVU+AFAhenAnt3SJMcoY8P5Y2DZ+nvp1SXkSUAngJ3XrQpcRWDSA724Cd4Fv2Hops=
X-Received: by 2002:a5d:4844:: with SMTP id n4mr509292wrs.141.1599167287739;
 Thu, 03 Sep 2020 14:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
 <CAPUEspgScq1ay7KgSBmgAW_8SAymWpydQm5gAO9WiTumtu-e8w@mail.gmail.com>
In-Reply-To: <CAPUEspgScq1ay7KgSBmgAW_8SAymWpydQm5gAO9WiTumtu-e8w@mail.gmail.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 3 Sep 2020 23:07:38 +0200
Message-ID: <CAG0OSgco0sRB=qXXfY2S2t_BdX9UpaOVxS3_VWyr5r6K+tjBOQ@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Do., 3. Sept. 2020 um 21:59 Uhr schrieb Carlo Arenas <carenas@gmail.com>:
>
> On Thu, Sep 3, 2020 at 12:36 PM Victor Toni <victor.toni@gmail.com> wrote:
> >
> > is more difficult to recover from. (I'm still thankful for `.git/logs/HEAD`)
>
> another command that might not be that well known and that will always
> recover from a botched merge (or a rebase in this case) :
>
>   $ git reset --hard ORIG_HEAD
>
I tried it on a backup copy of my repository (created directly after
the "incident").
Unfortunately it would have missed two commits.

> PS. `git reflog` might be also interesting; sorry if going slightly off topic

Thanks for that. Never used it before. git reflog would have helped
directly since it shows the last real commit I did before messing
things up.
From there it's a walk in the park.

Victor
