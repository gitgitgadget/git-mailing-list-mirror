Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E7EC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49154613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhGNIkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbhGNIkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:40:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9BC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:37:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dp20so212598ejc.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL3oJiB6sGAp1cN1HTafP6XVdKWiQZZxauamB3S412M=;
        b=OLld5AyaH4x8YjY2SyZWmSkoLkkmAaBv2PR5IvD7Hw94oUnkq+RWXp+ghhO4pItiqz
         +RuepgteqFBg9E3Y8DkQqluajPqG7yG6bTL4kvFi2+e3RP9kKO5IBimDOHgPQMOTdIw1
         3HXthPD0vqgih3nfvr0fWGwumnpRvH6PIwjQFH/XZkk4mErtwzg+mBnJkEXJHSQLDCk/
         xJkgVVzsVugCQZZ6AuSW/o38e2GWCI8nAe/whojzno8OlyCFB58WhjS5QTSLi3nK+4dK
         d4bUaC2gD4noucrbwl4TUUKYomwgc+OC/wJuo18S8AIekwM3Uox8Ybr0mq0Llf3ReGFk
         7G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL3oJiB6sGAp1cN1HTafP6XVdKWiQZZxauamB3S412M=;
        b=S43Jku8t3+kpDl7wq1/U5INp9oTEW+eE7PkM9MGdW/RpR9KIGily3YcgkGJ1EIDzBb
         BQ4uUpB9mbB6VeQqrU+kbMLEFKWkCAqD7/AZOr7YKTYM87be4jqakP00rVaiStbM/ikU
         axQOY5nxkdOPHJvhbWYmdkpkR01qEHtCvVEbHgxPSOM3zaZ79rzBJrGUACPCb5jS9l4C
         +JnLS+8aBv8c4dSdGnjL8GJEeehMlrJpzZ2r8AR1+hf5fB+CeQDRvgY32Xqej7Phc3oM
         UvYvVzpVEsTAiRUgLd5F39LjEq1/pcrWT3jarpTRkEBI9heX9a7hwOX4Fa6fHcpc7fPz
         ff/w==
X-Gm-Message-State: AOAM530BKraUjd5OF88UcCID2UZJKDF6odtV95i6kw6+p6SwksA0zocU
        wsRIt/e4MPQXH88QAjyLIwsqhQj3LXLSLDNzlNc=
X-Google-Smtp-Source: ABdhPJxVbVhVSJ+tBD9gZEF1x14Vi5zuouZTN5lNTL8/pGKRientnTxRYYaTzwQ5UzJ5xtqumlCvGkKElzG25TzpN9s=
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr11163226ejc.132.1626251859748;
 Wed, 14 Jul 2021 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
In-Reply-To: <20210711012604.947321-1-alexhenrie24@gmail.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Wed, 14 Jul 2021 10:37:28 +0200
Message-ID: <CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        felipe.contreras@gmail.com, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I am out of the loop in this thread but I have been seeing strange behaviors
with pull.rebase=true in the 'next' branch and also in the 'master'
branch in recent days.

  > git version
  git version 2.32.0.432.gabb21c7263
  > git config -l | grep pull
  pull.rebase=true
  pull.ff=false

But a git pull would still run fast-forward.
Some of our users (including myself) rely on disabling fast-forward to emit the
per-file change log summary after each git-pull

  Updating 245f278cb729..5e8d960db7b3
  Fast-forward
   some/file/dir.ext         | 44 ++++++++++++++++++++++++++++++++++++++++++++
   another/file/dir.ext     |  6 +++---
  2 files changed, 47 insertions(+), 3 deletions(-)

In a big, fast moving monorepo, this summary is a lot of noise and
switching to pull.rebase=true
used to be the way to turn it off. If the change is intended for next
version release, is there a
workaround for this?

Cheers,
Son Luong
