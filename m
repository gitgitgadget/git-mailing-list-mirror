Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237820FA97
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273846; cv=none; b=O9Q9Zwcvtx1a18lidoHx19+NLxuYbEclVQamU3NsQWCoxxSP3bgLTyFzdiugmFDq7aXy3YPHFG09WMaZPTj2mxKZpC9trFrwhDJY1CaQvzG6gVvFhPeBSjbzBrJC3LihBEos/VzOPQj7Y//VGeHKgpsmiKHObCPosYVGJzbzmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273846; c=relaxed/simple;
	bh=mXdhkQ8bzRO5qr4PQPic9X9CkEIzV+F/k+NASIeCwkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JR+0Dz9cOVn4G2jGTzk+6kmvaKNdoK7htyRdme1eH/5PwVjX5A6nJ+vonpknJcGnZSKvIHrA+wZBgCI8Oc304ZG86hPZWhgdL9xU+EdX4xtANIciWjoWoDN4b2QqdQWXa9ATOQpJMASgVx8cHD4H5iF3S8Nyxx1HSE7QTwJuKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hg15YD5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjuz7TpK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hg15YD5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjuz7TpK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 400B725401EE;
	Thu,  6 Mar 2025 10:10:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 10:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273844;
	 x=1741360244; bh=G6NGgs8AqSjCiqrhPd8MCfM+VBSqvIMFmLMOyI8LUUg=; b=
	Hg15YD5nqpaYptxkG12cFLw04kc0kxQtFw/p8OhRetCatRuIXuyajQSHtnGQ81CA
	LZFppAqOK9xZNJ+KFOu7q/vb6YANnfS0t67JBwKHUV+8nBYRFpiT8XlZ7VoErIkr
	rqhAX55+QZm3BDjOqwLbD7ODmoGGW/KzsGZuXpHoXcIQZ4MUA1hAxB70/twJU2zc
	PKLv4OptKeIoVULFPpTQ2B5/FIKcq9BT8CBhqTQSw5WuFPYUxRO8F6zuK42ilSCn
	/LCtBbttSFxinDIAmBfb8Zfnk0lZDCgOXFJR2/lv9ahbszpc0A3SuZyOLDSxdQ1c
	LjCa0NitNYqD1LDuL1bgcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273844; x=
	1741360244; bh=G6NGgs8AqSjCiqrhPd8MCfM+VBSqvIMFmLMOyI8LUUg=; b=x
	juz7TpKVU8W7JnNAW9vCuVvjl+PgMOu6zjfHTLRDA11B6Wp6hjZWy8TjioP4mgPl
	U+rcf7pRE4ZwtOT6lv6WKaBisRHy1QOy7ipRac98Cuo1Q/UhusYxQaHX3H3JxGNJ
	xaOaEdFkGNh0iAJaUWJ5+gCrEsypfCnAL4O3EykdynT0R9OwBmcLp3yUZonP3yvF
	7mSUBja2tTeQG+UkJSewczEAzKId4CUg2AEJjkFb1YH93FRIsvVHk/e9i3JO+KAB
	psrJRvS6bmg30s2qBAzA/BgTGy/TL832JbOrWBXxm9br2rfw5gziytWoYfOwjrFG
	aI5e0EgscR1g2yZMCVGVg==
X-ME-Sender: <xms:87rJZ7UvVP8JG6BtgtNVkgjzODnCXNylFxnAh9_RmA3IxR6w2Tc3Cg>
    <xme:87rJZzkKh5Kmob6A9i2wmIlt6Ze48hfEzOIEK9JyKoyYrHkKLFr6GR8AdtHRX-Jfz
    PE-BeFwrnVG8WaeiQ>
X-ME-Received: <xmr:87rJZ3bomohE-kxFxIp6F-p_cnV6DhwcD97s3UJwUqPEa6Vnf3445IDEcZVXQaH9ExhQQr50mFwTojlFco6Qm5wiEX0oU344OrNUsOaQ-tH1og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9LrJZ2Vqejyb-XHn-iNY7MDmt28f8vII-_ZeaTJFF6AQK0vT5TkgWA>
    <xmx:9LrJZ1nPFaMC4SAyYQ3_HtoJ2TBGfld7avjAtafV_lX1q4jopfw7qg>
    <xmx:9LrJZzfbhd0JvhEOoduFpI_uLx8G6dO7wBNsAcpttY0NR7Z9_JrRLQ>
    <xmx:9LrJZ_FRQ9BpotNz_VYIOhs3hfBj6vNOFEDn7XgRi5NEukAGrr8P_g>
    <xmx:9LrJZ7jQA2_QsghLHMpq98zSGjBZ9oGYmUVeaJWVWGZbAlhaDwgyOj4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc49ba1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:35 +0100
Subject: [PATCH v2 11/12] hash: fix "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-11-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of trivial "-Wsign-compare" warnings in "hash.c". Fix
them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.c | 12 ++++--------
 hash.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hash.c b/hash.c
index dd5ac9d0eb2..4d9f98f72c2 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hash.h"
@@ -246,10 +245,9 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 
 int hash_algo_by_name(const char *name)
 {
-	int i;
 	if (!name)
 		return GIT_HASH_UNKNOWN;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (!strcmp(name, hash_algos[i].name))
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -257,17 +255,15 @@ int hash_algo_by_name(const char *name)
 
 int hash_algo_by_id(uint32_t format_id)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
 			return i;
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_length(int len)
+int hash_algo_by_length(size_t len)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
 			return i;
 	return GIT_HASH_UNKNOWN;
diff --git a/hash.h b/hash.h
index 4367acfec50..55d67ed83f3 100644
--- a/hash.h
+++ b/hash.h
@@ -325,7 +325,7 @@ int hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
 int hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
-int hash_algo_by_length(int len);
+int hash_algo_by_length(size_t len);
 /* Identical, except for a pointer to struct git_hash_algo. */
 static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 {

-- 
2.49.0.rc0.416.g627208d89d.dirty

