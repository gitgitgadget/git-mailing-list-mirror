Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CD91F461
	for <e@80x24.org>; Fri, 19 Jul 2019 23:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfGSXJI (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 19:09:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45790 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfGSXJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 19:09:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id x22so27870469qtp.12
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FFCZr1RrcYKsOkHatp+JB8+CCOdQY8zAe6OLsAbEaw=;
        b=iGWNzqW1zFRVvsh3qWUy2eBsB1M7/7tgaNqNL0J8e17gcauLKNQmev4k64rzJKzPRz
         qK/70uarJmzP5MTOzyTyVNJfo5retu1qhgpjdrr1n6Whs1KWNiYkvuOoROYSQ56vbt3l
         2tA0vKP/b9k2MLHjcRK4FAHOcqes1juGqWrRLox19OYhfUqSXLi93pRmh1Zv7qRJtq7q
         XuxItiVRlFZ1JofdR59Q+1yTkT7S+p2HTbjsiIY7KA66rO62sp15gpbVWzu5te8vCYsv
         THimtHDYgXdrliJqslsc3Shayby3346napU/EmtYwLKLbOV01rqtaZs03yq8JL4r8cHl
         rAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FFCZr1RrcYKsOkHatp+JB8+CCOdQY8zAe6OLsAbEaw=;
        b=lQ6F4Bqd/JYM7LHRuoNFrDjVEqZdUxnLvwYDmYc3YIoq3KLnPZpmBTcZ78k0jGCfkK
         NGblCyIWIE8AH72rSsRH7fvQFpWr2oXUTz5SesuizEqQv9aU7XJ4jtU0xMWOs19isJ2A
         0BctdbpHEERuLPAua6oj1SerCOXNO5Ddp99jQi5qVLzCdfk7JcHYkFtEFu/WwEFs6ozh
         /OcY3uPsgaj5jOcWpYE7S8B0RRluMI4AC8uRLLKEo1u7WtBc4c6w/yNja5js60R8oZF0
         U4tizOSKpHeiLw/WpBdSrn8aE3Qgp20aIZHSvJdkTSsn+N3FHnHM7r2T6csacpL5QG2/
         EKQQ==
X-Gm-Message-State: APjAAAXcPQ1+bUuG+T/iY/QnYXqmFz23o5ajcOZTyE2l3WM7ywqRoGXD
        q+Z0gyYT+MBgS9XCmFbxwM48GmB434s=
X-Google-Smtp-Source: APXvYqzdNyQwSKgra4xSyyiwnZIAbcbkJr22DWwEm+fyUo3GHoGKB8bwj7T8isoqmrbB5370VbvUlQ==
X-Received: by 2002:a0c:983b:: with SMTP id c56mr41305627qvd.131.1563577746710;
        Fri, 19 Jul 2019 16:09:06 -0700 (PDT)
Received: from localhost.localdomain ([170.82.202.216])
        by smtp.gmail.com with ESMTPSA id s127sm14469035qkd.107.2019.07.19.16.09.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 16:09:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com
Subject: [GSoC][RFC WIP PATCH 0/3] grep: allow parallelism in zlib inflation
Date:   Fri, 19 Jul 2019 20:08:51 -0300
Message-Id: <cover.1563570204.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Threads were disabled in git-grep for non-worktree case at 53b8d93
("grep: disable threading in non-worktree case", 12-12-2011), due to
perfomance drops. 

To regain performance, this series work on the object reading code so
that zlib inflation may be performed in parallel. This is a good hotspot
for parallelism as, in some test cases[1], it accounts for up to 48% of
execution time. And besides that, inflation tasks are already
independent from one another.

Grep'ing 'abcd[02]' ("Regex 1") and '(static|extern) (int|double) \*'
("Regex 2") at chromium's repository[2], I got:

     Threads |   Regex 1  |  Regex 2
    ---------|------------|-----------
        1    |  17.5815s  | 21.7217s
        2    |   9.7983s  | 11.3965s
        8    |   6.3097s  |  6.9667s
    
These are all means of 30 executions after 2 warmup runs. All tests were
executed on a i7-7700HQ with 16GB of RAM and SSD. The output was also
validated against current git-grep.

I still want to repeat the test in an HDD machine and in a repo with
mainly loose objects.

There're still some open issues thought:

1) To allow parallel inflation, the `obj_read_mutex` is released at
`unpack_compressed_entry()` and `get_size_from_delta()` right before
calling `git_inflate()` (and re-acquired right after). For git-grep it
seems to be OK. But, besides git-grep, if it's wanted to read objects
and perform other operations in parallel, we probably cannot guarantee
that the lock will be held by the current thread when it gets to those
two functions. Also, as the lock does only protect this call tree, if
those other operations access the same global states through other
paths, we may also have race conditions.

2) git-grep operations on textconv and submodules are still
unprotected and should result in race conditions. I'm not sure if
having two separate mutexes for them would fix it as the latter also has
to access the object store.

Any comments on the series and open issues will be highly appreciated.

[1]: https://matheustavares.gitlab.io/posts/week-6-working-at-zlib-inflation#multithreading-zlib-inflation 
[2]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

travis build: https://travis-ci.org/matheustavares/git/builds/561200398


Matheus Tavares (3):
  object-store: make read_object_file_extended() thread-safe
  grep: remove locks on object reading operations
  grep: re-enable threads in non-worktree case

 builtin/grep.c | 20 ++++--------------
 grep.c         |  3 ---
 object-store.h |  4 ++++
 packfile.c     |  7 +++++++
 sha1-file.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 66 insertions(+), 24 deletions(-)

-- 
2.22.0

