Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2381F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935909AbeFMXGC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:02 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:45781 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMXF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:58 -0400
Received: by mail-io0-f201.google.com with SMTP id i18-v6so3305966iog.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gQquLNY/CzmqDwTMb4DavbQbIiwo2iKUwH5OYtJCt7I=;
        b=JFSyD7njryFeA8pYtJijZQF/fiHmjjhAOj8hhXjJbp/Q/XDY2ib6kr+3xDwlfomZJP
         QgOfvgheGstr3yi2n8tZT3SuPxmKvqD3251c9Mt6uqyctUElym5ntLdIz9fK44tt5WO+
         zFcVrbZO+zWzhalFOkLJA6/TD4HR3QT1IZ6vI9gi0pBRIfCYqlTBdOqwqhMQCuDJzUpw
         67roT3bwbGW8EeFpZpOm5XkLWcN1fh0jPpLHRdYg6auy6QJj5pFqF8TbHe1yNFMcSKQe
         AZIhXSuIi7iafDjrwn2BG+W86TnIuu2LxhSnmDLlxT8mKdRF5Z8CJToxljRE+Pe9ZWaJ
         Vv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gQquLNY/CzmqDwTMb4DavbQbIiwo2iKUwH5OYtJCt7I=;
        b=RBVE05cqCWSyb2MEafZm3ZRl6PyOYanU0BCqsBGQJRfjGnhHFgKei1dOCXmfEkzYuL
         QZDCNfFinWlKWZd2Rs6CsR6hhSaqO7oUsKACQH2CxoulS9vTamfN9tkq2u+/zdSKEUiq
         jAermyWbr4hf0USlCQhJgFjSJBmhNnxWuibhbirviie7rtxhHXHCfArbm4QsbiGaUGb0
         k+4Yyoq9lDRje5z3NNuTPEioHo7HcG/KzEfxhmKKnhCq3JPW0F+8S3cfRnQ3suUPZl++
         Eq9wvCqtgVwMK5wJ63zcJzUDwMywmQ3GaV+cKmNEUgSml7gEH6/mtvmNX0rnxCZnPFTU
         iZuA==
X-Gm-Message-State: APt69E31fdpMYKKDE44AO2OHCYaANPyFviH+x1MkLwlwEaPi/e/XMBqM
        zoZ/CAj+dcm+IDCdkGJsTwZM/KVuZhKodUTZXgLd/eTBX1YlPEM369NEljVihUYAj1GylK2aQdw
        vpCg8Sd3HRW7hiVhfbE0UBlexQPFBnqR/l3QbxCILWeTCh+WLIgWCmsQfZED7
X-Google-Smtp-Source: ADUXVKJ83Aa3h52JfI+tuFcjUnwU78NFR/z86e4g8tADHNqnJg1jyijpoxS8zp8ET3jft0A1DHNwZc9hkFIM
MIME-Version: 1.0
X-Received: by 2002:a24:6f8d:: with SMTP id x135-v6mr41480itb.3.1528931157878;
 Wed, 13 Jun 2018 16:05:57 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:01 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-11-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 10/31] commit: add repository argument to set_commit_buffer
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index fe1f84f7c6c..ff0ba98675e 100644
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
2.18.0.rc1.244.gcf134e6275-goog

