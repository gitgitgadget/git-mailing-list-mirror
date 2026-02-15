Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204C25A2DD
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186796; cv=none; b=DMs2kqhi8dx94MdHfun7fhf2un3f/CNG6dWeS2BlEHOGbU7WZDO2CL06f0mIHAposCqJTzbcqI2/674F9dewofhldp8Vr6ca7cqwbx697V8+IWcNEnT2YHjy5C8auVXMHHDVLYwo29UgJR8iwVNnkS1IOkVDbeOo8lpDC4ArBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186796; c=relaxed/simple;
	bh=9x6TQfjcybZjJAD9tzINK5oCbvIBwCvnKpTMdZnItu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSAdKBzHgtTPIgS7Xu4CRi4QuthRqDJfHa3TotV9LzmJ1I2781YV9V+DuNK8Z0FYqRqDMvoaRuPBlnUAbff2OYP21k1D0onzwDpU+b+B9zpcPl5fsw9og7mL5wM1/nm7YUr7khNWgVuXGWNfWglSzYsZxOgL7fAs2t/kG5IMqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=KQkyorbw; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="KQkyorbw"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriau-008BOC-QI; Sun, 15 Feb 2026 21:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=wjByl8HBZQXJ9CC+6hCOF8Z+8K/hiUUWaDif3XIYJhY=; b=KQkyorbwK44ga9TKiHjlSGRjvu
	oFntI/m4QG8mya7x9WK1oVYe6pfLqeqJKclEfCnISNpGDzIPHZ/1fOg/BgWqq9ru/FDAgnbVCMjkm
	4uXRO3BK2Qrkvo1a0iT2BzD4CRT0SIpSQ1X0650KRsvw25cjXq8KkIl7Ozr0sDt2K+LA9L+pCJoWy
	6snxDrZc5DkLZi3eVfn67nY6VAnM+WPqBJhary8WO52rXocclQhAePZnLkmnQNT/mCS9rVmKg0bn8
	udLpPk3mGvEkqiTkMXXDpjDT0C411K0NGHweR943hgDfYTrubK6iG9yUIiIaQY7VnYkVj8HTdyB90
	HcfKPmIA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriau-0005ps-HW; Sun, 15 Feb 2026 21:19:52 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriab-00E3Nx-4f; Sun, 15 Feb 2026 21:19:33 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Zach FettersMoore <zach.fetters@apollographql.com>,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] contrib/subtree: test history depth
Date: Sun, 15 Feb 2026 14:18:46 -0600
Message-ID: <20260215201906.889951-3-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215201906.889951-1-ask+git@howdoi.land>
References: <20260215201906.889951-1-ask+git@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add history depth checks to some of the subtree unit tests.

These checks were previously introduced as part of 28a7e27cff
(contrib/subtree: detect rewritten subtree commits, 2026-01-09),
which has since been reverted.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/t/t7900-subtree.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3ee2f95d86..dad8dea63a 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -411,8 +411,9 @@ test_expect_success 'split sub dir/ with --rejoin' '
 		git fetch ./"sub proj" HEAD &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
 		split_hash=$(git subtree split --prefix="sub dir" --annotate="*") &&
-		git subtree split --prefix="sub dir" --annotate="*" --rejoin &&
-		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+		git subtree split --prefix="sub dir" --annotate="*" -b spl --rejoin &&
+		test "$(last_commit_subject)" = "Split '\''sub dir/'\'' into commit '\''$split_hash'\''" &&
+		test "$(git rev-list --count spl)" -eq 5
 	)
 '
 
@@ -442,18 +443,25 @@ test_expect_success 'split with multiple subtrees' '
 	git -C "$test_count" subtree add --prefix=subADir FETCH_HEAD &&
 	git -C "$test_count" fetch ./subB HEAD &&
 	git -C "$test_count" subtree add --prefix=subBDir FETCH_HEAD &&
+	test "$(git -C "$test_count" rev-list --count main)" -eq 7 &&
 	test_create_commit "$test_count" subADir/main-subA1 &&
 	test_create_commit "$test_count" subBDir/main-subB1 &&
 	git -C "$test_count" subtree split --prefix=subADir \
-		--squash --rejoin -m "Sub A Split 1" &&
+		--squash --rejoin -m "Sub A Split 1" -b a1 &&
+	test "$(git -C "$test_count" rev-list --count main..a1)" -eq 1 &&
 	git -C "$test_count" subtree split --prefix=subBDir \
-		--squash --rejoin -m "Sub B Split 1" &&
+		--squash --rejoin -m "Sub B Split 1" -b b1 &&
+	test "$(git -C "$test_count" rev-list --count main..b1)" -eq 1 &&
 	test_create_commit "$test_count" subADir/main-subA2 &&
 	test_create_commit "$test_count" subBDir/main-subB2 &&
 	git -C "$test_count" subtree split --prefix=subADir \
-		--squash --rejoin -m "Sub A Split 2" &&
+		--squash --rejoin -m "Sub A Split 2" -b a2 &&
+	test "$(git -C "$test_count" rev-list --count main..a2)" -eq 2 &&
+	test "$(git -C "$test_count" rev-list --count a1..a2)" -eq 1 &&
 	test "$(git -C "$test_count" subtree split --prefix=subBDir \
-		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
+		--squash --rejoin -d -m "Sub B Split 1" -b b2 2>&1 | grep -w "\[1\]")" = "" &&
+	test "$(git -C "$test_count" rev-list --count main..b2)" -eq 2 &&
+	test "$(git -C "$test_count" rev-list --count b1..b2)" -eq 1
 '
 
 # When subtree split-ing a directory that has other subtree
@@ -477,6 +485,7 @@ do
 			test_path_is_file subA/file1.t &&
 			test_path_is_file subA/subB/file2.t &&
 			git subtree split --prefix=subA --branch=bsplit &&
+			test "$(git rev-list --count bsplit)" -eq 2 &&
 			git checkout bsplit &&
 			test_path_is_file file1.t &&
 			test_path_is_file subB/file2.t &&
@@ -489,6 +498,7 @@ do
 				--prefix=subA/subB mksubtree &&
 			test_path_is_file subA/subB/file3.t &&
 			git subtree split --prefix=subA --branch=bsplit &&
+			test "$(git rev-list --count bsplit)" -eq 3 &&
 			git checkout bsplit &&
 			test_path_is_file file1.t &&
 			test_path_is_file subB/file2.t &&
-- 
2.43.0

