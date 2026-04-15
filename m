Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225B275B15
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258406; cv=none; b=dUyKObzJxH7Vl4WPAeRR+FR/tBCYs3Gp3+0f0Rt9Ti0s6G0JQexJcTVW/G+QfD2t2CJFkE0I1QOQAiwvrkMYd+f/h2qnQxxpNjf4ltMqL2A6GcAG0aPyzmParctiVisI8JsIG0nkxe9Hpx4lpv1H4iun1V545QKBQKtmPuE0jtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258406; c=relaxed/simple;
	bh=M86DqBMf8uVizZ/m2UEhAdaZAuCt/HhSBndih+XWFrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyxmUppCv/DzO5SypvJOAQ/ETAYw1Nl/uWTMpY3Lz4c/Y1qEjXiMSRD6Yajr6iKPl9r9TTCJOae1aXmgBAJRBEDX+BRF9kqtmrJQMV3N7NQ/GbHP5qfTAqkxracEpGs1++cUd7GOni4p5qn+Zl8NqEOziij1rx4rO61CoOCSSPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sFaar4nI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kyKl9fbD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sFaar4nI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kyKl9fbD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47393140002B;
	Wed, 15 Apr 2026 09:06:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Apr 2026 09:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258404;
	 x=1776344804; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=
	sFaar4nITvz23T4823gwCmsa+1OLd3KuH5IRL3EhbSCowYFnjtQ5LgfoRhnR7AEg
	VkLlC6klJI344uw6obl6M8hcE8fLiTDTTPweDHM3x7LmSQWujJFo8RcpqAESR9g7
	3NnxezD4FS2s7bqi0nEWFUefHR9njis7uj6UXobNWW7te5Pk6HCw4FHo7fx2OWZn
	4LxxzKm4zYGVrccMTw7iNsZKZ/YGIDao1LAP+kPWed0qPW++SENCnyL9Hp/aSYhs
	wdlKaw7TD38wYitlhJIqQlNvmLq88NjSNLLppTYuz+2IX3c/R3ZKXgrOHFKNzlcd
	hCUYOaEK9ldzRmk/RKPP1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258404; x=
	1776344804; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=k
	yKl9fbDYtwq4nTA+bQWI3rjtaEdwjNC1F5Wf2i6E6KxJu8yivG+df5O//MRVrIiB
	2+ckWfKY0eJEW4ofqQTmDf53PnMz0OwK09/pUCC8XqO6XECh8JCBSbCCGV6Gw4G9
	RKg0h3P3DDu78nJm7HyWTSL9/zLCztEmWir/m2AADH33NLSB3oTqBvr1iaJAm5ZB
	VqeSePQQP42f4oX/0N9v7gUXD13RTVyEptmkPFnXdc3sGhmh4WP015Cks1KASzfR
	hlQwYpceQiQqsFxyQSzvAkhFgR83dsF63oHWNByeRAU1nS5ERX92sAjFEb8qXswR
	MyjI+Dmzs1aknpqG2RZMg==
X-ME-Sender: <xms:ZI3faYrDuGtVW_T75ZzjRl-a4DfgdE8uSm30Yv-sHtdaKUtm3CKnPw>
    <xme:ZI3faWE1Y35yYisHZhDj6_eFKkJWbv6vbiovurqOo-Da6kgvkXtverc0uG0yewJMJ
    amO33NSQTsWJth7EYD8ayMtkSmpco2gDZm8zO2OUQh4NwXPEXU2aw>
X-ME-Received: <xmr:ZI3faanoHHr8QHuL0I-FI_JHSoIYST7ST7GgzaxEBLCWnnwck3XyYQtRAxrbvVpd4JeFMChvx6Kbtl9JnM0h7NV8DqT2HFVFTH02UMUx50U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZI3faZlp7elzOK2Wptlo2ISZdedZW1S3zjumA_75hHnu16gY7EWYww>
    <xmx:ZI3fabvnYlhA3kFi776KRxbRidDgl-ssNc29WgLndOl-K4FUxIiyRA>
    <xmx:ZI3facktRFP_bvstd1cu0QdI4m1Wfl1OxIzzxF3VI7Up5kJkbq-5jA>
    <xmx:ZI3faWseSab0DVyZFUEdhCCp7VvSIUDhwhXDnFewMWsMuEsgRK9OQw>
    <xmx:ZI3faU019NV0MbqueaJkODTCOZHYE111ANRb4rVmKKoqPdZ_TapzS1-i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fef1f684 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:35 +0200
Subject: [PATCH v2 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-2-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

The helper function `test_must_fail ()` executes a specific Git command
that may or may not fail in a specific way. This is done by executing
the command in question and then comparing its exit code against a set
of conditions.

This works, but once we run our test suite with `set -e` we may bail out
of `test_must_fail ()` early in case the command actually fails, even
though we expect it to fail. Prepare for this change by handling the
failed case with `||`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f3af10fb7e..5fd5494ef1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1195,8 +1195,9 @@ test_must_fail () {
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
 	fi
-	"$@" 2>&7
-	exit_code=$?
+
+	exit_code=0; "$@" 2>&7 || exit_code=$?
+
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"

-- 
2.54.0.rc2.529.gd9106f7525.dirty

