Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4431F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407862AbeKWJrv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39538 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392523AbeKWJrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so2680009wra.6
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FC0CICXoQpUD/rTfQIhkd8bXUgSgit7MNR/RG9aJtg=;
        b=tEJR/mu1R5nj1jBox5yUDjQdMkGeDRf1X5e7mIAVOS+FWLHxoMQDwRGsYjPS4i4egc
         Bbf3iVK2fgQ3hckMAp3wigCfwMXNQLWnSnlFb+/RCG6PBbqe2WQfa7SAKoPUJ6+c0IdF
         yCRl1a4+XBfmOg5YUhO+kUFhWpA8F41rtPoTIuoUChE3seSg4Ls4QbRalramki2YoVuS
         JH0Sf6T+VvkTD5KxnliqnINszz/Fa5uiEawIuLB7yZyu0Kl0d61gD5mobyeSq1+cydpk
         ZZ4BNgqzvukPEWGGldmlDCuUWeM/CnoRlJKDH1KK4azSDv39Ihe1PsHJW/CSjvkfAtNp
         S5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FC0CICXoQpUD/rTfQIhkd8bXUgSgit7MNR/RG9aJtg=;
        b=K0W0q5ZT0eDgULSBL5d9DFNWIozhdOt63u1OwXdbOWYV+iTOiDhHwRPK8tnwkQ5Cqv
         I3sKEqkHdW0zPx/BahD4eZ4rLKUgeEi4kX42fPAAxTOFXgLG10D3wOBZKUnN1MuS+a5o
         4Y8YLkBa+TX3RYH/nsHnVEYbbtJ5c6ilGlnycX+dvzhjlBGqPhGvdLTvDf//UZJkYCq+
         1KzfVnN2T751KHLImIqwb28sggraPfX9Vat76xU5cJWGaUluznryJS5CEnsPvQhvMIEi
         kKeEKfVl51nmC5PWS7sYP6Lci4S9BHtDCXCZdu2VvLqVn5hW9HO6XtGywdnv9GcdvxDb
         arfA==
X-Gm-Message-State: AA+aEWYkOioqqrAdjywIkoSHNGDMJ4JZxdd6gc8lZElYmFMG2191jmbb
        +J9k4NjhJ9VDV4Cl6V/0gcuUIgMj
X-Google-Smtp-Source: AFSGD/UpsDPaQU5RhA2LrXcPgo2kTvS4X0qM7ZlSPFQ97W8cQjKtNVq0ByUd6MZRtkAQESy2avui1g==
X-Received: by 2002:adf:f149:: with SMTP id y9mr12340889wro.284.1542927971051;
        Thu, 22 Nov 2018 15:06:11 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:10 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 00/22] Convert "git stash" to C builtin
Date:   Fri, 23 Nov 2018 01:05:20 +0200
Message-Id: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is the 11th iteration of C git stash. Here are some of the changes,
based on Thomas's and dscho's suggestions (from mailing list / pull request
#495):

- improved memory management. Now, the callers of `do_create_stash()`
are responsible of freeing the parameter they pass in. Moreover, the
stash message is now a pointer to a buffer (in the previous iteration
it was a pointer to a string). This should make it more clear who is
responsible of freeing the memory.

- added `strbuf_insertf()` which inserts a format string at a given
position in the buffer.

- some minor changes (changed "!oidcmp" to "oideq")

- fixed merge conflicts

Best regards,
Paul

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Paul-Sebastian Ungureanu (17):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  strbuf.c: add `strbuf_join_argv()`
  strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
  t3903: modernize style
  stash: rename test cases to be more descriptive
  stash: add tests for `git stash show` config
  stash: mention options in `show` synopsis
  stash: convert list to builtin
  stash: convert show to builtin
  stash: convert store to builtin
  stash: convert create to builtin
  stash: convert push to builtin
  stash: make push -q quiet
  stash: convert save to builtin
  stash: convert `stash--helper.c` into `stash.c`
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls

 Documentation/git-stash.txt  |    4 +-
 Makefile                     |    2 +-
 builtin.h                    |    1 +
 builtin/stash.c              | 1596 ++++++++++++++++++++++++++++++++++
 cache.h                      |    1 +
 git-stash.sh                 |  752 ----------------
 git.c                        |    1 +
 sha1-name.c                  |   19 +
 strbuf.c                     |   51 ++
 strbuf.h                     |   16 +
 t/t3903-stash.sh             |  192 ++--
 t/t3907-stash-show-config.sh |   83 ++
 12 files changed, 1897 insertions(+), 821 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.19.1.878.g0482332a22

