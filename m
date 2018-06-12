Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6FB1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 08:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933487AbeFLISe (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 04:18:34 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34893 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932803AbeFLISc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 04:18:32 -0400
Received: by mail-pf0-f172.google.com with SMTP id c22-v6so11282870pfi.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=14KRCA5YDrvRj29Uu+otGUlfLgBpHsuCF3Ge3z08kSs=;
        b=TCes1goS87bdxdbyLW6CqDEXmN4a+d+nnnv5sc4L+ndkjwEtWbfzF9xlQZrOO0bOSy
         dC9s60SY79G6VENeIedyMu6617Z9lW+bRG23sR5VrdOGYcwWfkM3abNo2Fcu8pc/Dnxy
         inCfZe3ME/WOtN2axiJ2zrgelPvQYWmKSbjqLe2VWP+33uS49PzPh/7uMq2+WN4RIWZ/
         fb7t5xSDP0sL0KUYMQsw89BbaEmbPhIQO+8r+pidQxDHLlP+pUJX/59RL5Y8vnCCyd3j
         sTG9XctpdtLKkIggmSxASZ/rjICHh0YeBTm6wOMq0RDF2NN8Dd0Iz7de3n+MqWcJGW7K
         RorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=14KRCA5YDrvRj29Uu+otGUlfLgBpHsuCF3Ge3z08kSs=;
        b=B0C8fAoEK/nx96aRulh0VoxEpf3ywdblYDoCv6dWm1wKeHr/oadgTJc13p+AaCc4BC
         i/bDYutU6wZm19l19TXQdgM/6hnnDZfeP5l5s1Qe6r8ivhYPQuB7rzLMiyXGHtwB8YNn
         XaLddaOqNRcXT/5ixuylYVGFyCeLAtt9UPZIY/GlyAidLBLXL0ZZ5b+cqQ5Z+swJm1MZ
         IITOCTpZfmaCGsT3JMdZcR2dK8GEGrU1Dv0ix03o/u1lAiF8gY5kHTsqUNAFERVNfGMz
         Znq/bTneyCsTnjPIEwH9kw77KDHmE1jznpAZ7fcQKqzCMAcPlsc/frx5GaVXyxfYP9FL
         NzJw==
X-Gm-Message-State: APt69E0PVyyQmrFnmeQg67QeMASOol3QD9fb4TRtgPI4Pgq1CNRPn75D
        50LzaxpiSAFFrFntuJ7uKExR90IQrVb5XTwSh0U=
X-Google-Smtp-Source: ADUXVKKZQ9/saBXuODb0cPHLffn5wfJ3e4M7jLAcQoNXJM0nTL/mFFoaJ5dFgl6cwCpOyvd3SRmFghyot6g22Sr1IPE=
X-Received: by 2002:a65:4eca:: with SMTP id w10-v6mr2316877pgq.13.1528791511975;
 Tue, 12 Jun 2018 01:18:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3326:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:18:31
 -0700 (PDT)
From:   Crni Gorac <cgorac@gmail.com>
Date:   Tue, 12 Jun 2018 10:18:31 +0200
Message-ID: <CAO65DGcYt85sjTkjSK9ERaoMf6n56LG8WJ7q4pWymmaNQ+wLYw@mail.gmail.com>
Subject: "linking" to files from another repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on a large closed-source project.  For one of clients, I
had to create a library that consists of some directories from
original project, and even within these directories, not all files are
used for the library.  On top of that, I've added some files specific
for this library, in separate directories and in the library repo
top-level directory.  Most of files from original project are
unchanged, and for some, I had to make some small changes (mostly to
exclude dependencies on other stuff from the original project).  We're
now switching to Git from another VCS, and I'm wondering is there any
way to automatically "link" those pieces from the main project repo
into my library repo?  So far, I would run update in the main project
repo, check is any of files that I'm using in library changed, and if
so, then I would either copy the new version of given file into the
library (if given file unchanged for the library), or merge updates
manually (if given file is one of these files that are slightly
changed for the library), and then commit all these changes in the
library repo.  None of changes in the library will ever go back into
the main project, i.e. the flow of updates is uni-directional here.
So, any support in Git to automate the procedure of updating the
library with the changes made for corresponding files in the main
project?

Thanks.
