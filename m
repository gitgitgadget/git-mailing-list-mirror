Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C9231CA5
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807430; cv=none; b=drGZGbzFE+D4wHrJ7xhk1uR3LWAo6QYvS1N4aCOU5afqwIFjXhHBA6WEbvEdJ6LEXijLsMUvPbxUl8QIgp3mlg9SinbhxKqhiuzljGEU79UEA7JPYR/oSQsaA/+Wj4kpWh/P/eOP80e67xqPMqZLTELY3lejrCYv0DlLOiwCF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807430; c=relaxed/simple;
	bh=dTaVVldAkYLADkQpViT4TnkFPa/9dHQTVO7Oxahz6ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrigzJP323lW/Hw0a0zqHtXJZ47GeA3IQB3/Yy0E9rn8T0myQwrkAlaRAIdq6IKCVky6sTQCpcnd6f/Oq8o+gv9ojRqu98cenMiwC4HYTwxnLVSPnADp/WOh+K7N4626tEu20Qx2pb9uTxrIqTpElz+mUoWASkTJFbc+13Uq4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hke8xlxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/2T4Qg9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hke8xlxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/2T4Qg9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 39B821140185;
	Mon, 17 Feb 2025 10:50:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 17 Feb 2025 10:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807427;
	 x=1739893827; bh=lS4E3341V1QwRkhrxVmLTnyoSE18r65AH4/LVnWHeow=; b=
	hke8xlxbKj+5DvnO/8EwSAxaeRM+uQkyN0sbP7bunPeuiTLRc/soylTk9Dtt46l+
	x3ArakMJTt+mIPFgWQrWRHdlNmBw0c3nOrp5r13G4Al46U9Nkmdwoscc10vuaLoM
	LTkcUUUFu24Gu8R6B/B+t3+eXZeQNT20qewPOqet/GTPjbKGciLk11Qu/iLRnlqZ
	VTsaKgc1E5lczci1sb4LvmAnF+QHg4Ja2gGSeV4YDTVzGwA9BVZuC6K6qDWi2kEM
	sM41sEMX+jzN2HsRl/TBAWGYmPFS8HBJMnPwl68CMgPcbWiERfWSBbbLTe3ZCY2n
	GmGv1sm0N0nfwoxQIgZefg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807427; x=
	1739893827; bh=lS4E3341V1QwRkhrxVmLTnyoSE18r65AH4/LVnWHeow=; b=b
	/2T4Qg9eBEDljCz13VIIAZj+fKR2IwHLeuGTEdoGRCw36ovadKwKQqAOgRF7r5UH
	2oIm7DRzwHu6NMzhUDsqKLfj64JPbRxD5jU7gHB8nLQwWwUvc0JwcHslFVQ2FO8f
	02Zyqlqx9S/YkP0TJKz3PMnVWbdCUbaEPh+AGwDENd1bmQ+hduk4dEzktVwBDb+a
	IhQX9dKzn7mmLMHhfTvSCrHuBDwZ90Bl2XkBbPWLu+/zMNQXnk6dXOgiUgHJdqrf
	jBmjhP6IbjH78oSYfl2SsHjY2SMSZb0g7QzwYqeurbWMFoNc16sl1Lwy1UAhIbNh
	ifMpFIpq5bnxDPsfpLUEA==
X-ME-Sender: <xms:wlqzZzNN84UiwOQCMcq30VG8TRjIbvpvJKFigpUR6K8qEZaGY6oxxA>
    <xme:wlqzZ9_M7UwR6sh2fRJqwiknYVofS-Tfiue2cYEPzCHdI56iIjLeGZ6TjspV5Q6Ob
    MhJnKZZSKuTtwgdPw>
X-ME-Received: <xmr:wlqzZyTtRJ4IokmzjjDgHOwcTfa_F3jXK_wHvVFZJeYqkWx1NvInzVcBp6C23q2KX0YIDvy6pI2lmmDj6ztqX4OZ3xP4KSE6i_uNZQei669VWwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhi
    shgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvth
X-ME-Proxy: <xmx:wlqzZ3u8emouI-b5cMB_lSYUT2x-bcx20EFx1GYZ9xlybJuv0LSBvA>
    <xmx:wlqzZ7eGQENZL2Xfj9zQTKMXnOLjHhHZGoF-ip7WVws-kM04njxXiA>
    <xmx:wlqzZz1iHP_QBCZxV5aUFARt3HNVF1EjqS0Y4KIfoYzINIdq6bJrrQ>
    <xmx:wlqzZ38zMgjxJUAHwPmVPex-aaAl9U1Zg6Unpsx6_8li0PhlGneF9Q>
    <xmx:w1qzZzRl6q8WxqQezTuraHar2nFdup6iZqqbrWIIEgZjve9TohLkX8bg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea38487d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:15 +0100
Subject: [PATCH 01/14] object-name: introduce `repo_get_oid_with_flags()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-1-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.48.1.666.gff9fcf71b7.dirty

