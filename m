Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5F2D6E53
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996918; cv=none; b=dS4LImOgPr+PiU3oQ1n/wGNkp44f3eZQoXhq7lqSs2Xi9hbJFB5Xhk27uQox/fMnWobnu3kGZ16o7tPGB4fzNHc0A5iEL+2DBCn7t58ejRefww5wms8zMC6VtEXjYkKn+CtUP9klNW6ndvnv2xBdXXMb8YRClCLxZDCpy3Vdu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996918; c=relaxed/simple;
	bh=wC8YXN97/EUUuGHq8jyHqO5yqd4WeDLeWXZQQGat3W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfh5NrZ3l+bXR+02rvF8fqP+AigY6SRUesoQ07knIkdigeSaA574U/5eaH4RX9fUGl83DssH4F+BKY46RCLfNjlKK+74R9T25llB2zeOflsCcPbxKm+OX040/paaSwgqm4Q6zscGUQWA0N/2U32DAbLpwyoKNUhrsvnTz+OXvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eB2lNl6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfRaFj2D; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eB2lNl6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfRaFj2D"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54D327A00D1;
	Thu,  9 Oct 2025 04:01:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Oct 2025 04:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996916;
	 x=1760083316; bh=FPC9fnxItzALtTEzmL2fmYoYRRjH4VWtp3ofMVjlKM0=; b=
	eB2lNl6CcLuw/JBDgEf/y5lpCi3O3JvtAek5AdeeWLqCet9kjMdiRJ6AdMztDdPZ
	w1CKs+S/UfwT6OSH+XgA1sBC2bFV5zH6U4O4gJBjEonIUUQAg0TCXeF9d+gm6I+Q
	x+hyjdUiF7wQ4Lt0/3GXKb+A2eReVfYqS2civpIqhH25sdf+O/0lNEdwZmmnYTzz
	Xc/65BYVRqY4sqEoJjtY9lhYaksQKuxz3Qb/7L0ud9WYNnwk78BQkUkMrC/beqX5
	17W0zVP3Jgq0Nr5lcPl0Id9iaf9R2G0C5+N6J0jc9cRWoquyxtMrxQOeP+QVHX7m
	TFrMQhsOpbNnxDjcqQGVjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996916; x=
	1760083316; bh=FPC9fnxItzALtTEzmL2fmYoYRRjH4VWtp3ofMVjlKM0=; b=B
	fRaFj2D9sh9MiCEOPQwArn+A88tydhqwL+K0X+U+KQuBE3ekl/LvjAhSoaHPV1/1
	Qqe4GQxRsdO6tcziJg2wMxukZxK3mPZguqdN2Ywr8X2A9pI17sylDrUlVawLEV0F
	JLj1ctKQtxi6vt82zs1bDHkzbUlv1jckaYIh+ztZCMlGg5xdIgcfZGjg6CFrRPXe
	txmw4JMlAcXlnrwR4L23C/4lS4WqjmoXXq6Pv6oKlo66ArqlaU3EQLTZOk7CSiJM
	Bz1Rz7jpPjhaDhyaTEaRt/9Llin1ZNYaVP7xjnvKHD3KgcG9MBJbVcqUPrCY/SYB
	6Ve+OzzGFZixuzpfbkR3w==
X-ME-Sender: <xms:9GvnaCAXnsdejgg9x2tgVeqvm2pHVqQFddi8MDzzhIJm7wNw7_X2WQ>
    <xme:9GvnaCg4KvGBrs64lA2ND_tV-D2NFNbUF0QjTXvDeHd-mdHoyLjW_HTZKUyTEYMtA
    cmb1K_iUk-_f8tbfa_wtFeMihFFX6H_tSmOMjYAL7CWmSzfDT6LKQ>
X-ME-Received: <xmr:9GvnaDPPlkY0_QptLxPw7oAEXxa96KMwheQJNcYkbzBLvNogeq0IGXNnD7W-XHWGVWNhIfMyE1o_aKdTZ9ah_CXdsDHVPU9GM7Tww849YAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9GvnaL5TPPElWDzEhrSOFxF4B52EY1ix15DgW7lfLrrqVufDaX6pYQ>
    <xmx:9GvnaJ3Z2sr3X7rkzUTgSZO5YInWjRPt5IFyl6dRdXVUfVa3D9Em-w>
    <xmx:9GvnaEahBV_uZNVXwP2zaYX-LlkdJadZIG4QsfIPcc5Fg68FLYl0kQ>
    <xmx:9GvnaJBBZ8A-lnPUxxyFgliZVqnUouFFzmjjLWnv8p0m8hRijuWqtA>
    <xmx:9GvnaFL8auM7zoser8T4zgf8djS3_UkrQzYX_U6sxh2Dv6_s9UKZDxg6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16e762c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:38 +0200
Subject: [PATCH v2 4/6] packfile: drop `packfile_store_get_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-4-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

In the preceding commits we have removed all remaining callers of
`packfile_store_get_packs()`, the function is thus unused now. Remove
it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ------
 packfile.h | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5a7caec292..db748b0bd4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,12 +1027,6 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *packfile_store_get_packs(struct packfile_store *store)
-{
-	packfile_store_prepare(store);
-	return store->packs;
-}
-
 struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
diff --git a/packfile.h b/packfile.h
index e7a5792b6c..3f38c63476 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,12 +136,6 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
-/*
- * Get packs managed by the given store. Does not load the MIDX or any packs
- * referenced by it.
- */
-struct packed_git *packfile_store_get_packs(struct packfile_store *store);
-
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.

-- 
2.51.0.764.g787ff6f08a.dirty

