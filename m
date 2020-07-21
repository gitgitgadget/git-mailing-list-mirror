Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F230C433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A66120792
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkFpBNzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGUQQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 12:16:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC1EC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:16:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j11so24686612ljo.7
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQvymSnQ+Q/dXTimyBMs4fOAj6WKnnKElyZlKkktINI=;
        b=bkFpBNzvB34FSHUE6q4MXiorYXsYppA9Cqbg5Y9B4pTcai3lZxd0WdXKZvAd+setRl
         XrItrOiXP66VnFSqV3LrfJ0pdexMLydCmfDwig71t9p6h84kBkDVcVXOdsXfjIXBmVKE
         6gHsQgNUKYyIhPDt/rePAFGITngosNyFWMizD3+WwsBoQh0b/uizqaDhrmYr/8iLhyMd
         bCGeoX2UKo4Og5rkP6MySIzIWSUpq32qWHmv+i24s/vaNEk2bIb2KZXF8jW97U0MoZya
         2CuPOYDqITTcV+k6bkPiibO+Vpg18trN1nmxiNheJof8uoumsGXt/Q2zXIqcGd3sMVx6
         7QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQvymSnQ+Q/dXTimyBMs4fOAj6WKnnKElyZlKkktINI=;
        b=CN8qkvbgyRJnzBppdZA5C2pMDLQKYoyyevwtCbCpIJNuzByVq6Q9RgKje9X8hia9cK
         e3slAryaBVhi9YoO6EaSTwo8395dWLyP8cCcyyZSSqPAaEV4iF8x/fUPdi9DXy1rirS1
         l8Z8SIxeqIJTdHAD9MQh97b1UaUZbPW15EEdrHeerXWrSECft7Y/pKBzpeh8xv4HW0oL
         VV1pzdQedPKGJgyJVAdBK92hhjdjDHN7Ip7s1y1nSXaZaxIydnQ6E7UtNu+8nhRO/1mD
         VPpZXfRhhugPt0UUGnrsSYqBO8KWcrH7VuhQ6K7qYioU1wDBsakh9EIS9Mou5nIf0F5Y
         R/TA==
X-Gm-Message-State: AOAM5327vK+1avX+hlbWakr0415/PekBqzW1esyx3fAY1sxn+G1coyMD
        5Wv3F8xXQ1IBR+K/3j5nFj/NcE9y1/l+nUyJrhQ=
X-Google-Smtp-Source: ABdhPJyxFXGUFKSZMsLbxnYWcxJjRmdlk/J5zhiLnyKsnw6sjvNAActh+QmXICTxAqp01/WpV7Qszt59Ac2p5Q4RTNI=
X-Received: by 2002:a2e:760b:: with SMTP id r11mr13842792ljc.285.1595348175448;
 Tue, 21 Jul 2020 09:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
 <xmqqo8ofgycz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8ofgycz.fsf@gitster.c.googlers.com>
From:   Alireza <rezaxm@gmail.com>
Date:   Tue, 21 Jul 2020 20:45:47 +0430
Message-ID: <CAD9n_qi=9Dm83g+dJ42m+CJKtjzm7M9_x2cCi5_iHmYr6vDQEA@mail.gmail.com>
Subject: Re: Request for adding a "clean" merge strategy for a double-commit
 merge to deal with conflicts separately
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Say I'm merging from upstream with 100 changed files, but I only get
two conflicts.
If I manually resolve those, the changes I made in the process is
actually lost in a large merge diff.
What I'm trying to do is to separate those manual changes from
anything else that could merge without conflict.


> What would the "clean" (by your definition) result have in that
> block of contents that actually has a conflict?  Do you mean to say
> "Pick our version and ignore theirs in the blocks where the changes
> conflict"?  If so perhaps -Xours merge strategy option that the
> recursive backend offers is what you are looking for?

That's actually what I first tried. But when I use -Xours, I can't run
`git merge <previous>` again
to reproduce those conflicting hunks - because the resulting commit is
deemed to be in sync with both parents.
As a result, all the upstream changes are now overridden in this side branch.
