Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6622B1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968563AbeE3AtE (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46412 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968246AbeE3Asj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so9948231pld.13
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mAWp0iY/lfAAlBCa4z8xa+xkBbaxOYewPQFI35lQ5cA=;
        b=VKnD8gqjuWauzjeGOwVH2ZFgeZqsJ2YNoySvAMlODO9hRb8JAMYa7tJDziG0xnmd5w
         JugChUmRjPaMQTHYMTRHFYmaHI7g+/upbokt5GYphQ81HuLKV+kXcs64+zYwdoCfe7sn
         2KoLU/opVWaJxMbQ0ryYHH97t2sEz/Sz8j3rvjovxipAGx94YiqfpqE9wl8MfbO25bof
         iC0+AvtC+LVrdUFCjt29E877Eecy36tO28BNj746PmGyPpimrHBKBOVaKGeCDRpNGHcb
         qhffQsZ/6tMOhLGk5dAqiLiAM38QkOSXnimgf/liYF84KxEpkekkjq81vpKEGBGGlrPl
         UV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mAWp0iY/lfAAlBCa4z8xa+xkBbaxOYewPQFI35lQ5cA=;
        b=hgv5Ai4NGxwSfOxP46rAtJKAS/xBzq5Xnll7rF9XEu95A75VHFUBgTl+/CgpkwFi1f
         J79rWk5JeGn14lPY7ZeudDpv+VxU2KV/JvH0xajgCH7g6W+HKKlEKcfckpfKhUp6qY4e
         tbth9AnZtcdC3VfM0E2EynYxX2URUaTMNjhc611JSJWGb1V2W+RlPa+M9xANk49vZbGB
         YzOf6e6E1EgjY1NduoFSWsZSLZ5vKMTvGGKvDmzGZCQBybNsp7iSJNaczwq/RljYQSj+
         nET2iby/4cftNOwHTZdBHYQuboVOcQazN6RaamYU8xeZIF6GH4o1vAGbcJxWkf4Yjn/k
         OjEg==
X-Gm-Message-State: ALKqPwdinYXMRqQe55bViP8rCHHOLFLwy0eT2i399xvUTZSsewCmdG4X
        ErrFEuNt4rw+IcbvnIoHPcR59Fhxblg=
X-Google-Smtp-Source: ADUXVKJE3JGlTJCxVdFvMHgHBjt8QcUcT+Pllldn6tAKWQJ7j+UGRkncKrP1uTAXcEwsOd7JistwSw==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr620950plk.41.1527641318584;
        Tue, 29 May 2018 17:48:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y1-v6sm10658616pfm.87.2018.05.29.17.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/35] commit: add repository argument to set_commit_buffer
Date:   Tue, 29 May 2018 17:47:47 -0700
Message-Id: <20180530004810.30076-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of set_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c  | 2 +-
 commit.c | 4 ++--
 commit.h | 3 ++-
 object.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index 86d0dd73338..50808c0ff44 100644
--- a/blame.c
+++ b/blame.c
@@ -158,7 +158,7 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
 {
 	size_t len;
 	void *buf = strbuf_detach(sb, &len);
-	set_commit_buffer(c, buf, len);
+	set_commit_buffer(the_repository, c, buf, len);
 }
 
 /*
diff --git a/commit.c b/commit.c
index dda585025ed..667d4dc6cfd 100644
--- a/commit.c
+++ b/commit.c
@@ -249,7 +249,7 @@ struct commit_buffer {
 define_commit_slab(buffer_slab, struct commit_buffer);
 static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
 
-void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
 {
 	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
 	v->buffer = buffer;
@@ -418,7 +418,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 	}
 	ret = parse_commit_buffer(the_repository, item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(item, buffer, size);
+		set_commit_buffer(the_repository, item, buffer, size);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index 05b9eccaf66..a1ecd067ccc 100644
--- a/commit.h
+++ b/commit.h
@@ -85,7 +85,8 @@ void parse_commit_or_die(struct commit *item);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct commit *, void *buffer, unsigned long size);
+#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
+void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
diff --git a/object.c b/object.c
index 5b756b5184d..71dbd49b675 100644
--- a/object.c
+++ b/object.c
@@ -217,7 +217,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
-				set_commit_buffer(commit, buffer, size);
+				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
-- 
2.17.0.582.gccdcbd54c44.dirty

