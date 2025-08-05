Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CF20126A
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422554; cv=none; b=OalsL/wfRw5EP280sarpFdPGWH1Iu9q2Z2r/Qrffclwu/3RZ/w4RIDijw9QG8mAoOWfH5Tmb9b0QQeHpVP8spXHfuZknCHKzRvXF3S/4Ymn1fbrUBgVgBh56OVjHEYapSYKGs+dbzFSIQ/PDvU8MAVPzJgWLWrhLIm9lx9rmD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422554; c=relaxed/simple;
	bh=XZwKFJ6qrym5cRRXteURWjy2mVXf7Nvnf7AkqerrqUI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HEdRa3kNLOQgQv+Ek5KgPgiNs/toWh2V0DIWSDjc84tEds2KzeVlcmbqqQ/752CinY08JQEQZBKs/rJP2r3yUOT/N6EQOvy+4e6y/QXK7r12/sZisRO9LR272viN4//3X+Xhu3Z5XneFZq150ikJqStNAiY2DHF4/UHdK2SmXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itw+DMGP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itw+DMGP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b783d851e6so5055496f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422550; x=1755027350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sYnGWdLOXXjVH1RAn+fUuvFqiN5S14ikewZBJbjebk=;
        b=itw+DMGPQ3axmv5sLWWs+/7gl0WP+u73XYg5APLCzbslbJ0vKEhcx9rtFZDwIAhfp4
         4i46ox9w/d+7X+QQBSRFt1s6HoQffVXQvQyHAnkwe1ay9WQFBQ9jZofoJHshniDqmYDo
         2A5jx344WVJhGunaH5G1kesUvK1gQRDVosGrkBrqZpnoFXd1PRUQG8rLDZMT2B+n0bus
         jfrpzwol3ZasTl+22Mcv+OAhguQMMWus9cXAFT4EtqAG2wljmApmjGXUs0QgDMTEQ2K/
         8ui56qSrESewgridhjFcpypbfrBVwpb8AmepYfJNZv+QnH4VsGqIsp5m+yst6kit15W8
         kqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422550; x=1755027350;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sYnGWdLOXXjVH1RAn+fUuvFqiN5S14ikewZBJbjebk=;
        b=UuW7aOMJW1fbT/hw4hDyGQjHUHzPk+XnDNzJIkfDRnKLIbd4LzfA9HqUrWpYX/Tckv
         qYmxBDXOY8zQ3e+3E78WKnv8dNgO/3jofzUam5YFrsQpNcatFaa0RtMh/D4JoqcCNS4+
         RbnEiq4Gbx94hlbfms5ZS3SoPVWFPLexg1mf13RrTmEF4v6caPcrSFBG9VnLL3/HOfPq
         DdbSlmFQLQwnQqjaPW1T0An+wBPx3RwdwANGq49WDNiigkoI6I2KwBsnprR74W2AYtcm
         4IQXz822euCBnUEUZcMofEPTKKnRzInVGKyb8ePtNsf3fW2FfM0Wd+T4WUfP6ri+Gw08
         gq9w==
X-Gm-Message-State: AOJu0Yw9SuKCbglsTTQkUoaQNhVzgLa5SeamWxyhjaw/iamfU2oR/n6e
	sHudizw2qRf64DkW+AT+LyV9mlUXyBsvJvEvyf3vvOfx03w1q4fNX42gVyGzKw==
X-Gm-Gg: ASbGncsmH9Bc3qzBxDWTR07uj7DkHCX3K+pLxvXpKqSHaRUNkcTfUuJfJ/gQVukiHYp
	La2bKm7Mz6o2Do8OPc4Llo0DhnNxpXLS9ltd85LPlTSaRucTKG9KWofi5yataEIrkSoIKcIHYAw
	tk4N2D2CGOIYoe192GgmUij3N6baVYgi1xdJanMqavdAvtcCOdXwiMDcOTnDGrIZmfY3OGi4x1e
	FT2ZL7WZtUlDJqduXP1rrDcZ4mUyfqbUsbXPra4/LvaK6XDEOneidIfmlyp+wPYcEvISRSK82Oh
	kpKC7OkR5/rk9ZuH2z3BkOr7yC/3DfvXYfXwJcbSMbS9NDM4DH7FLaKoL7YKfGFHx93gR8La9c0
	RJC1CfLm0SAFey9ZJ+z6x7ko=
X-Google-Smtp-Source: AGHT+IEEZra9yKSlLJQZw+iXhfV7ysbRLsRxvbOncpgVeaUyrkH5+nbPof1jDE1N+72O7OwHFcjnBw==
X-Received: by 2002:a05:6000:2011:b0:3b7:87be:d9d8 with SMTP id ffacd0b85a97d-3b8f418f052mr172361f8f.43.1754422550117;
        Tue, 05 Aug 2025 12:35:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95e9sm19994433f8f.16.2025.08.05.12.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:49 -0700 (PDT)
Message-Id: <1ea7bfd3bff81a648a5ed1d0112ec404ab64fc91.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:43 +0000
Subject: [PATCH v2 3/6] t6423: document two bugs with rename-to-self testcases
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When commit 98a1a00d5301 (t6423: add a testcase causing a failed
assertion in process_renames, 2025-03-06) was added, I tweaked
the commit message, and moved the test into t6423.  However, that
still left two other things missing that made this test unlike the
others in the same testfile:

  * It didn't have an English description of the test setup like
    all other tests in t6423

  * It didn't check that the right number of files were present at
    the end

The former issue is a minor detail that isn't that critical, but the
latter feels more important.  If it had been done, I might have noticed
another bug.  In particular, this testcase involves
   Side A: rename world -> tools/world
and
   Side B: rename tools/ -> <the toplevel>
   Side B: remove world
The tools/ -> <toplevel> rename turns the world -> tools/world rename
into world -> world, i.e. a rename-to-self case.  But, it's a path
conflict because merge.directoryRenames defaults to false.  There's
no content conflict because Side A didn't modify world, so we should
just take the content of world from Side B -- i.e. delete it.  So, we
have a conflict on the path, but not on its content.  We could consider
letting the content trump since it is unconflicted, but if we are going
to leave a conflict, it should certainly represent that 'world' existed
both in the base version and on Side A.  Currently it doesn't.

Add a description of this test, add some checking of the number of
entries in the index at the end of the merge, and mark the test as
expecting to fail for now.  A subsequent commit will fix this bug.

While at it, I found another related bug from a nearly identical setup
but setting merge.directoryRenames=true.  Copy testcase 12n into 12n2,
changing it to use merge instead of cherry-pick, and turn on directory
renames for this test.  In this case, since there is no content conflict
and no path conflict, it should be okay to delete the file.
Unfortunately, the code resolves without conflict but silently leaves
world despite the fact it should be deleted.  It might also be okay if
the code spuriously thought there was a modify/delete conflict here;
that would at least notify users to look closer and then when they
notice there was no change since the base version, they can easily
resolve.  A conflict notice is much better than silently providing the
wrong resolution.  Cover this with the 12n2 testcase, which for now is
marked as expecting to fail as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 100 +++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index f48ed6d03534..2def1522bd59 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5056,6 +5056,25 @@ test_expect_success '12m: Change parent of renamed-dir to symlink on other side'
 	)
 '
 
+# Testcase 12n, Directory rename transitively makes rename back to self
+#
+# (Since this is a cherry-pick instead of merge, the labels are a bit weird.
+#  O, the original commit, is A~1 rather than what branch O points to.)
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
 test_setup_12n () {
 	git init 12n &&
 	(
@@ -5084,7 +5103,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_success '12n: Directory rename transitively makes rename back to self' '
+test_expect_failure '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
@@ -5092,7 +5111,84 @@ test_expect_success '12n: Directory rename transitively makes rename back to sel
 		git checkout -q B^0 &&
 
 		test_must_fail git cherry-pick A^0 >out &&
-		grep "CONFLICT (file location).*should perhaps be moved" out
+		test_grep "CONFLICT (file location).*should perhaps be moved" out &&
+
+		# Should have 1 entry for hello, and 2 for world
+		test_stdout_line_count = 3 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count = 2 git ls-files -s world
+	)
+'
+
+# Testcase 12n2, Directory rename transitively makes rename back to self
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
+test_setup_12n2 () {
+	git init 12n2 &&
+	(
+		cd 12n2 &&
+
+		mkdir tools &&
+		echo hello >tools/hello &&
+		git add tools/hello &&
+		echo world >world &&
+		git add world &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv world tools/world &&
+		git commit -m "Move world into tools/" &&
+
+		git switch B &&
+		git mv tools/hello hello &&
+		git rm world &&
+		git commit -m "Move hello from tools/ to toplevel"
+	)
+}
+
+test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
+	test_setup_12n2 &&
+	(
+		cd 12n2 &&
+
+		git checkout -q B^0 &&
+
+		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
+
+		# Should have 1 entry for hello, and either 0 or 2 for world
+		#
+		# NOTE: Since merge.directoryRenames=true, there is no path
+		# conflict for world vs. tools/world; it should end up at
+		# world.  The fact that world was unmodified on side A, means
+		# there was no content conflict; we should just take the
+		# content from side B -- i.e. delete the file.  So merging
+		# could just delete world.
+		#
+		# However, rename-to-self-via-directory-rename is a bit more
+		# challenging.  Relax this test to allow world to be treated
+		# as a modify/delete conflict as well, meaning it will have
+		# two higher order stages, that just so happen to match.
+		#
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count = 2 git ls-files -s world &&
+		test_grep "CONFLICT (modify/delete).*world deleted in HEAD" out
 	)
 '
 
-- 
gitgitgadget

