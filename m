Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675702EC547
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111793; cv=pass; b=d2IXfup20BxEBPUVy3cSdSE/MvR4Ly8QbxMf6MmOK3JFZddkYzQ0U1eFEktbt35bH9iii4/onovV2PCrO6Gfh1ha/xLyMbnmFMiBaIXizYU4hLdtQ0IHujlhbJEYyyjzjFa2Eh7cyYnSuKxqrrV6jIkmKnuYFLqCcT756DtBHME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111793; c=relaxed/simple;
	bh=Rdw/fKoQxDsUMqVouIvdFQPGH7umBCT1PIGwyBTBKJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVgGWWw1Iow7HB680Y49vqV7NKpc5jYJYqMbCOpKSL23tGSV9VKNrDVIi4LmWuC5u7e1sxPpURuh429ZhRBX9CfXSwzNJG0eBVw88gDLzvEJjmU8Oz6KlAZu2VZOwmfB+WoMZTqdrbQwVYVhDCnTWMhL/qcFIK8K6z3l7hyGeoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=VKYbfWsB; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="VKYbfWsB"
ARC-Seal: i=1; a=rsa-sha256; t=1761111633; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SuIRwLG2EgF3LprJgyPEXD1fS2lDxYebljWT6Tw5cVLgxCaDdvk8voKJKnOnDYO/rFo/6pmpQokUzl7FrWO+vRyRWcHd/ZJNnwbzwWEsxtcZUfDtyxy1Q7g664jXfH5lOrxUEBCYye2P0m8/Tr1Y1O17w2F9wAeK+bGg2FZASOM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111633; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=weNXQDOxAK+eB0ymVhyUxftR2EzlGnHyq4cRF+V0lsY=; 
	b=KlK9bJ+WD9QotFLSuFo3jllUd6pGB3dqVzBBk/WjJIIMbsMgit8TSW9xyT5uH2Ri/ya6YNDgJmNVcGmgaFWyf1I63gos1TOT6LX9nEATmQ/iLnxTaAGX6pt+oX2gw5Qo+KnLLOTzngU8hEFKOX3AVZv5nzc0Z35XykhA4chP9CM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111633;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=weNXQDOxAK+eB0ymVhyUxftR2EzlGnHyq4cRF+V0lsY=;
	b=VKYbfWsBjsEBpqYPiqk4O5NFVhQvmdGpEENatFHXH167zUu51JWQ0Cg17s09CrkG
	/rx8rhwu5BEFJJOqQ0a1n7m/YbcbILuNUDBjIo2xMCJSRpyaCqX0xmaf+cXMyUOFGP1
	lfEiROQ12l39ihrcD9Vbx3NajjFPxxpG6Pf2bmYI=
Received: by mx.zohomail.com with SMTPS id 1761111630376869.9252619907162;
	Tue, 21 Oct 2025 22:40:30 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 17/29] t3440: create expect files at point of use
Date: Wed, 22 Oct 2025 13:39:37 +0800
Message-ID: <20251022053951.602605-18-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Created the expected trailer files within the individual rebase tests
that use them, simplifying the shared history setup and avoiding unused
fixtures.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index b1c7b03330..a8108f2296 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -26,14 +26,7 @@ test_expect_success 'setup repo with a small history' '
 	git checkout -b conflict-branch first &&
 	test_commit file-2 file-2 &&
 	test_commit conflict file &&
-	test_commit third file &&
-	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
-	create_expect initial-signed  "Initial empty commit" &&
-	create_expect first-signed    "first"                 &&
-	create_expect second-signed   "second"                &&
-	create_expect file2-signed    "file-2"                &&
-	create_expect third-signed    "third"                 &&
-	create_expect conflict-signed "conflict"
+	test_commit third file
 '
 
 test_expect_success 'apply backend is rejected with --trailer' '
@@ -74,6 +67,7 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+	create_expect file2-signed "file-2" &&
 	git reset --hard third &&
 	test_must_fail git rebase -m \
 		--trailer "Reviewed-by: Dev <dev@example.com>" \
@@ -85,6 +79,8 @@ test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
+	create_expect initial-signed "Initial empty commit" &&
+	create_expect first-signed "first" &&
 	git checkout first &&
 	git rebase --root --keep-empty \
 		--trailer "Reviewed-by: Dev <dev@example.com>" &&
-- 
2.51.0

