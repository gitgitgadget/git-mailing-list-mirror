Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062939FCB0
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411609; cv=none; b=W9/tOTWjS7es1zK5ZVykw3y5FBSjgUe410UqWDBvRR4m2UB9uBJheOORndOblXuAuObUj+QClBVUownKU7GTadmbRTeII7cbs7X6EdSWtXMVAJz81VfHIbqyBsN8wippbmbm3tCEi+0FHpWrXPs8N9jG+YJeeAPBaH+2x0IT7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411609; c=relaxed/simple;
	bh=8vZsSpwUawXzJ5AmAj+n2l/SDP9CESYIajJ58Utq3io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Peupt0PG2ab7tgtSC1l/x4Fijmwgo1GgsNQB5XBd++r8vw3uk3qV3JW0QN7SZ2x+3+rusFmTxEq+utyAekR2DxCqeyAxv43wBI/3T3Uw8ffA6rgragkUsb8XX9eq4jjoLFxT0jpEFpWM5SjwAbgx01h9n7misFXbkonodlGi+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP8/q9fZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP8/q9fZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so2529788f8f.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411606; x=1774016406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VmPly3m3FVKGg3FInIz0k//FmljCkLEsxqfc8IxF6g=;
        b=eP8/q9fZAe+huPsvxCd1yjHtw6piSgXhg7A5/Yv+tJAzTKV3nFANoBGQLAT04XNl2h
         Qvw56/CnH0NRjwbbR9pF21nRO3Jum+TlWBtIUg5pFtmib4tw6TRioixpTrK5Mrv8UtYT
         V5PXXXPP100eosgCEgJ0Va1cH240iJzCLjtKbBnLDY68emxvt+uuSOk8IGMSPx7Hj0p/
         wHoBnWy6PTaySiD2Ux9H21xIwB0pEePgah2wkpmtRroFLhXIV6XZl8gCRpoDBgtJfx1C
         Rf4W3TkD1mwNKQpAFDj35XTC4IfiwxxfW3jWIm5FKNzAkbTiP2xYW8qhtcGr3hgv58AW
         ylGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411606; x=1774016406;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VmPly3m3FVKGg3FInIz0k//FmljCkLEsxqfc8IxF6g=;
        b=pCNwMyWtRsentrv1DoMRQW5c7Ogem3ohRAjmnx19Z6gFrargrwxzpkWqIrCZ/VkGxa
         3lRPW/hb9MGqP+WJzX5MXHznJj8+hr0DkxtDcvmIm01wTpp4WS6QkQMrmkBNTw1La+mF
         0t8RZ+a7sqGotNqyaGtialARcSMCG3lduoIDrMyYIMUkV9wBdatY3+IwelObgNGXutaa
         q4+OS1rDtzckQfjcupOOCGUKZG/PgseaKxQM2VnZCgICwaq+o/Qh66p5Fjg3RVR4x4cT
         YUHVMsAE0+jYFiKV1hookhsnnCDf6q1DvepvoWPwQTG9SGVzxPNnVjTEixw6H9XSXuQ2
         DGGw==
X-Gm-Message-State: AOJu0Yw4KBvZruRRAUgy5ffeSr7mrPmzuq4wJqx6OtcnTy0y9hJksvWU
	v5iU2IAOouuYKXnVLzJQWFH1pbL/YbQKsTnFqRsaFyGElV1p/Tmz8+PL8VAsJQ==
X-Gm-Gg: ATEYQzyTI+iFzUACMkAGZnNOncz9isaoGlgzzNFlAhVu6FFxZSfueW0EB/1uT3pbhXo
	NfrlY3WPjubwT7pzoYw5GrPvCEaHV1g50yAAh8C9/9cElsEKKcFEFH18Ed+oMN3+BofLjwayOiN
	LG9gYJCCer8Op/qSvugRnBOtn9ikNohmsoYW2b4gwsUIWtvb+OQJBj4NOQbsr8FS4iPELduu96w
	MMlHqPql25xbVkF0B8xw1BpCBmi09lHjG+8/6QvAujo3kEU6iyCNWjC64zoOFSArykNuc+SnuXE
	O4Gigu6BjfCItoUwmTL5hw3qFRtlDBpzTbP5j21aVhKSrvvs+S+ipQh2A+Lrm/rnzs78BLHZk3o
	M3EbQ0jN+7P6eq1uSF/0wRJv3UrID/lXmiR+Vkcg0Lz+KwOIQ1x4GMPhatFPkFz7O/YqYRrJBRX
	qlkFzVFEE1XzFeSorVTOvBSwNX8x0=
X-Received: by 2002:a05:6000:2f8a:b0:439:c81f:b96d with SMTP id ffacd0b85a97d-43a04dcbe5bmr6934232f8f.51.1773411605006;
        Fri, 13 Mar 2026 07:20:05 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm17215509f8f.11.2026.03.13.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:20:04 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] worktree add: stop reading ".git/HEAD"
Date: Fri, 13 Mar 2026 14:19:49 +0000
Message-ID: <ae2a368e7e783bfe9dd038bbb2e986e6d8540900.1773411586.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The function can_use_local_refs() prints a warning if there are no local
branches and HEAD is invalid or points to an unborn branch. As part of
the warning it prints the contents of ".git/HEAD". In a repository using
the reftable backend HEAD is not stored in the filesystem so reading
that file is pointless. In a repository using the files backend it is
unclear how useful printing it is - it would be better to diagnose the
problem for the user. For now, simplify the warning by not printing
the file contents and adjust the relevant test case accordingly. Also
fixup the test case to use test_grep so that anyone trying to debug a
test failure in the future is not met by a wall of silence.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/worktree.c      | 21 ++-------------------
 t/t2400-worktree-add.sh | 28 ++++++++++++----------------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bc2d0d645ba..70410b53df3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -692,25 +692,8 @@ static int can_use_local_refs(const struct add_opts *opts)
 	if (refs_head_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
 		return 1;
 	} else if (refs_for_each_branch_ref(get_main_ref_store(the_repository), first_valid_ref, NULL)) {
-		if (!opts->quiet) {
-			struct strbuf path = STRBUF_INIT;
-			struct strbuf contents = STRBUF_INIT;
-			char *wt_gitdir = get_worktree_git_dir(NULL);
-
-			strbuf_add_real_path(&path, wt_gitdir);
-			strbuf_addstr(&path, "/HEAD");
-			strbuf_read_file(&contents, path.buf, 64);
-			strbuf_stripspace(&contents, NULL);
-			strbuf_strip_suffix(&contents, "\n");
-
-			warning(_("HEAD points to an invalid (or orphaned) reference.\n"
-				  "HEAD path: '%s'\n"
-				  "HEAD contents: '%s'"),
-				  path.buf, contents.buf);
-			strbuf_release(&path);
-			strbuf_release(&contents);
-			free(wt_gitdir);
-		}
+		if (!opts->quiet)
+				warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
 		return 1;
 	}
 	return 0;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 023e1301c8e..58b4445cc44 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -987,7 +987,7 @@ test_dwim_orphan () {
 				then
 					test_must_be_empty actual
 				else
-					grep "$info_text" actual
+					test_grep "$info_text" actual
 				fi
 			elif [ "$outcome" = "no_infer" ]
 			then
@@ -996,39 +996,35 @@ test_dwim_orphan () {
 				then
 					test_must_be_empty actual
 				else
-					! grep "$info_text" actual
+					test_grep ! "$info_text" actual
 				fi
 			elif [ "$outcome" = "fetch_error" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
-				grep "$fetch_error_text" actual
+				test_grep "$fetch_error_text" actual
 			elif [ "$outcome" = "fatal_orphan_bad_combo" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
-					! grep "$info_text" actual
+					test_grep ! "$info_text" actual
 				else
-					grep "$info_text" actual
+					test_grep "$info_text" actual
 				fi &&
-				grep "$bad_combo_regex" actual
+				test_grep "$bad_combo_regex" actual
 			elif [ "$outcome" = "warn_bad_head" ]
 			then
 				test_must_fail git $dashc_args worktree add $args 2>actual &&
 				if [ $use_quiet -eq 1 ]
 				then
-					grep "$invalid_ref_regex" actual &&
-					! grep "$orphan_hint" actual
+					test_grep "$invalid_ref_regex" actual &&
+					test_grep ! "$orphan_hint" actual
 				else
-					headpath=$(git $dashc_args rev-parse --path-format=absolute --git-path HEAD) &&
-					headcontents=$(cat "$headpath") &&
-					grep "HEAD points to an invalid (or orphaned) reference" actual &&
-					grep "HEAD path: .$headpath." actual &&
-					grep "HEAD contents: .$headcontents." actual &&
-					grep "$orphan_hint" actual &&
-					! grep "$info_text" actual
+					test_grep "HEAD points to an invalid (or orphaned) reference" actual &&
+					test_grep "$orphan_hint" actual &&
+					test_grep ! "$info_text" actual
 				fi &&
-				grep "$invalid_ref_regex" actual
+				test_grep "$invalid_ref_regex" actual
 			else
 				# Unreachable
 				false
-- 
2.52.0.362.g884e03848a9

