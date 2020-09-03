Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721EC433E9
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589BC20897
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 19:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3B0ud5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICT7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICT7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 15:59:17 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC229C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 12:59:17 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j188so2446723vsd.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGPcaGhBC/TuvV7QKMffZRuIk4ALc97i7csA/nTGBos=;
        b=G3B0ud5LDwzv64g/v33vVzUFgJlUIR7ekwYu3jEgWIlhBphWGIQHYuqi5kiObUjd6Q
         kzHkPsn0QNSzSen0j5+tvxWIIShXfdmk896gzxJKL8gEph6qR8SiW3+GGY07lfqj8Jqu
         zMlxkpVRXDxSr2pvVpybLvIygdPugMzz34RfQ56CsrjMjsr7tSaRC3nVlvBxfuuWdQCM
         08vho2Vsfs480339uqckHdoM73mDqBGQsGb1I9Vo15+eUiUsDDwfLgjvy8T1y+WMC/yZ
         gFAAV+zoM2U5CxjPMPMRIGWE2egj054M2DgY0Y7XUW9wedGG5xipegeYsPBEN07bATu3
         LqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGPcaGhBC/TuvV7QKMffZRuIk4ALc97i7csA/nTGBos=;
        b=GmCCQ1gs3IXBow+W6CkmLanU7kYy5NZjniNFpiEYYMfCXhwZQtyCNTYCFtJpf2GCfb
         0K0LC7rdEXeA1OpqEGbuOBQR9S0VAxj48jC7Dd5iwqDsXTcGK8Zx79bg/Kt1AoIWWBh8
         bKTgAs/rATuycUYOTHj0WC9RC+Y/JdC0iOUfn6G8n0N4PIcjlL8yzEZ9StoAEp5+xuhE
         dW6sl/YUxNKGn7zg/LsyJemrKzyCOrfImdH0PVNlKMwyUV/tL+zw8EkHt6Y5Rr1oqDvp
         l3Rv3VcFgqhiw7ShG/oPWkyuk2gN36YfzGngEqPAsE2u46GEijzFwobJFXbQvqBE2pd1
         oJxg==
X-Gm-Message-State: AOAM532sB+taLp8chIhFiYyN6AGK3l4+2F13lITw9Az+ro+OQurKoVCK
        3fRhS37rrYcF4TkoYveCeBO4ceWDExt+dqw7I1g=
X-Google-Smtp-Source: ABdhPJzMJs41mTLZejCs90LB6mRIMp3oIINJoHiY23aNby0YJTK89gc9DUc+XLGNdab+kiOHzfOjUcl0tbVfTXio7ek=
X-Received: by 2002:a67:7784:: with SMTP id s126mr3406416vsc.39.1599163155439;
 Thu, 03 Sep 2020 12:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com> <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
In-Reply-To: <CAG0OSgcUi6sKJQmUEd4-Lu5qAiQqKk7X7aSRvRtcBWkcKj4f1g@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 3 Sep 2020 12:59:04 -0700
Message-ID: <CAPUEspgScq1ay7KgSBmgAW_8SAymWpydQm5gAO9WiTumtu-e8w@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Victor Toni <victor.toni@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 3, 2020 at 12:36 PM Victor Toni <victor.toni@gmail.com> wrote:
>
> is more difficult to recover from. (I'm still thankful for `.git/logs/HEAD`)

another command that might not be that well known and that will always
recover from a botched merge (or a rebase in this case) :

  $ git reset --hard ORIG_HEAD

Carlo

PS. `git reflog` might be also interesting; sorry if going slightly off topic
