Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27435364EB6
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847989; cv=none; b=BzHXdodWmF54HWla65apyagNYn3A3qOZtFPi9dFJOHLGbxlRS+koCv9TX9vgy0SLTl0cr+Jy+AwiLDXs2GfxoBviMnJhpJIsRiLfNdXdhilefxk3dmH7LMXtwQVasz0fdEr+XVh5piv2xJTsopzI+4rzh+uWNmc/Z3NCyypk8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847989; c=relaxed/simple;
	bh=TsJ1tPOSOIQ95iTKhacJEdIN2atdwmckIAfJeQo4aYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuyMcDpByWk4COlhm1OUYQid6//4KH7XKFAwnB+InlWowc7Oa6KY3am3aohwW6DT2EDvXGvCbkpSvkIdMbGj7J1r8JEpGBd8ecPajf7hMCuEOsk+aDNsXL0YgaWBNaKQezT7sMSKqo0dHSIJpacNurgbF7cKo0ePAhWEBBoq2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XT+FS2Nf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AguOQrST; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XT+FS2Nf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AguOQrST"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 67F01EC05BD;
	Mon, 23 Feb 2026 06:59:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 06:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847987;
	 x=1771934387; bh=gHhKyTiU+3neWWQaQwqNgQETnRUxfgmB7EOTpX2RaLY=; b=
	XT+FS2Nf8blFefablwvVbE1dSQwQRCf7BkEp0QSlKbCuZTupsFIShVXdA6CdP2Qk
	k6UKYQIUBC1K2jfN+1qHY8oTFtbM7d9C64/dPfEDTvi99/0CP2par5Wmt5CelV+Y
	aN/utnuvOedNVUkxAtuini5T9KlSfiMK/fxAQlyxBwOEwShug869oHBmAdYbgfD2
	SJo59FSyGCJc0dZxdKd6efZPB9jXquXcKAiYR7w+rXBrmm0eQ3jHKizbcdT4gxKb
	jCHDa7VEV9JLUSIVt6MukBuicgZf74PeZVD9fzmyJ8ydnI8le/2TsI7811XulgQ1
	pfotdApXg9Jc1J5ShFZv/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847987; x=
	1771934387; bh=gHhKyTiU+3neWWQaQwqNgQETnRUxfgmB7EOTpX2RaLY=; b=A
	guOQrSTRDeGSzyLW3ZEkeBPZd1qdOn1Wu3Me/IjQUc+Op4NXwR8XjyZ4VR2buwJK
	XKzA7fsX4nK9dC6QbrCFA4oWdv3L00pVm7Cxxw64KjI6lnapPLw2JkuWuvFpKoGy
	Fbp5iw/3QXmWvVO6NqpV77ztU9t6SRt1la55tv9Xk7hYuEWSkpzF1hB0T3M3NF0e
	iP5K9edCvI+XqhMRbyOVH3/VhBRVHJ9gG0yWCdz3MtApREkiLG+0kWRJgT+0TiDt
	dldIL6wTX9Hpdl8stGO52JlN/oLlw/fhiZdJSwr/+5GQiE/Io5neewNIDWOgaAv/
	c88jdBXMJSnXOQ1HwlKdQ==
X-ME-Sender: <xms:M0GcaYB-Rn15RvRPSvWDzq6zPz7Gh_NyNXrdRyCix1m2Fuikb0spTQ>
    <xme:M0GcaR_UfPwXY-V_dMX6hBy6u7Ymx6Wy0cfECqjFuvyFyESxpR8Tvw1xXAjEFVdau
    0Rq4keUUXWY4BcJYdSBolI_nMxDw2lGZYr47OlRlznMOU3Ons4r6w>
X-ME-Received: <xmr:M0GcaY8zzEo8Mxl7B3-r6630xkKrVkmDlmFEw_8GvsBLQWHHuZjGI11eesnbXGaqioma49E62QZwUX-HkcwixVm-1OLjIn_6MX2zZExFHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:M0GcaYfx4sH4bPLJZYgJywU9ZL71ctCaQH5uI0fmKCEnR8Qq3PbPmg>
    <xmx:M0GcaRGcdZeqPuhROl5HXLUIp0NeK2MhsWrZvw39mLcnLx5_4UMFvQ>
    <xmx:M0GcaWc6iM_GrKlQdxJH_gzFNoifq_1WNdGv4pU4p_D1RaXPylqwrA>
    <xmx:M0GcabFxQFix8RhPqjnH1tbs4CQzR6DA3lYngw2fwIljiUQQeqEgFg>
    <xmx:M0GcaecbCrFNXhAGlmjvQf2-0w_Njgr806z6hX6x1wON5qNOLcrBPe60>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 970b4d7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:36 +0100
Subject: [PATCH v2 02/17] refs: move `refs_head_ref_namespaced()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-2-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

The function `refs_head_ref_namespaced()` is somewhat special when
compared to most of the other functions that take a callback function:
while `refs_for_each_*()` functions yield multiple refs,
`refs_heasd_ref_namespaced()` will only yield at most the HEAD ref of
the current namespace. As such, the function is related to
`refs_head_ref()` and not to the for-each functions.

Move the function to be located next to `refs_head_ref()` to clarify.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.h b/refs.h
index 1fdb809343..718212a5d7 100644
--- a/refs.h
+++ b/refs.h
@@ -413,6 +413,9 @@ typedef int each_ref_fn(const struct reference *ref, void *cb_data);
  */
 int refs_head_ref(struct ref_store *refs,
 		  each_ref_fn fn, void *cb_data);
+int refs_head_ref_namespaced(struct ref_store *refs,
+			     each_ref_fn fn, void *cb_data);
+
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -456,8 +459,6 @@ int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
 int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
 			      const char *pattern, const char *prefix, void *cb_data);
 
-int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_data);
-
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
  * result set on a best-effort basis.

-- 
2.53.0.536.g309c995771.dirty

