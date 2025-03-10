Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA31DE4E9
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648619; cv=none; b=EwwF+cPRoayELDTuRhwYNhi2JpiE9SjfoxhaceKRTlSfSXmxfhefBWC01ptoriPTk4lAJniPXUXrdouuNnxyqoQfOVjLPX46wAbHCxyBeJ284BtISvPDzk2Ck2AVxp11pGSDw2IX75AVixzO1HFYiJqweWm/A/qbLxu2AhwnbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648619; c=relaxed/simple;
	bh=FetDEzY9RnQTXc9T/j0KLAAbCScZsk8I+Nmd3UazVq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIKM826fAsIhR6Vu+kt/PkW+JdCHO2R9oJ8T/KW6rtJMLweUPerAlwGMFr2RvS5YTEd2RRj6MmNiANYDZ3I92X9EqxKnoY+LZvFrHbOFQp7DPiTysCKh4yTgtOuuHPdYCIg0DSkg9p5Cu8shcTYjTIqZowM05d4V+7hwhgDDnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jGRBYPIN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixUUzxOj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGRBYPIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixUUzxOj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E957111401D5;
	Mon, 10 Mar 2025 19:16:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 19:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741648615; x=
	1741735015; bh=m7ZHKoawOliuVuFL74IMD/GaQTgWWUPcZWjfRgtCYXQ=; b=j
	GRBYPINZSRTmh5FEvGWpUc3s7RCveg/ITT8YtfSVsxsb3nw9sd3/DL290bMs/1uF
	/VrVvGCaelZ36NFOXpMbQNtzkb+bUT78YWA7AmWEoCXhDcEAvXelbGm763K3yu5R
	AOypeGaluj+POBeBimf0CRaie1ZAkYKDQ4J4y0+aAnd6s3uOdv3fTMtw3dgQoA16
	pmOsOvR2iDfOE4xA1rx73oc0wyyEe2UcS07FfuDqc2rn38rQ+KNACj7TQ5D2aSl+
	5FXgqFCqR6aDv2+e9H5P0jkhvkSa6Eo+SyMKe8rOheAQwujqyWsgbIWmezKdafpq
	qEQg3YoZ32MAtMlxQlu3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741648615; x=1741735015; bh=m7ZHKoawOliuVuFL74IMD/GaQTgW
	WUPcZWjfRgtCYXQ=; b=ixUUzxOjOnqWqyoKuVr8tUzF/0C5L4qjnd1Zkqqzq/lp
	oXfO8czB0K90ZCf9esKdA5LFr5wkRfkcZ7pqw1gjJ99GFnC1UE2sqVmBV7DcSyQB
	jS5UyOMSGL4/aGPwY8AZWFZJKpfWRXWMVSf5bKaoj7d6vKOSKUHe8qR+Rqipcf7C
	b06WgRWZ5Zsj8Q8AzVGHOszLhgCpSVL5fz2OVFFEH4UabxagpNx7XGRq+/2y4cG6
	74KxE50wITs1srGAVmWvtEjbmEZud8TN7/PWwR9zDbsethK5y0chr5jy1eJnGgyx
	+CXRHCDLoBxMNE0UNk7gQOAenNP1xxRYh0v2aK8mTA==
X-ME-Sender: <xms:53LPZyeveRP7ZjqTW_k-eXEnUFpLRJ5ygFuZki8PHFwOj0vRFBC1zg>
    <xme:53LPZ8O5FjAaTwR6kNuBiorHGMBrokCYumjmgwacNIYE84JsXBFClNRDG9RzY9N36
    dvIlZNWskagIvaDJg>
X-ME-Received: <xmr:53LPZziitjUD6tG9rihbwuFeNLUEccaciomYLrl-tYJ6Kif9KW1p1MAZ_XGzpOkm5J9QL5vkTCEK5dDM6cxO_KzXzN9JTFjLwXy3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:53LPZ__NBFWJsCCVKyOfP6g5BNiWhrp6GRUnsn1jIl9pXT0c19JhMQ>
    <xmx:53LPZ-uTdskJkft2vxAzt-HICU3Fv8bxSIW3Ei_foFRMgVllzkz--A>
    <xmx:53LPZ2G57Pf8mvEa1p2tl_4-GP3sUdO5KmV08KMjjE4S8CDdD8YbOw>
    <xmx:53LPZ9OlYbTVzQ9iaRlKLHwdFjuZJh6TH0suMotfQjHRFf80_xVcfg>
    <xmx:53LPZ34T6rC7iUytVfbOIm1IDpouAQTEvEGwlXfFHB62WySZuZz-s7dX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:16:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 1/4] t: introduce WITH_BREAKING_CHANGES prerequisite
Date: Mon, 10 Mar 2025 16:16:49 -0700
Message-ID: <20250310231652.3742490-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-173-g4d16673c2b
In-Reply-To: <20250310231652.3742490-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
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
have in the future.  It would inevitably invite doulbe negation when
we need to add tests to ensure the behaviour we want to have in the
future.

Introduce WITH_BREAKING_CHANGES prerequisite and replace the
existing uses of WITHOUT_BREAKING_CHANGES prerequisite.  Some
in-flight topics that add more uses of WITHOUT_BREAKING_CHANGES
would still need the old prerequisite, so let's keep its definition
for now while we'll eradicate its use.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5323-pack-redundant.sh    | 2 +-
 t/t5505-remote.sh            | 6 +++---
 t/t5515-fetch-merge-logic.sh | 2 +-
 t/t5516-fetch-push.sh        | 8 ++++----
 t/test-lib.sh                | 5 +++++
 5 files changed, 14 insertions(+), 9 deletions(-)

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
index 9001ed3a64..12fe82f660 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1862,6 +1862,11 @@ test_lazy_prereq CURL '
 	curl --version
 '
 
+test_lazy_prereq WITH_BREAKING_CHANGES '
+	test -n "$WITH_BREAKING_CHANGES"
+'
+
+# DEPRECATED; DO NOT USE THIS IN NEW TESTS
 test_lazy_prereq WITHOUT_BREAKING_CHANGES '
 	test -z "$WITH_BREAKING_CHANGES"
 '
-- 
2.49.0-rc2-173-g4d16673c2b

