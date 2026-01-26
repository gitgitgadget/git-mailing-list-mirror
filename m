Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8433556A
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429881; cv=none; b=Q2I3co34xhw9qdmJK4x7NlXvP/qCYfjTJOWWi4rvHXS3BxRV6jZ2NFcG4xQo034pEEQBuXm+oYxtf3znNmM6Y5FePN7JktneypqozB1/OZvnwAGqyRQRwGoxc5b1Xc0BOUCRWcWOFCswKqjnVBntO3gImYJsApgcK7YwysSkkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429881; c=relaxed/simple;
	bh=AGukXQwHjQifmiWxVPdVvpljx9Un7aSGH2/EmrLYjdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9dwDPbdw6/RiJ/Garf5/f2VCxnJli0buFn04FrvN8iDXu9ufgk8Ky+dd9SNzeN7BHVtHGomBvSAyZXGx4mKimWiB32j8uWDnXtwMMEDCQwbZQ8Bso2q9g6jX/vgEcwer/l/nzCt6UqJKZG6CHFLBWbjh4Onx1QRkDBe8euQ7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nzd1UsNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Taq1eQPD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nzd1UsNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Taq1eQPD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A791FEC0175
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 07:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769429879;
	 x=1769516279; bh=vMb3cXM/p/LwQvlnmipKZA+wmUVW0BL641NEO5U2PuA=; b=
	Nzd1UsNQ4e3wd4b/ff/qLbKCkhASUPijnY68XphsMO0WxKDpzakovXJ8+PoA3ypL
	u6QwR7TzypyOAR0SUOb9sA0uLNdgbvg5MhH5JnvteCv3ohWApn5JnHNsyqapmxma
	Ns3RQvfdn1oT8MsjMrjKk0YMXTb452Ilg7ZH2H3VkZSFiTF3AN0bE8UyHTmwatfl
	twrSCeWXzTfFnV0nTy/O3G6rFoXKvpn8OlffNApOf7A0bN2RoTgSX9t0p5hMiIZf
	Kp1tgkNww1vs6kptaR0dnT7iq3a6XcwzL6IucWHfoYEoaUSlfQwHHvzqTob8pcf0
	Fovtc0s/kP59oOGnClJjnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769429879; x=
	1769516279; bh=vMb3cXM/p/LwQvlnmipKZA+wmUVW0BL641NEO5U2PuA=; b=T
	aq1eQPD76uEIdCZl55OTRewelDskzDNTU7TA9h2wlHaR8EzJn1hRJG7C8CeRRXb+
	3uFG5PN0WCB9rO04kT+FbKBnS0Wx3NRhB+HYgksCF8WJ6yTr9S+u2HsIEimiOwH+
	5UKWFZC3qrLOi6buYSP+V2bmrr2JaVRIFh+6h+k14ArDPRJZKvLcmYl1Y6W3FJl3
	tEnNGOA6Sc3S9VM5oSr7I/TsFqxsXSyhegZwNOcdkZIRIiFrZ0OHABqPSaA2V0AX
	SaC0y/RrhgE9P3bqleKXsQLUM9L1C75TWV4ZFTktDg2qQUFzbEEGkGUyJPQJgB6W
	Hm/4osN3T9uiF1Vpqe9Ig==
X-ME-Sender: <xms:d1t3aXtFbZHWfl0PgPXm8UZ09Z4unOIdW0W-l7BrOCVokO0thXmIQw>
    <xme:d1t3afYr93XngNREBLx7rWoGz9F9LQEo0eWrkjUMAVAwZbcWV_z-05QYsFqhruUgt
    douzk6xRw9IMwCqzHzSlKQ4y-GpvZ089vJDCCKSPdlqofgfP0k1Fg>
X-ME-Received: <xmr:d1t3aQYnp6L2d4Xpo3VlZdyRHKnuiyWrxcJOKFgTmqVztWfdTY_SA_KdGZa8QrOIkplaNewPBFlqDuMZmK74J3iJvBqPwrz_r09Q5PUoGG4QCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:d1t3abWCOARKP529XG4_-QeGEJy8JVSRDs4l6MX_GxmE6WQBziw60w>
    <xmx:d1t3aX06f6e_evadX6I3ufkGAzlMMMxz12Dr_iuWCTk5OLEVKQdb_g>
    <xmx:d1t3aSYin7ItWc4YmDStCMi9DdiMF4JzdzjFp-VjCdvB7FzCA1tgtw>
    <xmx:d1t3aaq3doQ_99fjtQ0ZNJQe7QTRJYZm3QBt5PZSmt73sPIzbOHduQ>
    <xmx:d1t3aWfpVv8QvX57EQQJdR_kykr1VtroJp9oQA6WYKVL_WB3z31SdTVV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Jan 2026 07:17:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d77e2f21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Jan 2026 12:17:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 13:17:43 +0100
Subject: [PATCH 3/3] odb: drop gaps in object info flag values
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The object info flag values have a two gaps in their definitions, where
some bits are skipped over. These gaps don't really hurt, but it makes
one wonder whether anything is going on and whether a subset of flags
might be defined somewhere else.

That's not the case though. Instead, this is a case of flags that have
been dropped in the past:

  - The value 4 was used by `OBJECT_INFO_SKIP_CACHED`, removed in
    9c8a294a1a (sha1-file: remove OBJECT_INFO_SKIP_CACHED, 2020-01-02).

  - The value 8 was used by `OBJECT_INFO_ALLOW_UNKNOWN_TYPE`, removed in
    ae24b032a0 (object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag,
    2025-05-16).

Close those gaps to avoid any more confusion. While at it, convert the
flags to be declared as an enum and use bit shifts to follow modern best
practices.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/odb.h b/odb.h
index bab07755f4..1e4326b7f4 100644
--- a/odb.h
+++ b/odb.h
@@ -352,23 +352,29 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT { 0 }
 
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
+/* Flags that can be passed to `odb_read_object_info_extended()`. */
+enum object_info_flags {
+	/* Invoke lookup_replace_object() on the given hash. */
+	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
+
+	/* Do not reprepare object sources when the first lookup has failed. */
+	OBJECT_INFO_QUICK = (1 << 1),
+
+	/*
+	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+	 * nonzero).
+	 */
+	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
+
+	/* Die if object corruption (not just an object being missing) was detected. */
+	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
 
-/* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT 32
+	/*
+	 * This is meant for bulk prefetching of missing blobs in a partial
+	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
+	 */
+	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+};
 
 /*
  * Read object info from the object database and populate the `object_info`

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

