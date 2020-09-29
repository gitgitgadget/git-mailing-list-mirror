Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD53C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE7E207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyPrAR1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgI2Tx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2Tx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 15:53:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38681C061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:53:26 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 7so3689717vsp.6
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCPi4MfHrKGHgfkYSUkhPgZgiaX8tA/7eDrSNvlk5dQ=;
        b=qyPrAR1sgkEaU7HPqNqPACFxdFcKxxk305q9fkjPF5TSQ5LeBEt3Cq4jHq/g8izVS3
         Y2c8lkWXa2AO6Iy9Tdn0n36v48RXAmQQjI5MaklCekOZLIsInmRWt2O17i9D+/D+Q7B4
         4RybTumyn7c4jZJJN1qcwwWTR4ccETS7by3mTs2+oBk2F2ifT/2uPrGSH2dCpmSKM/SR
         C/daX5dHp2JbjZapJQmYMlmA+dc3yvfGdVKPambElNzoIAHuZRXKTqmqC5PIF4d9LJDE
         jIWdnG+kSM8WB+OBadeTqDI2jN1UeJ4+nPJZtBetQveXF+6uwZ4BuuH8rCRpWY2D+DuC
         5BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCPi4MfHrKGHgfkYSUkhPgZgiaX8tA/7eDrSNvlk5dQ=;
        b=BY0ybvpLcaD4odX3hi3nA+kK0tM+oF8Higblyu2aQakEOOe7ZIJvK7PwW2N7eo2CgN
         Zc2SpNMxThERjKNFgmloZL0bYaZxIOzCd7beWO9jo8ONFeFC7ia77PajzqwTYmvbja8j
         Xcj78lDazNYH1+2uM7ijhTxxWStMvdqPjRlp4QboX10HHK1+AaHPb2SAWYIvYMzUiRMq
         3muCB1OcJHRuaOW+1OzR7b21st3cP2Bce18auaF39W6EX4wE+E4QLkmEEo6oFmbzsMfj
         F0looGg5Mf5lPALAei3mgklG3x9+PaAo+sGmliMBDjaeUlIo7FS6Ur5rVK1H275HvRMl
         /ILA==
X-Gm-Message-State: AOAM530O1jppl9fYX8ei6aqgRcsdG9aTwSHl5Sj1u0eYVwIemHslXQb4
        aLmCVdEPHT7bLkZhMEPb35vqwR7/4ZTQRpjG5gs=
X-Google-Smtp-Source: ABdhPJwc/vCnm24jjqfSc4LEkDghDihr632XG/FODWeCmg01+ZjvduN55MKLRjLjGpgP2vP3B/3/xUiKJgb8L05OYD0=
X-Received: by 2002:a67:fd93:: with SMTP id k19mr4111188vsq.35.1601409205497;
 Tue, 29 Sep 2020 12:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
 <f54baa4ecd495026c2fce1772b560b7bbbeecc04.1600600823.git.liu.denton@gmail.com>
In-Reply-To: <f54baa4ecd495026c2fce1772b560b7bbbeecc04.1600600823.git.liu.denton@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Sep 2020 21:53:14 +0200
Message-ID: <CAN0heSqr4_orRR5BD53hoaykd26ZBrfZgQ8PR2WdyZTOwNh6GA@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] builtin/diff-index: learn --merge-base
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Sun, 20 Sep 2020 at 13:24, Denton Liu <liu.denton@gmail.com> wrote:
> --- a/Documentation/git-diff-index.txt
> +++ b/Documentation/git-diff-index.txt

> +--merge-base::
> +       Instead of comparing <tree-ish> directly, use the merge base
> +       between <tree-ish> and HEAD instead.  <tree-ish> must be a
> +       commit.

If you end up rerolling this patch series for other reasons, you might
want to consider using `backticks` around `<tree-ish>` and `HEAD` so
they get typeset as monospace.

>         If HEAD does not exist (e.g. unborn branches) and
>         <commit> is not given, it shows all staged changes.
>         --staged is a synonym of --cached.
> ++
> +If --merge-base is given, instead of using <commit>, use the merge base
> +of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
> +`git diff $(git merge-base A HEAD)`.

Similarly here. (I realize there are existing offenders. I think it's
fine or even preferable to leave them as they are so that you don't get
lost in a huge while-at-it.) This also applies to the next patch which
touches git-diff-tree.txt.


Martin
