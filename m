Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC31B95B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059681; cv=none; b=IaIytNh4eMT4aehQBRP6rVqJpVS2qxuvXys9lpS8TllafX2p0XJam/iSknDgXr/iZ4Kooc9ZnuU14h9fTZMw2qg9aPkpxsWX5Oa9h0RDpp08K8V6S8oKdpWSy0Ccp8Qyd7gVHzbsINWzd085/uH/GeeZFbSz/mDIwexlctRu9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059681; c=relaxed/simple;
	bh=a7Bb52HNffVnT4Hd7TWIFUaeXXXZ3u2Xy68D0wEBhDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqZPunDIDr2Lxw+KXVyBrr/2BDcPc7NyuHiIolOGVfPfiErW7u8poykWAL+v8IH9nvazzGH/pkI05JH1Zr079CFypUKHj57uFXEQX2O8z5vXLIPmHWDb9IQM7knUNlK8yIRwigtXQf18pyUUh8n98L6lyaroUR4F9KrtZ+0I4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lNrod+Cz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XaAgapI0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lNrod+Cz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XaAgapI0"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C1F11D0089E
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:47:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059679;
	 x=1754146079; bh=SefMPr43WHeKEGZTCHYSGyyHIX/92IRsk/mzTDWwt8c=; b=
	lNrod+CzGDXJUebFzqkGg+Xi+T9j0MeIpLgx2jNKGiOblxQpGisAk3PTutuLE4YE
	HumwM5Y0S1NEBFDIxJnQDT02lseVrx9x2UwjcPOFLi+wDjSxy7iZyvJoDJ4cWTaV
	fJUXo6vzJYjWqkkLprgAvtfdXdWidJ0pImnzrFlv0PpPhC9cYc1JkjxfqOqfSSS8
	YVBpIqrf5RUak6m/QUS2NZPAFvziAtpSNSMBxHcXzGUPulprDqJFYrXfJltJ6Re5
	DO9gm7oYDGW7bh0XcokryanN+IuIOUYSAsuUb8p8bhiTKdRL41p4gjVNFJsZL7B9
	WSTV6IRkdROAvVI2o8Uh7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059679; x=
	1754146079; bh=SefMPr43WHeKEGZTCHYSGyyHIX/92IRsk/mzTDWwt8c=; b=X
	aAgapI0F1qbNJYRA015MxPZ4kjWkQxAC9l/8t/4t2+/H1kalu+URRGE3V8aCtjcz
	573mkImPTk0/eDUPP6giLM0JHThU9S2pXJnLI3IjMKQmYSySTNvblgA6a69ILiNe
	UyrLU0fyr4+a+fFbi9aOVLLnM6/tQeV5GK/Uq96p+XYcCn1CheQr87sDQtk2c1Da
	pjqJc7mwW/7SRah+8ql12ain/RvQt4MrY+pERrvLN+eFs6iBHObhbFYaRj1D3Chb
	pjRm5bgXeK0XiMOKiRdFCAckqCwovTJ5DX8nK9YFvz+x6NWGa6BazQpGrSOFdZbr
	Z3pmqS5n4q80WozhzBpFw==
X-ME-Sender: <xms:ntOMaAASKxZh-RrvN03SM6picnIjY8TdLMNdx5vkL3qd_KoarDS3RA>
    <xme:ntOMaEgVpTa0pC_Wlfw80CjHcWTYw_sDagJdDMYTUW8tJKDYQzAkpdj_imAMx-a_K
    wHjlobd5E-O6LITWQ>
X-ME-Received: <xmr:ntOMaM9APgzQi1DNkYL761-Q0RP1y58m0E3z9DPjb0Io6pUrL96fgD08-8o0N88OGU5mRYwxyGTXCNkxEqe-0TuO-OQfuSW9Bi4_b1cSAlYL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ntOMaI-HtAaLgf0L4a1gTgZ6-57RBVr-_V2ScDsee5uqnEjSqUHPZA>
    <xmx:ntOMaNAeJ8jgqthS4z0L8r0JGZa6j2yXRYqbEqwaXUWmGpBQ0I7Ovw>
    <xmx:ntOMaAwIFjXsrT4TqTwnojVCrgzGpR-Jx_c_HTrr7P98rS7NdLQ51Q>
    <xmx:ntOMaKTUPxGXOorD0ydpm_FOuXIJ0BJuNLzUZGeuqbhnAiRmi1pexQ>
    <xmx:n9OMaD6u3PtRwIUwePdBGGSJovaS42D4s7c8Sb-B8NzIq7lzO1ymyf9M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:47:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6a0b223 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:47:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 01 Aug 2025 16:47:47 +0200
Subject: [PATCH 1/5] reftable/writer: fix type used for number of records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-1-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Both `reftable_writer_add_refs()` and `reftable_writer_add_logs()`
accept an array of records that should be added to the new table.
Callers of this function are expected to also pass the number of such
records to the function to tell it how many such records it is supposed
to write.

But while all callers pass in a `size_t`, which is a sensible choice,
the function in fact accepts an `int` as argument, which is less so. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h |  4 ++--
 reftable/writer.c          | 17 +++++++++--------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 0fbeff17f4..1e7003cd69 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -156,7 +156,7 @@ int reftable_writer_add_ref(struct reftable_writer *w,
   the records before adding them, reordering the records array passed in.
 */
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n);
+			     struct reftable_ref_record *refs, size_t n);
 
 /*
   adds reftable_log_records. Log records are keyed by (refname, decreasing
@@ -171,7 +171,7 @@ int reftable_writer_add_log(struct reftable_writer *w,
   the records before adding them, reordering records array passed in.
 */
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n);
+			     struct reftable_log_record *logs, size_t n);
 
 /* reftable_writer_close finalizes the reftable. The writer is retained so
  * statistics can be inspected. */
diff --git a/reftable/writer.c b/reftable/writer.c
index 3b4ebdd6dc..5bad130c7e 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -395,14 +395,15 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 }
 
 int reftable_writer_add_refs(struct reftable_writer *w,
-			     struct reftable_ref_record *refs, int n)
+			     struct reftable_ref_record *refs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(refs, n, reftable_ref_record_compare_name);
-	for (i = 0; err == 0 && i < n; i++) {
+
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
-	}
+
 	return err;
 }
 
@@ -486,15 +487,15 @@ int reftable_writer_add_log(struct reftable_writer *w,
 }
 
 int reftable_writer_add_logs(struct reftable_writer *w,
-			     struct reftable_log_record *logs, int n)
+			     struct reftable_log_record *logs, size_t n)
 {
 	int err = 0;
-	int i = 0;
+
 	QSORT(logs, n, reftable_log_record_compare_key);
 
-	for (i = 0; err == 0 && i < n; i++) {
+	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);
-	}
+
 	return err;
 }
 

-- 
2.50.1

