Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A51DD0E1
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590821; cv=none; b=p9ZKfilrxiM6Cu5/FT6Rr1YfYnrXGkk2P8a/m4GnfuE1aDZvG0oWIdLWKdouzGeI8qKwhMx6qwHiq7sEhlbHN6Tc9YnKJTZPOjZq8C+VqH9WRwEN4pph789zWFmjcypG9wpwc+EymW3j4GTXcmPlqgYxOKm829qOoTLKZ23CSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590821; c=relaxed/simple;
	bh=Y06ZJsenirOvU9kZ9ISpu/hzQiKBR14rqnNvWeJkJYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWI/eUyUYJRcAvksdG/ICif/1Rxi8CgOzbrfnn0Spr0UA/YxqmaSUFni5JRHhUPQ3NlNilTjyMP2W5ePfcz+ntBqOvpA3Nl2l+6nMAM95HA2mpJj8tm/1b2ab6+iSvTSVIRF2TFqdV4hLgHbjw0LkrcDqyqJ45fJC1zdeBEhJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pRV0VTx8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTDK6pGr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pRV0VTx8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTDK6pGr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4E952540130;
	Mon, 10 Mar 2025 03:13:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 03:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590819;
	 x=1741677219; bh=jpBSH3DZ3AlfRc82KzjeqO+6RH1esmGSh/mj7elDb4E=; b=
	pRV0VTx8aV4efNhEiVoDMJGZ06Vt7U9CmXsf7NtO18isV/hw9hd3kuBIk6I/O4i9
	rpelbIInKjs8Xta0nwiNWb54gvDxyvkOgir7eiJo4KL0MjIStvd+BG/Jq/xbogeI
	3kXJlZ/IdXT8eJi9LxViBIPbVn3W4c7ZMxd0rf3PzloeK4i/bDDp/+l3nuJ4SAIm
	Acdcn9E0+7WizyAqP9DEVqO2kWk3leixOgqg+N9ulH9TJ34aPQEkuZZHUEB8JlP0
	wUabHobd8v14dke40an+Qwtip5Hhf2+1Q8N5155uZ1UJJANvJ7vy5B/D4rfom1N5
	e8k1/Ifpi1nlaF1FlY5zng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590819; x=
	1741677219; bh=jpBSH3DZ3AlfRc82KzjeqO+6RH1esmGSh/mj7elDb4E=; b=v
	TDK6pGrYudTIEmVhP5FOzRJW7sp4wXfM8M+2tOak0rLfm1wgl5GxkUGqoJwxomuG
	BfNhqDUcCn+hz1xrdJQZI5pr1uWMOt3K74oFLy3cTPsBj5oB71UyxmbSUFCMNaPl
	wjeyQVo03nRhdB73dsxvN8Uf8q54iokvFNCEZzsv4H5X6tqwRX/dM5NtYn8mnG3f
	HY15al2/iP+fllysQSfvEn8buXkl7DFX7E54RRBoy5GOUe6KfYgkauvkMMts/alz
	+tLNk9jJel+UMUq3ghARf/aNbnARBrJqe1YGlBPFa13GUwIPu5LKbP8meqF+t3Fy
	qxm7vhdbXIMSWEISInt5Q==
X-ME-Sender: <xms:I5HOZ0k5y_hCRPXmHQK-maxTGCsQBDJYjINDzBRYdscZ6unVrPcBcA>
    <xme:I5HOZz0WQemAfvzJDqCQLYTM1rYbwnje0gNOsisewpPGD-5nG5wlsIQKSFChkOrWP
    M2ChjjsU3tR-HtvaQ>
X-ME-Received: <xmr:I5HOZyqeTSjpr0QZkmL1EONBhmh1vazXe63F4cG2oVDXpDoSS44lYaiFaC-X5QyIoaxS7PbF7kMcvG1rd1lNF-7SGiSRMi97iQ6lwwgkvlEnTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I5HOZwmAwWT4XxWE_Sd1W0kA5n-648fi8etHnM2ftmZnwjD83ArgcQ>
    <xmx:I5HOZy1e-9FTvK9bDs9Km0P1G_pX0TXrRCrj4Bnpqf1WyvKSPer8Pw>
    <xmx:I5HOZ3sjBpf4kijKPdT_QBhJRM3dbaxKAi_OqdVEXEbIjiAnMI_MIQ>
    <xmx:I5HOZ-Uuf6NLkpFAxGMhZg_3N591AwR_dHUDfOJQnypweylbyZdp2Q>
    <xmx:I5HOZ1TVj2hIo_XEzl68faXuVfqsE6KzZLBgbEJe0n9kypO6_zGi5rf_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b31ce5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:30 +0100
Subject: [PATCH v4 11/12] hash: fix "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-11-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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
2.49.0.rc1.455.g4cd33545ba.dirty

