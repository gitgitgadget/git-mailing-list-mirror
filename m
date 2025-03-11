Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42012264F83
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728315; cv=none; b=EnIWbYZgVkkamWxURfKCQGzw9geQzfMsb9whQwRYd7Msxx2znGVUYZgpwbFu7C3HipD88ZxE9uuItmseJ/qbHexZsHOaja7XZFqaAtYhY5LNFHQdOmli+B+A4wyQ4+h1hs3s/MRie2dJcLhw0LwAc8vpyJw5YWuPhJa8X0P2/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728315; c=relaxed/simple;
	bh=P2Ot7d44b7yZCoOG2d4AIRCR+SfY7GARQ0oLEtpj/G8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8+/1tw6KvuE/MrDCBJ1yS4gC810ttFNGx5DL6GdAdVc3AIMijz/VppgDwK0qQ4UPhWMr3cdHoEjkHEIDVMZVVMcQ5GptYuTD3Ns92H3FM0clTWAmBXaqXqomRH9w467ocLkQyn2f6ST6JevdkSfimGNcH7V29RBvKZc+WChCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hEqSHxUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yPyKYWl4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEqSHxUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPyKYWl4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 50B101382DC2;
	Tue, 11 Mar 2025 17:25:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Mar 2025 17:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728312; x=
	1741814712; bh=nhICu5J/+1GMMSWcwSB4VjN1IQN+cad4LG3zv0a8/GU=; b=h
	EqSHxUwMd5+r1JfdMGLHeIlX60G8YazaiWV27sbD6tdyjgSSkiMc3mtQHoLgOWX4
	jXTanUUimINQYirs/C4X9bob95HEcNe2Ua00xKLCcTqRzWrZSqzrDHSrcMm4aNZT
	vaCPIWMhp9dlM4TeqnIC6B8zFkVQzsXI+mxfUooVQMComvKHz6b0WcA4kiiESvMu
	zAsODtGdLVHH69LmhmuxP2yhpa5Wloxa49oOptihImH8KGYxthJOi7Fsy8/1mmBO
	Jmb639SwAabJNGcXA+kNin369m1o7F6V2P90LEo/F2esAsaxoSTPkuHFopBb7u2z
	0WLkOnnHVWol2morgsozQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728312; x=1741814712; bh=nhICu5J/+1GMMSWcwSB4VjN1IQN+
	cad4LG3zv0a8/GU=; b=yPyKYWl4ZdFF/qgLrvPLhK4VFr4AbLp6qa5pRTEG1Zg6
	a+Dn0kuau8Bj8vmY58AuJw2xqS1HFnaZ6cjRYRWq9S784v4St24n0d7OBnnLcZBb
	rkoNPJcAbJNfetURiEmcNwftn8g8stSK/9MgxWghD8i5fb+UwGemyeKUGiezvql8
	MHqe+LqtZKHG+flHjuAVOHnkXSpX6jMAZ53h5xY/CIUzad+5y7QT2fAyHxbhOLbp
	9QLW9N8bvkNs+3B0QTVcXFZ2cR6D0jdVZHaW4Jm2BDq60BaRFQWylFT1dGpiCTtw
	ECV2RHgFSTjIFw5IKfEv09gxZSL/+eX89lXroRXe5A==
X-ME-Sender: <xms:OKrQZ3R8Pg3XDsEewS7bRoGHbx1SS8B2YI2gshDjiYBEJZNweZ4gXw>
    <xme:OKrQZ4xRUWIyIIhNG9lDTflI975pKKmXtftdeB_MgebgA_gpPSdLafip6CKdkYGmL
    o8Rfl1v85t1ZemV8A>
X-ME-Received: <xmr:OKrQZ83YU3i-lhKC5Y-Kl98UPXTFyOVindMXLGfN86Zh7b7dvCFq-z2us_hwUHm3Of0An1-rM-yCdG25FkZOjTP0SVejQcX2Inhf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OKrQZ3DpWngL28wbGa77fSMODGV3ziLaAyg0WGRLHxyM_qDikzXD-g>
    <xmx:OKrQZwjJ83sb1aBKnmAYPAoMFz0ivTjJHlPwarp53uJWU2DFDt_5aQ>
    <xmx:OKrQZ7pksJF7v3yUaF7_FvHHPyGJFhusgK2_wdOWn5uQRY9mQYrNPA>
    <xmx:OKrQZ7iQrxy-4lqfAapivrj9m__SWauuGQrl1AmI8lQdpm4LbRX-pA>
    <xmx:OKrQZzvvOyfxy2SvvTvL25nWMVJ-VPI9x9bsnU3jfVqxP4hsrRgeTEyE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/6] t: introduce WITH_BREAKING_CHANGES prerequisite
Date: Tue, 11 Mar 2025 14:25:02 -0700
Message-ID: <20250311212505.2920181-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier c5bc9a7f (Makefile: wire up build option for deprecated
features, 2025-01-22) made an unfortunate decision to introduce the
WITHOUT_BREAKING_CHANGES prerequisite to perform tests that ensure
the historical behaviour that may be different from what we will
have in the future.  It would inevitably invite double-negation when
we need to add tests to ensure the behaviour we want to have in the
future.

Introduce WITH_BREAKING_CHANGES prerequisite and replace the
existing uses of WITHOUT_BREAKING_CHANGES prerequisite.  To catch
any future topics that add more uses of WITHOUT_BREAKING_CHANGES,
introduce a mechanism to mark a prerequisite not to be used, and
use it to mark the removed prerequisite as such.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5323-pack-redundant.sh    | 2 +-
 t/t5505-remote.sh            | 6 +++---
 t/t5515-fetch-merge-logic.sh | 2 +-
 t/t5516-fetch-push.sh        | 8 ++++----
 t/test-lib.sh                | 7 ++++++-
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 688cd9706c..bc30bc9652 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -36,7 +36,7 @@ relationship between packs and objects is as follows:
 
 . ./test-lib.sh
 
-if ! test_have_prereq WITHOUT_BREAKING_CHANGES
+if test_have_prereq WITH_BREAKING_CHANGES
 then
 	skip_all='skipping git-pack-redundant tests; built with breaking changes'
 	test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index bb7e0c6879..82fccf8e36 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1123,7 +1123,7 @@ Pull: refs/heads/main:refs/heads/origin
 Pull: refs/heads/next:refs/heads/origin2
 EOF
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/remotes' '
+test_expect_success !WITH_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
 	origin_url=$(pwd)/one &&
 	(
@@ -1149,7 +1149,7 @@ test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file i
 	)
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches' '
+test_expect_success !WITH_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone --template= one six &&
 	origin_url=$(pwd)/one &&
 	(
@@ -1165,7 +1165,7 @@ test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file i
 	)
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches (2)' '
+test_expect_success !WITH_BREAKING_CHANGES 'migrate a remote from named file in $GIT_DIR/branches (2)' '
 	git clone --template= one seven &&
 	(
 		cd seven &&
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 4e6026c611..8ac04d742c 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -104,7 +104,7 @@ test_expect_success setup '
 	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &&
 	remotes="$remotes config-glob" &&
 
-	if test_have_prereq WITHOUT_BREAKING_CHANGES
+	if ! test_have_prereq WITH_BREAKING_CHANGES
 	then
 		mkdir -p .git/remotes &&
 		cat >.git/remotes/remote-explicit <<-\EOF &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85ed049627..6e2b233157 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -975,7 +975,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	! grep "warning: updating the current branch" stderr
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches' '
+test_expect_success !WITH_BREAKING_CHANGES 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
@@ -991,7 +991,7 @@ test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches' '
 	git checkout main
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches containing #' '
+test_expect_success !WITH_BREAKING_CHANGES 'fetch with branches containing #' '
 	mk_empty testrepo &&
 	mkdir testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
@@ -1005,7 +1005,7 @@ test_expect_success WITHOUT_BREAKING_CHANGES 'fetch with branches containing #'
 	git checkout main
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'push with branches' '
+test_expect_success !WITH_BREAKING_CHANGES 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
 
@@ -1022,7 +1022,7 @@ test_expect_success WITHOUT_BREAKING_CHANGES 'push with branches' '
 	)
 '
 
-test_expect_success WITHOUT_BREAKING_CHANGES 'push with branches containing #' '
+test_expect_success !WITH_BREAKING_CHANGES 'push with branches containing #' '
 	mk_empty testrepo &&
 
 	test_when_finished "rm -rf .git/branches" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9001ed3a64..fffbfb89ef 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1862,8 +1862,13 @@ test_lazy_prereq CURL '
 	curl --version
 '
 
+test_lazy_prereq WITH_BREAKING_CHANGES '
+	test -n "$WITH_BREAKING_CHANGES"
+'
+
 test_lazy_prereq WITHOUT_BREAKING_CHANGES '
-	test -z "$WITH_BREAKING_CHANGES"
+	# Signal that this prereq should not be used.
+	exit 125
 '
 
 # SHA1 is a test if the hash algorithm in use is SHA-1.  This is both for tests
-- 
2.49.0-rc2-181-g28e223d67e

