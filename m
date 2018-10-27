Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6C41F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeJ1CL6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:11:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39938 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1CL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:11:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id n3-v6so3167717lfe.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KROp2OmgV4SGm4yVDREQihvIZxUo+oEFPeIbF4OSdj8=;
        b=ZSMN6jhIn6QBovfm7O8SBmP13JE1d6EGzZTs2eNXB8jbEMD9BTTyNC8lJvwaP0VRk+
         +0oUmPRkEJQ2s2zycR3YbqjmlNav4lAWT6czovFoGCJKXQsyM90chHkYAaKqvjeJqomu
         tnIvKHTV+DDx1eKRMUzhYTdU9yJM3wLFtflTAmp7wPl1il3kqRxSA0LcMSyWQkt1TWgW
         4+4HE+UMlvt9FdYtoT11FJZUxr5/Z+/incsdiTkfbK232YLJu8ok+63UtSAB4ckuZbfT
         ohnq4Jwyc1IKxT2C1T6p+zhOSkwLOktHNycdBxPNX07MLDqWLe6iSL9WcAoFAEOj0C/Q
         998Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KROp2OmgV4SGm4yVDREQihvIZxUo+oEFPeIbF4OSdj8=;
        b=WXMBvfvHNtbxA6v3nmVMi55VuHEXGA0CYybyoWpiR0h3sPj0/d7NQDUbUv9qvyU9e6
         64AJ+QQ6PpGEb+/XjhmPyiV1RXLKmGzWDlAGhR+hJPgimOuAHvOOzwoYvTBDtwdBQs9q
         kNmm8karP7xi99oieYUA8YbtArjGH2zJ5IFW09yiDvtkK/5/UUAypnBPZcUolQ+8YySJ
         eBiVZmy2Uj/cCk3N5TCeNO/cIPvbjVWnOEalKcSO/Yd+b8YTh/KMICEnt3oWE4YhHLks
         CuxSVhFA7d2dc+M/SVXfKGdYJaXJ7Nz/sjIfNLN09mwIt/pIqqwEpYlR5/i8ieJxsr2R
         Pehw==
X-Gm-Message-State: AGRZ1gK37G6oF7sTj88Oq9zFIxVtZgtKHhp86WDrQZpzo/WUBqeAiavS
        7YB7r79g4/5nG8VJSoHGT+o=
X-Google-Smtp-Source: AJdET5fHx71DMPMq+Y+6TmK6geYkIW+uaRycFK9/Sqkhk/NNxTQGCquveYBd18gXejvqDIofM3gaPg==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr4984806lfb.132.1540661416090;
        Sat, 27 Oct 2018 10:30:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 00/10] Reduce #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:29:58 +0200
Message-Id: <20181027173008.18852-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The send-pack.c patch is dropped since it's tied to async code and
like transport-helper.c (or more cleanups in index-pack.c) could be
left for later.

I added one more patch to shut up -Wmaybe-uninitialized but since I
could not reproduce it, Jeff would need to verify if it works for him.

Nguyễn Thái Ngọc Duy (10):
  thread-utils: macros to unconditionally compile pthreads API
  index-pack: remove #ifdef NO_PTHREADS
  name-hash.c: remove #ifdef NO_PTHREADS
  attr.c: remove #ifdef NO_PTHREADS
  grep: remove #ifdef NO_PTHREADS
  preload-index.c: remove #ifdef NO_PTHREADS
  pack-objects: remove #ifdef NO_PTHREADS
  read-cache.c: remove #ifdef NO_PTHREADS
  Clean up pthread_create() error handling
  read-cache.c: initialize copy_len to shut up gcc 8

 Makefile               |  2 +-
 attr.c                 | 14 ---------
 builtin/grep.c         | 59 ++++++++++++++----------------------
 builtin/index-pack.c   | 68 +++++++++++-------------------------------
 builtin/pack-objects.c | 26 ++--------------
 grep.c                 |  6 ----
 grep.h                 |  6 ----
 name-hash.c            | 38 +++++++++--------------
 pack-objects.h         |  6 ----
 preload-index.c        | 23 +++++---------
 read-cache.c           | 53 ++++++++++++--------------------
 run-command.c          |  2 +-
 thread-utils.c         | 48 +++++++++++++++++++++++++++++
 thread-utils.h         | 48 +++++++++++++++++++++++++++--
 14 files changed, 178 insertions(+), 221 deletions(-)

Range-diff against v1:
 1:  fd4926a83a !  1:  2791c06629 thread-utils: macros to unconditionally compile pthreads API
    @@ -146,6 +146,7 @@
     +#define pthread_t int
     +#define pthread_mutex_t int
     +#define pthread_cond_t int
    ++#define pthread_key_t int
     +
     +#define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
     +#define pthread_mutex_lock(mutex)
 2:  47b1f63fdd =  2:  61b3efceee index-pack: remove #ifdef NO_PTHREADS
 3:  a842b27e1e =  3:  93aa33eaa6 name-hash.c: remove #ifdef NO_PTHREADS
 4:  c0939283c3 =  4:  5d9441d8e2 attr.c: remove #ifdef NO_PTHREADS
 5:  6c6f3a0d28 <  -:  ---------- send-pack.c: remove #ifdef NO_PTHREADS
 6:  9f6e259fb4 !  5:  834b19d5c6 grep: remove #ifdef NO_PTHREADS
    @@ -13,6 +13,16 @@
      static pthread_t *threads;
      
      /* We use one producer thread and THREADS consumer
    +@@
    + 	int hit = 0;
    + 	int i;
    + 
    ++	if (!HAVE_THREADS)
    ++		return 0;
    ++
    + 	grep_lock();
    + 	all_work_added = 1;
    + 
     @@
      
      	return hit;
    @@ -136,15 +146,6 @@
      
      	if (show_in_pager && (cached || list.nr))
      		die(_("--open-files-in-pager only works on the worktree"));
    -@@
    - 		hit = grep_objects(&opt, &pathspec, &list);
    - 	}
    - 
    --	if (num_threads)
    -+	if (HAVE_THREADS && num_threads)
    - 		hit |= wait_all();
    - 	if (hit && show_in_pager)
    - 		run_pager(&opt, prefix);
     
      diff --git a/grep.c b/grep.c
      --- a/grep.c
 7:  97fb2fdba4 =  6:  10969f86ae preload-index.c: remove #ifdef NO_PTHREADS
 8:  b8aeb2776b =  7:  7e83190364 pack-objects: remove #ifdef NO_PTHREADS
 9:  40a9bfb8f2 =  8:  404e9d9041 read-cache.c: remove #ifdef NO_PTHREADS
10:  0bb0c667ff =  9:  046008b4ef Clean up pthread_create() error handling
 -:  ---------- > 10:  2ad9554687 read-cache.c: initialize copy_len to shut up gcc 8
-- 
2.19.1.647.g708186aaf9

