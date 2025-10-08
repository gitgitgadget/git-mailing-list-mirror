Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9262FAC0E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938647; cv=none; b=vBllUmjpBDClZ7NqWwsWk8h3ozf4HHD9P6fYf4uTVMyFo2VaoWnH//p6zN8pc2P/krrPUJUHZF0XxSOfM0d0ZQXERppOsbHPRlPLRTTYyDqQa/E1eY0c8foLJCuWRg8KQwT7hzkA6tlzgHp0wojCaOZZ4kikRQ0QkfloigZgk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938647; c=relaxed/simple;
	bh=51iGbW17dseEntjFwy++TbHQnmiSd5okWwgqef/PCnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+irJVntdCFPgg6x01TH+GIbAGN3sDYmcYyhKJWf6kG9o0I/MfiWb9P5g3vkSjooKKA8X86iCYQEhIQS/dJEP94eNnuriwwRNBgw7Z7eq33Bo/77SSfcUCY0nqGHkx2D3Pw6qvSmF0ToKNiOTMYO8zQIvmNxsIhPwZTH1XbUXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p+pE4uq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNhopzQ3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p+pE4uq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNhopzQ3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A560140022C;
	Wed,  8 Oct 2025 11:50:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 11:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938645;
	 x=1760025045; bh=a8QVS3fuMw2p0jh8Ruxuqza9P59TayqHrr0XrATVDKw=; b=
	p+pE4uq4dseVzd5jSZ6C9F8cwXpu7jgJ6EodRaIbOXzU25gWb4cwhlTKT/2M9cNs
	6b85wVgLvtnHmEDVkkw+vKh7vrDWDJiMkLmTsP8R/btUfKD2R9Rr144+OFVNmbZG
	95FZXhEwktL1T8vDo66+iaE1McGESo7vtmVonDepU06ZzgOVIN1eUnatOiQEwBcL
	8ysvUbTzNMkR/uvIZEpXZs+KBmdfgR4BtJhFzyITZfgUZEao7KXmzd32D9zpWczw
	62tSS7ospcBbrvwhuZZF8+mE5+4l/InP7etftPmCKrlQnA+uFjTtq1dz6dy5e8rO
	BYC1akY4vtdW/JuhhJZFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938645; x=
	1760025045; bh=a8QVS3fuMw2p0jh8Ruxuqza9P59TayqHrr0XrATVDKw=; b=j
	NhopzQ3ClbI/r2sVpT7pjnV10CIc9PpHSPXAAHtHniJ/eBi2j58wS+c/ZASIRvo5
	1DAVe2wKTUo2DRKS+qxvsPrUMBg1rwmESZwQgWVrVBcwdJXriYSO+8VUeLFyzbrn
	CkHEYoG9Zinyyr/ARvhJoVEv+dpY7UNDvA9No+RFwx0NmWGTxhrAZqwB4DJ7tBdi
	vNWG6o6zs4Va1FyboOuwRlUqXipRO3k9ANEZ4S43PvH2nGDtqoMauvrF1rkBo4/i
	izyHvZWd6jOndpeCNao82uajqnkl5RLOleejpVxs7mKDDHxT2gx43VqUrpSmMOlO
	+YyLlEvQFop6pPMH+Nh0Q==
X-ME-Sender: <xms:VIjmaAYQuNoCXRD8h442Cal4auqlvfDlffdh4mM-_ahBNYbBAafqQg>
    <xme:VIjmaPF3vW_iF-ub9kMLWHPuXDRy4nhuls3LfQ-uXKun7zqicKA9DrIWVa_ZtcbWc
    WWPoLjwX0O8XBCTAM1OApEX5s6H-qkfMZC9FORbXk6r8G5YGs9MCA>
X-ME-Received: <xmr:VIjmaEzyXaZlBq3jgLe77rLnniDr36TbfQwSEhq0od3MzpYc0lotpq5VcT0a_PE48crvMFTi9naqI4Zbx5tS763OpS0UR3bWbdfTdao2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VIjmaBnirWdPHOqygLL1lBfzohA15QFfQvqr4d3dNd8uWgIQkzsPMg>
    <xmx:VIjmaNmJreEguSDM5lsUGBMFpzHP0nmgw4OESLUuDSTM9CgE10rlPA>
    <xmx:VIjmaDzG-NHVzoF6tEWNwe_UcA5B4x-lGvpNcMygHCl-9eDqgelwzA>
    <xmx:VIjmaCrGXr4xsDoG7s5uWZGv0wa88e69G6WUX0SHJrEn9zKmn5_4Xg>
    <xmx:VYjmaPlw8Ad1TuzkCncHJHpk9jIYEWPzG83rzZ4wNmqgkKXar39oZAng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb472a3a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:21 +0200
Subject: [PATCH v2 06/14] upload-pack: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-6-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The `write_v0_ref()` callback is invoked from two callsites:

  - Once via `send_ref()` which is a callback passed to
    `for_each_namespaced_ref_1()` and `refs_head_ref_namespaced()`.

  - Once manually to announce capabilities.

When sending references to the client we also send the peeled value of
tags. As we don't have a `struct reference` available in the second
case, we cannot easily peel by calling `reference_get_peeled_oid()`, but
we instead have to depend on on global state via `peel_iterated_oid()`.

We do have a reference available though in the first case, it's only the
second case that keeps us from using `reference_get_peeled_oid()`. But
that second case only announces capabilities anyway, so we're not really
handling a reference at all here.

Adapt that case to construct a reference manually and pass that to
`write_v0_ref()`. Start to use `reference_get_peeled_oid()` now that we
always have a `struct reference` available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0d563ae74e..2d2b70cbf2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1249,15 +1249,15 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static void write_v0_ref(struct upload_pack_data *data,
-			const char *refname, const char *refname_nons,
-			const struct object_id *oid)
+			 const struct reference *ref,
+			 const char *refname_nons)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
 	struct object_id peeled;
 
-	if (mark_our_ref(refname_nons, refname, oid, &data->hidden_refs))
+	if (mark_our_ref(refname_nons, ref->name, ref->oid, &data->hidden_refs))
 		return;
 
 	if (capabilities) {
@@ -1267,7 +1267,7 @@ static void write_v0_ref(struct upload_pack_data *data,
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
 		packet_fwrite_fmt(stdout, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
-			     oid_to_hex(oid), refname_nons,
+			     oid_to_hex(ref->oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
@@ -1283,17 +1283,17 @@ static void write_v0_ref(struct upload_pack_data *data,
 		strbuf_release(&session_id);
 		data->sent_capabilities = 1;
 	} else {
-		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(ref->oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return;
 }
 
 static int send_ref(const struct reference *ref, void *cb_data)
 {
-	write_v0_ref(cb_data, ref->name, strip_namespace(ref->name), ref->oid);
+	write_v0_ref(cb_data, ref, strip_namespace(ref->name));
 	return 0;
 }
 
@@ -1442,8 +1442,12 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 					 send_ref, &data);
 		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
-			const char *refname = "capabilities^{}";
-			write_v0_ref(&data, refname, refname, null_oid(the_hash_algo));
+			struct reference ref = {
+				.name = "capabilities^{}",
+				.oid = null_oid(the_hash_algo),
+			};
+
+			write_v0_ref(&data, &ref, ref.name);
 		}
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref

-- 
2.51.0.764.g787ff6f08a.dirty

