Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C259B52
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185382; cv=none; b=TDpHdhbA7X6BXG1Z35dduHLQAu++XsdtcNCDGBwkYm5U74lgdN3NHplIfHwmKDD0FWsjRfES1Ql5NNxKMqwJTZTTBobXqua18PZl3sgI79b0E/8LCtw1lPeA+BMxa/v+HioAh+szUqi9kPdEeAKDpMVI5U4dxeaLI9eyMZWip1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185382; c=relaxed/simple;
	bh=HGXJ6yJVYJRmrwSgaipEGVpNY+0QrXRWz5feVRBK+FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDWBXyPnp8ahSpoUI6yJ3uqaGys/YxXOlEOPEZpwKRBmSiUIiGMm0mT8TTkKbEkV8OxIOM9FFLeym9Eq5KHfXM7td3WhglDCA8gq76xSdQBs6K/9HeM+lTLCpQI89/nVslH90CrMkNb6OD9E2inmo9lZg25IB/G2u6xwZ9cqQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkE5T1RV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkE5T1RV"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e04d24bd39so1004567b3a.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185380; x=1707790180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+JK/rItI+4UK66WxLpJmpNmDuoetU2nq7vmVLgnJKo=;
        b=kkE5T1RV+UiD30t7Ber0T71ec0s6ZoMfJuuUyvoWcNEVIBlirhXJdtlxAHMQ3U+dir
         O3geIus2GzYS1vHaWQRF9xBi4IHgmYopnNo+K3HbkO97qt1C7TMAvcSi+7/dM3TWswrd
         GfP+8O+ZomiNF0H0zr8bMYllhhGK8f8Ij5A9XVYoymte7tups36tB0U4GVjoRWNkdpsi
         Pqzjc+8Lq2B5Kgle6F8LS2NNBLQqNwVfax+j2LU4EkKyfjTlacpkWtalGYqaK1IdMYr/
         WiaVMynf1dX08xmU38idZMshebe8nZstG5dUGVtXW5PzGlqjzGy54Gmnv4fRrP4LuHUY
         qv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185380; x=1707790180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+JK/rItI+4UK66WxLpJmpNmDuoetU2nq7vmVLgnJKo=;
        b=xQfa5nx/xSzcn20WHjuP/UGCsXwmnHqS08LF8xKBO13Uz9YQdyOsnKx4v4wm+vKoRd
         8jshtoiI5AUiqw2JKy4Q5i0R3w6SpyMIa+NNnjAbJrQxtmDor8Q/tCgRuTmKdgW2/a/5
         QF4gYCR8sUFgr/q0I2+j6pww1TDzlOtKe+ThnW6DA81iI9QWUuTCCNs3yG1+64ji0+7h
         f+2FYVc4Zv1IKZvMYG/LrACLJXvXpfkFBXnQQ7QYRdjJ51VUgZOjvLyspLGWBCkm5f3X
         1WhRvt47xt+IGxbV1jnwybqLpYqf2uNfm7INlCAITj99ZmTgoNBUOJxWfA4ASrJJZMtu
         AiXw==
X-Gm-Message-State: AOJu0YwQF3jgYnFiuhFZ5r1/fSqAET3hHYLD8CBI5+clYOZYNVtoBF/a
	oFzug6dUV4z/OFkvsnY0NLfuVkNh40sQEfda5qNOgz1jyOv4j+Ei
X-Google-Smtp-Source: AGHT+IGNWphNKLvs1AoZ3TvPiDGd9KwgvJHB6VS0EzSaCq1I1LflSMn27K2w/dMUUwt2rOfAc+Z2vA==
X-Received: by 2002:aa7:8893:0:b0:6db:e366:53a8 with SMTP id z19-20020aa78893000000b006dbe36653a8mr1134399pfe.12.1707185380540;
        Mon, 05 Feb 2024 18:09:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwotcerYUrbyiL0EOWaOWttCBd/u/PhZ81njtZbzYDY9EUoV2HB5Yi1TAG+XNXJo6978ZCZkifaoXBk6yaFXF2uxssm86GzF0NQSxCwqtGCcQx
Received: from brittons-large-Vivobook (mobile-166-171-250-223.mycingular.net. [166.171.250.223])
        by smtp.gmail.com with ESMTPSA id 33-20020a630b21000000b005c662e103a1sm781065pgl.41.2024.02.05.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:37 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 8454B52029A; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 7/7] completion: bisect: recognize but do not complete view subcommand
Date: Mon,  5 Feb 2024 17:09:30 -0900
Message-ID: <20240206020930.312164-8-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "view" alias for the visualize subcommand is neither completed nor
recognized.  It's undesirable to complete it because it's first letters
are the same as for visualize, making completion less rather than more
efficient without adding much in the way of interface discovery.
However, it needs to be recognized in order to enable log option
completion for it.

Recognize but do not complete the view command by creating and using
separate lists of completable_subcommands and all_subcommands.  Add
tests.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++----
 t/t9902-completion.sh                  | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b4cd94182e..b3d5468c15 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1462,12 +1462,19 @@ _git_bisect ()
 	# more usual bad/new/good/old because git bisect gives a good error
 	# message if these are given when not in use, and that's better than
 	# silent refusal to complete if the user is confused.
-	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	#
+	# We want to recognize 'view' but not complete it, because it overlaps
+	# with 'visualize' too much and is just an alias for it.
+	#
+	local completable_subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
+	local all_subcommands="$completable_subcommands view"
+
+	local subcommand="$(__git_find_on_cmdline "$all_subcommands")"
+
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
 		if [ -f "$__git_repo_path"/BISECT_START ]; then
-			__gitcomp "$subcommands"
+			__gitcomp "$completable_subcommands"
 		else
 			__gitcomp "replay start"
 		fi
@@ -1490,7 +1497,7 @@ _git_bisect ()
 		__gitcomp "--term-good --term-old --term-bad --term-new"
 		return
 		;;
-	visualize)
+	visualize|view)
 		__git_complete_log_opts
 		return
 		;;
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 74132699b1..6a6019b0a8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1375,6 +1375,30 @@ test_expect_success 'git-bisect - git-log options to visualize subcommand are ca
 	)
 '
 
+test_expect_success 'git-bisect - view subcommand is not a candidate' '
+	(
+		cd git-bisect &&
+		test_completion "git bisect vi" <<-\EOF
+		visualize Z
+		EOF
+	)
+'
+
+test_expect_success 'git-bisect - existing view subcommand is recognized and enables completion of git-log options' '
+	(
+		cd git-bisect &&
+		# The completion used for git-log and here does not complete
+		# every git-log option, so rather than hope to stay in sync
+		# with exactly what it does we will just spot-test here.
+		test_completion "git bisect view --sta" <<-\EOF &&
+		--stat Z
+		EOF
+		test_completion "git bisect view --summar" <<-\EOF
+		--summary Z
+		EOF
+	)
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
-- 
2.43.0

