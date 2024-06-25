Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D915F3F9
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322592; cv=none; b=FNXA7m2lrbcwDGEm9oEbd4ygh2yDa09REzSlJ3LN0wbJINlmm+wURNiNUljajs6swEcR4z3zrRMjh1DO85PsZrcf6dXoi+nWGfrlob6wxwdPxDvGxwOEuYGPlomRjlgc7mBeonlnhueobxxNZUxc5S4Mck4XbGqOuPIWWqNSctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322592; c=relaxed/simple;
	bh=1sqDlc2m3GdrY2MO5yPHNkK5a+n/ZjtmSL73f52WZco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yo8dn1ha1lVhO9ysHvy2mECldm1aPLcx6IInm+x/HwDlbyUXHDHU2Yrf/GycCDHkoujuTk120wZ0n2Iry51V0QYfhRk8B62ZHGTz+qLGCbTrHOl9S3vrDiTCjeMlu1wDQ+lUQiwaRST6gmhKDo97MFiaKXRihqbOdeW+XPFDgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih3JRgLE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih3JRgLE"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c2d04b0833so231686a12.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719322590; x=1719927390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH37mcGzi7712beP4g/UmddRnoAp49IJ81uXj77GNhc=;
        b=Ih3JRgLEO5oMU0kS4DayAdsH9o66oxBgXLaefAnVUGOgOYKP/njp4jl88UzuOXoXQg
         Hb5ptulL+dCgfBjbU5QjtmtWtsV08epfV1X8DHTLvR0jxkvvwryswMEyfARoRzqdDfvg
         XcWXIj3UNrLE8yIgPr6Twyjld6qF2mzxom1X0uyvHel9UnDC6nrFhZCIqJJilyVvHkPo
         +mxBsiyXtqz2TBXf5lPt7Jopn9UWZudgPqvPbgLtcJDc3wRQAU5j/8xBQ470aV8Ay8va
         pYXNpQJTwtxHntJ5pHjGAEti6c9dm4qM4TqQCspfhtW7KOx4nkCG7/cR9BhUAdaX3eDT
         okfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322590; x=1719927390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH37mcGzi7712beP4g/UmddRnoAp49IJ81uXj77GNhc=;
        b=rcrdPm6EhAldO2ZquqpvLeckXPj/a8Okz2cwghxTUefliSIIgHV2L3pLGPkCQjSHTK
         fJosDoWmKGNZJVnCUZ41l+cgxSzuwcV3d8lL4vQU3M/iT0HH8UnetJMtRZOIUiDDCCBO
         UeRVBsz10IYL5RS/eGB+N5Tn45hb4uhLgVCle6OJmnZUUpfij4ale2JKITQ78MA17TBv
         JhqqoILtqSwMBiClRX7DguF3TH0uVeNZHZ3vniA/4fStpfosX77QpVr4Fmw0CyfMhDSq
         2LMm/AWvqCxrJ7HW8C4FsndsyVENkuhUUZbveZ72bWwDpZd2oHPyandtids9gD7CRVqi
         MGEw==
X-Gm-Message-State: AOJu0YxFRhLFUgVnge6N1PhgFRrvgyfmyPoayuoERlTeVwuE/irgXfVj
	bgyPaWYJ8AXDoxtsA68njizq+QbaspTgIpEtXSRIKOgr9m2pl955ARduCSaynDU=
X-Google-Smtp-Source: AGHT+IGnfmNXpitKjVpNbG+NYIRhSBa8JqTrKw7kfFFv9baS42dQG0RUnt8HrXvXYUlA60RJYCJQFg==
X-Received: by 2002:a17:902:da86:b0:1f7:3ed:e7b2 with SMTP id d9443c01a7336-1fa09c1a5f0mr105047715ad.0.1719322589723;
        Tue, 25 Jun 2024 06:36:29 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:3e:f8f9:88a4:a18e:4f73:d7ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3205e8sm81314225ad.68.2024.06.25.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:36:29 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3] describe: refresh the index when 'broken' flag is used
Date: Tue, 25 Jun 2024 19:05:19 +0530
Message-ID: <20240625133534.223579-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c  | 11 +++++++++++
 t/t6120-describe.sh | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..deec19b29a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			strvec_pushv(&cp.args, update_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+			run_command(&cp);
+			strvec_clear(&cp.args);
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..6c396e7abc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty --broken >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done

Range-diff against v2:
1:  d60fc0fa02 ! 1:  1da5fa48d9 describe: refresh the index when 'broken' flag is used
    @@ Commit message
         Reported-by: Paul Millar <paul.millar@desy.de>
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
     
      ## builtin/describe.c ##
    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
      	if (argc == 0) {
      		if (broken) {
      			struct child_process cp = CHILD_PROCESS_INIT;
    -+			struct child_process update_index_cp = CHILD_PROCESS_INIT;
    -+
    -+			strvec_pushv(&update_index_cp.args, update_index_args);
    -+			update_index_cp.git_cmd = 1;
    -+			update_index_cp.no_stdin = 1;
    -+			update_index_cp.no_stdout = 1;
    -+			run_command(&update_index_cp);
    ++			strvec_pushv(&cp.args, update_index_args);
    ++			cp.git_cmd = 1;
    ++			cp.no_stdin = 1;
    ++			cp.no_stdout = 1;
    ++			run_command(&cp);
    ++			strvec_clear(&cp.args);
     +
      			strvec_pushv(&cp.args, diff_index_args);
      			cp.git_cmd = 1;
    @@ t/t6120-describe.sh: test_expect_success 'setup misleading taggerdates' '
      
     +test_expect_success 'describe --dirty with a file with changed stat' '
     +	git init stat-dirty &&
    -+	cd stat-dirty &&
    -+
    -+	echo A >file &&
    -+	git add file &&
    -+	git commit -m A &&
    -+	git tag A -a -m A &&
    -+
    -+	cat file >file.new &&
    -+	mv file.new file &&
    -+	git describe --dirty >actual &&
    -+	echo "A" >expected &&
    -+	test_cmp expected actual
    -+'
    ++	(
    ++		cd stat-dirty &&
     +
    -+test_expect_success 'describe --dirty --broken with a file with changed stat' '
    -+	git init stat-dirty-broken &&
    -+	cd stat-dirty-broken &&
    ++		echo A >file &&
    ++		git add file &&
    ++		git commit -m A &&
    ++		git tag A -a -m A &&
     +
    -+	echo A >file &&
    -+	git add file &&
    -+	git commit -m A &&
    -+	git tag A -a -m A &&
    ++		cat file >file.new &&
    ++		mv file.new file &&
    ++		git describe --dirty >actual &&
    ++		echo "A" >expected &&
    ++		test_cmp expected actual &&
     +
    -+	cat file >file.new &&
    -+	mv file.new file &&
    -+	git describe --dirty --broken >actual &&
    -+	echo "A" >expected &&
    -+	test_cmp expected actual
    ++		cat file >file.new &&
    ++		mv file.new file &&
    ++		git describe --dirty --broken >actual &&
    ++		echo "A" >expected &&
    ++		test_cmp expected actual
    ++	)
     +'
     +
      test_done
-- 
2.45.2.606.g9005149a4a.dirty

