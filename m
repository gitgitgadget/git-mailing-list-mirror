Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7681F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935994AbeFMXG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:27 -0400
Received: from mail-ot0-f202.google.com ([74.125.82.202]:55689 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935906AbeFMXGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:00 -0400
Received: by mail-ot0-f202.google.com with SMTP id b1-v6so2453079otf.22
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kAX6zHxiNIxFxehkTK24D9DJr39Rz8WtMJgeYcn4Idw=;
        b=QiJDdUbUATdRd/eGm/nXaEixtodqbvcy/8hEiJ7aL+k0lz+X2dHFmBsMIElmpOpVDC
         6gIXTSWNG6oSTAnCUL43i4qK8gVYVntoxqvWWSABhdefJJ0LCbMR4lrhoR3CSFoz9NUu
         E0nS13LEUcYxxQ70AO57VHbY4sbGNN23D2/6QsYuWfsg8koSPxaNEv9TnywqwMLLF9fs
         AvETujxmgAnlyQ4Ikhj8dblPW/+++Z6UpiEeH7qaPtwplzjEjb17v0kFjmIeJSnsBRdV
         VeeYTawMSLDpU6eGU9lJpl3J3uhnTg+GATD3Es2fNxCmWyrx3GnQdsGJpdeOwZSgAmbr
         lT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kAX6zHxiNIxFxehkTK24D9DJr39Rz8WtMJgeYcn4Idw=;
        b=ZvK6pobngs+A/1/+jMn5SMbo0FHfCpoIiAZkqyDTHzZCz7s+SPjbsexEXtaANBFKtr
         JdWNnKjvEqUDxvInam7gkcrc3jD66KBslGf/eNCNQ6/Jzdv2Q5i2Mn8f3fMtlhA27xTU
         hZnkR1+0UCrZdE1phyD9nTeLMrGiU1Ng6bKzjsPA9fmUBNJyGOy954eU6TRNEv9wNNpF
         /LJ1y0WdqbuCqQXoatfVjwbRHxkX00r9Gw6iR2sNrLIOd78/qdpm+jsxzt/DvTZiDvvb
         c9xeMZOrEgI5D0mKOxdeH6XJj6USWHWszrjvJxz5LVclVYvZVz0uCQSAn9AGPC3Rm2OW
         LB+A==
X-Gm-Message-State: APt69E1gYvZukeoxwA0pGLlBogHjpvQKLbfxjU35dy3dXcY2ODwRfdnr
        DRuYQfltiJkz6YlBhkwh7ZVtJEQBqHxPPDwWS8OAw0/l+Kn1KU9rlZYdu0X7I+VN9NYxP6YpJoX
        Swgv8s6JdLbcclpt6zJ0N85Je7FQXqYgE3r0avu7HwNX0nzbYVva1LhpPEuaD
X-Google-Smtp-Source: ADUXVKKhCB0kE2ZTfcFh+8sCKAWJA/DmNGwexgor7tUpwzTnN6TeA9It0r/y6hDPAtErBkb4DNLlH0TYXu6s
MIME-Version: 1.0
X-Received: by 2002:a9d:7415:: with SMTP id n21-v6mr65246otk.117.1528931160190;
 Wed, 13 Jun 2018 16:06:00 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:02 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-12-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 11/31] commit: add repository argument to get_cached_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of get_cached_commit_buffer to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 4 ++--
 commit.h | 3 ++-
 object.c | 2 +-
 pretty.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 667d4dc6cfd..ba06918ba41 100644
--- a/commit.c
+++ b/commit.c
@@ -256,7 +256,7 @@ void set_commit_buffer_the_repository(struct commit *commit, void *buffer, unsig
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer_the_repository(const struct commit *commit, unsigned long *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (!v) {
@@ -271,7 +271,7 @@ const void *get_cached_commit_buffer(const struct commit *commit, unsigned long
 
 const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(commit, sizep);
+	const void *ret = get_cached_commit_buffer(the_repository, commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
diff --git a/commit.h b/commit.h
index a1ecd067ccc..66eb576897f 100644
--- a/commit.h
+++ b/commit.h
@@ -92,7 +92,8 @@ void set_commit_buffer_the_repository(struct commit *, void *buffer, unsigned lo
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
+#define get_cached_commit_buffer(r, c, s) get_cached_commit_buffer_##r(c, s)
+const void *get_cached_commit_buffer_the_repository(const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
diff --git a/object.c b/object.c
index ff0ba98675e..ecaac5c2990 100644
--- a/object.c
+++ b/object.c
@@ -216,7 +216,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 		if (commit) {
 			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
-			if (!get_cached_commit_buffer(commit, NULL)) {
+			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
 				set_commit_buffer(the_repository, commit, buffer, size);
 				*eaten_p = 1;
 			}
diff --git a/pretty.c b/pretty.c
index c99f8243faf..5b139775eac 100644
--- a/pretty.c
+++ b/pretty.c
@@ -630,7 +630,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(commit, NULL))
+		if (msg == get_cached_commit_buffer(the_repository, commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
-- 
2.18.0.rc1.244.gcf134e6275-goog

