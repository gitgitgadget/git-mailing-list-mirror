Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BBC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A4964ECF
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBXTjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhBXTjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:39:48 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00FC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:39:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e6so2168533pgk.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZnrRgHeItSpvvTixWHqqq2zMr/ZTbIAjrZVl/CTG3nw=;
        b=hRnYesk1eU5oHnc58CJw7zCOrUE1ryCBlzATwW2Xgo8sLHbMnBlUZGzMEaYyY3N0tr
         kOX2gpJs6PPVL2Dkm/oTdYvyEmM8ZfmbXQX3H/3wwyT+QxMLNSrnlQJY+2z8lr93NAcq
         9Z1TP4K0sP/trWku7wSAflk3gvC+K/8/BbftcnEQv7BatIYzVUa/4/v511VV3EpBxRKs
         uvReQE9+YNqxoLxpxvfSWH/VvvHAAiNw12hed1JKpc/Pw74YBDvB1Vo1DM4npQgdTYo3
         uvfs+lo4TAw+fGnu0SWfBWBs64fa0gix0kcW4848yb323x5AGBaluXEXKeICzeGPLOi2
         6/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZnrRgHeItSpvvTixWHqqq2zMr/ZTbIAjrZVl/CTG3nw=;
        b=K6HARjsVOvqR4nvm27JZ0E35iUW8pvd22Z8fw9QA4zBQ1s+I+raw340yjrdK6Db8TT
         lAJILXqBX13OtltcpU5f5UDlAW9O5SeqBAf0uBRDiS6Vy7XxjEbMU9Igpw1dlSjECsCr
         7DZpcwtLIvdCzk57wp5maL2WqviyVT7bFVp0vn/gzjn74yPRjrLO0pprOUhNM8JgI5Kf
         LLKtl7UhsuqLsKtea3jL1gxqqLDLLdhYd7FU4uU4OchG67AAwwIo9Y4Zx3XkA6blF4ut
         IbPEDkO+cwKy8A/LAdhKpV5Iz4r7TR+wYurkyIux84I8mLcMYO77zkkgb4Y+QUZ24svv
         6kSQ==
X-Gm-Message-State: AOAM531D/UB+YFJEXiNuudQAEg0mXY7eXg68WNoH04RwOjm7iMD6P7we
        t5HXbctF6QuhmgeQrXtz8FRWt1sjtm4FdAc+8zGfce+JxxY=
X-Google-Smtp-Source: ABdhPJysDPGp4Y3UH86r8ngR0+1aTdskeGJB1uXdRy/0hCgSNTBjDUuLQNBFVMULPhwJtci/58MIf26CRcp5j53wV3g=
X-Received: by 2002:a63:786:: with SMTP id 128mr29835816pgh.408.1614195547714;
 Wed, 24 Feb 2021 11:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20210223071840.44267-1-alexhenrie24@gmail.com> <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com>
In-Reply-To: <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 24 Feb 2021 20:38:56 +0100
Message-ID: <CAN0heSp9ApYCr8RK5xF=_q2WJgE1RjUpZ3dexQuOwQFi8NLS9Q@mail.gmail.com>
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 Feb 2021 at 20:33, Martin =C3=85gren <martin.agren@gmail.com> wr=
ote:

> just ":", it ends up being rendered literally, which isn't horrible, to

Hmm, I sort of take that back. In git-config.1, it looks not-too-bad,
but in git-rebase.1, this item runs into the next one (sequence.editor)
and messes with it, like so:

  rebase.forkPoint: If set to false set --no-fork-point option by
  default. sequence.editor:: Text editor used by git rebase -i for
  editing the rebase instruction file. The value is meant to be
  interpreted by the shell when it is used. It can be overridden by the
  GIT_SEQUENCE_EDITOR environment variable. When not configured the
  default commit message editor is used instead.

Martin
