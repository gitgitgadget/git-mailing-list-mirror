Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901251F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeBFAZS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:25:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40219 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeBFAZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:25:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id g2so171203pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ltv7JyBSGpYppGgbCYpypGF7Pl3XdeyFlB35/u1BpIo=;
        b=Rx7viay5nsP+UYzdtUjfPFY8UP2fkpmfP7fIgyK6lgTguHfzzAOx+1gwWC61SLxNRd
         Eh1vB9mG4GZDMJzu1BBFU4StT2Z1H8dFHMM2wmEPGQiCPMbldeT8XktFtJnUJACoVd8q
         ObCWOCqNtSWficbadauMyjXFTRBq6ywe8IlsRzvudz72zZn65+jg90Zof0wCr7Cbs4bD
         ni9YjWA3FHnjS5sFbBck9cMTuDXYuSBH5HWXx9wtJjlR4eRLs0to7YYn2dtsmw9TZ1ZO
         tR7CzlODooJNLn6SYWy2PCH/ksWK52DdpiNmcPQKOMuJk2etaTL+O63Xuk+FZPkFeyMB
         hIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ltv7JyBSGpYppGgbCYpypGF7Pl3XdeyFlB35/u1BpIo=;
        b=BfvjrhVPo8M4zBGJfq9XU7O2iMEfOG3BIEorc5q3BwUpGltpfxStj1UBYztplsot+x
         3KMin2Hpo6HhEgP+mV1vNCQnwitLSdIUPOvGyLoydJaMAMQw2KaZAn7Zr8fctyKZ+QDh
         y6yfgrcl4ARJo/jzfPFzela2ip+PPoCSauyqgRUiWMfvjqNV8IRxX90ankXgvS+IK07d
         vK7kkg3/iOjY6LCLzKuh4AlvGbvfSBxkHm/wSl10EmWzD0yjjgWL2nyOHhVt5SKXe468
         oWT4auXDfikNGhkPwSgwIYG521fHgqjNDleZ4/8mDWkmIu2CKLBvGCeTIgyXQ5enZuDB
         X7KQ==
X-Gm-Message-State: APf1xPAg6T5T5zyQHYxF46C4cK2Bj8PbFGQqC7Qm6J6nHgXa4dBsyFSf
        Ztji/CB0/zWnjLWcsgJ/Je1kNAQf+jI=
X-Google-Smtp-Source: AH8x226TS1v3wB/kShZrPRPCEj6ZrykMPdcRpDMj7op8Bab68HC0fqPv/CdXHax94VvE0x6gmBP8ig==
X-Received: by 10.98.8.206 with SMTP id 75mr563159pfi.172.1517876713392;
        Mon, 05 Feb 2018 16:25:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i11sm13851858pgq.34.2018.02.05.16.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:25:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 145/194] commit: add repository argument to set_commit_buffer
Date:   Mon,  5 Feb 2018 16:17:00 -0800
Message-Id: <20180206001749.218943-47-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
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
index ccd6a5097b..1cd39e7a17 100644
--- a/blame.c
+++ b/blame.c
@@ -138,7 +138,7 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
 {
 	size_t len;
 	void *buf = strbuf_detach(sb, &len);
-	set_commit_buffer(c, buf, len);
+	set_commit_buffer(the_repository, c, buf, len);
 }
 
 /*
diff --git a/commit.c b/commit.c
index 49c8f76e41..5de78c73fd 100644
--- a/commit.c
+++ b/commit.c
@@ -250,7 +250,7 @@ struct commit_buffer {
 define_commit_slab(buffer_slab, struct commit_buffer);
 static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
 
-void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsigned long size)
 {
 	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
 	v->buffer = buffer;
@@ -408,7 +408,7 @@ int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing
 	}
 	ret = parse_commit_buffer(the_repository, item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(item, buffer, size);
+		set_commit_buffer(the_repository, item, buffer, size);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index 16203fb18c..d3ec52d1c1 100644
--- a/commit.h
+++ b/commit.h
@@ -79,7 +79,8 @@ void parse_commit_or_die(struct commit *item);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct commit *, void *buffer, unsigned long size);
+#define set_commit_buffer(r, c, b, s) set_commit_buffer_##r(c, b, s)
+void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
diff --git a/object.c b/object.c
index db15de6623..7d848b5b7a 100644
--- a/object.c
+++ b/object.c
@@ -215,7 +215,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
-				set_commit_buffer(commit, buffer, size);
+				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
-- 
2.15.1.433.g936d1b9894.dirty

