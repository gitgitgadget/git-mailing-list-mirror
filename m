Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6503B38BB
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073775; cv=none; b=KzgLg7DQDCRGkQMMyO2kCFAHB0hp9U7g4T4D7fhHHsDbWBjKkfdfOWEAqQxr4y9a1WW5e/jnv3NhZ1A1RcgeUtxbMe9Ela6NvaKqFHfhTlcxx8xVNhFrWEsuc5hAHS62hGgmBDAVUtiag9BKmUNrx47BUSbAWBx2Z1YO8kEnmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073775; c=relaxed/simple;
	bh=3MarGTOxAPuytyYlInXlCCc9YUUzDkrrswo/Q/Mw33k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXZqwgEplCbJ07JmorhvwK7N/uCNTKF5xkUSCyWPpOF31S6cqyW4Sax8WYwlK/j4BCRjVfBtK3uEiF0Q5c+BEnxd0D/Xlc3buVRh8gvvSLoEzWOVXcY2++yThkYU0omlV4y7LzMOvsPd60c4R4tvcZa9V2jFrHWJUslwUFVgvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=btY//e/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrFXgDfp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="btY//e/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrFXgDfp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AACAEEC0436;
	Mon, 13 Apr 2026 05:49:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 05:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073773;
	 x=1776160173; bh=gIQxxbfUKvKN38l3/uiietoua2bYbc0HiQW/UUuGA34=; b=
	btY//e/NnIhSKVIpe1IBB2mURsGk9jo/PeFoI/3sjvLn2gzytKih7iMosGHfcJ6O
	8+KSfQEkkfsna7Kr4rKDPvJAIubjoSA6BPnVs/l2CRR0KjAsQXk1E6KQnYpHzL7a
	qY1tg38ZJlV50Jw3uV9yYIh5k0x1QSgZd4OxvtQRcbbArZImz9s1oQ785KTkHW6w
	/Bm6LS0nZqe2b+WFD6rEZ2uubyUsI066zhb8l4CvoXBZ7Vpdj9sHgicPpejylewT
	J614i6RfWQT0JrrKlnajHUMmrk5A+eOme4cD+fdDCVfIpoB2XaD1Lta35wQcYt/W
	arWHHHZoEBXTsqYQ0vRlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073773; x=
	1776160173; bh=gIQxxbfUKvKN38l3/uiietoua2bYbc0HiQW/UUuGA34=; b=N
	rFXgDfpZZKBTbbwrg6bf/TVwbOJoyu5vAFsxO0/OdrSQlR27sxkwk5Uq6QzILSFw
	JlQBDG3mWLkWErpN+P12tuy/8erapQxEgbPKk9len3GtvZwRSAitRq7Jg3JN9pNG
	fPFhp5fFlnPa5LX9zgqbrSmEeM7IUxWuKL6/kjpftAn5Xc43rEly6aNNOwUlcPzb
	O/ziOLswKb1HHrtiLTnMaI7xDViionFcSoT8lYrJo4+XSvp+QfZTKjApZeRahrp6
	Iwo2Pvlg9CotVF4fYA1ofAo0oiAoaFnyW2BfP3+fNYCi4xn3/urWYugU5ctCdxTW
	fK3e2EeRbpXrDeRHHc02A==
X-ME-Sender: <xms:Lbzcafxq9NuQi4ptAjD4_SgEkrE2T55Tois76OuYkMunrIMOgkbx6w>
    <xme:LbzcadSUE0A6DZwEM1Bmg9BCDHQMbbSSlc3c-BE0UB1bgrGfBApZBmpUad5AHoIAu
    KovCQE3tHDZ2LdZp47ztODoTjI4nmUxcJUEOJMMAy1xkQG8-wSr8A>
X-ME-Received: <xmr:LbzcaW_MxR9ZBtyt93PH65zMD41B-8w_SSvgfp84-cBbblPvYLwq-yj8vhcfhdvYThLK8Y3pP9Ev3EA3FtwyBqQbQrNJTpXOp9LhZiOhKtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LbzcaUoOEh0K5BT-aZ3pVxGZq0Qznthy8z5xkaCrJTyN6KtjjCMe7g>
    <xmx:LbzcaTkPhdsvwyVOoHPyuQUzv6kg_i4suh_1dDSkFZBDENEhe33LTA>
    <xmx:LbzcabKceBcMMibFxd6hFnnQxbJHwhIpfpvZbg0BRvwvd7Hn9zZBWA>
    <xmx:LbzcaYxWzwbWHdsbg0pNjMXJva1xttBrCwUdPTuvcIuUAGTBjgtSNQ>
    <xmx:LbzcaTKnJniuM0O-ptHGSKPPMedkNrpodYVIIsJe7_uvEmUUO8bCmpxe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9758826c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:23 +0200
Subject: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

The helper function `test_must_fail ()` executes a specific Git command
that may or may not fail in a specific way. This is done by executing
the command in question and then comparing its exit code against a set
of conditions.

This works, but once we run our test suite with `set -e` we may bail out
of `test_must_fail ()` early in case the command actually fails, even
though we expect it to fail. Prepare for this change by marking the
command part of a condition.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f3af10fb7e..f8bc77619b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1195,8 +1195,12 @@ test_must_fail () {
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
 	fi
-	"$@" 2>&7
-	exit_code=$?
+	if "$@" 2>&7
+	then
+		exit_code=0
+	else
+		exit_code=$?
+	fi
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

