Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C63E1232
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146234; cv=none; b=ph72hSMJbz9Bw8e70+hpZ17cow6pJV18cBbtsPHYvl4GaFso0i2WliI12nayc/RiaOFNXwQqIWjOXooEqZVnclrpXIbSotkJwemAMAKRYl0xqgpzeeit3Ex5pVLijLC/tq6oPhfwQHxB5lnikKzEIKnYNPMdAPlp7BjHgzXyiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146234; c=relaxed/simple;
	bh=J56Zu5CPVoPw48GUgE8J3KpDiRx2Fa//eAaRXUOOJoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tpu9akM5Pg6O4QKcswcEQ+Jn7mIkdEIsNzKHQyG7dF57wRw3y4rCcCbmT4iToJfFEuDX96gFJObXwlAfGKc68eJPuM4dJPnHVQutseCmR3+6MtFqvwcVwci6JjnKv/12mQGz7nbA/sZ+2nBwaRl6bxqyib46bz9frLIBqLpqaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAwbNFDq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAwbNFDq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf52d15d88so23650985ad.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146232; x=1785751032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juVO73rhtwoypv7WSVhu1/1iAYBTxSSONNMi84+2IJU=;
        b=WAwbNFDqrnlWKN8eyTyWB8aK3AnyYdnb1LrULxe2nox9ZKvQCAEzYhBoYaoJeU45CT
         REMsVWmi3rQDFeigGIeKEitsKDDQivXklCgD66ZDftxOe3UJS7WAbSmZO+9lz1l7G86W
         4xS7OxkD9+LGgio+lDansZY48qxvReujhZGdfcgZsXReyxzcESlZcjkk30ZpkWIxU0dn
         5hTXetIlNv4ET/7zDvX3qkBeyuNBSPZJyhukyvOIpdAzNxeLYd0iIzAg9VXkKTeIwvw9
         c3Rk3v22GrlWJlMU00+b7JakodxXzz1dPAL8LRy/Mx9CBaIWKERVjCrpavlLodREIS1h
         TlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146232; x=1785751032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=juVO73rhtwoypv7WSVhu1/1iAYBTxSSONNMi84+2IJU=;
        b=MzNJAIKqNBANDjEpFl/kWzQTc1yMSgyV9b2ub8/ivux+bQZ91UOFCiADQQKDaL0tHw
         4fKoKFwMfA+4OOE8eE7H0Y01IbTKgYO+SSwc74EC7yCl6M5CYTMnDqv87WCpuxk5wq0E
         tLSINzsJpoB5nqhUxd+cUmyJaje4AXvOZTyRuB/Tc1iqt1obgXGlBzFnlNOhNGSCcAaa
         28tgjXKrPwDMT1ckPAY4jBKh5iYNrlzoaKEtmY5aKFbDfOHENH3C+T0xrmpplghfyXNm
         dZSN5dp3zqgfWVBLOu0CYbY7uee/I/hUGPO7kN88JSMrxzXZh7TLEWCoZhwefRB7hIs9
         mO1w==
X-Gm-Message-State: AOJu0YxzJBMwNta8QY1xHC/ZiKbnprOjtLsNvKnmD5avLSGtwKI3pfop
	zEcl3OILtQOvmeV7LWub0T1L5ECqZ9mltYVUrPuKN0XCA8rJEvp815BIhWACcQ==
X-Gm-Gg: AR+sD11E6fnR9x3hWBD5UA7SuuQ9VTKQkpqw7+Jqx0npGdFet98s5byL342iSuji/OE
	wP7F81/so4W/aSCWR6qyTzte+ucjcQN0PqTeMOfFh2KyhNWjFq+QqYXit4PJI/hkyv8RuDFYvVB
	WnGPufRI91vpn9WgjEduo2cN87bQBIytUQU2loeK5kbYc3m263UZUx0dcsO+1pg8TF7HwmuYe10
	p8bM4h+bs+i3CDC4Xf3iA5SesHRUJSVPDx46YpiaUdpvmDBYx8AFsqqRwZAKrrYjeSRs5PxKFHd
	BubeFBpdAMregpcqXe1FfeSOGlTrRdN0BXrr4F2mdThgolgSAy4KMvdwWXdqLOERvG/BEebYNgx
	JgFSgFupHGKYJOK6k2JGD4i00DG7Q8mehEdk0pUqYAu/22L+PWOlrNvpGkydZURSYUrXDd7p1pO
	ODcYuYeiT2GdjbH1z2gfOYmfQudHo=
X-Received: by 2002:a17:90b:17c8:b0:387:e0db:bc33 with SMTP id 98e67ed59e1d1-38f29885908mr7800971a91.41.1785146231610;
        Mon, 27 Jul 2026 02:57:11 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm49203193eec.2.2026.07.27.02.57.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 02:57:11 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2 2/2] t: use commit_body to extract commit message bodies
Date: Mon, 27 Jul 2026 15:26:56 +0530
Message-ID: <20260727095656.75496-3-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727095656.75496-1-diy2903@gmail.com>
References: <20260726224803.45131-1-diy2903@gmail.com> <xmqqldawq24y.fsf@gitster.g>
 <20260727095656.75496-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the "git cat-file commit | sed" idiom with commit_body across the
test suite: 61 sites in 12 files, plus one local helper that wrapped the
same idiom. The idiom appears in four equivalent spellings -- piped or
written to a file first, "sed -e" or plain "sed", "\$" or "$" in the
address -- all producing byte-identical output; they all collapse to the
same commit_body call.

t7509-commit-authorship.sh defined its own local message_body() helper
around the idiom instead of spelling it out at each call site; remove the
helper and convert its six call sites to commit_body directly.

Two sites needed more than a mechanical substitution:

* t7600.sh ("merge --no-ff --edit") greps the raw commit object for a
  phrase before stripping its header for the final comparison. The
  phrase is part of the commit body, not the header, so the grep can
  run against the already-stripped body instead, letting both steps
  share one commit_body call.

* t3900-i18n-commit.sh pipes the stripped body into "iconv" to test
  re-encoding. Piping commit_body's output into "iconv" would reintroduce
  an exit-code hole one line after removing it elsewhere, so this site
  writes the body to a file first and reads that, keeping the &&-chain
  intact.

Some greps for sed -e "1,/^\*$/d" left unconverted, as they are not extracting a commit's message body:

* t9001-send-email.sh strips mail headers from a message file, not a
  commit object.
* t1450-fsck.sh strips the header off a hand-built commit object while
  constructing a malformed one for fsck to reject.
* t4014-format-patch.sh runs the same sed address on a ".patch" file,
  with an additional expression.

All converted files pass in full, and a deliberately failing
"git cat-file" now fails a converted test that previously passed.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t3404-rebase-interactive.sh             |  2 +-
 t/t3405-rebase-malformed.sh               |  8 +--
 t/t3408-rebase-multi-line.sh              |  4 +-
 t/t3434-rebase-i18n.sh                    |  3 +-
 t/t3900-i18n-commit.sh                    |  4 +-
 t/t4150-am.sh                             |  8 +--
 t/t7500-commit-template-squash-signoff.sh |  4 +-
 t/t7501-commit-basic-functionality.sh     | 21 +++----
 t/t7502-commit-porcelain.sh               | 77 ++++++++---------------
 t/t7509-commit-authorship.sh              | 23 +++----
 t/t7600-merge.sh                          | 14 ++---
 t/t7604-merge-custom-message.sh           | 18 ++----
 t/t7614-merge-signoff.sh                  |  9 +--
 13 files changed, 72 insertions(+), 123 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e64816770a..a952e2b49d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -484,7 +484,7 @@ test_expect_success 'squash and fixup generate correct log messages' '
 			EXPECT_HEADER_COUNT=4 \
 			git rebase -i $base
 	) &&
-	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
+	commit_body HEAD >actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
 	git cat-file commit HEAD@{2} >actual &&
 	test_grep "^# This is a combination of 3 commits\." actual &&
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 2524331861..271195fc11 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -37,7 +37,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -F F &&
 
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >F0 &&
+	commit_body HEAD >F0 &&
 
 	git checkout diff-in-message &&
 	echo "commit log message containing a diff" >G &&
@@ -48,7 +48,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -F G &&
 
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >G0 &&
+	commit_body HEAD >G0 &&
 
 	git checkout empty-message-merge &&
 	echo file3 >file3 &&
@@ -66,7 +66,7 @@ test_expect_success setup '
 test_expect_success 'rebase commit with multi-line subject' '
 
 	git rebase main multi-line-subject &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
+	commit_body HEAD >F1 &&
 
 	test_cmp F0 F1 &&
 	test_cmp F F0
@@ -74,7 +74,7 @@ test_expect_success 'rebase commit with multi-line subject' '
 
 test_expect_success 'rebase commit with diff in message' '
 	git rebase main diff-in-message &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >G1 &&
+	commit_body HEAD >G1 &&
 	test_cmp G0 G1 &&
 	test_cmp G G0
 '
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index cde3562e3a..2ab89e1a7d 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -50,8 +50,8 @@ test_expect_success rebase '
 
 	git checkout side &&
 	git rebase main &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
-	git cat-file commit side@{1} | sed -e "1,/^\$/d" >expect &&
+	commit_body HEAD >actual &&
+	commit_body side@{1} >expect &&
 	test_cmp expect actual
 
 '
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 8c94fdffc4..0f93a239f8 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -27,8 +27,7 @@ fi
 
 compare_msg () {
 	iconv -f "$2" -t "$3" "$TEST_DIRECTORY/t3434/$1" >expect &&
-	git cat-file commit HEAD >raw &&
-	sed "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 }
 
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 3c930ec202..b3f03bcbd0 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -232,8 +232,8 @@ test_commit_autosquash_multi_encoding () {
 		git rev-list HEAD >actual &&
 		test_line_count = 3 actual &&
 		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
-		git cat-file commit HEAD^ >raw &&
-		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
+		commit_body HEAD^ >raw &&
+		iconv -f $new -t utf-8 <raw >actual &&
 		test_cmp expect actual
 	'
 }
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 61c3ce9018..ee96223668 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1018,7 +1018,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	Signed-off-by: J C H <j@c.h>
 	EOF
 	git commit -F msg &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
+	commit_body HEAD >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -1027,7 +1027,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		cat original &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual &&
 
 	cat >msg <<-\EOF &&
@@ -1038,7 +1038,7 @@ test_expect_success 'am -s unexpected trailer block' '
 	EOF
 	git reset HEAD^ &&
 	git commit -F msg file &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >original &&
+	commit_body HEAD >original &&
 	git format-patch --stdout -1 >patch &&
 
 	git reset --hard HEAD^ &&
@@ -1049,7 +1049,7 @@ test_expect_success 'am -s unexpected trailer block' '
 		echo &&
 		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 	) >expect &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 66aff8e097..5e782ad8d7 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -59,7 +59,7 @@ test_expect_success 'nonexistent template file in config should return error' '
 test_expect_success 'nonexistent optional template file in config' '
 	test_config commit.template ":(optional)$(pwd)"/notexist &&
 	GIT_EDITOR="echo hello >" git commit --allow-empty &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	commit_body HEAD >actual &&
 	echo hello >expect &&
 	test_cmp expect actual
 '
@@ -204,7 +204,7 @@ EOF
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
 	echo "zort" | git commit -s -F - foo &&
-	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
+	commit_body HEAD >output &&
 	test_cmp expect output
 '
 
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 7794babe46..d0af38df20 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -491,8 +491,7 @@ test_expect_success 'sign off (1)' '
 	echo 1 >positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo thank you &&
 		echo &&
@@ -511,8 +510,7 @@ test_expect_success 'sign off (2)' '
 	git commit -s -m "thank you
 
 $existing" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo thank you &&
 		echo &&
@@ -532,8 +530,7 @@ test_expect_success 'signoff gap' '
 	git commit -s -m "welcome
 
 $alt" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -553,8 +550,7 @@ test_expect_success 'signoff gap 2' '
 
 We have now
 $alt" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -575,8 +571,7 @@ test_expect_success 'signoff respects trailer config' '
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -593,8 +588,7 @@ Myfooter: x" &&
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -626,8 +620,7 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	(
 		echo one &&
 		echo &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 62e3970e3f..2adfe70b3d 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -175,8 +175,7 @@ test_expect_success 'commit --trailer with "="' '
 	Reported-by: C3 E3
 	Mentored-by: C4 E4
 	EOF
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -195,8 +194,7 @@ test_expect_success 'commit --trailer with -c and "replace" as ifexists' '
 		commit --trailer "Mentored-by: C4 E4" \
 		 --trailer "Helped-by: C3 E3" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d"  commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -217,8 +215,7 @@ test_expect_success 'commit --trailer with -c and "add" as ifexists' '
 		commit --trailer "Reported-by: C3 E3" \
 		--trailer "Mentored-by: C4 E4" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d"  commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -238,8 +235,7 @@ test_expect_success 'commit --trailer with -c and "donothing" as ifexists' '
 		commit --trailer "Mentored-by: C5 E5" \
 		--trailer "Reviewed-by: C6 E6" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d"  commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -259,8 +255,7 @@ test_expect_success 'commit --trailer with -c and "addIfDifferent" as ifexists'
 		commit --trailer "Reported-by: C3 E3" \
 		--trailer "Mentored-by: C5 E5" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d"  commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -280,8 +275,7 @@ test_expect_success 'commit --trailer with -c and "addIfDifferentNeighbor" as if
 		commit --trailer "Mentored-by: C4 E4" \
 		--trailer "Reported-by: C3 E3" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d"  commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -302,8 +296,7 @@ test_expect_success 'commit --trailer with -c and "end" as where' '
 		commit --trailer "Reported-by: C3 E3" \
 		--trailer "Mentored-by: C4 E4" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -323,8 +316,7 @@ test_expect_success 'commit --trailer with -c and "start" as where' '
 		commit --trailer "Signed-off-by: C O Mitter <committer@example.com>" \
 		--trailer "Signed-off-by: C1 E1" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -344,8 +336,7 @@ test_expect_success 'commit --trailer with -c and "after" as where' '
 		commit --trailer "Mentored-by: C4 E4" \
 		--trailer "Mentored-by: C5 E5" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -366,8 +357,7 @@ test_expect_success 'commit --trailer with -c and "before" as where' '
 		commit --trailer "Mentored-by: C3 E3" \
 		--trailer "Mentored-by: C2 E2" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -387,8 +377,7 @@ test_expect_success 'commit --trailer with -c and "donothing" as ifmissing' '
 		commit --trailer "Helped-by: C5 E5" \
 		--trailer "Based-by: C6 E6" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -409,8 +398,7 @@ test_expect_success 'commit --trailer with -c and "add" as ifmissing' '
 		commit --trailer "Helped-by: C5 E5" \
 		--trailer "Based-by: C6 E6" \
 		--amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -424,8 +412,7 @@ test_expect_success 'commit --trailer with -c ack.key ' '
 	EOF
 	git -c trailer.ack.key="Acked-by" \
 		commit --trailer "ack = Peff" -m "hello" &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -440,8 +427,7 @@ test_expect_success 'commit --trailer with -c and ":=#" as separators' '
 	git -c trailer.separators=":=#" \
 		-c trailer.bug.key="Bug #" \
 		commit --trailer "bug = 42" -m "I hate bug" &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -461,8 +447,7 @@ test_expect_success 'commit --trailer with -c and command' '
 		-c trailer.report.command="NAME=\"\$ARG\"; test -n \"\$NAME\" && \
 		git log --author=\"\$NAME\" -1 --format=\"format:%aN <%aE>\" || true" \
 		commit --trailer "report = author" --amend &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -480,8 +465,7 @@ test_expect_success 'commit --trailer not confused by --- separator' '
 		echo &&
 		echo "my-trailer: value"
 	} >expected &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -498,8 +482,7 @@ test_expect_success 'commit --trailer with --verbose' '
 		echo &&
 		echo "my-trailer: value"
 	} >expected &&
-	git cat-file commit HEAD >commit.msg &&
-	sed -e "1,/^\$/d" commit.msg >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected actual
 '
 
@@ -508,7 +491,7 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" tmp && rm tmp) &&
+	actual=$(commit_body HEAD) &&
 	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
@@ -545,8 +528,7 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 
 '
@@ -555,8 +537,7 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 
 '
@@ -565,8 +546,7 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 
 '
@@ -577,8 +557,7 @@ test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 
 '
@@ -605,8 +584,7 @@ test_expect_success 'cleanup commit messages (scissors option,-F,-e)' '
 	# to be kept, too
 	EOF
 	git commit --cleanup=scissors -e -F text -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -618,8 +596,7 @@ test_expect_success 'cleanup commit messages (scissors option,-F,-e, scissors on
 	to be removed
 	EOF
 	git commit --cleanup=scissors -e -F text -a --allow-empty-message &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_must_be_empty actual
 '
 
@@ -629,8 +606,7 @@ test_expect_success 'cleanup commit messages (strip option,-F)' '
 	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD >raw &&
-	sed -e "1,/^\$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 
 '
@@ -849,8 +825,7 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_line_count = 3 actual
 
 '
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 8e373b566b..561c19a219 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -12,11 +12,6 @@ author_header () {
 	sed -n -e '/^$/q' -e '/^author /p'
 }
 
-message_body () {
-	git cat-file commit "$1" |
-	sed -e '1,/^$/d'
-}
-
 test_expect_success '-C option copies authorship and message' '
 	test_commit --author Frigate\ \<flying@over.world\> \
 		"Initial Commit" foo Initial Initial &&
@@ -27,8 +22,8 @@ test_expect_success '-C option copies authorship and message' '
 	author_header HEAD >actual &&
 	test_cmp expect actual &&
 
-	message_body Initial >expect &&
-	message_body HEAD >actual &&
+	commit_body Initial >expect &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -40,8 +35,8 @@ test_expect_success '-C option copies only the message with --reset-author' '
 	author_header HEAD >actual &&
 	test_cmp expect actual &&
 
-	message_body Initial >expect &&
-	message_body HEAD >actual &&
+	commit_body Initial >expect &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -62,8 +57,8 @@ test_expect_success '-c option copies only the message with --reset-author' '
 	author_header HEAD >actual &&
 	test_cmp expect actual &&
 
-	message_body Initial >expect &&
-	message_body HEAD >actual &&
+	commit_body Initial >expect &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -77,7 +72,7 @@ test_expect_success '--amend option copies authorship' '
 	test_cmp expect actual &&
 
 	echo "amend test" >expect &&
-	message_body HEAD >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -124,7 +119,7 @@ test_expect_success '--reset-author makes the commit ours even with --amend opti
 	test_cmp expect actual &&
 
 	echo "Changed again" >expect &&
-	message_body HEAD >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -157,7 +152,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 	test_cmp expect actual &&
 
 	echo "This is a MERGE_MSG" >expect &&
-	message_body HEAD >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7f2a1db16d..64cb83284c 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -332,8 +332,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -363,8 +362,7 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -387,8 +385,7 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	# Conflicts:
 	#	file
 	EOF
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -989,9 +986,8 @@ test_expect_success 'merge --no-ff --edit' '
 	git reset --hard c0 &&
 	EDITOR=./editor git merge --no-ff --edit c1 &&
 	verify_parents $c0 $c1 &&
-	git cat-file commit HEAD >raw &&
-	test_grep "work done on the side branch" raw &&
-	sed "1,/^$/d" >actual raw &&
+	commit_body HEAD >actual &&
+	test_grep "work done on the side branch" actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index cd4f9607dc..3a7d1ae858 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -36,16 +36,14 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp exp.log actual
 '
 
@@ -61,8 +59,7 @@ test_expect_success 'prepare file with comment line and trailing newlines'  '
 test_expect_success 'cleanup commit messages (verbatim option)' '
 	git reset --hard c1 &&
 	git merge --cleanup=verbatim -F expect c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -71,8 +68,7 @@ test_expect_success 'cleanup commit messages (whitespace option)' '
 	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git merge --cleanup=whitespace -F text c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -97,8 +93,7 @@ test_expect_success 'cleanup merge messages (scissors option)' '
 	# to be kept, too
 	EOF
 	git merge --cleanup=scissors -e -F text c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -107,8 +102,7 @@ test_expect_success 'cleanup commit messages (strip option)' '
 	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git merge --cleanup=strip -F text c2 &&
-	git cat-file commit HEAD >raw &&
-	sed -e "1,/^$/d" raw >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index e58bf07b7a..b078eaf8a3 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -45,8 +45,7 @@ test_expect_success 'git merge --signoff adds a sign-off line' '
 	test_commit main-branch-2 file2 2 &&
 	git checkout other-branch &&
 	git merge main --signoff --no-edit &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected-signed actual
 '
 
@@ -56,8 +55,7 @@ test_expect_success 'git merge does not add a sign-off line' '
 	test_commit main-branch-3 file3 3 &&
 	git checkout other-branch &&
 	git merge main --no-edit &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected-unsigned actual
 '
 
@@ -67,8 +65,7 @@ test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
 	test_commit main-branch-4 file4 4 &&
 	git checkout other-branch &&
 	git merge main --no-edit --signoff --no-signoff &&
-	git cat-file commit HEAD >commit &&
-	sed -e "1,/^\$/d" commit >actual &&
+	commit_body HEAD >actual &&
 	test_cmp expected-unsigned actual
 '
 
-- 
2.52.0

