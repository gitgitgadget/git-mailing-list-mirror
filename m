Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A265CDF
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473775; cv=none; b=KMZsj7786DDQmc0q1bPF57zOJxfUfynjuww8w6OroGDKiF/unv8mLSpineZqzwSJX64mDXM6VfhAG/Vs0daA/iuAbtFbK/dFi6TUHykjbQaNWDrr2C4w+ilKqYaXBwSsv1ahwZqTKLPpw13OCzce0TGOPck9YFwtvbGokt1IPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473775; c=relaxed/simple;
	bh=b8fJyCnS8dACcCnDWRVw5FrC+6SvVd0r+XRr2cny8m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJjUvWimfQv4tt9XUUxcUCXg0lWBuYz7DB78oEAlL6wLkm4yh/UtWD3TX/sAxa0YuBsxCa7drFB1WcmKDHtaEtSjVH/3oYPuvUnNZOEG+PcuA58Zqpk38/eZgeua7ozMR7wFqetpgFUrhLdgItoU7RWmCN9K3aUhjqwPVqCjkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AmMwEGuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1RzUZtTx; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AmMwEGuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1RzUZtTx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AAFA2540175;
	Tue, 25 Feb 2025 03:56:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 25 Feb 2025 03:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473772;
	 x=1740560172; bh=bAnEC5LEQv2KIeZSxMmvqhioX0uNPnWP4RR5gdObBNk=; b=
	AmMwEGuhz/NidE7X0zZBj42NEsOi6LBnklWO8XgWENrb/ittJnwvxwwJKZFGfphY
	uQqJ+99pqDn9YlKyUysj9kSQGXZ0jBDURlBMWmprzKFof3XXVL4KqLehL8ktvo4k
	Uz9xbKdHyAVjhtN6ryEgI0nUqSxbAnM1zjIp5w/EjW16PJugcrSsXsu+SbxlSfzB
	qYk7PSYpip6hF+R+HgMEgBH6F56vtdAc0xmuXJeas9ZpnH0P7hcueMQlF0uyDEl4
	1+W4C4UxDHJ8kXpIoEotQaulhvl6e+yUaP5kluj/w+JIkw+ZHFgNivq7MK1EJfOJ
	BRywNK7Bn9kn7/63a99gUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473772; x=
	1740560172; bh=bAnEC5LEQv2KIeZSxMmvqhioX0uNPnWP4RR5gdObBNk=; b=1
	RzUZtTxad8sRwaGlgAFdlTA59vCT0WoL8ZH3rcHDSaVxCyxFPGEDwEPvgdAk4zOd
	YhfrKkR9f7nGiV+jLKaeAkhGGbRPy49UflsIlUy5BLw9kz918QG/s2gtH0Gg4uyH
	xDmtE0/LCmq4NTPzjJdpK3+ECuEor3oZ1dLErKmJSGBBEqeKSyNZGnl0dzf1Kf0Q
	uekFG3qxmu5c97O3dNQ+JPATKAjo45HtAAGMwvr8tagbp5VdReBxNAiVs6Nnv5PX
	/6D0dqSM0xGYVK6+/cuqMww4lodDdYWa/tZR4XzJoOWSUGCT1Bz1WfNC7oAttDL4
	cu3Zty7/t90Tlwl50r9hw==
X-ME-Sender: <xms:rIW9Z5hZ5_Ku-FxQsh4DJUomKtkEs46YOggTYwFpKjM7DyBZrhfIJg>
    <xme:rIW9Z-DRFfeAw-WGE9XJBvAqPKgIsm7yQ95ei72o5fCP4hIqhoRtieXWWSzK-FFIf
    XqIOuhus554z5EiWA>
X-ME-Received: <xmr:rIW9Z5H0uYCDRqks8Fpv6dKERYPSppA6S26YC-wvYD7ERcgYht6qezWzvNkmaZ-1X8aDOCWFLTdCmvsp3XMWJa8ky2tD4aRInYx2XXnzXHIzwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlseht
    uhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rIW9Z-TTdlnsmv2rXnVfDbXnzXz4ixUz0xzN07nj9oEMtEHUAuyrBw>
    <xmx:rIW9Z2zUaiSzsW9tV2aSnQX937l9-eegHuyXctp8ToEnD4dHaSbKiA>
    <xmx:rIW9Z04WzHiJ8mSmDMWo_nn_9mSR8xDAG262XfQdxJnUlBJ731QigQ>
    <xmx:rIW9Z7wkdXExxoHOKHnwWVDF4MHRhWmNwsgxchsonQABulYcVwYNdg>
    <xmx:rIW9ZxyUF_QKg5un3BaHxVgGaz3pNMCb72QjE_f19p_uYriX2g0H-65N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63e68aa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:56:01 +0100
Subject: [PATCH v3 15/16] refs/iterator: implement seeking for files
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-15-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking for "files" iterators. As we simply use a ref-cache
iterator under the hood the implementation is straight-forward. Note
that we do not implement seeking on reflog iterators, same as with the
"reftable" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 859f1c11941..4e1c50fead3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -918,6 +918,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct files_ref_iterator *iter =
+		(struct files_ref_iterator *)ref_iterator;
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -936,6 +944,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
+	.seek = files_ref_iterator_seek,
 	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
@@ -2294,6 +2303,12 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				      const char *prefix UNUSED)
+{
+	BUG("ref_iterator_seek() called for reflog_iterator");
+}
+
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				      struct object_id *peeled UNUSED)
 {
@@ -2309,6 +2324,7 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
+	.seek = files_reflog_iterator_seek,
 	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };

-- 
2.48.1.683.gf705b3209c.dirty

