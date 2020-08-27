Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA5C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4D82078A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 05:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvwGaQjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgH0Fos (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgH0Fos (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 01:44:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CFC061240
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 22:44:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x7so4111712wro.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXT4ORcuGS7hBV5p/QcY/xmLccMz+wojCf+8VsF2Km4=;
        b=QvwGaQjmNvcppHjdLYNQmiUKQJug2KXpxOuOBx0rbr3po5NuLVPYDJC6XVuQ+Xt9D7
         gguArklEJNoQkBY32rJSJ+LtV95U3ziPuKMNHoxOtZ1Ac+dYb9TgT/+BvFmEUIjQD7r1
         /JE+mD+6DCJ+6Ytcn5UJG/RcU1QNRM2No1EA1EaiN4Zt9Bj6p3dQc1yfI5QwKmaN89nl
         LcIlj5W20rUm4nwHqWVqbkNwA91KDt6hClsgQHkAVSMIBNj6temBGCkpauiRxF/xP5Fh
         nQSO2Mwd8iWJMSfPJUSLGb893Nb/00q5tsxldEJedNoMR71eYiRWKOW3wNTOr1TJHasZ
         pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXT4ORcuGS7hBV5p/QcY/xmLccMz+wojCf+8VsF2Km4=;
        b=eEUrypnpzuLcRXr0E4q3kRIYyl661ZIuxE9u7Lbk+RJWcNjRiaapl+WG21523D0ifQ
         NbKpUCrhWon2556zTZUR5JcnsiJZFpruadRM+3Nz+k///7Zcsg79z9fzuDw35kCFVAOh
         kNjC+oBfrh1qJz5XkdEJV2zRelr800ej/ZOtBxyMr8nnQ0FWFjZVgRzu9pNE3fXUWunK
         dqPkpDxWW81RvJyesy+xNxvS2n4knZcNd29noMadI+uw5+DsO7R7VP/XeicF7xKhoRad
         d0mD7PssdE54me3Pb1lTK5vfjjZ43dWZn0quzVB2p5Q300NMeu7RS1X3vpTKiQQ8Bt2x
         CRGg==
X-Gm-Message-State: AOAM531Sp6RfcUGf92WlrGyIfdLnxIPqr4NFSHTxOdKo2Z8hU/SVrFL0
        Er0yKSCuYL7GNvyDgMgXKt5xkYZgX40ubDyea9w=
X-Google-Smtp-Source: ABdhPJxfToM+CCO9x4kbdFu0cTkMw521ADAoBAOx2Ckhb9vXrHMjqB4owc2zI+D8vJZt2i0+TD/RdJSNN2cHQJPl6OY=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr17468514wro.233.1598507086521;
 Wed, 26 Aug 2020 22:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
In-Reply-To: <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 26 Aug 2020 22:44:35 -0700
Message-ID: <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Tom Rutherford <tmrutherford@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 5:48 PM Tom Rutherford <tmrutherford@gmail.com> wrote:
>
> Thank you for the response Junio.
>
> For what it's worth, my hook does not make changes to the repo. It's
> running a command to check that the installed version of our
> dependencies match the version specified in the commit being checked
> out, and merely warns if the two don't match (then exits with a
> nonzero return code).

I've run into this before myself.  The core of the bug is that when
`git checkout` runs the post-checkout hook, whatever exit status
that hook has, `git checkout` has the same exit status.

This might be intended as a feature, but if so, the documentation
needs a tweak: the githooks docs say in part

    This hook cannot affect the outcome of git checkout.

If "outcome" includes exit status -- to me, it does -- either the docs
are wrong or the code is wrong.

> For this reason it's been convenient that the hook runs during
> rebases, but I find it surprising that the nonzero return code would
> impact the rebase.

I have to agree with this, too.

(The simplest fix would be to have `git checkout` ignore the status
from the post-checkout hook, of course, and just exit 0 for success.)

Chris
