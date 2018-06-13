Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF671F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936000AbeFMXG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:28 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:40284 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:56 -0400
Received: by mail-vk0-f73.google.com with SMTP id y200-v6so1627004vky.7
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DDrfRPpIqQxjohg0EE9prfuLpAKH7d7G08BUkSnFezM=;
        b=KxFTvLUUKh/FeYG6gNu50nJfJAfYILqsqCOTlB2ZB1GkO9CovlU3DkhDROcIkPJ6P0
         Op5b31gtSO5uyF2Wh2J600kCxDj9Qh3vUHMgw1j8vg4jzlaTRTV4AvKTigxpaaRAWds1
         VUPcPHakZHdX4RtgJmuUC5kEZRFXd/m4qI6PNd5BvZC07rCrD8jOTNHmH9uudju0wUVb
         ZJzAhlCrxYP3YiQEIV4g6yJrGBhuqL8dgFBabXc5/gxynyhQ6ACsgjhq4KL1SgW0E/Q2
         WEONx67Vln1848LbOGUOspY7JfDbuMMo/GHQYWOAC9WpqRhmyo++ahCmGXv/ca0CRB+r
         4Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DDrfRPpIqQxjohg0EE9prfuLpAKH7d7G08BUkSnFezM=;
        b=f9rQ9//+CLIamu03ny/FXFGZ7BXcu6+DQIKwBf2rCNqkb2gjj2VT9Iw8DH9yI9pBQz
         3nU1oLi1h4MjnDaC4EMMJ+4LP3KkY7DA+xk7G4BmgZ1QiRcOTeKqSXUMu7YzGPxwhZMo
         wSR/muDZin7kjg0cD9r9hMS1Y20TZgIZDmmx/I+wVlct1ESTEwsurNntjXHuH5cMXeoj
         QTMjyLwMKulwq2rDf66Vq+8YZ+pk58V1HD/99TnQ7Hpgw9CDOgvphufRTzZ6aFNrwDNP
         O/qF9xMIsALpQ5ewdKVIQT3iJERD7FTvs/rBTDhY4cZGNPiExsoH8TJpS4bo+J8pGffh
         AtLw==
X-Gm-Message-State: APt69E0ItiPHkJlb3Als/FFriM9LRB02kKV98sYLi4Bn1i581ieQNeYl
        Gn57pxQr7uTWYRH2Dggc/+5n1bPuTWqYpg/cSWN/HehUOSGXRLkK7OrkLtyuUlw5sF97kWjHp7w
        EkU7c+gKJgV3bzDou3NHm+3lBKOFUrT1rvnSN6WRg+kkzmv6UToDfsiocu7oX
X-Google-Smtp-Source: ADUXVKIDuCPO2lhLWwNnNKOTordlS5iHudkzV9rAGdpbdEo7clnRHqjj0MB86VppZ/3tA5trPDBZA47Qugdk
MIME-Version: 1.0
X-Received: by 2002:ab0:2146:: with SMTP id t6-v6mr91013ual.6.1528931155371;
 Wed, 13 Jun 2018 16:05:55 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:00 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-10-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 09/31] commit: add repository argument to parse_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_commit_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c    | 4 ++--
 commit.h    | 3 ++-
 object.c    | 2 +-
 sha1-file.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 5e3f18801a1..dda585025ed 100644
--- a/commit.c
+++ b/commit.c
@@ -334,7 +334,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -416,7 +416,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_commit_buffer(item, buffer, size);
+	ret = parse_commit_buffer(the_repository, item, buffer, size);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
diff --git a/commit.h b/commit.h
index 431a7d97a24..05b9eccaf66 100644
--- a/commit.h
+++ b/commit.h
@@ -72,7 +72,8 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/object.c b/object.c
index 4eca16f4adb..fe1f84f7c6c 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
diff --git a/sha1-file.c b/sha1-file.c
index f66059ed7dd..00b1b2b8660 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1780,7 +1780,7 @@ static void check_commit(const void *buf, size_t size)
 {
 	struct commit c;
 	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(&c, buf, size))
+	if (parse_commit_buffer(the_repository, &c, buf, size))
 		die("corrupt commit");
 }
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

