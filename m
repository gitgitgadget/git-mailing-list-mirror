Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D362EC0A7
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111867; cv=pass; b=nHicDMWid4vhf4Bw+GuZjsW7psjKSRl61OMAf0kYMUW+PNknwstVeAsZp8makNuGPRxCseZclgg2lIVAUM+7vRSpn5MkH82O/uqbemJHlJeIASHnlILR9VoyAc6dUr41ICQZK8SudcQGbpu/jxuN9O/+2yQDbo1Ez9AawVl8rco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111867; c=relaxed/simple;
	bh=bewPntsPEv8Rh9sXJjgGCfVNVSMn/uSNgeZ/KYd0DbQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfwQZkI12xi1t9yy/1ZZeP2bmUc4BVHKtq5YZzRy54Hgw4yIiENJK4B9/L1P1N2KQVFbb4iQCf9VsPgLv9uR47yk9a36Kc7Gnj1FF0bV5oHQKOz2/QxuSuXP9gIrTfqVLVAVQGcFY5OZIdNB5FZ8suMTEZddrCAl+e6/8+pkmLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Lg1MPQg5; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Lg1MPQg5"
ARC-Seal: i=1; a=rsa-sha256; t=1761111647; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cQSN/kAWJ6mQfK17fteiac4rCs3Zg0tPcfI7XgTLhgzUJk7f1JTTadk3w70s9iOvIWznECCZWd2NJze3Vwg1kFoEGsEAiESYu4kQeSdcLeb3lj4aJypAU+RG1VgZTbSfAPx1/E37GN2G4Sf2RtjMTjCB67/kfcnA9IGkRXSPqAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111647; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=FPTwgl4c1gxjkrAd/eAJaqm8roSET7DDtCfx4D8U5vE=; 
	b=hzdPB7cczZfxO9/l6Jdi6rgFy8wSq7hjk9BJFXKBGHJYo01WU4C9ESliThq6wnJ2ZgWMEfyactccLqN1nTzrjMM8aZkb3HtIcaxo+6hHhPuujQjtzPCB1UIbZ/MsrcuJXtiQ8UhQ15Z1/B5LpbsStqXpJr/lQ1YmcWcc0sY2Et8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111647;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=FPTwgl4c1gxjkrAd/eAJaqm8roSET7DDtCfx4D8U5vE=;
	b=Lg1MPQg5y/sswfXOBfu1r3onnHcglXDSHXCOUpMpM+Mnrno6VhjS6GMNiQ1oZoRh
	epxGEJ06GrXuY5bPOOcdaJcv9pJYhIISZyH14HLxDT2MVr9yIb8XB4cOfmKek89LkMd
	qElmV6kOs4CA60646t6Q0XtE9Ynrt4nqV/dVdiU4=
Received: by mx.zohomail.com with SMTPS id 176111164509188.61106828811648;
	Tue, 21 Oct 2025 22:40:45 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 24/29] t3440: use helper for trailer checks
Date: Wed, 22 Oct 2025 13:39:44 +0800
Message-ID: <20251022053951.602605-25-me@linux.beauty>
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

Introduce expect_trailer_msg() to wrap test_commit_message
and dedupe the trailer via REVIEWED_BY_TRAILER.
Drop create_expect and temp files. In the conflict case,
assert on HEAD (rebased "third") instead of HEAD~2. Update
--apply rejection and --root tests to use the helper.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 4687be3a21..4b0b0ee2d3 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -11,11 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
 
-create_expect() {
-	cat >"$1" <<-EOF
+REVIEWED_BY_TRAILER="Reviewed-by: Dev <dev@example.com>"
+
+expect_trailer_msg() {
+	test_commit_message "$1" <<-EOF
 	$2
 
-	Reviewed-by: Dev <dev@example.com>
+	${3:-$REVIEWED_BY_TRAILER}
 	EOF
 }
 
@@ -32,7 +34,7 @@ test_expect_success 'setup repo with a small history' '
 test_expect_success 'apply backend is rejected with --trailer' '
 	head_before=$(git rev-parse HEAD) &&
 	test_expect_code 128 \
-	git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
+	git rebase --apply --trailer "$REVIEWED_BY_TRAILER" \
 				HEAD^ 2>err &&
 	test_grep "fatal: --trailer requires the merge backend" err &&
 	test_cmp_rev HEAD $head_before
@@ -73,23 +75,20 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
-	create_expect third-signed "third" &&
 	test_must_fail git rebase -m \
-		--trailer "Reviewed-by: Dev <dev@example.com>" \
+		--trailer "$REVIEWED_BY_TRAILER" \
 		second third &&
 	git checkout --theirs file &&
 	git add file &&
 	git rebase --continue &&
-	test_commit_message HEAD third-signed
+	expect_trailer_msg HEAD "third"
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
-	create_expect initial-signed "Initial empty commit" &&
-	create_expect first-signed "first" &&
 	git checkout first &&
 	git rebase --root \
-		--trailer "Reviewed-by: Dev <dev@example.com>" &&
-	test_commit_message HEAD   first-signed &&
-	test_commit_message HEAD^  initial-signed
+		--trailer "$REVIEWED_BY_TRAILER" &&
+	expect_trailer_msg HEAD  "first" &&
+	expect_trailer_msg HEAD^ "Initial empty commit"
 '
 test_done
-- 
2.51.0

