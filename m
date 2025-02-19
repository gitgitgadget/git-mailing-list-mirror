Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811E1E0080
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971422; cv=none; b=O7Rgbv5qhbGtvXqBMZOCbzJi/voRXojG1PM/JZSgF8fYtaSD1cnniXowWUJ1o2lGfaMAjaReMB9IXcqdIXHqh7TVjvIkKQQ7HgWzjNL2+5XXLfyNopcVEmevG1jMPge+Zr/ou3sTP/TYSYHcSsDW8OpX6t36dNeIAnzaUo3JWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971422; c=relaxed/simple;
	bh=5ufMPVrKJUDR8jF1jUHGPiHEAiWbNTOQg5+YsbAoUx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRuLSog2wu320SDR6WXgeo3Z8SGrKKOo3R3/nu9qTzNGmD31Ck5iG8M65pCTp3DrzIFgkx1O5Bi8ctZDCkv9QQbd9pY3k3zOGKihXRT6R17OVcaJ2kklPH60m43CpSbGH1r3KVFRzgmILXGiSjPtf0hTQUPl0jR6ZVpQGZlso8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r22wi7DM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bzTB8CAr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r22wi7DM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bzTB8CAr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 749292540140;
	Wed, 19 Feb 2025 08:23:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 08:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971419;
	 x=1740057819; bh=AXSbXR1FEwAkCUN8T6T8OOZFc8T0Xmq+3glCG/NBZI8=; b=
	r22wi7DMS4UacuTM4fIPtlXieuJSjN6OhKgrHbSEw4665HXPLMSx0jssETwVE3Xp
	u9TMnBB0Pi31KbEgUI8yXS3pVHHV1OYDdobhXE1FJd42HS99aII9VtNS657AthH4
	OLqKgsx5hIjjyONQshLhATRamVuOfsBhyfEhQp0CXW74+7q0TY4OVYgbKdFszg1u
	IXz86664H229tvhgjE8bK9qOQlJtOe7k7PMbJ8h5JOfnYctN0MifkzUG6mkI+K+w
	IlOcVhBKwgtLMh/W90PId9qQsJZaqmBVCydsfBQat+xbVcvykd+se+KdSEhd7q0l
	+be0PBg77uYsgt0aQzob/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971419; x=
	1740057819; bh=AXSbXR1FEwAkCUN8T6T8OOZFc8T0Xmq+3glCG/NBZI8=; b=b
	zTB8CArBRMYJKfKGBs50zjvRh7/t4JMtcR+Zt5m9rBSxUQhCJWX5VaJmAvLhsL0i
	3SzTvuFDgHgMuJAYYhlyDwhf+2SJmdWKAP1v3QiTfvjOUxberrV47h19Qlx1THXS
	H7dBJJo2Q5ip9aG8p6kWk4e4r5Yy8hTzYL6bE+vyf6mIA5atFhshn4rhhwcVYA9S
	kHCPh0IvHU4JV3mtg4k7nZxT3qQT5USAA335BY0bkD0F2kZCqFGzYbEDAcOebnrv
	e4FfMx96MHrjhRBh9AQuPNOhSPvCZyGhx3giQzfkPBy5KTQGb3JcDFCTSruoB1cn
	XpnDcaSsvmbg5KPSx60XQ==
X-ME-Sender: <xms:Wtu1Z7lUgN71zW-hvGzRjrynBjWgPvutmpXooFC3Rxns-lYLQgJ3NA>
    <xme:Wtu1Z-1kRNlkMlf7Wk21soOoTziQtm2x5gX3MGyUY3opBOIJEw-lIIfVCWWS2wwEi
    2ewx_-oBuirfxV61g>
X-ME-Received: <xmr:Wtu1Zxo_qHyARCHinLpeeT5ld3ZekrERalGxQcbLP3kjb5DshX-x9AC_YtFPTGvHE5YMKTCKswAnNuCM_YYh6qNNBhYCCoVIDCN3M20-QOHd7t4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Wtu1ZzmmLzm1BiF6mmDBknc0LsN04NHRH5O8Fi-WEBmsFdfrcy0g6w>
    <xmx:Wtu1Z53AcA9M7FZaN9tT_pcbavFe_nKTH9qSF8n6UlEuG53QbZc60Q>
    <xmx:Wtu1ZyutsRfBsgEAaJ46M-CbnT31BItprvdcArWUY6sNRvODTHTCSA>
    <xmx:Wtu1Z9XufBhVXo-zUk4AmyuhyRvV3KOvqFnX_EmSAVG6_tALB3rvUw>
    <xmx:W9u1Z2kE9UB692EPs7lIe7IZSsTTdg0ml7jJ3hVnl6NpyxGwneJ6d3mo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98dc7a04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:28 +0100
Subject: [PATCH v2 01/16] object-name: introduce
 `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-1-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Introduce a new function `repo_get_oid_with_flags()`. This function
behaves the same as `repo_get_oid()`, except that it takes an extra
`flags` parameter that it ends up passing to `get_oid_with_context()`.

This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 14 ++++++++------
 object-name.h |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 945d5bdef25..bc0265ad2a1 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1794,18 +1794,20 @@ void object_context_release(struct object_context *ctx)
 	strbuf_release(&ctx->symlink_path);
 }
 
-/*
- * This is like "get_oid_basic()", except it allows "object ID expressions",
- * notably "xyz^" for "parent of xyz"
- */
-int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+int repo_get_oid_with_flags(struct repository *r, const char *name, struct object_id *oid,
+			    unsigned flags)
 {
 	struct object_context unused;
-	int ret = get_oid_with_context(r, name, 0, oid, &unused);
+	int ret = get_oid_with_context(r, name, flags, oid, &unused);
 	object_context_release(&unused);
 	return ret;
 }
 
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
+{
+	return repo_get_oid_with_flags(r, name, oid, 0);
+}
+
 /*
  * This returns a non-zero value if the string (built using printf
  * format and the given arguments) is not a valid object.
diff --git a/object-name.h b/object-name.h
index 8dba4a47a47..fb5a97b2c8e 100644
--- a/object-name.h
+++ b/object-name.h
@@ -51,6 +51,12 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
+/*
+ * This is like "get_oid_basic()", except it allows "object ID expressions",
+ * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
+ */
+int repo_get_oid_with_flags(struct repository *r, const char *str, struct object_id *oid,
+			    unsigned flags);
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);

-- 
2.48.1.683.gf705b3209c.dirty

