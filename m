Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125864A2058
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047461; cv=none; b=tGWjuWlhn6jh6roytTWo0t78OWwjDkVzFSId8TyJF8rcN6mf2bLIwtV4RjoOuQFmeGsaOS6QRI6TIgZnm/Tv+c/TK3mO08jMvh4WKUCPRZ2ivXZRHIsaeYT/rBMePQ+8XEfTJ1Xbc+FD9VdB8SL+h3LzkcTxM19AZaBcRDxjR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047461; c=relaxed/simple;
	bh=pNgXAi5qS7XuDS3F8sASfLAy4CZFmWAn3UYw5f00Igc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hx4S8cygMi5TV4oZL71eb0tTEu5sk6fxHtypQdziMhRz3yc5+WeCKpqrNn0s7WowD8SSwwjJguWadkcdnmArvAerhc9GY+9N7Fw2TrHcWCaUeRB2io9Ud+cCJdNy8Djc+iXD4oQo1bzbp9UH66SJUYsx08Qs+lFc3c2i5A/yekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DEjyBSdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IgdJcs9M; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DEjyBSdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IgdJcs9M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5677A7A01A0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 02:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047444;
	 x=1792133844; bh=tfyKsQSkDfantok2TpjBJFE0VSF828pT0LTTB7Z/LmY=; b=
	DEjyBSdLCFXgvVnRcs43Z3WnXQW9/S2YhugKqhuW9AGUCEnlGgCK2J7hiJGj4E9v
	8yt+V2YIvGeqwIuX/Xg75cvfa0v1brL/gSCFeDLH8u68dPrHdw25eRjbjMwRzLZe
	Shsn6ZfeMfOeZoAa1zEtWzpX8gk4PcaZ3danDgKdsVlD40Zft+qPLquVZfacGQmD
	FM731XQHeoexHwxWCz21P54K3JZonqa+b+MjSnaNq1v/Gk+YZyVVnlNDDoQUnSxy
	a286t25uGgtZkjOtfQBEyyHkOMqisuP2sk0L8qAhLAJOreU4HIyN1nEWXjh7x3/l
	+L5iSccYoFYQ4vskbDE5Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047444; x=
	1792133844; bh=tfyKsQSkDfantok2TpjBJFE0VSF828pT0LTTB7Z/LmY=; b=I
	gdJcs9MoKjtD1c6hNcFkGReuGePpWgQJuCJhjhPzF56pTpRglhzNdPjTcDC59TJY
	nzxRBKR3GD3iFKiR9JrC9hY5J5/mKaeJNTVnpNzkOracRnxEhdUX+RR1q7ZaWnCk
	TOuv7NtkRuFcJNt+rf2gimrZJzQOKBatrKnxBu6D/8FN4JZc+nyKKa4McOUFVgXy
	F6t4kdrucpKZMkacpacxjNdFl/kZMtcx2VG9/LQQCoFZ6L9Pl2eLXBkki7voXGIQ
	x5QxQlSjeuDq9WexCdcX7Gf5t6tuneGV8lhbkevtMtO2ThW1FS60NTwIMVHhvaUb
	3ogdjt8tqCDpWN2VsTpvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047444; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OYGfinU3xNl/OWw5o3GUL1l60HbbD+GnhnBRwoOR94br2oI
	cx31Zz4ANjB8JkOFOErRLfX0LZ/G7LLJQl/0/OQRh6iFqo0nGyfVGVOxJsiF/tGu
	O3Ri+ux94Uiiwy3aWeONVbHsqhdQfFYNpnDePM8/nftJLGq3kGrH7Wi32KUCC7DM
	PIvNjS8yNTjB0HurLxIX2UOvLxUXvz4Kwd4dM/KSEw1SgD4Y6R0iE9vmGwbxPXWs
	umSwiDjWIxmY2NsTf3xJG2C8g4XOLIFiPsy8IffS6aYy2r4+S5JRWgUjt6UHsHAp
	nUkj0w9xaa6HOxjldivp8DlZlvN3cSvt8Fe1Z7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2BJKNqtZxoRugbVlF6Ijoo8z1vpt8ZZAMtPQeUz+OWU=:pNgXAi5qS7XuDS3F8sASfLAy4CZFmWAn3UYw5f00Igc=;
X-ME-Sender: <xms:VHnQarjpyXcO2I0F0IyxJ7ZUxsvySp9XbpbY1UZm10BKAJKnCYCzWg>
    <xme:VHnQagcuV7dIwm0U7-2r8gau-gCqq2wDqCvaJZ3eqvEJm13D496JJD2y-uocx0UMJ
    kv_sNVuyZwLSjB8dUBVgK9PRzOFNeW3idvqH9AiU0OsTIu3Yy0pyw>
X-ME-Received: <xmr:VHnQarhS2sd17onbDrEx0k5n7YVLlU-oD0Mll1zYVwjCPhT4vXV4ppFVWHJZ2EMNDCue5sU>
X-ME-Proxy-Cause: dmFkZTFpmkZOF7C7SXGoHVZ+ysJCnuUwQTIn1DaUrGmj/6paOzC5Lnr00Q/xxoBzHr7LSJ
    +5siuB4uaF4Uv9QmJOuNKb5lS8/ThYN0f00mPIBVq0Wvsr4/TaONWuoTw6V4rGF40oQfrZ
    vVzRLg3L8fcWLnCbzN5ts1UgW1UQwbOlxl/gpozn14frlovLjPe+G2aqYflaJtHOPp2R7A
    Lsf7KkELCJws171AfGzIC/WzOPhU5gje5oC9zLdqoruLjeVFBUjohD8Dp/dKB1vGuV9BsM
    6pEO2mOsRbM072o+HhxvYGcG4VDRVvF+NEr2ylmIuz6DZCntgRZ3RqPkQvnHpuSoY+ktaJ
    jQxIZz6a6QO/SIjPje68Tl2a2Lnoy4HdKmj4JLuyANlApHL+nyt5qRhbxLPt0P7UVDunwM
    53evlyiAjmVemhLOiQUA+cwt4+FMkzMgixX+3xgKzBbcL93RwU+HqOqbd8gG4zhEOiLnfe
    B0RmOeRve/K6TVBE3492FcCvVU6Ytc8vHu+ZoAlWKz8oMCOrsmj4RvDr0JCTm7YvI7UoSa
    z8QFnXZp3WAfYSNY/FUfNuzzrpK0DaygHc3N3MuXFgkNq0b5wSFXfloYk/oGHS1UdPtudk
    +UjY70hoVor0YKyabkWqJO+t3LwrT4w+AfGbgj2AHBhMvWnT8MO7x6DVNYtA
X-ME-Proxy: <xmx:VHnQaoxXXHZMa5Nm2Ba482_DFoYdG3JCSQFc3aGLEcvHRWfhoi9-2w>
    <xmx:VHnQanMtOQg1IR0Z3xUhW2l8D0rrE9d7-bS3HJMPKfPqGhxNrmVwCA>
    <xmx:VHnQapUiOo2Sfc1nlvoDlivd2utTbTID4bNt70QAt1U0YdLPYGvENA>
    <xmx:VHnQar2b_HIfowYjywR86wy7n2p9b2AwmIowFXeADPIC5F0QYkuFCw>
    <xmx:VHnQat_xUHz26baW49jjKBbaWE77jfZOtA9-msjEEs5S86otrAwy6SmY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84090a21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:12 +0200
Subject: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

In d88d727143 (ci: drop linux-clang job, 2023-06-01) we have dropped the
"linux-clang" job because another job already uses Clang anyway. But we
forgot to also drop the logic in "ci/run-build-and-tests.sh", so we now
have some unused logic in there.

Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index bc5058c917..23e87cbbd6 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,10 +37,6 @@ linux-TEST-vars)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
-linux-clang)
-	export NO_RUST=UnfortunatelyYes
-	export GIT_TEST_DEFAULT_HASH=sha1
-	;;
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;

-- 
2.56.0.212.g129ede20d9.dirty

