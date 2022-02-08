Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3701BC4167D
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376916AbiBHNOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350242AbiBHMO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE50C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id om7so2864222pjb.5
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKtDBI+EUQhE6MFFnvjFiseJ/0q3yxKWPgE7iZBevkM=;
        b=jvaRI64tbINqK3oRjzxs2lq323sRsl2+QvVUU+/0heuY44fZiukkBLPOZT18+rmj+s
         pM3/0wEt9oO89Zd/7zZ4DqSE1wMbj+zdxkFbtGTQwNBvsLkD3h9SrskrZ0z6bVV0Nf4V
         RBhr+mJnTxiG0CSA5raH3ZcV2YrDRVKmoo9HaP9RjVD0xDhTvM2JM8sEcetYPX6KHvBa
         YNLqbr/IEHxAhIxMAVfhF9gYTOHhbKZSAIRdwy6F0ZpGrRwrnge88e7SNZsP4tt0zjnG
         DYscCjNuSAFO+6icd1rM4XdjZsfba8WdUAzy6A122U5qkhcGF02/4WTnw4lWgoQgr79I
         f8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKtDBI+EUQhE6MFFnvjFiseJ/0q3yxKWPgE7iZBevkM=;
        b=3LPS02dhRlGdq/elvl3mHGOHqU98Jv0qPCKqFCnLHyRWpATt0o4kKRzxHx9XfIaFCc
         seIEvMzoOxQqhS33HcT1lri7Xwvdez5AHS59IQcm2yi4N1w94s8pgNFFaN/J2oLiGSNG
         dWRrIj624jv4o6wNvLdTEB3Xl7nPCbZiPb3Jjr2YAsIlXA3PnJWYHDxUNdcLxPYdOtJh
         Mvvr86S4kJTo4cTmzmlOQ9LBry7YaRipo0wzfw/OYGfWFBy0cT9BIY3RabPUlPO20ts0
         tFmhbwSlaV+CJHdKZR7o+2rq4T6TOdWex701ZP4Ohft/yLrcxmwDKZUJya333itnGr3s
         qUTg==
X-Gm-Message-State: AOAM531Yx8cdhgMKc8z2xRzKaag1O11R3obzLJSx39RjlpJSAuqGvYnN
        qk1yI6qJsBhC/qD3YNhyQaE=
X-Google-Smtp-Source: ABdhPJyn6kywfLpD++4Mro+bkz4yBWDbJzJ3KLfb/0zKX2ZeoOBx75VkWgCWqPqQnGucT/TPf5Vnow==
X-Received: by 2002:a17:90a:2e0a:: with SMTP id q10mr1062568pjd.130.1644322498709;
        Tue, 08 Feb 2022 04:14:58 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:58 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 05/13] ls-tree: rename "retval" to "recurse" in "show_tree()"
Date:   Tue,  8 Feb 2022 20:14:30 +0800
Message-Id: <99e6d47108308b0bbaf406b439170de04e375c56.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. The commit rename "retval" to "recurse"
which is a more meaningful name than before in the context. We do not
need to take a look at "read_tree_at()" in "tree.c" to make sure what
does "retval" mean.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..ef8c414f61 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -64,7 +64,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recurse = 0;
 	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
@@ -72,9 +72,9 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			recurse = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return recurse;
 		}
 		type = OBJ_TREE;
 	}
@@ -109,7 +109,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recurse;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.34.1.403.gb35f2687cf.dirty

