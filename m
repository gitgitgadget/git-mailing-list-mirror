Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8123914EA
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338383; cv=none; b=t7Ddvcg4IYganEWuHziMUMm9yjh833yCxtoMuWTcvAZobO5Bb66SP+kMZsAjYCTUQJsvNiJVUbSyACScvSyle71GMrcNUBZREwFz6SKUb8cpoWqsK3lfv+FAX9tiZEJU+ENQFHARyk1ccAqereupbkFZi0RsbVrBZ+e/Sff366Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338383; c=relaxed/simple;
	bh=ObdRYQZFYbTS1ePGjWS1xpHk5P/smc3lj+j09EyDTFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRvyruXZt4xIhBrBfr/UPPap4SJfx9hM3GnxKT41ESM1oP6YEAwdcsfeJLZG1tm7zj6vgnYqY1UFWT/OKYHH+YNLui76+I7pqR0oEqGNB5M0JnEpgihlVso80dIYx9VDrrn7yS7sfaQ8ZEyZshbz3K0kTzyXyFXOryJhlKBOKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqZHqzd6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g6XusdkW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqZHqzd6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g6XusdkW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 342CE7A0272;
	Thu, 16 Apr 2026 07:19:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338381;
	 x=1776424781; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=
	lqZHqzd65boklBQkvQ+VHvUpLnvVK7sUfMgeW3OiXouH2Zb+bf6YtHHm03FX1dDb
	2wxkydpZN8RRlJ0KYOC68z8rRAj+sjpNpSW+gdJ7OX0saoYmPUfyYuLuQ9eVmc0O
	VJhvHZJ4S0Fcg0Dk6ZQ8596RvCpHGxZA1i07pk08hbf2r8W9zd211pHdQx7BZkkP
	DvHMmmJryLndbcVmlMA/sWEe3LTOB3SN5jpUVX1iLf7XHMYQsjFhQLu9Q9e1xg7i
	b8OhjbC5aw4teyckmgMcC/4sFaUARdlxY+ROFm2mnqBMT6XhKCk0Hlqnbn6vquw0
	3uMMxa1RM6itgcIWBq8Xhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338381; x=
	1776424781; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=g
	6XusdkWFbZg1S+FHRfp75vl4dhz3Nv0gyQI8HsefCg17s/DyS7PndF7x2Szeum8F
	LtdrpG3F1uGf3PjBPVr397j/zXybLRQTQDNRz4kWwES/CDAwCLKuSTOLnwy/JBFU
	FXEon7/slomjA4iQopmu1LDawNl/p2pkn6cjyBr0Nvuk7K87Wx0AaOsjDyIFDMl7
	dXRhGmUMNWCqDijEGuK8YwNnMu4XTYXPEqEdjA7oHX23fP+IeaQoPC+xcP0VQoy3
	LtEd/B5XgiWlTloR/D277qfdE9LdCMb8Uxla/BIXoVGZx94Zl4W3ZUV0+KSLpCA2
	jjqcJpuzThUwgxjqoYoDg==
X-ME-Sender: <xms:zcXgacP9OEMtGb4qh_69exEbvB73bPxcks5-loYfSVAfPzObT9nepg>
    <xme:zcXgaaY1144s9ebAdoKerRheG_SqrirhI2DIrhhPpjvubL2Q-uV7ZnZezmQp21j1S
    HHY0TDG9BctnwRsSWo44drMm_zefUx0hkX0hKMmhpoy7RvUV7PWOg>
X-ME-Received: <xmr:zcXgaQoEW8khenwdlrnv9W1HVb8CVgU13Gk_e8L7rLmmy4Je02glA5dM4VOxZOA0lUGR_m8Db8L7Lki1yqEBk79T-BIhrmHuYIuJPHFffg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:zcXgaeY3ZM8AowcyiLi5-_3D1Tpzb-_bXZmwi0Pe452huRHrEvsMoQ>
    <xmx:zcXgaYTsTb5wInM3wptK9D68buhi1gTjOvQCJQApk7PTtfG5_ub_fw>
    <xmx:zcXgaV7N7ZXWC-0A6RunRdSjE24mdM_e76rUz0hbVnctjXZoqFm_ww>
    <xmx:zcXgadzuPcFYh2TwkjvQFWlybiCC1p1_gQdtJpd_q_Dsj-heLBpULA>
    <xmx:zcXgabLvzHwOzrEYBn0V70MrKskWv5wO_7CCwW1yKzlOxmoZSj1nKXgU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96f1c57a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:21 +0200
Subject: [PATCH v3 04/12] t: prepare `git config --unset` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-4-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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

