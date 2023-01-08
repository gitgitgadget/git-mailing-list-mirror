Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58FC46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 02:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjAHCQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 21:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjAHCQr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 21:16:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672021A5
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 18:16:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id k19so3769271pfg.11
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntgQxjVjwP1438Ix+CW1PLnodIFzJPiwcVZIMAfwOFQ=;
        b=FavDk507fBD8STkRQLj2WDscqNbIR6nhMIRATsHNuYi9wOl1UwliMHvdVqjaNDNJJ/
         a4aI75l0laVzfFgF3b+PL+Wk1uwtpgg2H3XZkSOGx4G3c58FbYelv+lB9uE+9y9BcHna
         7mSVVwqd9m7ts0gMlyFPDho8iBPS/ISjfA9fKyRIEoMM6GazNRDL9PdqHljpLgOs8MCa
         PJJkb8Ds/hpZBVBn//rg977YYNgP4wgnt5c+dviQ62aeZBNTuSbl0Gd883u6bJTSfCzV
         3p7rSSzJBhjyHtGSGA0G+YSFQEFaoRDPnJ6mgZmopBSqB61MVXcarx7MsgnGaYYpGMbC
         LaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ntgQxjVjwP1438Ix+CW1PLnodIFzJPiwcVZIMAfwOFQ=;
        b=fobJVjx1aSAB+LcD4ozmkSic8/cFybDZoFOiRmurEjjiLDgUAp42Sis614nQXtJH5e
         VoKLxfWNOiYEMaxOydffTRG+RHoBriCthXQlEfUhF4pTFbeQzEd+4Yr3KGtqRAcq+Mxk
         ZDuHNPztfEYYFh1+dtdmqNxFObsMI1u5LIZUUdWJdToLeqXwuJwLjLEnNtwRxxuAG7aN
         bbcLumSXtSutyCNCOitSmCxZ5gU/WCU7DVoikNpZIkSrP5IUnPqACFf0TSYyXp/MrraH
         az2CDZUt/NzUDMt3dLeNleAhPNFAmjWsM77avBqKBEEHDDQm5844Q2loWm6YNbWWqVer
         03NA==
X-Gm-Message-State: AFqh2ko0SBfDz0ySpbKGFy83nkAuki+AhyFY5JxWx/p1RhE2IlYc0vYn
        BEEIA85elSgITpnpPwSumw8=
X-Google-Smtp-Source: AMrXdXvtbgYmKB744hfxOCGAHnhM0jmrIoCKBi2BFGC8afUlrV0X5We2U+xPMTPbQeEVcENb3mN9lQ==
X-Received: by 2002:a62:ed06:0:b0:583:3e7f:a038 with SMTP id u6-20020a62ed06000000b005833e7fa038mr7507144pfh.5.1673144205817;
        Sat, 07 Jan 2023 18:16:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y128-20020a623286000000b00576ebde78ffsm3380704pfy.192.2023.01.07.18.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 18:16:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 5/5] git-rebase.txt: add a note about 'ORIG_HEAD' being
 overwritten
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <9ef427a9a2adfb6a47d13103f00a64df96725560.1673120359.git.gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 11:16:45 +0900
In-Reply-To: <9ef427a9a2adfb6a47d13103f00a64df96725560.1673120359.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Sat, 07 Jan 2023
        19:39:19 +0000")
Message-ID: <xmqq4jt122k2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> 'ORIG_HEAD' is written at the start of the rebase, but is not guaranteed
> to still point to the original branch tip at the end of the rebase.
>
> Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
> like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
> being overwritten.

Is that a news?  If a user does "reset", the user is asking that
HEAD is changed and the old state kept in ORIG_HEAD at the same
time, so while it is not wrong per-se to say that user can clobber
ORIG_HEAD after rebase sets it first, it is pretty much expected,
no?

What would be unexpected is if "rebase" overwrote ORIG_HEAD after
user did all these other things while it gave control back and then
it took control back, and it would be worth documenting.

Having said that, I do not mind documenting this.  I am not sure "is
not guaranteed" is a good way to phrase what happens, though.

> +[NOTE]
> +`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
> +at the end of the rebase if other commands that write that pseudo-ref
> +(e.g. `git reset`) are used during the rebase. The previous branch tip,
> +however, is accessible using the reflog of the current branch
> +(i.e. `@{1}`, see linkgit:gitrevisions[7]).

    `ORIG_HEAD` is set to point at the tip of the previous branch
    when `rebase` begins, but the user can run commands (e.g. "git
    reset") that overwrites `ORIG_HEAD` while `rebase` gives control
    to the user (e.g. while asking to resolve conflict).

It is excellent to mention reflog, which is very much an upward
compatible replacement of ORIG_HEAD.

Thanks.
