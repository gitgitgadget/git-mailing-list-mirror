Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAED17B421
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852297; cv=none; b=SspgOivT5hL49csqE1dShMqQWLq1GhpySCUoAEcyPxG4YJMFuK8WjU+s8Z2YOp7ySbdiQXc702dL0B9ikhu7jq3mz/iiFKDnl7xOqjci+0WFmbbO12j2cs7kGksTDpCtYZH5XrB8AIoWL/mbcq/vbBDn9Qcb6CCeOz8dRBTkEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852297; c=relaxed/simple;
	bh=B72wCzzjAMScPASrFs+lO/j/sySeBigjXsrrfoNVCSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ptkh/M89kB+1zvLuv0GpY845DZjvBNLwCayVyIrAHZsrLj0XOdSy0SzN8lU0xTIxit3q1VMu0UVDOPHI/penfi+0ZVZ1Ue1z6ptDUfWv0fQ0a9kwYqLsv2xw9SPTosn5bYKziozlI3xKphcTwvul2d6tcmVW5Wez+j+TvJQw4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2zSzp2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ov58S4Bt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2zSzp2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ov58S4Bt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79C56254018A;
	Sun, 22 Dec 2024 02:24:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 22 Dec 2024 02:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734852294;
	 x=1734938694; bh=vM4VanXwFujuK2w2Psv62FAZc8cPmTAe1U8IwEHjapI=; b=
	O2zSzp2mZZYFqPc6iTaEyFgyOt5u8zh2Q5Nyng1EDmAvJwne5OXu/oUiasFDTtyH
	MySlYap+aNNU7veRAJdUOD4lGmwDFtzvvFa+i2ppaS7FMjqFXm4ZUIHg9LeYLUh5
	DUuzXv935+duwalXdmFDY/mkDms7LlwQ9MwKai1T7a4yOnVQNhzMUpX6mfDmMdBL
	7mtOJqNP66vrKjEzvWcFuLTmhwzNw98VTrbjRYK0GRbBifDsWbuJGSEkXG8NAIRS
	KEBX8ndbffDpw4H+yDa/y2wQNbZyDVUMfAJscGzCG8xjSHtm7MCe0Eez3QK/RoyM
	gCHiQWpABvWZ6auh0dndGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734852294; x=
	1734938694; bh=vM4VanXwFujuK2w2Psv62FAZc8cPmTAe1U8IwEHjapI=; b=O
	v58S4BttPCjBPjA4A48P4zKlLMA3TjtGTI8gBEtoEW7r4heVXSBkxho9ZdwtcfRr
	7Pald6bDmWdlUtixRITeEiGWwfwbtYPUj4dbAVA7h97iBFOwQN93gusO85Su59rp
	hHAKiiqGzm3dZyktHLLuELwrW8xwWGWJmPvkF37jqOjXzHpO3raEWCz9xdSIq3S8
	BFTSCYoNL2tai8OWVOpKskZwiaIfUMAkSJwHvbgC50JwJ55ofyhFy124RGdT+l53
	qyXdExDqlRgESZEghMTUdUO8K8auC5gYUXf5cdfEYVSnjv0mgKtW061Q7bVZDHL4
	qQ4yngBWEBzftNkabq6mQ==
X-ME-Sender: <xms:xr5nZz1NNExlIoQ4A5_QkNvf6-hXFCCWFJXhTXHVoqukG6SR2smnIQ>
    <xme:xr5nZyHN29Eqcw90-Z-O9MrxpIbMYo1a-90toTowMXGfLRnZadg8jw3VWmNCkxCz_
    pefH49TEyf100VuAQ>
X-ME-Received: <xmr:xr5nZz5VroQcjmr4x1fcb_tYBj8SAxFsqCBzQynGgdYMPbs91pZRxZbeZVvi2sqveS_maSmi8_tR6rscAO2aAao0QCr08UsqFOg6aF9RrIEQSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhes
    nhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xr5nZ41r27yq9Sj7oVUexXvp9LJUTih0BjzbUwJJgYQQBJnm-CqncQ>
    <xmx:xr5nZ2E9TTTOQRXx_wktdWGHOg4B8RAXqcvc38fIWMmAgJRgGdOPbA>
    <xmx:xr5nZ5_kWt4Tk9LM55W8gwLQMMe12kKeI_Nu4cJ_GlIzVeQroQa0Xw>
    <xmx:xr5nZznDS21S6ftUDHja3oPOWxFY0SJB8L5b3l6-teoYMrf-mo1jhw>
    <xmx:xr5nZyggMxjPe9tNblrATIJ9y7gLIjqR9h0wZVMYBiP4LO7cw_j6mdYy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:24:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00e48c19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:22:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 22 Dec 2024 08:24:31 +0100
Subject: [PATCH v2 4/4] reftable/basics: return NULL on zero-sized
 allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-4-19550090d15a@pks.im>
References: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
In-Reply-To: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

In the preceding commits we have fixed a couple of issues when
allocating zero-sized objects. These issues were masked by
implementation-defined behaviour. Quoting malloc(3p):

  If size is 0, either:

    * A null pointer shall be returned and errno may be set to an
      implementation-defined value, or

    * A pointer to the allocated space shall be returned. The
      application shall ensure that the pointer is not used to access an
      object.

So it is perfectly valid that implementations of this function may or
may not return a NULL pointer in such a case.

Adapt both `reftable_malloc()` and `reftable_realloc()` so that they
return NULL pointers on zero-sized allocations. This should remove any
implementation-defined behaviour in our allocators and thus allows us to
detect such platform-specific issues more easily going forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index 7d84a5d62dead1cf1a60698b1bb12fe6ac41c090..70b1091d1495bb5b4c8aae63bd9213dc704aecde 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -17,6 +17,8 @@ static void (*reftable_free_ptr)(void *);
 
 void *reftable_malloc(size_t sz)
 {
+	if (!sz)
+		return NULL;
 	if (reftable_malloc_ptr)
 		return (*reftable_malloc_ptr)(sz);
 	return malloc(sz);
@@ -24,6 +26,11 @@ void *reftable_malloc(size_t sz)
 
 void *reftable_realloc(void *p, size_t sz)
 {
+	if (!sz) {
+		reftable_free(p);
+		return NULL;
+	}
+
 	if (reftable_realloc_ptr)
 		return (*reftable_realloc_ptr)(p, sz);
 	return realloc(p, sz);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

