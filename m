Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83A4C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E36423B81
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 09:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgLIJcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgLIJcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 04:32:05 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477CC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 01:31:24 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p187so963002iod.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMUTfnSm6KCt+fpCwZGRLm0cxoiLUOfCpH/SFY14jgk=;
        b=PIVISFjzg2IJQtpipVY3dOlwsBx2pdrjoEswe/S69RHzDibXQOfU5JCeWQREVo/mrg
         j2a+HUrEvsh8mJeqfMDux673X8kq3fny9qU7VW6IXry3luzmvwiK/958nMUlxz1qOcu1
         LCmRZ1rKp6I3j0dmcTjJrg5bgnEuRUBpB8WEGyIngImerR3LtBjoILLLzPeauhFVj2i+
         pqmg8qLkxceBD18uRZWF4k1hZB49cZngIYPT2+riRYu+wJQO5DxO/0D00rBZ6v+UQJQC
         urK7Dwtp4UeEl14vQK+xEopP5U2Zca9p/PK6VES+4kXIYxnqUpqwlnnRr0hdYu80rWaz
         EG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMUTfnSm6KCt+fpCwZGRLm0cxoiLUOfCpH/SFY14jgk=;
        b=Yp5B6Y/U0r0hTxfO1BnFW7AWR0XmT/3Hsm4SETzwNLOHdxSbR2zU/DGSx4sy7bzvoP
         1geg2XHDvSv98hNCE55/fyOsNG2wvvdhRfUOKn8tmo6f1BPdWsZBuCm4L5Z2mcLF+6sr
         hkCmMhvMDhoI4Em0ApDHrVj/UZNj3e1MRnBw5cCrkKeiXNpI4GDse+idpOZnBKIkuxtd
         wptkBXrN2nuF2eYKE99lkgD6RDp/+vkwcENDjJXj587+/UYZR6xN8p4MwJIwO152UYXY
         t+0doH5th/t04luOE0ho8C84kM/Rs1I2njxx9zf8Uy3/uo04hEWUpPHeFhT1Tbha+ld5
         FJGA==
X-Gm-Message-State: AOAM530VGH/ll58WeIITc5+JhwI++lBKjvTXFE66blGW2X6ezwQkKeow
        9n/msbrUdXgRWB3Ra4q0+eT8D+7evXUdf1jJbwY+K1Ukop8=
X-Google-Smtp-Source: ABdhPJxwRc8LmhpcvSE7lRl8vDheuOUuX5WFb20oCfpYc49M/CsaSTmmIcttCI8mp9XS7+O3sJ6J5GY1FePqccDb2tc=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr1851743jal.30.1607506284142;
 Wed, 09 Dec 2020 01:31:24 -0800 (PST)
MIME-Version: 1.0
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com>
 <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com>
 <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com>
 <A462326B-505D-4A92-B789-21BB8FE6AA16@gmail.com> <CAPig+cQad_yyVgwQQ-NZyy7SergM-fUMeMAm9RsV4zEqNt9TDg@mail.gmail.com>
In-Reply-To: <CAPig+cQad_yyVgwQQ-NZyy7SergM-fUMeMAm9RsV4zEqNt9TDg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Dec 2020 16:30:58 +0700
Message-ID: <CACsJy8Dq9Lz1YkkqvR0Fa1PLUBJhNJTmLtnRssi=DDpWAQTWww@mail.gmail.com>
Subject: Re: GIT_DIR output from git worktree list
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?Q?Ganriel_N=C3=BCtzi?= <gnuetzi@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 2:27 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> What I was suggesting was that it might be the case that the only way
> to solve this would be to store the location of the main worktree
> somewhere within <repo> in some file, and then `git worktree list`
> would consult that file to learn the location of the main worktree.
> This is complicated by the fact that that file would have to be
> updated automatically if the main worktree directory is ever moved. It
> also needs to be done in such a way that it is easy for other Git
> implementations to understand and not trip over.

Not that it matters because I don't do Git anymore. But when I was
doing this I imagined unify main and secondary worktrees. When you
switch from single to multiple worktrees, there is no main worktree
anymore. The place that is main worktree still has your files, but it
has the same status and treatment as any other worktree. And the repo
is tucked away somewhere safe.
-- 
Duy
