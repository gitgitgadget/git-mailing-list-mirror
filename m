Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C222A808
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751848; cv=none; b=Nk5pRYnnzadNtYVDy427T52rLGRTBK0M9oW5hCGkZjg81Y3pIfEbrDEcONZcCIpYjnYA3Je1fkhmMKUxBVvmUSuUD0vbQZnmXH2s8VzIRxogu3/pa9+N2rqXY8kBnA13rxhAl92NNd4MJg96DCWhh3clAXkvfzzgQ9/DNOLECSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751848; c=relaxed/simple;
	bh=5rAJgXvsapit/HkKz+3m2LAra9/zo3RCJAGgWeOoa7I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fbODbtKqVnM+wHGzjn3ecwnqbFR3mZS5eVCWNIVhwgteAyDn260m7xt810NqIr0mnwrZ7kXjo4hz613HAE27w3NsUQRDqZBo72Hm0YGueDxpfdxY24JsRVgDBv9Zz9XGviK37nksBKwwdaSNZiku9OrByk40uYcvRrMxXT50aUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbbpapul; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbbpapul"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab744d5e567so150093366b.1
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738751842; x=1739356642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3khEsYN3K1B7E8YmS9p1u7Wl4uz09XaF8MuLLCNRF5E=;
        b=Fbbpapule4vqhyBIpoasj3uIxIxBDr6dA0rCZLEavLSRC05VNt+4kO7lWWqIAu3TNQ
         xf505AzU3T8I2oKDaTxZBJjC9iuiWSWYFS/sVrMup515ISw6YyRexwiESbwsTcg4rEY3
         two9uC+XtsCbxqdSkVKeudPqij66pq1viDHJZnGaLnZPlnUnSvzK5Ejnorj/hhVrcsCW
         rznjnRni99R0VY9aHONHvsHx0Bjr+yzVejrYNm7o5WvB7LKrsBs6UR4LhcoeTf9CiJ+r
         eAhK1FMeYMJ0jCEChim1n+9lwDUwc45IL+w/c9h6aOCopl+iR6S9fv4o76HFWYRBWAtu
         0g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738751842; x=1739356642;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3khEsYN3K1B7E8YmS9p1u7Wl4uz09XaF8MuLLCNRF5E=;
        b=R5XAyjtJxL4XUI76icppXkXhry3zeFLhEXdhcP8x7Aq4j2NQBnAQTfDDZ8Tx0d0SFc
         rxxn74q6AoSTJeUfXPEUqMiSUu4laxYsIjhMmvcURVQCHn7Lt314BX+a54jKY7dxonL5
         /i15sIK9H52MzRE/19KaEpAm6PInzU0ck89nrujhE6sZ2G84ZEEABvEUkqFHDhZjBlem
         SGh4GI0G9whHBLUMFW8c/2r8+muk8Hu91x4VbvKhSNJbI+j03i2oxmXYlhVmagRqmKzc
         mhgpmhDNw+8Jrm2/tcDLs7eOsl6Q+wYJ0Sl5IuBdSjeyPCbReTDlp+nS+iASmRgoVwGo
         rM4w==
X-Gm-Message-State: AOJu0YwQWChssUUDPvG+naM+RUFihyqY96Pfrh/xtCg/Whn1FKnaDQXu
	UAFepPCFYMwQtOGWyRQtllll7YXFkH/m8uoUUFldyCANLGm6/Y24aEx6HQ==
X-Gm-Gg: ASbGncv09Ao4KQTQ87/1s3Oa4AP87QGXjwFx+E1BP3Zn5t2GB6TE26r4bB6sKoM31Vv
	0ZrVPVF0Z5hdWKQ0txRGfKGO+IKprIK/d2CksKJI5BhGn6wrd69PdtjQKkKkF4HTvV02TLa5zAG
	TsNtDkuFt7xKPoYBoXhnR+/ugaOwiPXfuMfQjj+IHX3STiKPoMWrebTKzX24X0KckFtxMElyj9R
	T3r3raioCUwfUIc/eYF43gTJtVJ0Wz3fje8nhgBIjJieDsEaewABp4sExImNMuNDc2HQAX3+RVu
	0EosA9xSy9N2eHoZ
X-Google-Smtp-Source: AGHT+IF+BlZUbstxLf6BGEAnEFo1wuRdE6ohFpEwQy0GnDzzLPrV0FNDqmtLWzVrIQzO0STYifL6Tw==
X-Received: by 2002:a17:907:2ce1:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-ab7483fba47mr688390066b.8.1738751841939;
        Wed, 05 Feb 2025 02:37:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab75f70ac64sm89000866b.99.2025.02.05.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 02:37:21 -0800 (PST)
Message-Id: <pull.1860.git.1738751840816.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Feb 2025 10:37:20 +0000
Subject: [PATCH] rebase -i: reword empty commit after fast-forward
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebase rewords a commit it picks the commit and then runs "git
commit --amend" to reword it. When the commit is picked the sequencer
tries to reuse existing commits by fast-forwarding if the parents are
unchanged. Rewording an empty commit that has been fast-forwarded fails
because "git commit --amend" is called without "--allow-empty". This
happens because when a commit is fast-forwarded the logic that checks
whether we should pass "--allow-empty" is skipped. Fix this by always
passing "--allow-empty" when rewording a commit. This is safe because we
are amending a commit that has already been picked so if it had become
empty when it was picked we'd have already returned an error.

As "git commit" will happily create empty merge commits without
"--allow-empty" we do not need to pass that flag when rewording merge
commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: reword empty commit after fast-forward

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1860%2Fphillipwood%2Frebase-reword-empty-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1860/phillipwood/rebase-reword-empty-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1860

 sequencer.c                   |  5 ++---
 t/t3404-rebase-interactive.sh | 14 ++++++++++++++
 t/t3430-rebase-merges.sh      | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 407ee4e90fe..763bef1c898 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2510,9 +2510,8 @@ static int do_pick_commit(struct repository *r,
 		*check_todo = !!(flags & EDIT_MSG);
 		if (!res && reword) {
 fast_forward_edit:
-			res = run_git_commit(NULL, opts, EDIT_MSG |
-					     VERIFY_MSG | AMEND_MSG |
-					     (flags & ALLOW_EMPTY));
+			flags = EDIT_MSG | VERIFY_MSG | AMEND_MSG | ALLOW_EMPTY;
+			res = run_git_commit(NULL, opts, flags);
 			*check_todo = 1;
 		}
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ecfc02062cd..2aee9789a2f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -791,6 +791,20 @@ test_expect_success 'reword' '
 	grep "C changed" actual
 '
 
+test_expect_success 'reword fast-forwarded empty commit' '
+	git commit --allow-empty -m "empty commit" --only &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND=edited FAKE_LINES="reword 1" \
+			git rebase -i HEAD^
+	) &&
+	test_commit_message HEAD <<-\EOF
+	empty commit
+
+	edited
+	EOF
+'
+
 test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
 	git checkout E &&
 	test_when_finished "git checkout @{-1}" &&
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 2593711fecd..b84d68c4b96 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -610,4 +610,24 @@ test_expect_success 'truncate label names' '
 	grep "label 0123456789-$" out
 '
 
+test_expect_success 'reword fast-forwarded empty merge commit' '
+	oid="$(git commit-tree -m "D1" -p A D^{tree})" &&
+	oid="$(git commit-tree -m "empty merge" -p D -p $oid D^{tree})" &&
+
+	write_script sequence-editor.sh <<-\EOF &&
+	sed /^merge/s/-C/-c/ "$1" >"$1.tmp"
+	mv "$1.tmp" "$1"
+	EOF
+
+	(
+		test_set_sequence_editor "$(pwd)/sequence-editor.sh" &&
+		GIT_EDITOR="echo edited >>" git rebase -i -r D $oid
+	) &&
+	test_commit_message HEAD <<-\EOF
+	empty merge
+
+	edited
+	EOF
+'
+
 test_done

base-commit: 58b5801aa94ad5031978f8e42c1be1230b3d352f
-- 
gitgitgadget
