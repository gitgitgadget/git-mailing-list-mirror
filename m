Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D730C61C
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340162; cv=pass; b=pSBaHLz0ihg/R2b9WxtPUzRcZJCif9pGaVw3G2DTpHJeLe4M9sd116xiquh6I1flanQI6gjjrqHqwzbnYhiaOOopIraE0ownPLqU+jsyCpdJKyoQwyH9ang5R+dJWey7mUyfut/TF+6ddM8uXsC8+O3vtXdqkB3yRJNUM7PnDF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340162; c=relaxed/simple;
	bh=rboWCAmZ5VRDh3CZVOOH7K4EjoA2eFX+n+ensnA0GpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nyy084+uPrsrXzP5zU0pgtPzP35sOvuqFCa9NpjX6eDB8DCpoFlZX7ompKoW4+udhTRoNmISfSAakPpEnbDQlfez7Kq7fhPu4sgjnAQ+5H/T9NesZCKQE4iRizFNt20Kdsti0SZ8AdUsIQ4pq1e0pbb9bQJ4Z0pONn7VKH8gBOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MUvvZLcd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MUvvZLcd"
ARC-Seal: i=1; a=rsa-sha256; t=1757340136; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lAK18yFVfeS5Wyfk7tZrJEILDOu+MJJfCCRv8jhqFrPrp0qm8Qew9smX4tVTjGI1SLhl7XYn+8+uR0Zgw2bSKFkO9H5NgdXD0n86mbEEz3/XViQj6kxK3YKVGUAZqLaKhj7WZXzY5KYk5WXHI3K9sT6prEBPnkay+BRQXLR2aiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340136; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CNbgitQhL4ykBLZu+QBtW74D90V4Ca5+FA4ptc6HQyM=; 
	b=RJcyY9gI9gLz3lXGdX2zMc2JtVOCqD/DzXIGbKpP4Uyi850jLmaCUGptrhvGiiLNfzluX2Y6xLbjFRZEurGwtUg36cYWnXBMOWfs/+5tKTSuezZGmDnmzZ2EqmnvviohMBNVDMmQCVcDMJaITIN9AVYQvKzrTPC2PR0Ll5bb3jg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340136;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CNbgitQhL4ykBLZu+QBtW74D90V4Ca5+FA4ptc6HQyM=;
	b=MUvvZLcdt2GGA/tFc9rlsBIWOYcaokz8pmZLU8mHP/1JaidxINYi+iSlOKhKbunR
	zvrBevsshrU8+JeF4aRR/jbtnJApgmjbCxeypBR7IYc+3ec54NsR5h2JyRp/YhgsEjd
	hJsK7lKNQRO975AKj8tjeQTt3FDst1nYkixq7NCc=
Received: by mx.zohomail.com with SMTPS id 1757340130905668.2605757126696;
	Mon, 8 Sep 2025 07:02:10 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 04/10] t7425: add basic mixed submodule gitdir path tests
Date: Mon,  8 Sep 2025 17:01:11 +0300
Message-ID: <20250908140117.262205-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add some basic submodule tests for mixed gitdir path handling of
legacy (.git/modules) and new-style (.git/submodule) paths.

For now these just test the coexistence, creation and push/pull of
submodules using mixed paths.

More tests will be added later, especially for new-style encoding.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/meson.build                           |   1 +
 t/t7425-submodule-mixed-gitdir-paths.sh | 101 ++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100755 t/t7425-submodule-mixed-gitdir-paths.sh

diff --git a/t/meson.build b/t/meson.build
index baeeba2ce6..28456158a0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -879,6 +879,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-mixed-gitdir-paths.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
new file mode 100755
index 0000000000..31f16d7741
--- /dev/null
+++ b/t/t7425-submodule-mixed-gitdir-paths.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: allow file protocol' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'create repo with mixed new and legacy submodules' '
+	git init -b main legacy-sub &&
+	test_commit -C legacy-sub legacy-initial &&
+	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+
+	git init -b main new-sub &&
+	test_commit -C new-sub new-initial &&
+	git -C new-sub config receive.denyCurrentBranch updateInstead &&
+	new_rev=$(git -C new-sub rev-parse HEAD) &&
+
+	git init -b main main &&
+	(
+		cd main &&
+
+		git config receive.denyCurrentBranch updateInstead &&
+
+		git submodule add ../new-sub new &&
+		test_commit new-sub &&
+
+		git submodule add ../legacy-sub legacy &&
+		test_commit legacy-sub &&
+
+		# simulate legacy .git/modules path by moving submodule
+		mkdir -p .git/modules &&
+		mv .git/submodules/legacy .git/modules/ &&
+		echo "gitdir: ../.git/modules/legacy" > legacy/.git
+	)
+'
+
+test_expect_success 'clone from repo with both legacy and new-style submodules' '
+	git clone --recurse-submodules main cloned &&
+	(
+		cd cloned &&
+
+		# At this point, .git/modules/<name> should not exist as
+		# submodules are checked out into the new path
+		test_path_is_dir .git/submodules/legacy &&
+		test_path_is_dir .git/submodules/new &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev new" list
+	)
+'
+
+test_expect_success 'commit and push changes to submodules' '
+	(
+		cd cloned &&
+
+		git -C legacy switch --track -C main origin/main  &&
+		test_commit -C legacy second-commit &&
+		git -C legacy push &&
+
+		git -C new switch --track -C main origin/main &&
+		test_commit -C new second-commit &&
+		git -C new push &&
+
+		# Stage and commit submodule changes in superproject
+		git switch --track -C main origin/main  &&
+		git add legacy new &&
+		git commit -m "update submodules" &&
+
+		# push superproject commit to main repo
+		git push
+	) &&
+
+	# update expected legacy & new submodule checksums
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+	new_rev=$(git -C new-sub rev-parse HEAD)
+'
+
+test_expect_success 'fetch mixed submodule changes and verify updates' '
+	(
+		cd main &&
+
+		# only update submodules because superproject was
+		# pushed into at the end of last test
+		git submodule update --init --recursive &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/submodules/new &&
+
+		# Verify both submodules are at the expected commits
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev new" list
+	)
+'
+
+test_done
-- 
2.51.GIT

