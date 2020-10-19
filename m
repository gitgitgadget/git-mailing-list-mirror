Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562FC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B601422409
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4eev1Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgJSWAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgJSWAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:00:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DA4C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:00:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d28so1336588ote.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz5KK1hb1Cfs3Q9tAlS+rHhdTtl78EoNvKxzE4DqmSk=;
        b=J4eev1Z0Bd2htWJLDxxMvo2Lhy7WkVbH64EvfUyOcwL7vW356PZD7CE9ybxQ5Bub5W
         Tis5sbNHUA+os4qklNV7ncr+AePzRxaifgR9z3InJAF89BRCEAq7uh12wUE1n/cp4UaS
         hBVOZbj71x9qQatom12w/uusdZD7oKWXx5xjPYvgSGEtqyU78ywSMtFexHYNDOif+CwS
         x+ATObDzmo0+bOfOPAbpb+v9J+svb+06qtBsAdlruquc3MvUZZZXocbU4rtotnW+VCR2
         pxERrH8KkD91K+YLoyz7pHSdH6gfVvkVZHm8yZMeMV41Ikyd52vwUWRj/Js3QcGKLwIA
         We8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz5KK1hb1Cfs3Q9tAlS+rHhdTtl78EoNvKxzE4DqmSk=;
        b=Eqe/aE8nbEeUSwW7/ONK3E6prZwOxU+CwY/ePTej5VQBYPyDkw2fBpsmG9kO+4/RLw
         VMMsGmaRVnd8mzwY//H6Gg0zDzCKX6FtgdV6EimXdYpxEQ0HLOO3P149I2osJ53udsl+
         9CtMtHW+jGEuUfLgv7/e7iOr4HqgUjLvWicd3zRi/yzC+K93YDOuhjhSBJMq91juI4gr
         nS53s0GdYWx5HdCDW25v+sLOmpnecL7J3f3MM6RI/kG+LcI0V3dHQuwLz3vcCWZokCX/
         XF/S795vr9ZsxkPepyZ4Ue69aEyyj2z5xzgjg3aW3vgBzRsq/3mu0fLz4VWlbcndymVE
         PdaQ==
X-Gm-Message-State: AOAM533MuTCXW2bBpGYVFKGnDTK/0PYB6oEcfIoUwifOBr/wRNB8xcxp
        f9fvbDDVSvpF0h3BGykUCSQ7abXID6FJERNM/Vk=
X-Google-Smtp-Source: ABdhPJwQyzIYoRUoC6BieZn19l5tjzfFzpyzZ1rJZeTmdpYz2QNMv1YlKfnFBfsMdwtiNvGgbL84DgoVFjrI7JTM82c=
X-Received: by 2002:a05:6830:1347:: with SMTP id r7mr1466737otq.172.1603144817383;
 Mon, 19 Oct 2020 15:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <pull.756.v2.git.1603143316.gitgitgadget@gmail.com> <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
 <20201019215438.GA49623@nand.local>
In-Reply-To: <20201019215438.GA49623@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 19 Oct 2020 23:00:05 +0100
Message-ID: <CAN8Z4-VxEFvPJwA987xWV9d54geyTJJgaqc0FRL-0MuQgVS5ew@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] t/perf: add fsmonitor perf test for git diff
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was wondering how this slipped through since it should be checked
> automatically by t/check-non-portable-shell.pl, but that is only run
> from t/Makefile, not t/perf/Makefile. That probably explains how a few
> raw `seq`'s made it into t/perf.

Makefile issue is easy enough to fix - will fix in another commit
