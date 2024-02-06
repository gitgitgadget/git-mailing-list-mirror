Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972D1CA9C
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256259; cv=none; b=M/+DUYfkK51+CYQAsGvnjHIbaE9uT6+jMSya5O38LbmOvhYBH7+eWddVDOWsZKYkpdiHeJTAPMmh7nDaMJoeYl62pa99zZq/CpcR10FV8iliNRQyDfxYnM3VSNl2OkTxNT9704Pex8jMlpo4LHgavJG7IlrzSkMekAFnY7YYqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256259; c=relaxed/simple;
	bh=FlRpLXlYAStIXYzqnKK+hK2fFtbOT7iHqIlh9ZnTzBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBiv3WgaEvDPQRixteRRwzfXNr0M7B3tqa9mLT80enP9fMmOHQkxvoc9xOgmmnzKGh2omKD1MMbCm/EkOQOjHaNVvBUhU079osJBNqnqzR8j1ksXjFrrfM6tNJ4Tp/T0Rg8k8lm8qZaPx8nKGeAykO1z1FRka/wtH33e6AZD1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGstGSYL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGstGSYL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so5264974a12.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 13:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707256257; x=1707861057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kut9/Pr5p71KYzHi5/hOfKZIqkrsfIGmkmtH70WtQs=;
        b=UGstGSYLv3Pj37XGG3enK5+eu/r+IV0CxVH5cATo4k1Q3adTMs/bgysOexdMb35uij
         /xv4BJO0eoQoLf/6On1ZgfXw7gSUnY3mAqa0o7Muo8+EEXc5QJhlsr8ZIeCIzymkeQau
         Ckj/nmx2H92OJ/VdhQ2yPFDRBoaJtdeOEt0zmJihSGb/RDllL2PcNqpMGDFNMcfWGdh+
         8H5C73Iqzvbl+B5pR+6/mJpGmZV1BOwA0Vbyn+1QoragLGmc/HhcOWYvNgShyuIo7E2z
         KASzpvHqMNh31+AZ/+Cm1kpO/s+aC6XbUiLVXlQayGocOaXgVf1r/rvPJRh4gE1eDhI0
         Sk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256257; x=1707861057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kut9/Pr5p71KYzHi5/hOfKZIqkrsfIGmkmtH70WtQs=;
        b=fsfWObBt5NeCKRG/xjf0cKWGlj6I0d02TbTQN+wMyIsQsf2ItImv1OYaT60ApHXrms
         zv6K94fmoOvxyZ0b0OrxWVDXnN1rmy1vCXPm6dgLg4tqsvnF2E1+r6T040KNtm3iADQm
         T0mdXsiWNUkDPRHNQYsEtr3uIFEgsbEGjjnfHmfX49a8bR9631uB0SkjQAKwQuc/Ov8X
         az2jL7QwsWm08LQLkw+J1U4Sz2PEc1EXrJfESI6pIn61vTur74oTUK08EdBU1687ViNR
         3cth+c6FDukwHVtumhwQtyBNu6QJP2K2y6Y6IAXreWwwOQ9uPPteO+KoS9f6wty0PwlO
         42Jw==
X-Gm-Message-State: AOJu0Yyas22hSlKujBkyaox2tuVSUjwIPznl1BkgNF0pDX47gvKqHphX
	auJxCk4Nq0wEI+wHp3Hu4pTIP6bn349BjJutl4vgLYMLuo+9P9HLSG8Ye7jH
X-Google-Smtp-Source: AGHT+IFICCF0hFAp3GbLTi+/AhmjjPVXHI+gu78AvF68F49Rv3DTyKDcVjiGB84nBCHOOc9vDDLIow==
X-Received: by 2002:a05:6a21:8ccb:b0:19e:9b8e:8bda with SMTP id ta11-20020a056a218ccb00b0019e9b8e8bdamr2517672pzb.42.1707256256804;
        Tue, 06 Feb 2024 13:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWOK2U9bI53oEWO8Kbi0ADpXzwp0ISUTb5jWj8l4Q0hSVmNGDQswwWRCK2BmtwRxnkfj6On4Yim/PNBM9/+QrQFmcahXfjPpfPn5qdWioe+8HH
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id lb11-20020a056a004f0b00b006e0350189f0sm2557557pfb.91.2024.02.06.13.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:50:54 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 51EF75202A6; Tue,  6 Feb 2024 12:50:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v6 7/7] completion: bisect: recognize but do not complete view subcommand
Date: Tue,  6 Feb 2024 12:50:48 -0900
Message-ID: <20240206215048.488344-8-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com>
References: <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206215048.488344-1-britton.kerin@gmail.com>
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
index 5337ae4ce2..0734debc11 100644
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
index b989388e7e..70557eb684 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1376,6 +1376,30 @@ test_expect_success 'git-bisect - git-log options to visualize subcommand are ca
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

