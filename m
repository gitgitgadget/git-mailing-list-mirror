Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CF22036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdJCT42 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:56:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34938 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdJCT41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:56:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id y44so1552853wry.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DcpadyaF3Wn8QFGAcIos1jtTz9QTw0NfTy66SHI/DSw=;
        b=UZqj/ex0cLmReq4qOK0XvSNyqQwgG/f5n/fV4zfzceR1q2U5iS9NzhQyG3Pf1cPY6S
         p5Ka7oGK0RVpze5z8y4VJEghwNfJYvWyFpKCa9t7cd29WtVPInvIFfwsxz2iasuaCbz+
         XRNsE2yJ19uG4E/arpgaXNAAC602U7GGD/SpDarJ9ya25z+th59T3r+3coUiHZzl4nUd
         OVWJ/nrbFRCYJubjj2DnDwAVUptKQC8aDPoTj3oaIXvECCfYHA/Zy5egV4flkBP/n7R9
         sZKmi7qLuIqxnM+aBOWQ0a9qne2cY/I6Sl3pw4edlbVZA8m5tF+9tdkJdeZYeMOlxosW
         pw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DcpadyaF3Wn8QFGAcIos1jtTz9QTw0NfTy66SHI/DSw=;
        b=UiNrm9po6/E4bK2tsgrNn8mEm9BX4unRfffFLXAqs2TgEo2wrnEx2co/0pMAwBsYKi
         AhbFJJixoooRuOaO2lofhHo6lrb3D0v6i82c4eAgYUSYsf/znwUxsY4Q3bM/VFkQmwR4
         EocLIobFiuKapvjcvvxtSkT191N40CWUzC4r9ECwMlOgGwFiu1NbL6nIAMH9EdPOuuhN
         L+5omImCRLjH4Gkx4qF2B2zPFqJdYWEgIfsI34BzcUaFy7j7owVH8Wth2kxT2svjPdCz
         f1Wv7wXcxqmhOsGkT9dMk1MIVs2kegwSyn290O8NRHsyLWrvG1NQpES8Dywp1nsja0RC
         mzoA==
X-Gm-Message-State: AMCzsaVleT8+4OpQ33ruOrQonzWqI0I6Chjy5D8seVJgnmfduCfuBb4e
        s8UaYOf/wCKBrg5Dsonww6Pa6fDU
X-Google-Smtp-Source: AOwi7QCe+9hznzBknyfSk05halPdzMezje+PIIQsCTyHg2HcbQpEkry+pkySYi9TGIQvOwMLWh7wmQ==
X-Received: by 10.223.163.148 with SMTP id l20mr9084567wrb.73.1507060586217;
        Tue, 03 Oct 2017 12:56:26 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 10sm13122936wrt.59.2017.10.03.12.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Oct 2017 12:56:25 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] fixes for running the test suite with --valgrind
Date:   Tue,  3 Oct 2017 20:57:10 +0100
Message-Id: <20171003195713.13395-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently tried to run the git test suite with --valgrind.
Unfortunately it didn't come back completely clean.  This patch series
fixes a bunch of these errors, although unfortunately not quite all of
them yet.

The remaining failures are in

t0021.15 - This one is not actually valgrind complaining about
something, but the clean/smudge script not writing debug.log for some
reason.  I'm not quite sure what exactly is going on here.
t0021.25, t0021.26 - This is an actual uninitialized memory usage:

==4751== Conditional jump or move depends on uninitialised value(s)
==4751==    at 0x2796D5: fill_stat_cache_info (read-cache.c:153)
==4751==    by 0x2218A2: write_entry (entry.c:359)
==4751==    by 0x221D42: checkout_entry (entry.c:458)
==4751==    by 0x2EB627: check_updates (unpack-trees.c:382)
==4751==    by 0x2EDBA1: unpack_trees (unpack-trees.c:1380)
==4751==    by 0x13797E: checkout (clone.c:750)
==4751==    by 0x138FF4: cmd_clone (clone.c:1194)
==4751==    by 0x11A6F2: run_builtin (git.c:342)
==4751==    by 0x11A9E8: handle_builtin (git.c:550)
==4751==    by 0x11ABCC: run_argv (git.c:602)
==4751==    by 0x11AD8E: cmd_main (git.c:679)
==4751==    by 0x1BF125: main (common-main.c:43)
==4751==  Uninitialised value was created by a stack allocation
==4751==    at 0x2212B4: write_entry (entry.c:254)
==4751== 

So far I've tracked this one down to the lstat call in write_entry
failing, and thus not filling struct stat_info.  I'm not quite sure
yet about the best workaround for that (and I'm not very familiar with
the clean/smudge code).  I'll keep digging what the problem there is.

There's also one test that's unexpectedly passing when the test suite
is run under valgrind (t6410.) but I haven't dug into what's up with
that yet.

These patches could be applied by themselves as well, but since they
work toward the same goal, and a cover letter would explain where
these are coming from I decided to make them into a patch series.

Thomas Gummerer (3):
  path.c: fix uninitialized memory access
  http-push: fix construction of hex value from path
  sub-process: allocate argv on the heap

 http-push.c   |  2 +-
 path.c        | 19 ++++++++++---------
 sub-process.c |  4 +++-
 3 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.14.1.480.gb18f417b89

