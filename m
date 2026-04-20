Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B36296BCF
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670061; cv=none; b=HhqvFJeXJWu8DBSrQwLBbuYouUao/TjudtxSYPQFJYMIZMc4cVgwpL5W5yEUNd0MVUg4O9TaCQobXfqd/Ik9Dmbr0N7GI4gXCHtR5uEViLAQreKzH10qOGJZ8zzA1ntfiHokCj4vDAG8eiYnOl8VPtEWBC/CrBRorZtcJjmqOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670061; c=relaxed/simple;
	bh=ObdRYQZFYbTS1ePGjWS1xpHk5P/smc3lj+j09EyDTFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnejmHSQc9HwLvFxh1dJpONMUO2YfsXwdvVsA9idwSfAyC11ON49pEx5pZjI4uQ7rYoVpTa2M4qMG5tXCJ5EOl7s9h2RW9bPbFeu/t3yyxQ/21KwdIr6IKva9yMsJr8lZ3arMGT/kGwy5SzEF985nplUkV07uXWRbyEXAnfj7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F9D9LASv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+tv2Q1m; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F9D9LASv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+tv2Q1m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D213EC00DD;
	Mon, 20 Apr 2026 03:27:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 03:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670059;
	 x=1776756459; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=
	F9D9LASvs42kJscKEOd72649ARLM+fc8AdMR+XqL2U2J9sA/8vPGbe1P2vajqfnh
	oBAuX7QM39eHUlhgBAelhy9fjkQUWmHmblQm3QRBDsUwNQic0xh5cmuAtyZpQB1u
	kcV2yMTXSxxkgDBgHj+Ki9zKw6KR9Qq5TtF0rcL/jPVFJkjyKOeMqVMBlLpes6YS
	RxQwZqtJowYEXx1nEwqhHklmgvXKgBttNEiM7DOoAeUEIhmYA9BNtUNuuh5YJFbJ
	Yb5FEhHnhNKXrFTzhTvRmdS2lv4PIKU7QIORH7qssJkx0ZJYCbbD/b0kP4HuKug1
	rVeDfwqBf1rKr+66L21gDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670059; x=
	1776756459; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=l
	+tv2Q1me1A7X7nx605WERx1kYGkQ0dGNlHgOr3lOL7KJ5INqnD6zvT7hlNQOzsY+
	6/9whjrl82oqJMdAd/Vw9ogNetcguOjYKlQyn1laAJPxt61U0dbsaurs04te3JeE
	gtODY/+8cC2QXzp71CzA+2WiFn0WeRTtj83whbCl48A0N/0MbTj6wJKARoGNd+2n
	0nZ/kh40qPpOOsB3WvL+eidPDktJQmqwtkur71dr7MLwAQwj9L6ODd3vFUm9ClzU
	NLlyjT5eZ6TxBzVhb9CHZ1pncAbQJsLBoOFUYUrAWXVfDTpn5gmZ52x6d1Ok1cwf
	ZwUfSjjnZXqQUKJL3bLNg==
X-ME-Sender: <xms:a9Xlab9u5c3EeETPZDGoSQ-AiQCeTM-W-zs3vZyZVhwXQm1Q-cDe1w>
    <xme:a9XlaeuBcumEd5u0qtig65NmpY2Dtfek36t8OIysMRHuldw7M5gG8X6T5_NDpuzjl
    HK4WEhaptO0darDzGDzhEbedTDzcmVLn5ht7hMEvsuTsS7z2m05HQ>
X-ME-Received: <xmr:a9XlaeCACEMA5BAZa_lCa6O1yCF1iobdtv5PwfdeOchBRsnWRtIZXX8TsuD3h6yr4W3vIlaXDeE1Qc0uwdyknmYe3uei6bLF-mitpg9sPIMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:a9XlaWUtCBY2ZqeJv-FNyBZXhagvr99ieuDwPK4sP1SN2KLSimK-Rg>
    <xmx:a9XlacBHodbUJhV1zDbX0lFBbnT52j3p9MgFCzdYRU6FlLmii-oUhA>
    <xmx:a9XlaZ9auDwZ3Cc7tqgJu9GV5V09JSKIPNcM9U5-9j7EYXRtEaBE0A>
    <xmx:a9XlaTGDaHCD4EDEqu62G9fXxbtX97BnH0PdHxrn3jGUWaburu2uQQ>
    <xmx:a9XlaeeO2444JMq_nGRULETMeRt4zV6B2U5XvI7jQxPFN9lAs83GzH-I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d2f495e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:23 +0200
Subject: [PATCH v5 04/12] t: prepare `git config --unset` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-4-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `git config --unset` that ultimately end up
as no-ops as the configuration variables aren't set (anymore) in the
first place. These calls are mostly intended to recover unconditionally
from tests that may have executed only partially, but they'll ultimately
fail during a normal test run.

This hasn't been a problem until now as we aren't running tests with
`set -e`. This is about to change though, so let's silence the case
where we cannot unset the config keys.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 2 +-
 t/t7508-status.sh                  | 4 ++--
 t/t9138-git-svn-authors-prog.sh    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..c98eb6abb2 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -17,7 +17,7 @@ f() {
 
 t() {
 	use_config=
-	git config --unset diff.interHunkContext
+	git config --unset diff.interHunkContext || :
 
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a5e21bf8bf..1167b835a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -773,8 +773,8 @@ test_expect_success TTY 'status --porcelain ignores color.status' '
 '
 
 # recover unconditionally from color tests
-git config --unset color.status
-git config --unset color.ui
+git config --unset color.status || :
+git config --unset color.ui || :
 
 test_expect_success 'status --porcelain respects -b' '
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 784ec7fc2d..5bb38cb23a 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -68,8 +68,8 @@ test_expect_success 'authors-file overrode authors-prog' '
 	)
 '
 
-git --git-dir=x/.git config --unset svn.authorsfile
-git --git-dir=x/.git config --unset svn.authorsprog
+git --git-dir=x/.git config --unset svn.authorsfile || :
+git --git-dir=x/.git config --unset svn.authorsprog || :
 
 test_expect_success 'authors-prog imported user without email' '
 	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&

-- 
2.54.0.rc2.529.gd9106f7525.dirty

