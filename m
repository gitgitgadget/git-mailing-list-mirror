Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75C3C388F9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A89D24248
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 20:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKTpG3zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371728AbgJVUbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897070AbgJVUbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 16:31:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72AC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 13:31:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h21so3067327iob.10
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9Mh6RAGVWCUeMv0NQu4hal2VakWB+eGI8D2tclKN1Xs=;
        b=kKTpG3zZ8YpfFAt2hxIViXHL85n/zojh76FJ4BI0doH/ONz5PJUdyhCd58Ze5/aWXT
         WS2k6g0Be7tj2h32YDlb/89PErjKavzXJ+AWOS7yybS4tkW5vrO2f+kWKgVCcuJkYHzS
         5Wvyk5W4Gf9zTkpow3AvEa62ZinvK9dMArqduKv9A226ADRV//D6pXS1r8T1gt65fsNP
         I72ZhP1zSgNEpOWwLZFx0sgkv2iAGXxnr0f2VMS8o89Lj39iplgg8/y78VHtkSwXsGW8
         AraRTD/PihXR1FZ00/hDJCtS91+GQHZ6g+in3zk6WcfNRpDbkn6PZbpoTmtFqvmOMVu5
         Sf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9Mh6RAGVWCUeMv0NQu4hal2VakWB+eGI8D2tclKN1Xs=;
        b=mDZ17Y9nK0nlJmjY5zF04TW/qt92qmiOdHXvSDzPLA56Pjtd47ThL0BsEvu+3hx5WJ
         tHQyH+/ilWG2PHSQV274egfEw2SlbPs3JOnw3PE7578M1phFYAWDFqiTqg0a9qXEhrXD
         cQkIz/AHcRxHSOCNYx0VDKg06ePZbdyxdMUHu9JglJ4Biz6UFUC7++qP1h0MxS7vreYw
         iyLmcOR+skfhShTIWUkgv+Wh8KOuzo+QKJXk4R64vt0FzmvP5Ass0ZQHmu99DaHwoW9i
         ofMmCanasPUKti1FwMeFccKJOdncz0AenwUFKJeMIIsleQSLArVWCW0diBEhUqKTqnok
         TewA==
X-Gm-Message-State: AOAM530SG29aetOhyw2wZlbpqwWXFOss2GMqF5cZunCkV1PblmjkjXqc
        T5PNyRYjAdkM6zulCvQTWchtwtyut+75C6f3kxNXK0TFLa1I+9Gk
X-Google-Smtp-Source: ABdhPJymvqhKHryBgx55Hjeiz0L+oPaYJ5Gww8fYIrvkKnQY1J2bRmOIAvmNNMBFH85xgFBBNAgAx4Jj8lC5Lg5t344=
X-Received: by 2002:a6b:c3c9:: with SMTP id t192mr3096940iof.207.1603398708979;
 Thu, 22 Oct 2020 13:31:48 -0700 (PDT)
MIME-Version: 1.0
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Thu, 22 Oct 2020 22:31:22 +0200
Message-ID: <CAFzd1+62PmHBoVpMw-y4TC=bmc8N0wDpF2jQa7XGz2e+7Dos6A@mail.gmail.com>
Subject: ORIG_HEAD after rebase is confusing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reading the git rebase manual and some answer on stackoverflow I assumed
`ORIG_HEAD` will point to the original HEAD, the tip of the branch *before*
I started rebasing.  But it doesn't seem so.

For example, I have this:


  $ git log --graph --all --oneline
  * 9830f9f (master) X
  | * fb7b6a6 (HEAD -> feature) D
  | * 46b7a7a C
  | * da5e4c7 B
  | * 5c135da A
  |/
  * 6848823 Init

  $ git rebase master
  Successfully rebased and updated refs/heads/feature.

  $ git rev-parse ORIG_HEAD
  da5e4c7e9eb3b10c1efa08c534b9c9e4b92d9fd7

  $ git reflog
  a647bd7 (HEAD -> feature) HEAD@{0}: rebase (finish): returning to
refs/heads/feature
  a647bd7 (HEAD -> feature) HEAD@{1}: rebase (pick): D
  2f458e8 HEAD@{2}: rebase (pick): C
  0aa2160 HEAD@{3}: rebase (pick): B
  b957fc7 HEAD@{4}: rebase (pick): A
  9830f9f (master) HEAD@{5}: rebase (start): checkout master
  fb7b6a6 HEAD@{6}: checkout: moving from master to feature
  9830f9f (master) HEAD@{7}: commit: X
  6848823 HEAD@{8}: checkout: moving from feature to master
  fb7b6a6 HEAD@{9}: commit: D
  46b7a7a HEAD@{10}: commit: C
  da5e4c7 HEAD@{11}: commit: B
  5c135da HEAD@{12}: commit: A
  6848823 HEAD@{13}: checkout: moving from master to feature
  6848823 HEAD@{14}: commit (initial): Init

So `ORIG_HEAD` here points to the original B commit.  (I expected the D.)
Honestly, this doesn't make much sense to me in that I don't know *why* it
even chooses B which is a middle commit in the chain.  (And from reading the
source `sequencer.c` I can't deduce it either.)

  $ git --version
  git version 2.29.0.windows.1

What I actually wanted to do was `git reset --hard ORIG_HEAD` fwiw.  And for
example `git diff HEAD..ORIG_HEAD` to check for unwanted changes after a merge
conflict.


Regards,
Caspar Duregger
