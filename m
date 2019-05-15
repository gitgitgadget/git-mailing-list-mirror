Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21751F461
	for <e@80x24.org>; Wed, 15 May 2019 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfEOOwj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 10:52:39 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:41990 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfEOOwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 10:52:39 -0400
Received: by mail-qk1-f175.google.com with SMTP id d4so127417qkc.9
        for <git@vger.kernel.org>; Wed, 15 May 2019 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6YvgKJFyzBjiBOKtsl+S8XJCxqj9oALAiOqCpMmGD7o=;
        b=h/E5xcSn2BVTXYlL3lbNoqTzpTblFHmfNEJo9IfWs50v4g34k5T2BLxjlObeVBiQih
         EeX2j6sNUqu6Qw2nMgLliaFqvVTWZpkFqkJ79il9IJp+Fu8/Ua1MReMhqZOUGCY58Q2r
         3M6kRuPStW2t04arPK/7AsSu8/3dZoMAj1AGIOwsoZ3pgKyacoNwB+ZZq8zM0zY91y8z
         JrN6aYns2QwsdU/iFSrTqGxkBomOuJrI73e7E2NyWBtPh7MlazdSK1M+jNyEoJ+KpWYv
         +7IrKQ5wlyqEkF5arDcGgNBec8M6LbhHx8UXOZPFjILZFgqIfU/y1dD0pr6lSjzSIUob
         qaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6YvgKJFyzBjiBOKtsl+S8XJCxqj9oALAiOqCpMmGD7o=;
        b=dPHT47VgrqQMlj7dfk/nkt/IfHEpR9clkw5kEQIu+e2J7k70wu2qzb3RpkRWrSzHop
         yabQvJ4p2BfZaWmaOPqMIHj3Jq2GtarA5BaipRQGP/PihR5SQYz3TtGPnQyh11whS0yN
         kmfOjD9KTq6HMezn6YC0TvNKmnliCm24ECPQAyg1mWa8nUffzmlj4hll2HjpGmZquMMC
         daSMIS1IQIF7GChsuKz1GNZujdbk+FwqFj8UGrC7yeK81Fq6anWd3Yn3UyiSbN/xsau+
         H/SqRrwIOY9j0Gti7M3bGdCehjsC5EylRAjzlpuqsZOtCi3NATMcbH2YVn7hvD4/jgmD
         BtRw==
X-Gm-Message-State: APjAAAWNrxmzPobOTn1AQPdPhUZFVoNtZ3naCm0vJ10SLsW2lytxZidk
        fQNft/KgUzeMjyBbKCYTPS+eWe3JCW/xkC4lor7bS7p5
X-Google-Smtp-Source: APXvYqzzweTN5zVHWr8uxQYKoHbrABHRFKrx76Vy9WM9rfePxuTtBA6ymF6cok1DNjw/1oatZ8akc2SjQCCwxGFc0MI=
X-Received: by 2002:a05:620a:1641:: with SMTP id c1mr33911450qko.103.1557931957880;
 Wed, 15 May 2019 07:52:37 -0700 (PDT)
MIME-Version: 1.0
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Wed, 15 May 2019 16:52:26 +0200
Message-ID: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
Subject: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm migrating two repositories from svn. I already did svn->git
migration (git-svn clone) and now have two git repositories.

I would like to merge them into 1 git repository, but to merge also
history - branches and tags.

The reason is that the svn repositories in fact represent one
"project" - you had to download both of then, they are not useful
separately. Tags were applied to both repositories, also list of
branches is almost identical for both.

So right now I have:

    - projectA:
       master: r1, r4, r5, r7
       branch1: r10, r11, r13
    - projectB:
       master: r2, r3, r6
       branch1: r12, r14

The content of projectA and projectB is different (let's say projectA
is in subfolder A and projectB is in subfolder B). So revisions on
projectA branches have only A folder, and revisions on projectB
branches have only B folder.

But I would like to have:

    - projectAB:
       master: r1', r2', r3', r4', r5', r6', r7'
       branch1: r10', r11', r12', r13', r14'

Where all revisions have content from both projects. For example, the
r5' should have the "A" folder content the same as r5, but also should
have "B" folder content the same as in r3 (because r3 was the last
commit to projectB (date-wise) before commit r5 to projectA).

There's additional difficulty of handling merges...


Any suggestions on what's the best way to do it?


Currently I'm testing join-git-repos.py script
(https://github.com/mbitsnbites/git-tools/blob/master/join-git-repos.py)
but it's slow, memory inefficient and handles "master" branch only...


Thanks,

-- 
Piotr Krukowiecki
