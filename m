Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1251DB346
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019053; cv=none; b=biC9DHsGFFM/RlYPkeVtuiv7sHPDdkc0zA6iN4703nnBBwpeBKmmN64n/akdf+bDSgYZMDChgmMsJqIArHO5WJeEhpp16sInT9yD/QLq5uXuB7BmGjqC/su1Xv5aaka4/aN+mnrd4PlMwFrvb7SvReX3bmnRY4tHMHfPRALdX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019053; c=relaxed/simple;
	bh=oGsYQLpCFUDWhhgxk1gEsdwBA7ZC2vGKFCXlNH39QUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9crgrgEyQZh9TZLfENw8VkkrfCY2WmqgvFTm2lGJU4m/Jnnh3ixbXLiY3dysOANKPKFAcemEo+5TE4l2nEnfL5gQ2KfTMv+2G3sgLU0qbZkfULJPFOk8ihZG4QVRIN6s8a+8439HjP5v5vBEkI//t9jgAsGHXvr/oE0KbntYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YlmG7WJC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ojny3gLd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YlmG7WJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ojny3gLd"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB1402540185;
	Thu, 16 Jan 2025 04:17:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 04:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019046;
	 x=1737105446; bh=/CtZPM9QeryLRLvwkwAyg0cieLHfEGypsKcLGjTDKXY=; b=
	YlmG7WJC/EgKq2mngswuTlOGEuWz2uzIRloaGuZg3hMddcngOenUb7TXYqgi4V4+
	3ebjUbzgKkrBjmakJ7uWlqfdnJUzF5QKaCqrVrLxUI/Uo5xPjeh+5KNq86J7WfzB
	2zRVlgooI0KI/eX3/loISMYLLhEQC6pDJfNvb9HAr+alydjX7f4RxPZc+ivy5q5I
	JcNBdYvut1EnVo2uBOTBg4MdOFDcLttiRh8Wb4Wp+bSN74A/sMp+0D/Ty7w8Y+DM
	F8Iay8gcPW34JVgroE+0iE3OsvcU21J8Hmm2Af0zGPSxak/inbXjwZSnwPKgGbmP
	/8c6clVX10HH96ER2Oh6XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019046; x=
	1737105446; bh=/CtZPM9QeryLRLvwkwAyg0cieLHfEGypsKcLGjTDKXY=; b=O
	jny3gLd2AuMzIlBI490uDls9tTKRznIonGOHzQmvEcksWvgnwFBTJRQd1BPdFCw+
	GI/nbCZEhx5u4rfPyaxzRcZ2JJz7CuHQ1fHA1qG/GHhMDofMtuv9R5Q+00BequQf
	DoeHQZ/slSQLPKfeUQy3DpiJaS0cI+Z26YONJU8LbDQ1e/dREwYoKNCAn1MSoxjT
	7+W6Xou6yUkRPdHqSPOsllOKDkaWixnmZHzwofqECaXWVdykcQICihaYl4z0FpFQ
	tqdUYHyzG1y3PVteUgY0FLnFTNQHM5GY3Uvd4xENkdtjfk5Fn+yQ2PORwiEYfSuk
	Uny0Ms4WiDdnMdV0C5XYw==
X-ME-Sender: <xms:ps6IZ7ecqAYoapMuLvrmnTgPmzI6LCXCIiTQ77cWwwfdmTB5qBhCeA>
    <xme:ps6IZxNAQcX4KGAZ6gWZk3ODWiINC3c0xksXp6qWs1TMFcRdJ2_E-pXkBrnr303XF
    WoUfcIWb75Mp5nJFQ>
X-ME-Received: <xmr:ps6IZ0iyPR95HnJ5729Y3Ma5lq0vmx5wjs0R2X5pLdrSwLOP86ebGpbRFPlPTkvn-NHvBNapD0wq_TAxchn6ziirCrd8S3yAACyVEC31T5HZYdUZJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ps6IZ88Etco4twPQ64GzNFHK8mfx-84emz5trM3ZDKxUXAMP_geGKA>
    <xmx:ps6IZ3vKfB60fk5F_f-2cZLB2M_5rZL3ubaMG0-y-tGw7-DyIF97JQ>
    <xmx:ps6IZ7FUV-3XVgJL0Wydm_uJ0tX96bjY6rt8VItrygIL5NrVAH_Hew>
    <xmx:ps6IZ-OmD4iVyGP85emvWT4yg3W_ZTzVZcCUyJE54YfkmAFJhnU78A>
    <xmx:ps6IZ3I_GehYpgfkwGEb7tDszF609vSuwHo__DCYu_U3j_w65OiObT-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63d1978b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:18 +0100
Subject: [PATCH v3 05/10] compat/zlib: provide `deflateBound()` shim
 centrally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-5-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `deflateBound()` function has only been introduced with zlib 1.2.0.
When linking against a zlib version older than that we thus provide our
own compatibility shim. Move this shim into "compat/zlib.h" so that we
can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 4 ++++
 git-zlib.c           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index bc20b884ef..96a08811a9 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -3,4 +3,8 @@
 
 #include <zlib.h>
 
+#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+# define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
 #endif /* COMPAT_ZLIB_H */
diff --git a/git-zlib.c b/git-zlib.c
index d43bbeb6da..2e973320c2 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -147,10 +147,6 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
-
 unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
 {
 	return deflateBound(&strm->z, size);

-- 
2.48.0.257.gd3603152ad.dirty

