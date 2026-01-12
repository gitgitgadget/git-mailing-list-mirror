Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05631A7F6
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200822; cv=none; b=WabPhAhGNHdINN/r8pQfDBwUwkz5Ud67mjKJbvM/d8DosghRleSp7i21KkxKYFlqv8TY0UFwtGaQGpn9kMtTBXBWkKicPhU9gXageKcVg4ZJPDcEOtMljPShZjDWlms3UidsVfnnVEesutzyMzI0+vAhkrWI3f0dEae70b4xUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200822; c=relaxed/simple;
	bh=x6L4jpkoBGsYVqDne/HGG8MRXwvdNHWoaP9UycDqfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEcbZrxSLATDxMmUgSrlcmbf45v1uUeg/uPayNhmDrYY5ZlPhH8qukG+5WQ08Rj6uZP9KwLzHk9BrNJxeWG6Aetv7th/ys07kL7LWtFfe4cnYJ9dlf60FiFnpdjLyiZVtDjfeJYLlSm5YSwwqEGaPgB1K0GpTgUqe60wNKjlb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhLA7pFT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhLA7pFT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0ac29fca1so40414295ad.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200818; x=1768805618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA3pjgULRJgvF7TCtASF+c3E2GVhUcRh6W4O9lav8ZI=;
        b=LhLA7pFTXnRLBrXXkV5+dEcTQVtNGy1+01ZvM+3oejwERT7zmh4Wiqp20CncB+v61w
         CxxGK5klKR1iN54ylf3hmyYJY9l4gECh+uvUR9I8EMxgRVmue2t3efXnv0R01NQeI6o4
         O8Vr15uh9HQLGh8XHLuirVFs9NCKVUXknIdMJSWBjMW5lOizl+Xw3sn0YL/QQcN62LBP
         QCq/kLUl26oadOe1JTtAr4FBL4I2NdeIBwl/d6BCGu9TcJPJ/MFDzoLzDlbtL+akskYE
         Dvof0vBfQ+0Olwd9DKxw/p6PeG5cprj8gOwsvndxTLWNwvbC0ftZsIMKexUVdTVydGoJ
         5Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200818; x=1768805618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RA3pjgULRJgvF7TCtASF+c3E2GVhUcRh6W4O9lav8ZI=;
        b=OiiLUHXu+TyCW5bdlcUqwyixoEnwb3+FxIVxp1ASHcQNnTFPW+fw4RW7t8KOyg7Wf9
         Pn2W+/H2nZ13grcZUlycvavQgncbAZSe8cRycEuRSXz4fQqVc+8j0TSwg3S23PE2pGdc
         vb4sX/MIWiAe3WyjeEpLEAn3hebOd3ld7yJILgjjIT8SyAPonA3iYUQZHzR82ASCX+e6
         qHmelqb0pEayR5dFycoOBKXdXE1sjoAundZ3aHiqOLa5pCO49cD3s07MjEHgFEdWTlr3
         1zo8+AicpBGNjyQsW+XI9wa813ZArEkDw/R4dAjazyZyFTM8uvXMsEMw0rceUQG9Hd7K
         LjXg==
X-Gm-Message-State: AOJu0YyN/bclfsO8tcK6ArAfQgD4CqiiPdJfC+Qptpy9tcu8gV8Oztsu
	xP0tgcthxhCBdWrvo2f9KmPh/ySCki7uqZXPPcuGWZwrLHS7FUCpuVVeLcmFxExg
X-Gm-Gg: AY/fxX4ir26zsEcgT/aIGfGzj+1txbfQlnEM6nEcAZreVeJ34kK6Z0/15TewrLRvRzg
	dAjlt/9mV4jtfTgpvvSbc8XLGCyBKIzx09oDprP5uzJdDQAV0FWp1nKfLH7/q9IAR42Xo3YQPaH
	llQZeGfuhIgmYNxDZB4f8lkDehOSAwKgV6wDFOLZp2lEiVUNOzF0AaXSszJ99SPs72ZLWfmiPUj
	zr8T1BVIt/G/V2mAa6I3VmzUSFXi9KTXXBmQX7WWsd+98XX6WI8ixDBEg8gY4N4f5gqfrDJAjcu
	kEBLGzjLR1PFyrkrbKFzDwW5/CH8pOCklHcpPvoHctOvLkDLsq+Adyp5qiNWwokyZs0yIMO+Kbx
	+Ss69utKNdnKm1s5XQB9XTaqYWa9pkRI8Jnt0BzAoovIYtIBVaNVA0k7loCb3ua6vMkgkEpnsjE
	llwt0TH6bRiAh1T2ZAmRHY9Onw0UmppfGnianKd7fa4TvR
X-Google-Smtp-Source: AGHT+IGkTWmOiD+rXuV34d8PSMJ9PtJXE5XBLGptkRxZeWe/ePCm+cVy8x3dDOv+SWoNuxje8tYPbQ==
X-Received: by 2002:a17:903:247:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a3ee4bff1cmr151083395ad.41.1768200817946;
        Sun, 11 Jan 2026 22:53:37 -0800 (PST)
Received: from d ([27.59.119.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f476sm2634005a12.8.2026.01.11.22.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:53:37 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com
Subject: [PATCH v2 1/2] t5403:introduce check_post_checkout helper function
Date: Mon, 12 Jan 2026 06:53:00 +0000
Message-ID: <20260112065301.1290-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260112065301.1290-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260112065301.1290-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test file repeatedly uses the same four-line pattern to validate
post-checkout hook arguments: read the args file, then test each of
the three values individually.

Introduce a check_post_checkout helper function that encapsulates this
pattern. This patch does not change test behavior; it prepares the
code for improvement in the next step.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 49 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1462e3365b..7bdea25107 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,6 +9,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Usage: check_post_checkout <file> <old-ref> <new-ref> <flag>
+#
+# Verify that the post-checkout hook arguments in <file> match the expected
+# values: <old-ref> for the previous HEAD, <new-ref> for the new HEAD, and
+# <flag> indicating whether this was a branch checkout (1) or file checkout (0).
+check_post_checkout () {
+	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
+	read old new flag <"$1" &&
+	test "$old" = "$2" && test "$new" = "$3" && test "$flag" = "$4"
+}
+
 test_expect_success setup '
 	test_hook --setup post-checkout <<-\EOF &&
 	echo "$@" >.git/post-checkout.args
@@ -23,29 +34,30 @@ test_expect_success setup '
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout main &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout -b new1 &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
+	old=$(git rev-parse HEAD) &&
 	git checkout two &&
-	read old new flag <.git/post-checkout.args &&
-	test $old != $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$old" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout main -- three.t &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 0
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 0
 '
 
 test_rebase () {
@@ -55,10 +67,8 @@ test_rebase () {
 		git checkout -B rebase-test main &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args rebase-on-me &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev main $old &&
-		test_cmp_rev rebase-on-me $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse main)" "$(git rev-parse rebase-on-me)" 1
 	'
 
 	test_expect_success "post-checkout is triggered on rebase $args with fast-forward" '
@@ -66,10 +76,8 @@ test_rebase () {
 		git checkout -B ff-rebase-test rebase-on-me^ &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args rebase-on-me &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev rebase-on-me^ $old &&
-		test_cmp_rev rebase-on-me $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse rebase-on-me^)" "$(git rev-parse rebase-on-me)" 1
 	'
 
 	test_expect_success "rebase $args fast-forward branch checkout runs post-checkout hook" '
@@ -79,10 +87,8 @@ test_rebase () {
 		git checkout two  &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args HEAD rebase-fast-forward  &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev two $old &&
-		test_cmp_rev three $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse two)" "$(git rev-parse three)" 1
 	'
 
 	test_expect_success "rebase $args checkout does not remove untracked files" '
@@ -109,7 +115,8 @@ test_expect_success 'post-checkout hook is triggered by clone' '
 	echo "$@" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
-	test_path_is_file clone3/.git/post-checkout.args
+	check_post_checkout clone3/.git/post-checkout.args \
+		"$(test_oid zero)" "$(git -C clone3 rev-parse HEAD)" 1
 '
 
 test_done
-- 
2.52.0.230.gd8af7cadaa

