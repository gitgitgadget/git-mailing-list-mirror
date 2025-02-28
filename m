Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6E25E440
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734825; cv=none; b=FpqKZhMNURX9H9k1x1gZ8J3nvWKCYLYHUGd+yboIzQF7oeGJwH/NAuVwyN7H9Yp1ePIt2A5zbgX0znprkYrPVP+LKFvyhs3sCOykvP4bLb2REDbNUZjtgemS8zuBFinOA7IW56iXTFGq6NA71ni0Xf7euxDHix1g6x5IeASJn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734825; c=relaxed/simple;
	bh=uk6p5/En7ZEqmmTMxnHYCgPeLoCoftjAuuCm38k4Agc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuZW9pudATXqTamM7lkFVWdFyHHYV99rmbVolzthiiD3UBO3oAHTTfJ21Idttvh+tDZmszz2fIcsBsSt+REg2n3x694mQLxX1DCt551B87pJ193PRmJDGz63cpJMwdEIhXSL5jpd+EycGQyqqnZwEDM9YtSNuhtMQXqCdif5kNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h2hsDVhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzijEpij; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h2hsDVhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzijEpij"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C73AB1382794;
	Fri, 28 Feb 2025 04:27:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 04:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734822;
	 x=1740821222; bh=o/jUoS3CsKbEHLU60/uFtP51x0sS0GvVGfMI1xzJiQA=; b=
	h2hsDVhDehsXttoGJpHRmoabHJF81kN3bPIEeog7lW+hGutKp9bZyU8A/eIIZZj1
	Zwz4WYt2c1bmVwxz0fUy6B8L8JSW3g9ohI/U/OKT9hQ5w9JRJLAP739z4uRknnf0
	NSacQaM+3xLC9/j3hjuAOG+Lfvxd1j3ACdmKhvHU7KLV/3dqguMIurDM/Dt2CO5P
	piD0rLXUCI9/mMdvduUKjQKI3tBg+si6d5fPQkIDovGGK3uGOQ2k4JYqG50R7TGw
	lpF8gYxpIgfD+5iXQ44oH+YVW2JPIoAGmnokhMNmDjBKJWSntp3uxlwhp6hF1qEd
	qbC7sc5MyYHukej61r8F8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734822; x=
	1740821222; bh=o/jUoS3CsKbEHLU60/uFtP51x0sS0GvVGfMI1xzJiQA=; b=I
	zijEpijBSQQyTpOoeaNxZu9NuTWNcFSeQxCVYPjcCgEhzSIt3NvOPUgbp5oUpGse
	6bnDMaGsDwOc5nJbgbPrQPB/0AEtvheOo7F1Igntsp0YGVJZ37WArJo07M5POpgj
	k25H80yyIAb7AAwpV/kS1y6AJbFwYfsS257pPiBWzWtSky7sGGkGfFYncaL0huUo
	u5O0SKBqxW8nDRWv9hdCRKfqeYV6uv7ajplaGxkNmjTr4jfmzxu6IsDDrDqw5r1d
	jQ7kE1gAOpjRdspNdqpsqcQ3jBkVU18S+UFAR1DPR/strY2Q8QDxOC8upiR9tum2
	EYJcIGv5fDUGaFmw9voxQ==
X-ME-Sender: <xms:ZoHBZ64MJnSyCvZXOla7IzNX_CGj8PYqFILLLrbXVhuH8RQqijpiFA>
    <xme:ZoHBZz7W9X9Gl7zMqK98NjE3Xk4Cg7PNqA-KhGHjhoQCaApI-6iIZlVuu5otfBkU-
    KGbZ2jnaThkIgJTmw>
X-ME-Received: <xmr:ZoHBZ5dEsJZIsaRVjs3EkACc6Su6sv2OP9e_LsXNL6DYAgFGl4gk19hW6cbgw7jnLkX-cwZ18SIVy934drGHCJ5Ei5gOtUpyayjGts3dT4mkHL54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:ZoHBZ3JKxPizdDBIRGwtJcKSbkRn9WpfsNfbjzwYH2wascJ2dYkGpg>
    <xmx:ZoHBZ-Li0f-JpZVNsSHNFnzzjIrbNAPLczEDn4LNlhElxQ3iJ7VOWg>
    <xmx:ZoHBZ4xCcyNT8pTyaR4Xn4s2L1hdpDNq45unfXi4t2GH6grFyYP5ZA>
    <xmx:ZoHBZyKvitksFuDpzj4LFk0LAVpwywUDk-9DvKZ9mkEOnnj16q5RsQ>
    <xmx:ZoHBZ_prma-pmZ67ekhPrALPjHNTo0YOknk3GQM_gDSbAKX5ES6OOqHx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:27:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83339155 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:52 +0100
Subject: [PATCH v4 15/16] refs/iterator: implement seeking for files
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-15-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

