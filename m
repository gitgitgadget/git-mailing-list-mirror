Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F2275B15
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258411; cv=none; b=s01exYHmrpVHVlgrQgdjTIbpjHE1NFolgkHpvVR4SOVEV0ljXZBbjD8DaVSLUziVtipn/ABeBtDgAMQIXMBWxiBpyASr+K1mtsg+cqx9trkob2BCLN8pg28MgMWfT18YO81WGwRLFc1vyNHtpPnrofev5WghFuGInmtpDgyXflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258411; c=relaxed/simple;
	bh=ObdRYQZFYbTS1ePGjWS1xpHk5P/smc3lj+j09EyDTFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eMQhUsIC0sd/l89ZwPMHYT75zfm8Tq2MbkmKw3KtN8PwhIbSuJ5LyULlPWYgETuXxdvp96XajBil+Oe5aNheEpsucakAGQnCF/iNYLkrciDVCrnbxJcchrNQ9BbELt8lHVLjvPo9IrKHsPI83xyaJSC3+QAZl6XDeMvdBTRc1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fhHwzr93; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4NcDtuk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fhHwzr93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4NcDtuk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F814140002F;
	Wed, 15 Apr 2026 09:06:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 09:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258409;
	 x=1776344809; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=
	fhHwzr93MHfbvdYXFyWRjvTmYobclyHOc07v6wG6RI9YQTJT5BFqGlvzOClx6JrM
	udIeu8QPXWbP9YMHjxocV8lU9eFsO7u9ZYHkfbuRd8CngeZqhp7NKwfzyTAiiKKh
	2a+t2Id8/qi6S9xW7W2IUeL+20u/TCNJk8fWR7vmnBBfGquGZNDzQVWU/VXq6GOs
	SEdSzpXps/6D/hPCAQHmyQ7NpfMNbLJqkqj4t0u13q7G7U5fKucHo42QpddqnXCc
	7ZESX762dRI8WRJlGq/YhbJrMu11Xbj/HBtCxSWAVJhxCl+fJDXY1DeAdDFG/HAx
	yAByQUpyxSfCntSXBJt+wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258409; x=
	1776344809; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=T
	4NcDtukRqqfk+UKMExAS9UugjK0vpgb6c0UoBoDvEDNIL6CNUDtRDIVvkf9KtVN6
	Sn6uQTyhpskWIyCWD0XTBSvG9fDobBGCSFXHRbINUg97a8RgA54yOuaybDuj+paH
	KdNZwO5B7UDX2v/yBj/aSdK2meM23RtIRkfzBN91VS7g1G04IxlAXS/jYfhUU+16
	3ciEoAOkZ0rbPY05396nQr1J42svOVHbRYlvZ+ntwwjsCx9s/nePjZGG0Th2BZN6
	QJPWaR9pvfOuNd1uZ+sGTjKDwWa09OcfzPCSYyB33UIRaFoAg+dyW9T68o4NjoT/
	2uqu0abVLI+TjZeCLGobQ==
X-ME-Sender: <xms:aY3fabCjfn2CAXebE2kAnsQriEuLvV9kJS26ZM-HUqTNJuYDSrs9qA>
    <xme:aY3faY_JDW7MBA0Tkou5j12ZeYsqsd0NmduXS3_2cuptzL4fgGgKP_zuD2dhBxLDu
    CYqQH2j38Mq7aoKKjX_wDXp_MzIUndd7SSxoopzE4NjzF8PZLlT4g>
X-ME-Received: <xmr:aY3faT9UR0WQhSKXuSEZ_oy98ur64dWmekPg1FI3S34MZB5B65Dmx7eGYv2PoAoCSyfbOUBMHKonvwnV7xrptAmhybnGFKut1b-PYE3PIQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aY3faXf87cnLnXgK_Q4qnICktnfU5cymQVt0ZpK8vnNFdHi3Qb8cpA>
    <xmx:aY3faUHkPCXS6CotI8tonPZYapyJJC3cmMKN91jsmUTCjzsBT-YEnw>
    <xmx:aY3fadcWfWQwFK4AVvzkh_dn0jTDgzBlNcge6eftx4_rqUwUOSiLKQ>
    <xmx:aY3faWHtzhlXmlJ25uediN_x08V_G1BwqLJJjIn7Zjod6lE0OZtSmg>
    <xmx:aY3faTtwOuCR_aFczvPutGqLFLrhs8_HAvI1JPBYTFjezQQjqvFGXrgY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 176661dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:37 +0200
Subject: [PATCH v2 04/12] t: prepare `git config --unset` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-4-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
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

