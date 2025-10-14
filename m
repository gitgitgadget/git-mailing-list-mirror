Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34748313E13
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444930; cv=pass; b=lLCeXbp3X4zH46guCtBvnhLi/yeyK7E0Z2rWXX+fX3TpjJObI2/FhKDTlWpqKVWEO3XzDC811DS/K9KZONT/tEHtBVVrctSLHXwM+zR0yh8ueOMIAImPN0ig2O7IOUcxqE/xjIgUZ4n7yCyflyICA5RMAuwApzQwpUQOUvLXKwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444930; c=relaxed/simple;
	bh=6Rtl/OQBvaUWUruDKPosElnE6R2bz+qk77ghx07u9F8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmAT05+06dH+ZmgdGsNbUD1wzZzc+MsF4rzAA/vcjoM21bFFaPAfCa9S0dFbZY4JgV7bndhOYl0v0rouvybXkXdJYmm7RqtwkmZPn4f3JClMWTjuRoPf42YGuvOfYIWQ+2UoYrTPgGeiDNHZaVkaJstty8qBTB9gNqSbuO04j9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=A+C9bDwq; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="A+C9bDwq"
ARC-Seal: i=1; a=rsa-sha256; t=1760444780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jGmThpX74D7j57tfo9ikxrnmXnAnBFks7tsCQV1ZerhIb5luK+LWgstXRs0tCKL7Rqg3zqMuja2K7Yt6lCyuYvuT1qanowmKSbPO7687YKlIOsVJlO+pxpK8F3Z2+NJql3PBTNFX0eTEc9iV/IxaT6AAJR8EgG9uclbo75U5PDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444780; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=CVr2B+25DjcCXIG+0K7PVWksiGK5OCryGzzdZRaQw5c=; 
	b=B9sr+Jm9khj1tHfDo1F+fqMwrDMKZfYvnZs62Z4gCPG1L6REASnKSylpmrEcyTmHwB5hqGvgOb66S9NI91ivXWQuSWVJFVzwnZABdju0NhgBGe4qY8QhYBRFDjc6uqSeBhVWpNQ7gp7QXJMWxXToIDiLQ2sjqjzRqw8tfiyQk9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444779;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=CVr2B+25DjcCXIG+0K7PVWksiGK5OCryGzzdZRaQw5c=;
	b=A+C9bDwqaCwo5XZ3O5FlHQuEBVkuHMCjm1M0/UbsIuQwMZMS5CmLCiZ2Ef4mVFBJ
	cW4egx65MiM4rPry6/adNiLlU2ARMrL/5MQlWfvaEOBRkjZ9O7+z34Q9PWcGismJUCY
	qT1W6uiX04kObFE3E31pURkroO0qrcEh+uFtZvDY=
Received: by mx.zohomail.com with SMTPS id 1760444772509229.64697258665024;
	Tue, 14 Oct 2025 05:26:12 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 24/29] tests: t3440: use helper for trailer checks
Date: Tue, 14 Oct 2025 20:24:37 +0800
Message-ID: <20251014122452.1851103-25-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
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
index 2315a0c86c..36f11f579e 100755
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
 
-		Reviewed-by: Dev <dev@example.com>
+		${3:-$REVIEWED_BY_TRAILER}
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

