Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0461C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A135E6162B
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhELHYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:24:49 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3EC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:23:42 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c3so21390295oic.8
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=wYubJ6Otx2kRK3myfY/h1FcRcDXHcXgr1X5guaR+5nE=;
        b=JU9nEvMJZeG7DN6tWzXBWfmAfHRjf95S9D7ZsO7bI52yaVOyiNvWPwkBIuIjXvyt4T
         y264NxBouGeTizCzNIYxLyFvmrYEmFxXpZoHXPbRHLZ/gNzf/Y5rJMIVbiH2hhDyE8qa
         U2I23e1ibnSGmJtz1A5ck/3al0WB4M0yGX5NpEeGfmUSf3AIK5geEXdEcSdXt/aOG1Cc
         bTOspAik/6iQNi6Do/3LtQrM08ohAoYUElopn8iSewn6VNQKtX5MZECIojWTcefxEUHA
         qN5GdaQCsPfcTNwg/Mn6a1w/iTSAdWOw7S12dubm75yaESGnnFHwYRd3dJgDekai0GRv
         7scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=wYubJ6Otx2kRK3myfY/h1FcRcDXHcXgr1X5guaR+5nE=;
        b=YAgOsQ5jaA4ac+6NJnZtoZwJUDZk2STjVagTdZ04G7oAgQEMjHqJ96/MN2T/lH+XEk
         z/8nk3Pn/B2Tb69yI92q3HVOuTVxtEZtw6BWJ2lYk2aOVXbC8Dpeat1wEzycvEYI31fH
         U5NTGJp+vAGSaNBHUD8I/uTU1MNoJRiDBA9f/iHzX9a7FLSk//oo9nvqF/bIj363Yhv8
         IRhzisixA7DT3mPBtJAwM6VF7XhFq95jwukXiQdm45mpJwhEhGWoaNsYX79Ht8dTbSPi
         +hVwUcocdgJetHX8wnr1ZXnEXqhNcmsyjhKYhvoYeRCkWznW7HTSbjUWTp04bw+UlY/Q
         w9Pg==
X-Gm-Message-State: AOAM5320ktw1IwEXpXrq7R7dPFi2A4eEFuJlv8U8f+QIkxtUw5AdrFbh
        MoZODMSL5V9h2TTrVFANGKTPfP8VZ1v1IQ==
X-Google-Smtp-Source: ABdhPJzBcGLXE/fGnGuVRR8h8EgHhGqTSscyqK6VCRze7l4WA4Q92NtQ+QI8iWaOEYp+ohyCIJUrsQ==
X-Received: by 2002:aca:408a:: with SMTP id n132mr25527375oia.70.1620804221391;
        Wed, 12 May 2021 00:23:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 50sm4297509oty.6.2021.05.12.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:23:40 -0700 (PDT)
Date:   Wed, 12 May 2021 02:23:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andrew Ottaviano <andrew_o1995@live.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <609b827884bfd_6e0fc2083c@natae.notmuch>
In-Reply-To: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
References: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
Subject: RE: Rebase Question
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Ottaviano wrote:
> The difficulty with this is that if I have merge conflicts that show
> up on my first commit, I have to resolve that stupid thing for every
> subsequent commit.

I don't quite understand that. If you have resolved the chunk, then that
chunk is resolved, and the rest of the commits don't have to worry
about that...

Unless they touch *precisely* the same lines as the first commit, in
which case... Yeah, you have to resolve that stupid thing over and over.

> The solution that I thought of is instead of resolving conflicts from
> the bottom up (starting with earliest history), resolving from the top
> down (latest to earliest) and resolving the conflict in the commit it
> occurred.

Well, this is interesting because it's something I've wanted to write
about for a long time, and it's what I call my "pronged approach".


I actually do *both*; I do a rebase and fix the problems from 1) the bottom-up,
but after I have resolved the conflicts from 2) the top-down. In 1)
(bottom-up) I resolve the conflicts in a rebase, and in 2) I resolve the
conflicts in merge, but in *both* the end result sould be the exactly
same [`git diff 1) 2)` is empty].

Yes, it is more work, but at the end of the day I'm 100% sure I did the
rebase right, so I don't have to think about it that much; either
there's a diff or there isn't.

In fact, I rarely do just one rebase, because quite often I miss things,
so I do a second, or third, or fourth rebase, but at the end I make sure
that the diff with the merge (top-down approach) is the same.

To facilitate this work I use two tools: 1) git rerere [1] (others have
mentioned this), and 2) git reintegrate [2] (only useful if there's more
than one branch you are merging).


Yeah, it's a lot of work, but I'd rather do a lot of tedious work that
I'm 100% sure is correct, than do a little bit of work that I can't
easily verify.

Cheers.

[1] https://git-scm.com/docs/git-rerere
[2] https://github.com/felipec/git-reintegrate

-- 
Felipe Contreras
