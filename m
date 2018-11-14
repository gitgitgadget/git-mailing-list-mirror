Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3141F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbeKNKPN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:15:13 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50073 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeKNKPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:15:13 -0500
Received: by mail-pg1-f201.google.com with SMTP id a18so9387620pga.16
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AmC1N4f2Hpm9iBV4CqRjLMB11EbW2gsbN4jjEH7W/SE=;
        b=TkF4OUHslID8Zd7fXWz/cgphOIx7qN4QQB5gtBdEDkEcoMhnoQSsE3jS+bdCjh71NY
         FXPXFr/Jtc7YqAc3Z7fdduIWOE7nFgVgAyTRH5+tT1ArmzaJA5xsV7jC/7f7CF6M9YtB
         11DNvxgeruct1tD9M9hiqgM5VTG9OXWXnPwFMw23TyPaRtxuGJdFbrOmTYJXh0OG5BAh
         78IfAeuwkoydT3oNOkl5RmLk2ohTg4xrKXbY2u5JLt6+bxfqXgA0SHF7GC5fRZqJfzNr
         aGNY1rluWZMENXrFUrpMwuLndngMkDu6ghBYBqpL1xMenfM4PTIkjNQkZRz+hlVnOP7A
         RXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AmC1N4f2Hpm9iBV4CqRjLMB11EbW2gsbN4jjEH7W/SE=;
        b=WtIwSzmSFN1lQAwFPhzLDPZ3QI+qczzPEl/kLfwjUk52c2a3NdPBCCIlfdmDVsVwQg
         Y+vtOMwHApjbqP8y1TB6eUoTPnQY1XGqdUpyE9f6htU0eYyPQbXbWq1aVK1Cj0/Y+Bt2
         oY613uSJM03ptPD1gZWh5LjSKR6NOVUmfFbfeGjbIhT1tyUsdmFLoe47K/ehk9LcM4wF
         2B0FRQnh5K1oO8oQQmvzoWWvZOJj0FYcNmvq236aW76iUmM24QBHhRYoTojrtdgfdiy6
         l9MGlAldshYvbNHIV1jb3HzZ66YfrrQO6Ti47NlxBJPBPrsmQ1mzvNKV0Qnmc7a0FTBB
         3B8w==
X-Gm-Message-State: AGRZ1gKqqkfdnkptvc7hLgDPo6ocZP2SyEnlUxVYYJd9FqLoVYpky/rs
        5SnNRRxmFwHY0ngnTCnllgtfNHaCNerT
X-Google-Smtp-Source: AJdET5fPNrZTB+FDDd8PxVciyOmqq68epDvmoqLgbsVvT++1gwoTshufYp4mhs/kcBRaYnWCX4uuzeY1BzWJ
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr506773plp.66.1542154470019;
 Tue, 13 Nov 2018 16:14:30 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:13:06 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-24-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 23/23] t/helper/test-repository: celebrate independence from the_repository
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dade47c06c (commit-graph: add repo arg to graph readers, 2018-07-11)
brought more independence from the_repository to the commit graph, however
it was not completely independent of the_repository, as the previous
patches show.

To ensure we're not accessing the_repository by accident, we'd ideally
assign NULL to the_repository to trigger a segfault on access.

We currently have a temporary hack in cache.h, which relies on
the_hash_algo (which is a short form of the_repository->hash_algo) to
be set, so we cannot do that. The next best thing is to set all fields of
the_repository to 0, so any accidental access is more likely to be found.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h                    |  2 ++
 t/helper/test-repository.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/cache.h b/cache.h
index 59c8a93046..8864d7ec15 100644
--- a/cache.h
+++ b/cache.h
@@ -1033,6 +1033,8 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 	 *
 	 * This will need to be extended or ripped out when we learn about
 	 * hashes of different sizes.
+	 *
+	 * When ripping this out, see TODO in test-repository.c.
 	 */
 	if (the_hash_algo->rawsz != 20)
 		BUG("hash size not yet supported by hashcmp");
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 6a84a53efb..f7f8618445 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -17,6 +17,11 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	setup_git_env(gitdir);
 
+	memset(the_repository, 0, sizeof(*the_repository));
+
+	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
@@ -43,6 +48,11 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 	setup_git_env(gitdir);
 
+	memset(the_repository, 0, sizeof(*the_repository));
+
+	/* TODO: Needed for temporary hack in hashcmp, see 183a638b7da. */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (repo_init(&r, gitdir, worktree))
 		die("Couldn't init repo");
 
-- 
2.19.1.1215.g8438c0b245-goog

