Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546A3B47F0
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073792; cv=none; b=agBj1E6PJvkF45599WQbvBUawjIyZ79rfLfEt329b5beRFXh8i2yYcX/AAU31TeL2FlkvO6vJlCVyTEWvMOUep1sH5Q7B2FvoCjyf+VyPUnv51iXTI+bTkGe3d4pqmZSrYtJMQFc9r3wXWFTcKM7dzvLS0phrFzrl2uUiAXxnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073792; c=relaxed/simple;
	bh=30X3jWEy1gHQWfRrOYwkuMXEyKBbypQj1x4wZSjqmKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQlE1v39xpyfP2uqttHN22zqccJvmev3keWrpZNt/rqTQIG03XRkT0RH01Qo0uyxwswA4V1T3JEY7Hkv92jYKljN7RhqVK5TqvywqWZbJuoyHFbH1gOWvUvvP2VCkBEwYFcGTzpE6gtjDDd9s/pq5BZfmisMwwLmvO8Mi4Q9nrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pq8KVKXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPmutlfd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pq8KVKXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPmutlfd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AF124EC0438;
	Mon, 13 Apr 2026 05:49:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 05:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073790;
	 x=1776160190; bh=bS1Qdz5EoYNc+KaZ4fxu9S9QbWIIu8hrtqT3Kd9be5g=; b=
	Pq8KVKXbHzJFCkHLAK5NbgOkVsxck6XxWb+8uA7M4T1n35aWwgoiuWXI5j24Py6C
	9ikFm+jtkuuDI1YLp2eyx0oX49X4R0oWRSvToVpKDKTvJVyscGDQxtdNNWXYHS2N
	dAuuy/FWizm2ncpLhey3S/9NXnl92NvchPvnvrH5PyxvO7nZYLET7BdxmeksNnv2
	xe+LTwoQsT3V28zJYeYRvqPKcSAMZj0p3v6FMhuGwAf4jQqeheUATe9wHJy4myQ4
	4uq/RS7hOnyiEF/0Z8jWzziSSN3jVXte1DxbeabhdBxZQSGdlFpZXj03HHsjYI6S
	WEJXjH9uIRzlb+Bk7DmX6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073790; x=
	1776160190; bh=bS1Qdz5EoYNc+KaZ4fxu9S9QbWIIu8hrtqT3Kd9be5g=; b=H
	PmutlfdgVx2prVZ612Y3QLL0ZgIpNWG6JQLs7U7LcWqveTBByiA7p48lerUBKu6v
	iR3LNIAEGr1acuO/ZRgYtyNCBqS9mbW27VuxuL9Ad+GGKMgxXeL0rLQ/QN2DFNCO
	3wQwE8J1wyBY30kl2u5iGkzVEyCenqFlu3CXTwm/+hBNSuCD6fLoAMAhJHKD0F68
	9KoPYf/v9+xbulmHRKnVRGQz3qlcmSAY9A1KKSwnguu6wN3pPhGYU9lTU8gnLfmU
	p1yvoYsIltEWCe/ONoxaV1pUWM84F2CQCV8gFrDk4eu7Egek1N1dMz2wxPfBJcmL
	RvZPZExd4x2KHtxKN8Z8Q==
X-ME-Sender: <xms:PrzcaWLaN_89yT97V-e6s7vXzKO1twpWdCVDX9iN_mJRrJo0kA_-Ag>
    <xme:PrzcaUKn5_8gAx_3yKUZpf6fu_QAyqDHmdNsy7mAskL4QOA_lcVqe8hpjiFwjl5ad
    XzahRty_nslesQpiW9_6_rpJjUeRSUFdu4Eu9m_O1c5qgfaMXYf-g>
X-ME-Received: <xmr:PrzcaUV5CLd_Jx61GJaD_b5Ck_VF4AQrT1nplZH8dDeUjVpQc3AHifTRrYNswDZGE_S69SS3x1TGFjBEOCaotW3V9gqUQQC4OHJRXYOCAec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PrzcaWjpBVUTsC706x_Vplp5ttn65MUOjSE_CLJX_eLF1ART6gqThA>
    <xmx:Przcaf9O3sg5Ezwb_jnXPdAGGSaUF_cqMVGAbMNyXgGP0WBmvsZozQ>
    <xmx:PrzcaQCoTNR7kFGF784nxkAB1-BwdyUUnfYruznUsLZb8nratHXNQw>
    <xmx:PrzcacI6KP_1zdep-z0YeFHcPMh6O4IjKT3oql4Pqo12EzBqlLRmcw>
    <xmx:PrzcaZjBQx-IalFJIIWLQFEQjXjFi6Uc-aE6RQEpUz4Xxg4GM1dgwPrU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df48f495 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:30 +0200
Subject: [PATCH 09/12] t1301: don't fail in case setfacl(1) doesn't exist
 or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-9-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..7f920d7b9e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || true
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

