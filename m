Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3F420898
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342884; cv=none; b=bKf1djoEf1bg9CRmWthPeoiyFCETVm7Sipp4AKNTAE7svosb7UMKFQ3591yJFnUM8kVF6c9csZj4hGsbqz0TVzGJaaErA4VuD7rPfI1+dGpyrBJ/R4Sgp+lbwyimKGL8TIYziBniEDBgLwLBrYXW+O1W+ky+MPDfrmmzqhDNiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342884; c=relaxed/simple;
	bh=RRtC0cIK4kr78NBvX+MU4z+gy9is5cyEDgM8gxKGhNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3KJD+Ac56Bsf63bs20jGKA1Vui9nX0lwfjqib+7G2vcwzITc5764+s8sFNNje2Bxf+l0iCNvz30cGpIW4DP6mixBOi6ONHDtSri10db6BZAxL79mVN+yO7VkHkRvhcf2jEOulpF31HXBMahEVv32A+BAw6LyWrsQVICEoRjyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=tWIuVozy; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="tWIuVozy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=l.chiark; h=DKIM-Signature-Warning:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6MGZiBsM8Vocchq0T0rZPMck/O65QwzJfzezHNvpyTc=; b=tWIuVozyLQoWcsr46SH0ahaIXi
	s/0sSWUohoFc3s7fn6Vdy05HPpD3HwIsSqWzucAaIYfwzSlCw7tH3+lJdnsN2vo2PpBrB+Xezz5EA
	ZYtGKNt+NPhqiFPxrTYz38VgLTjHJJh+5J1H2dQaOQB4+lmUzhY6Ox9EYq2e1Toe06WlWfb7vlQb6
	ZXlgC1J9BKKRHy6osDTcFJs+MKt8KPJqvqkxEvFyV9l9fFSEikAPSHlSxaCphrrfqPRzKT12Pvqzu
	8kP8HwwQThKJ2wKUCFlI7q94kUmDyAK+hGe8rWS2LctgcVV6VnQA8ek30nHSBHCd96KnuDA2qbHke
	cHKZLanQ==;
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
	by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with esmtp
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wghy3-0000qE-Dk; Mon, 06 Jul 2026 12:58:31 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
To: git@vger.kernel.org
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: [PATCH 2/2] git-subtree: Bail out if we find output from Rust rewrite (test)
Date: Mon,  6 Jul 2026 12:58:16 +0100
Message-ID: <20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/26/2626ff584df1644c89bafcc8f3c9745f.pem

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 contrib/subtree/t/t7900-subtree.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 4194687cfb..e8fa640166 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -439,6 +439,24 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	)
 '
 
+test_expect_success 'split fail on RIIR git subtree data' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD &&
+		# simulate RIIR git-subtree generated data
+		mkdir .git-subtree &&
+		echo "# sabotage" >.git-subtree/config &&
+		git add .git-subtree/config &&
+		git commit -m sabotage &&
+		test_must_fail git subtree split -P "sub dir" HEAD
+	)
+'
+
 # Tests that commits from other subtrees are not processed as
 # part of a split.
 #
-- 
2.47.3

