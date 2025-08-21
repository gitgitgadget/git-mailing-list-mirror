Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A897296BA6
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761961; cv=none; b=ea47qT+e1WOcRKXJzfKRVT+NbsHwO+VAGgjn+Ndht0CSFW2A7zdtk2COyU2vDwDMxJuAZVV/MllDStqrHpCjYgT9OPB3OmlHrSTSA2UiGGi1KoTzVTiR6nevYqdVOiF8KXGssre59sXZiyP2Ejgy6kWE/LwPc7cinC7W4IsfayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761961; c=relaxed/simple;
	bh=4tE3/S5y3QWC5YTAttBysFdKzMKA3i4Rbywc9xh6LEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iwp+kaGnh71MnlZENsgIyL27b4OPL2tfPbfq7LrzLTpJN6BxHQWZ+p9VEx9Q30oHw6Wb/eveplwHZaJbg9gSSXwJIS2ftrCr11leyfIxyBmBGBUuoLFgLUQYeEiYb1CS54kun8oQBoyVB+VPil9/7cYkrHv9dHM8Luk4qkCxCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZMIUGs2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkLoeub+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZMIUGs2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkLoeub+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 266F3EC0143;
	Thu, 21 Aug 2025 03:39:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 03:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761957;
	 x=1755848357; bh=Tg78V4dFox85MjdXtws2Xl5vCH9CuK01+eZO+R51iTI=; b=
	ZMIUGs2+iIvSAv1nH78RdawFj+5Ypn8susLen12QS0kiVeYR2qcdHQDYQ524PkGi
	GjuDZpjYZ9gUU5yMAJtiwiV0eCtuMrjbg9ekTv22cJzJgqta4KApx9s3mQWVXiGn
	IZrV3vAg+rTCeg3fwy+GtllW4wx93KFke1CAeg7VTYw4SfRPx+mpeGaqnL7/IUYi
	2/BoMFBY7vvLuJDN0IwM/0BEVCocJVIBeEYvEFxJvI1DIHIvEQzbwgMWNsIZbFIm
	5F/K+1TajA9HUlYCkD+ZnXCRMBBHvVYRFRJAQHfoDGMhRQat6FAkdPsaAtwEI91M
	b7cDYwPHYUlsFbSthobAmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761957; x=
	1755848357; bh=Tg78V4dFox85MjdXtws2Xl5vCH9CuK01+eZO+R51iTI=; b=b
	kLoeub+1FKSZ1biVEFVjaJXzCQrzpKx863yoqtu2fmGwsVvvmrzO8QOY9bqGSs9f
	CYXAa7sWRdzWQNL+vzwWs6KYNavGMf2+Amd+tTgPGGM70ehcFROlXMEyeTxTIXh2
	zHNtC4SGivV0KLXWjdZRWMu9+RMgwuh/cJRwU5stm3n6F7uLDby7wvhRRx+o/01J
	SRkufMd27s2ZNnJqUZinTgNfMdPr3x3URIb8KbmONm2/CDLAg+1wpzBSh5qkMQrp
	Ym8wp5+/bm1Lj3Pqt3Xxoee6yocm3v8TwmeK/q9LpI2HjKJo//4CI2sYcqFmP57e
	Wy3ItGUpIHBy+aMW8swdw==
X-ME-Sender: <xms:JM2maO0hx8Qe9fr5mCgnKVv1Eip_GEZB4vBLMts8mp0rOO-NXj45OQ>
    <xme:JM2maEVoPrIyiLhK6suZQ9dfOfK1EeHrlfkuFZNzze8atSpUY7_sBI6fBhOIRUVDM
    EI9C4E60X2h3IfBcA>
X-ME-Received: <xmr:JM2maAXnptSM24e_FCfLBfRxpv6M6lIwTRbX5fsVSBOEPmfYoPIVIOdvC682AEwgsuS5W3Nc-CUrsLJKqisuZF_KXUCAxLk7lbihUfckVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:JM2maLdWnDf2T_aNWAMyYHsS7Z3AeqjVFuCPbeEKIF4ooimdtjFeJA>
    <xmx:JM2maBXXvtAMlBMMbDuDZNrWzgZjhqIdMkWWK-CxFpffCNJbssB9fg>
    <xmx:JM2maMd7rUHaOO0lpTwKguEGpOju-DxS69tLcyj_vMhB7TejscsKKg>
    <xmx:JM2maFM-teTwn32eDi_7o30ef8SvSQyiQt-1F8GulUDlmJh7kMicjg>
    <xmx:Jc2maC_UHmaA43GqkcJUiL3NykQrR_WQUeCX6jdTUr0_yl0Y6ll00QXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4adcb746 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:01 +0200
Subject: [PATCH v2 03/16] odb: move initialization bit into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-3-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The object database knows to skip re-initializing the list of packfiles
in case it's already been initialized. Whether or not that is the case
is tracked via a separate `initialized` bit that is stored in the object
database. With the introduction of the `struct packfile_store` we have a
better place to host this bit though.

Move it accordingly. While at it, convert the field into a boolean now
that we're allowed to use them in our code base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 6 ------
 packfile.c | 6 +++---
 packfile.h | 6 ++++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb.h b/odb.h
index 6f901c5ac0..98e038fa73 100644
--- a/odb.h
+++ b/odb.h
@@ -161,12 +161,6 @@ struct object_database {
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
 
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-
 	/*
 	 * Submodule source paths that will be added as additional sources to
 	 * allow lookup of submodule objects via the main object database.
diff --git a/packfile.c b/packfile.c
index 6478e4cc30..17f770e0e0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,7 +1027,7 @@ static void prepare_packed_git(struct repository *r)
 {
 	struct odb_source *source;
 
-	if (r->objects->packed_git_initialized)
+	if (r->objects->packfiles->initialized)
 		return;
 
 	odb_prepare_alternates(r->objects);
@@ -1039,7 +1039,7 @@ static void prepare_packed_git(struct repository *r)
 	rearrange_packed_git(r);
 
 	prepare_packed_git_mru(r);
-	r->objects->packed_git_initialized = 1;
+	r->objects->packfiles->initialized = true;
 }
 
 void reprepare_packed_git(struct repository *r)
@@ -1061,7 +1061,7 @@ void reprepare_packed_git(struct repository *r)
 		odb_clear_loose_cache(source);
 
 	r->objects->approximate_object_count_valid = 0;
-	r->objects->packed_git_initialized = 0;
+	r->objects->packfiles->initialized = false;
 	prepare_packed_git(r);
 	obj_read_unlock();
 }
diff --git a/packfile.h b/packfile.h
index d7ac8d24b4..cf81091175 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,12 @@ struct packfile_store {
 	 * the store.
 	 */
 	struct packed_git *packs;
+
+	/*
+	 * Whether packfiles have already been populated with this store's
+	 * packs.
+	 */
+	bool initialized;
 };
 
 /*

-- 
2.51.0.261.g7ce5a0a67e.dirty

