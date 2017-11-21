Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9C12036D
	for <e@80x24.org>; Tue, 21 Nov 2017 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdKUPKk (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 10:10:40 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38333 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdKUPKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 10:10:40 -0500
Received: by mail-pf0-f193.google.com with SMTP id r62so10037397pfd.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nDTXk9ls3OzrgVbtAHkpXS86C9k+zoqorCKnYdjeXHI=;
        b=Kq0Errgn6wWe9nu0NrzrQhreEszgf57KI+4ZhdYBrFNJfq4pw043mzK1MCXMeah5K1
         biXpUP9mDNXBuGEKkAAdOPB9DyeTRowPAo/ellhysOb+qrOgY9fDQN7c4TcTIQTOzLXx
         IcMrFpOGVHlHlM6zhh0KPd22CNq0ArBwLOrtWtgBrw4Djzkj/RTv+fRDw5fhQ/GdIlXp
         +QZNX/IhPPLkj2ztUflKRrzr3c56N50ezb5OrxNNoaxX/vukTyCSOrPc+DLAUONoDzeb
         5Pem1ur5b4u/9NoiLGH+9oRG322AOt698b9WetCTTnLC2k2OyzWKNz0iMFC4bhnzDcMi
         rmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nDTXk9ls3OzrgVbtAHkpXS86C9k+zoqorCKnYdjeXHI=;
        b=DATFqQx3+7Km5NOxqCN4IkYCnEi+rCAli2elCJMKtHciyMBy13+/zVG8SL2uv70QwW
         xjdpusyxRq6oHLcoM4szuIFdpAcNHf2+AMpNwiPwgcX/gGCUn2HXq1kRPR9J0+FV1FPR
         tCab0/itSf1mZggmijUA9DqkYanUJ1eJ083L+x5U0sRqYOqCWrmB4p1Ind0FUFsE1M1d
         e8VdWi3dBwzwER9WvmmrINcZyku3U+BiTfNPEOxGHSvCm4eyQoy+GXlEtOUlPxEMqj1R
         VEKWjh+ipW7oL+JE8NhMjTGDMdbTFf3eQn3G6rvCBXfi/yVwv/heetDEE5qOAjiQv3wQ
         XdfA==
X-Gm-Message-State: AJaThX5Q1mo0fspwvEYhiHcX7SotO9BD9cnU+E0NU2Ys5x7UjAJGM3KY
        URMjVnq3PjU9pfRsQqJVK8o=
X-Google-Smtp-Source: AGs4zMYW4vCqFbYXsBnoYQjJREi3S3lC/zP5p/8jp4oE5LeSan3nFaqxVyDc/23nx072Lo+2Vjc1Jw==
X-Received: by 10.84.215.207 with SMTP id g15mr17594743plj.369.1511277039595;
        Tue, 21 Nov 2017 07:10:39 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7280:849f:7a33:ea78:e714:400])
        by smtp.gmail.com with ESMTPSA id l24sm11722251pgu.38.2017.11.21.07.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 07:10:38 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: [RFC PATCH] builtin/worktree: enhance worktree removal
Date:   Tue, 21 Nov 2017 20:39:54 +0530
Message-Id: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new feature to 'remove' worktree was handy to remove specific
worktrees. It didn't cover one particular case of removal. Specifically,
if there is an "entry" (a directory in <main_worktree>/.git/worktrees)
for a worktree but the worktree repository itself does not exist then
it means that the "entry" is stale and it could just be removed.

So, in case there's a "worktree entry" but not "worktree direectory"
then just remove the 'stale' entry.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---

Hello Duy,

I noticed that your remove command could be enhanced for a particular
case. So, I made up an ad-hoc patch "illustrating" how it could be done.
I may have broken something by quieting out 'validate_worktree()'
function, so take note of it.

You might add this as a separate commit or just incorporate it into
one of your commits if you re-roll your 'nd/worktree-move' branch.

Thanks,
Kaartic

 builtin/worktree.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b5afba164..f70bc0bd8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -605,6 +605,22 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	return update_worktree_location(wt, dst.buf);
 }
 
+/* Removes the .git/worktrees/worktree_id directory for
+   the given worktree_id
+
+   Returns 0 on success and non-zero value in case of failure */
+static int remove_worktree_entry(char *worktree_id) {
+	int ret = 0;
+	struct strbuf we_path = STRBUF_INIT;
+	strbuf_addstr(&we_path, git_common_path("worktrees/%s", worktree_id));
+	if (remove_dir_recursively(&we_path, 0)) {
+		error_errno(_("failed to delete '%s'"), we_path.buf);
+		ret = -1;
+	}
+	strbuf_release(&we_path);
+	return ret;
+}
+
 static int remove_worktree(int ac, const char **av, const char *prefix)
 {
 	int force = 0;
@@ -634,9 +650,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 			die(_("already locked, reason: %s"), reason);
 		die(_("already locked, no reason"));
 	}
-	if (validate_worktree(wt, 0))
-		return -1;
-
+	if (validate_worktree(wt, 1)) {
+		if (!file_exists(wt->path)) {
+			/* There's a worktree entry but the worktree directory
+			   doesn't exist. So, just remove the worktree entry. */
+			ret = remove_worktree_entry(wt->id);
+			free_worktrees(worktrees);
+			return ret;
+		} else {
+			return -1;
+		}
+	}
 	if (!force) {
 		struct argv_array child_env = ARGV_ARRAY_INIT;
 		struct child_process cp;
@@ -670,13 +694,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		error_errno(_("failed to delete '%s'"), sb.buf);
 		ret = -1;
 	}
-	strbuf_reset(&sb);
-	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
-	if (remove_dir_recursively(&sb, 0)) {
-		error_errno(_("failed to delete '%s'"), sb.buf);
-		ret = -1;
-	}
-	strbuf_release(&sb);
+	ret = remove_worktree_entry(wt->id);
 	free_worktrees(worktrees);
 	return ret;
 }
-- 
2.15.0.345.gf926f18f3

