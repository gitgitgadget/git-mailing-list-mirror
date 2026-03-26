Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1337E2F9
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534657; cv=none; b=b5gwnPkbd45jrTKSecAvpbNMtv3Z+P3jNfRtp4kQ4V0JLLacay13X6rUQG87tmQCSX7yOr8RC8+4D4CZFp5g5KWCXALKBzyJTmN95xzMPjdzgOBof+ubim3S/jBJ1zNtOYjpX0yJpguBeGpJEi5nnbr745ZV4EhgTMqeiXlzYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534657; c=relaxed/simple;
	bh=WKuhoHAHFUr6l+Us0qp8tSRmTMqkVK9Rc4OYJ6hE6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YncNfb5GX8rmwyy6PZlpIZ4lNYbydqJ0rrJOuO3VEXXkzyXR73Ln3y/Ae++wQdodsOvCNDQHoMLjXTktK1zdTQy4039SS3W8QgXBHKAygYNY58dYRQL9IELtS5Ae7CbMzJ4gnOnG4qOypgRVW3oPYtPzveCAKHdhrsBIbDcNqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6fl6voI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6fl6voI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486b9675d36so9829835e9.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774534649; x=1775139449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Or1dZt+Y2ygOgdPCFzklhJS64rKdyBFGCD9z67IXa7M=;
        b=J6fl6voIsr8iAr6jyH9wWE3uhRDyXKmuZYLRSYz6gNxnPgQ45N6IkkzhnzINCi143Z
         r/YGYhHCkSo4UkEEuQTyQsAIJ63ZdEkekNFV+maJY7wzkVkx2++E67cwu3RL57GKNFSE
         la6FQVvKha7yV5XAy1NpR4X2iuNbtxyBVP1TwnRSZdvL4ndNJ0mKB6EAhzcbTHy0lnUF
         ceDD+KyBfo2vyi9iA6IG4rYc8kYsSO21EXGnzGXyU/fePwuiBiiXWlR02j1rQI759EmK
         0+05esBY7wcD6z/6ee1QmZldr4+z06xyfgJfE4YtRS4LFXku/JfWzFAGK9LzrAC2sFjg
         G+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774534649; x=1775139449;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Or1dZt+Y2ygOgdPCFzklhJS64rKdyBFGCD9z67IXa7M=;
        b=D/YBFrqylmF3+VAE4Ldn0B7lhj2Jks7+3rCob6F1BdA82QXwcFnYD62AhnG3ERIbrP
         C/zIKtkpmT/sTsj0ff85/YOooB8spy39/xy1po3AIdU9WihyWRXEGcBygqKjS73XKoYB
         AQhHnZIV8CuqQvd4ETsAWktjI2BGaJW3x7c02ODC2b0uYr3S1SYUSRMsWWVSDc5Klro7
         kAxN2fMsLNYIBDHwBAmZCk7IM0xByyz9334b8ch7nZX5B+b6fBVAbvpwDn02NMTNs8X7
         l/cXgHOsyh7x8tFEMZb5JGe4s7EIR4NRJplQx5b/tSxttFEhtncY6Px22CEYcvzUJB4G
         Df5Q==
X-Gm-Message-State: AOJu0Yz5I4g/u8zXpjqU0MtIMWanNpAnefYU+2MElCaQ6HGXZMi9kMJY
	i26G0HuJcq/cWbsIlYInFm1efqzq2kZemms0FZ5V0aDip43tsowBLVmaWKaWvg==
X-Gm-Gg: ATEYQzwkMQWadq063I8d9NrL6zJQLwRRpp7ubiZkuirz0XEfXGdRPuzxynVGbyje+fE
	26cT0vm38rm6hrI6PS9eqnndiK5fp2vx99MLGomEUuxv2I9foa7PsJizFcqJv/ASQC0dNYIKzSN
	vUcE5VfcTQVUJeFDCldhxnyOdsN/P4Xk4gZKqSy2LaupRLoa3TySo9FJmRQjY3d0Oot1YXtfz+9
	DsonAeAVB/Px/d0bHdhxRBQXecENafNw5r0iclLWIsLf9drH+lgJ4qg9dLCQl+Zuunv04tww19O
	/M9gEmwQBx/YQ+JHm5jPQdlOwmw4/bD0hC6OtXBCseA2348kv5i98FY9YCD/pVMGqFqRzVolByY
	7RQ/dW/9+KFM6Nq4i0ykp2YV+dwuHe+tqZVwnw53k27sLuzitH+Leo3oaKXaFIHESjt2iVpNJyb
	pZYu20qSrTLWT0st+5Ijkhv3pd7DE=
X-Received: by 2002:a05:600c:1d0e:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48715febda2mr115612525e9.15.1774534648438;
        Thu, 26 Mar 2026 07:17:28 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720901b90sm15507775e9.17.2026.03.26.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:17:27 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/3] worktree add: stop reading ".git/HEAD"
Date: Thu, 26 Mar 2026 14:16:58 +0000
Message-ID: <4d50e6bcb2e5899f9f14b878bb9cca1c12cc5119.1774534617.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9.dirty
In-Reply-To: <cover.1774534617.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk> <cover.1774534617.git.phillip.wood@dunelm.org.uk>
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
index bc2d0d645ba..9170b2e8981 100644
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
+			warning(_("HEAD points to an invalid (or orphaned) reference.\n"));
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
2.52.0.362.g884e03848a9.dirty

