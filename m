Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390737AA60
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895805; cv=none; b=r3xYQRycXTTl20v24rcYVqVSsb+Gv5FUX1Ge29i6pZvCtCoSt83pWivF/DLjzmdE3gK16B2sslAFpTjBgeE6JSWCDcEpmhlBpC1DDZ73S8LyNbLOd+CF1EM6SEf7Jsu1XTvCQfCeu9nbWA1rq1eGNwYmm+fDoUMLlytiMbDq6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895805; c=relaxed/simple;
	bh=aVhiorH8tqzATQydMTE43VNeR3evDjFSFZyDbvIhgGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arcEIzH5EBI6aVZhW/lqJfpiKlumnoOnEoNB9ZHTuUnC+ZDXV4bTacEKx48/eWkg8Fe0vnjBAf77mEVv0tYHVjowzo/5WRfsAYea2A03QURxLDkWczI2fCy2DFCiRZb4XGpGK+jSe9SmoRWqOpxULKxpd36j//xlX+M2ZM/RsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSFwJn4J; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSFwJn4J"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6a7638f42so477543985a.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895798; x=1770500598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6wFwxTm07+e5VJZFpKiDP2BDTUCOICfzm8uPffkmUA=;
        b=YSFwJn4JaGKWbhWsmz8+RFNMmT7AuEBeIQ2+Uh+tE6wAFEmO0B+UCJjYZcN6jUPsbo
         zEFfMmQF76MDMryU5AoPNwTMlHWQYDbfs3T3b7sfTH8onXnLrmBW6mOHmfibnW3EjwSh
         5LtK0alZuFygF0WMus2zEUpteBqKjCDdrxd20YqOexFmeJXHcpG3PM8J/CoOyM3LGvuy
         UBf2q95O9sY8F3Gqj9c+f4oHl+AWh16ywlCIqLpKcrVDVjs3x15XZA33I+DL31lT71nc
         lgkoBc/wJI1EGkBLRrMBetPjfxNWQpFd2ZlsJnlzDyYW8FNNpokYGBIVYeyxuuS0y3Rp
         GVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895798; x=1770500598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6wFwxTm07+e5VJZFpKiDP2BDTUCOICfzm8uPffkmUA=;
        b=hTGZyiMyB1IsovyqdG1hrRZhKSB7sDNB39cREsAMrMfwwyIRkcbT5sR+y2y/eSq7yF
         +G+mm0BEDa68GVTYpNhNVfZgafql2MVJ1TBCun8QDHXimi3IjUzBwlhDwTAGqMLUmatB
         cUDVNPuD9XsNZOIV1/55PLEGl2PKBPq/mhYpjzI8LISxKvHTXNhVnr3KQ9+eWvtlaQ7W
         y5olQI4pqYdZPBEPE11bIdjdtujSXfQ1ee6PnHknqJzZ+FHGqH1CN3lObfkEGEC4lB+a
         GACOpIp4aSGe9dLj5gVNLfsosU1hwJgppXhFMb2h7qLKnrNIV0I2VRw5IGrCY9a3kyr9
         mtrg==
X-Gm-Message-State: AOJu0YztjGyQaUPS10RfTPykHJpO4EJ3lhRzg+zmbgPQ0l/CHf5mxjeR
	grwA5cnFe9cD6+GOXs8PkIjvzjgawK1ZJ+2aAWU7uOV8xOPfoosoAcSn6aVPO/CB
X-Gm-Gg: AZuq6aKZR72UFZh3g1NiYPz0EW+C6yzNgPyUAbsSl4GCttVm70rNvdV+vz027rd1QUR
	/nED1rNir31JWxtSHF1v+IOoLUjB3iXHoEo49LfaiOa+x28JJAZ2GeAxoLN52Ry1tt55NcGvgRP
	tdVwF/6oARVSqsxWEYrqHKlD4jk94zdWbczLAgtFaajV81w94WrvhdfwZwLmJUOcJEQzktYc3AV
	ae/AZ+5NzlSSh3V8x4mAfE51lw7z7OT8HXo6AAwJ2rroEbfS/HG6EkoS1SLKmSBFC1liP3tNqdv
	PCTcFJuz1c8SAs8VmktOnx3yMlXlAWfT+Q07SfeEL1Xp5pISdYf5Zq924gcvs3d2PS1V18W1EqL
	WAcWeHNnWB/kwZJRoSP4zVPGHu2WZJVnBZHl0LvX0T20kFHDLNJh1/3v1XagUJx4OO7PEWhL2lu
	vL8PnJK/ZXYfozTbsfuyI3hA==
X-Received: by 2002:a05:620a:19a7:b0:8c6:a5bc:8a90 with SMTP id af79cd13be357-8c9eb1e6a42mr930034085a.14.1769895798590;
        Sat, 31 Jan 2026 13:43:18 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:15 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 1/5] t7425: add tests for reversive submodule traversal
Date: Sat, 31 Jan 2026 16:43:05 -0500
Message-ID: <20260131214309.1899376-2-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add test suite for the upcoming --reversive flag and its constituent
options: --reverse-traversal and --append-superproject. The --reversive
flag will be shorthand for: --recursive --reverse-traversal
--append-superproject.

Tests are marked as test_expect_failure since the features are not yet
implemented. They will be flipped to test_expect_success as each feature
is added.

Test structure:
 - Tests 1-2: Setup (success - prerequisites)
 - Test 3: --recursive existing behavior (success - already works)
 - Tests 4-5: --reverse-traversal (failure - needs implementation)
 - Tests 6-7: --append-superproject (failure - needs implementation)
 - Tests 8-9: Combined flags (failure - needs both features)
 - Tests 10-12: --reversive shorthand (failure - needs implementation)
 - Tests 13-16: --append-superproject edge cases (failure - needs implementation)

The test creates a multi-branch submodule tree with varying depths to
validate traversal order:

    top
    ├── sub0
    ├── sub1 -> sub2
    ├── sub3 -> sub4, sub5
    └── sub6 -> sub7 -> sub8, sub9

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 t/meson.build                  |   1 +
 t/t7425-submodule-reversion.sh | 329 +++++++++++++++++++++++++++++++++
 2 files changed, 330 insertions(+)
 create mode 100755 t/t7425-submodule-reversion.sh

diff --git a/t/meson.build b/t/meson.build
index 459c52a489..d3a5e17ff7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -887,6 +887,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-reversion.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-reversion.sh b/t/t7425-submodule-reversion.sh
new file mode 100755
index 0000000000..06c3ab6294
--- /dev/null
+++ b/t/t7425-submodule-reversion.sh
@@ -0,0 +1,329 @@
+#!/bin/sh
+#
+# Copyright (c) 2026 William Hatfield
+#
+
+test_description='Test "git submodule foreach --reversive"
+
+This test suite validates the --reversive flag and its constituent options:
+--recursive, --reverse-traversal, and --append-superproject. Tests confirm
+flags are correctly parsed and set non-zero integral values. Additional tests
+verify post-order traversal, superproject inclusion, and flag combinations.
+The --reversive flag is shorthand for: --recursive --reverse-traversal
+--append-superproject.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Helper: create content and initial commit in a submodule
+# Usage: create_submodule_content <name> <content>
+create_submodule_content () {
+	echo "$2" >"$1/file" &&
+	git -C "$1" add file &&
+	test_tick &&
+	git -C "$1" commit -m "$1 commit"
+}
+
+# Helper: add submodules to a parent and commit
+# Usage: add_submodules <parent> <child1> [child2 ...]
+add_submodules () {
+	parent=$1 &&
+	shift &&
+	for child in "$@"; do
+		git -C "$parent" submodule add ../"$child" "$child" || return 1
+	done &&
+	test_tick &&
+	git -C "$parent" commit -m "add $*"
+}
+
+test_expect_success 'setup - enable local submodules' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'setup reversive sandbox (full multi-branch tree)' '
+	mkdir reversive &&
+	(
+		# Tree structure created in this sandbox:
+		#
+		#     top
+		#     ├── sub0
+		#     │
+		#     ├── sub1
+		#     │   └── sub2
+		#     │
+		#     ├── sub3
+		#     │   ├── sub4
+		#     │   └── sub5
+		#     │
+		#     └── sub6
+		#         └── sub7
+		#             ├── sub8
+		#             └── sub9
+		#
+		# This structure provides:
+		#   - Four top‑level siblings (sub0, sub1, sub3, sub6)
+		#   - Mixed branch depths (1‑deep, 2‑deep, 3‑deep)
+		#   - Multiple nested sibling sets (sub4+5 and sub8+9)
+		#   - A leaf‑only sibling (sub0)
+		#   - Ideal coverage for traversal tests
+
+		cd reversive &&
+
+		# Create all repositories
+		test_create_repo top &&
+		test_create_repo sub0 &&
+		test_create_repo sub1 &&
+		test_create_repo sub2 &&
+		test_create_repo sub3 &&
+		test_create_repo sub4 &&
+		test_create_repo sub5 &&
+		test_create_repo sub6 &&
+		test_create_repo sub7 &&
+		test_create_repo sub8 &&
+		test_create_repo sub9 &&
+
+		# Create leaf submodules first (no children)
+		create_submodule_content sub0 zero &&
+		create_submodule_content sub2 two &&
+		create_submodule_content sub4 four &&
+		create_submodule_content sub5 five &&
+		create_submodule_content sub8 eight &&
+		create_submodule_content sub9 nine &&
+
+		# Build sub1 branch (sub1 -> sub2)
+		create_submodule_content sub1 one &&
+		add_submodules sub1 sub2 &&
+
+		# Build sub3 branch (sub3 -> sub4, sub5)
+		create_submodule_content sub3 three &&
+		add_submodules sub3 sub4 sub5 &&
+
+		# Build sub7 (sub7 -> sub8, sub9)
+		create_submodule_content sub7 seven &&
+		add_submodules sub7 sub8 sub9 &&
+
+		# Build sub6 branch (sub6 -> sub7)
+		create_submodule_content sub6 six &&
+		add_submodules sub6 sub7 &&
+
+		# Build top (top -> sub0, sub1, sub3, sub6)
+		create_submodule_content top root &&
+		add_submodules top sub0 sub1 sub3 sub6 &&
+		git -C top submodule update --init --recursive
+	)
+'
+
+test_expect_success '--recursive parses and prints(runs), existing behavior' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --recursive "echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub0
+sub1
+sub1/sub2
+sub3
+sub3/sub4
+sub3/sub5
+sub6
+sub6/sub7
+sub6/sub7/sub8
+sub6/sub7/sub9
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--recursive and --reverse-traversal parses' '
+	(
+		cd reversive/top &&
+		git submodule foreach --recursive --reverse-traversal "true"
+	)
+'
+
+test_expect_failure '--recursive and --reverse-traversal runs' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --recursive \
+			--reverse-traversal "echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub6/sub7/sub9
+sub6/sub7/sub8
+sub6/sub7
+sub6
+sub3/sub5
+sub3/sub4
+sub3
+sub1/sub2
+sub1
+sub0
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--recursive and --append-superproject parses' '
+	(
+		cd reversive/top &&
+		git submodule foreach --recursive --append-superproject "true"
+	)
+'
+
+test_expect_failure '--recursive and --append-superproject runs' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --recursive \
+			--append-superproject "echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub0
+sub1
+sub1/sub2
+sub3
+sub3/sub4
+sub3/sub5
+sub6
+sub6/sub7
+sub6/sub7/sub8
+sub6/sub7/sub9
+../top
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--reverse-traversal and --append-superproject parses' '
+	(
+		cd reversive/top &&
+		git submodule foreach \
+			--recursive --reverse-traversal --append-superproject "true"
+	)
+'
+
+test_expect_failure '--reverse-traversal and --append-superproject runs' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --recursive \
+			--reverse-traversal --append-superproject "echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub6/sub7/sub9
+sub6/sub7/sub8
+sub6/sub7
+sub6
+sub3/sub5
+sub3/sub4
+sub3
+sub1/sub2
+sub1
+sub0
+../top
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--reversive parses' '
+	(
+		cd reversive/top &&
+		git submodule foreach --reversive "true"
+	)
+'
+
+test_expect_failure '--reversive runs' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --reversive "echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub6/sub7/sub9
+sub6/sub7/sub8
+sub6/sub7
+sub6
+sub3/sub5
+sub3/sub4
+sub3
+sub1/sub2
+sub1
+sub0
+../top
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--reversive stops on command failure' '
+	(
+		cd reversive/top &&
+		git submodule foreach --reversive "true" &&
+		test_must_fail git submodule foreach --reversive \
+			"test \$name != sub7 || exit 1"
+	)
+'
+
+test_expect_failure '--append-superproject with no submodules runs only superproject' '
+	test_create_repo empty_repo &&
+	(
+		cd empty_repo &&
+		git submodule --quiet foreach --append-superproject \
+			"echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+../empty_repo
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--append-superproject sets all expected variables' '
+	(
+		cd reversive/top &&
+		git submodule --quiet foreach --append-superproject \
+			"echo name=\$name path=\$path displaypath=\$displaypath" |
+			tail -n 1
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+name=top path=../top displaypath=../top
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--append-superproject from nested submodule appends correct superproject' '
+	(
+		cd reversive/top/sub6 &&
+		git submodule --quiet foreach --recursive --append-superproject \
+			"echo \$displaypath"
+	) >actual &&
+
+	cat >expect <<-\EOF &&
+sub7
+sub7/sub8
+sub7/sub9
+../sub6
+EOF
+
+	test_cmp expect actual
+'
+
+test_expect_failure '--quiet suppresses Entering message for superproject' '
+	(
+		cd reversive/top &&
+		git submodule foreach --quiet --append-superproject "true"
+	) >actual 2>&1 &&
+
+	! grep "Entering" actual
+'
+
+test_done
-- 
2.53.0-rc0

