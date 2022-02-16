Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD31C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiBPK4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:56:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiBPK4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:56:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14564C2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k1so2769995wrd.8
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+f0ihd+Et5mJJpDa9qgkZzSzrTEAgRRf2dbaRmc4l4=;
        b=jbtdzFWBz3torgBB3Mzv016GZekWeAsgdwxeHRhyDvpDvuayRm4LyaELBBnSGDCXq+
         PQiLs+L+iyMriyWyrEZGCgUV80urWago21cjqwNOOR7YrzsGJdNlWbjS0/OowBH351hB
         Ij3m9iMsU4qR2VKuqKmulk2aJs1nAFT8A1PkLxaap5mx4qXQWIux3VbnsXR8eHAXwuAH
         XSBHjLWVEzJgnJEmvhRbK/VlSygRpIA7mmUvSwszOe+baEVHwhzIrIQdDWGv6vmHXAtA
         EvKa5ume/lQWSlId7R0HA3Yw6KSYy9Wcet8cm6SyPohr/U1lOKR5/P37TkIUtuw/u1I2
         qrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+f0ihd+Et5mJJpDa9qgkZzSzrTEAgRRf2dbaRmc4l4=;
        b=YREljpvFEHGQFsuFNfDfTtE1/4It+/HtDBrBIyO+x1ZUeuS9lIUupnIfWRk4UQnMlq
         8pmjSS4fW/GydjSOAvpV1VxljGYvSBxh1Gt/xnu43/dmjKC9EguJYqa1JrsJ6vOXX2cN
         o5+bmEYYV5I7o1mLzUKe8fsy+3KCtVX3pndEK8TbN66qR/zX0hkXOpNNxXyHbBwG5XWO
         qVDYbMqrEKPui/3OvmyCnWndEJcc9jGF5X9lfTH49EWSkpwgOosOx+XRQ9r6HNpeixD5
         tzzrjuOGRZ7pPIQcAQc+zIfWJU6unLo3b+aO37JkL131uO13aA6s4Xg4Gf+hV6W+AwBB
         OJyA==
X-Gm-Message-State: AOAM531HC6q0eL3AWOl44c6saIuM6kiHALAg2Gx0UZZjztwqT0BJx6tN
        UK0ps7W+gKxHSZ3/zC2It9WVpEE4dn4GSg==
X-Google-Smtp-Source: ABdhPJwdVYzsgdqpwpemkkKaUkc1g1g6/5zMfL3PNLqp0u4M16QxFQhjY5LyAmYfmcKjrQ65Pf+W7A==
X-Received: by 2002:adf:f2cb:0:b0:1e4:bd07:ed68 with SMTP id d11-20020adff2cb000000b001e4bd07ed68mr1840997wrp.306.1645008994709;
        Wed, 16 Feb 2022 02:56:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u7sm27185370wrq.112.2022.02.16.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:56:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diff.[ch]: have diff_free() call clear_pathspec(opts.pathspec)
Date:   Wed, 16 Feb 2022 11:56:28 +0100
Message-Id: <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the diff_free() function call clear_pathspec(). Since the
diff_flush() function calls this all its callers can be simplified to
rely on it instead.

When I added the diff_free() function in e900d494dcf (diff: add an API
for deferred freeing, 2021-02-11) I simply missed this, or wasn't
interested in it. Let's consolidate this now. This means that any
future callers (and I've got revision.c in mind) that embed a "struct
diff_options" can simply call diff_free() instead of needing know that
it has an embedded pathspec.

This does fix a bunch of leaks, but I can't mark any test here as
passing under the SANITIZE=leak testing mode because in
886e1084d78 (builtin/: add UNLEAKs, 2017-10-01) an UNLEAK(rev) was
added, which plasters over the memory
leak. E.g. "t4011-diff-symlink.sh" would report fewer leaks with this
fix, but because of the UNLEAK() reports none.

I'll eventually loop around to removing that UNLEAK(rev) annotation as
I'll fix deeper issues with the revisions API leaking. This is one
small step on the way there, a new freeing function in revisions.c
will want to call this diff_free().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c | 6 +++---
 blame.c           | 3 ---
 builtin/reset.c   | 1 -
 diff.c            | 1 +
 notes-merge.c     | 2 --
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f1..e1ab39cce30 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	diffopt.flags.override_submodule_config = 1;
 	diffopt.repo = s->r;
 
-	if (do_diff_cache(&oid, &diffopt))
+	if (do_diff_cache(&oid, &diffopt)) {
+		diff_free(&diffopt);
 		res = -1;
-	else {
+	} else {
 		diffcore_std(&diffopt);
 		diff_flush(&diffopt);
 	}
 	free(paths);
-	clear_pathspec(&diffopt.pathspec);
 
 	if (!res && write_locked_index(s->r->index, &index_lock,
 				       COMMIT_LOCK) < 0)
diff --git a/blame.c b/blame.c
index 206c295660f..401990726e7 100644
--- a/blame.c
+++ b/blame.c
@@ -1403,7 +1403,6 @@ static struct blame_origin *find_origin(struct repository *r,
 		}
 	}
 	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
 
@@ -1447,7 +1446,6 @@ static struct blame_origin *find_rename(struct repository *r,
 		}
 	}
 	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
 	return porigin;
 }
 
@@ -2328,7 +2326,6 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
-	clear_pathspec(&diff_opts.pathspec);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index b97745ee94e..24968dd6282 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -274,7 +274,6 @@ static int read_from_tree(const struct pathspec *pathspec,
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	clear_pathspec(&opt.pathspec);
 
 	return 0;
 }
diff --git a/diff.c b/diff.c
index c862771a589..0aef3db6e10 100644
--- a/diff.c
+++ b/diff.c
@@ -6345,6 +6345,7 @@ void diff_free(struct diff_options *options)
 
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
+	clear_pathspec(&options->pathspec);
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/notes-merge.c b/notes-merge.c
index b4a3a903e86..7ba40cfb080 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -175,7 +175,6 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		       oid_to_hex(&mp->remote));
 	}
 	diff_flush(&opt);
-	clear_pathspec(&opt.pathspec);
 
 	*num_changes = len;
 	return changes;
@@ -261,7 +260,6 @@ static void diff_tree_local(struct notes_merge_options *o,
 		       oid_to_hex(&mp->local));
 	}
 	diff_flush(&opt);
-	clear_pathspec(&opt.pathspec);
 }
 
 static void check_notes_merge_worktree(struct notes_merge_options *o)
-- 
2.35.1.1028.g2d2d4be19de

