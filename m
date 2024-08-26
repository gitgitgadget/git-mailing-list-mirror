Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DD12DD90
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656929; cv=none; b=RtW27LEuTfl8fDSdJ5msmP3olEgoaKzBBwAyyy/GKpBDgl/+VA6+0+pVTHmq59I3QY8qi3mz1DEjZdvFPnSe6/FefDwD43VCYT6J6qyBYIwLW6F9HT6nl/MKhZS+lNPuOrQkuyfSfyKuV7ngwQdhsnBx3Q83ylYOix34s+F0R7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656929; c=relaxed/simple;
	bh=8WKEjhWi27v4MBV37Utpcbo/CDLmZNUGImAkQmOcREI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6tky4Q1NMF75XBqvKDe1bPMIWggbqd8fkDT4QjT/cMt9fgy9WwWrAGEWzy1eS50ainPTfWUW//WxdkbwHVxYclr1uB74hnagMBo554oWGmuTTdwS+bfSt22g4IQnshE7RiNsDB8AKzi2184W5IJ9bGVseYkHqdxSr1z+BYeoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R62neDKt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cANoRk+0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R62neDKt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cANoRk+0"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AB7601151ABF
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Aug 2024 03:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656926; x=1724743326; bh=FZNc52J5Dr
	CNSP8BW+CDrnsHMhOrDhJ9UNvLddXosp8=; b=R62neDKtDgHxNjq7snwk2N44F9
	42MXjvXTjgsqztTtUmidU6qYIJlDzXjxifMTDEySBj8FANDQxe+JQeVFztYLcCf3
	WH88ZQSdGabZ9Z5PMknxvKh8h82S3qcWVvUsSyKi0NXzVuJ6s1Q4zgBzqZIuSDzy
	Wsf3p3+ecRL6mneGz8UFG8XWrJAPEV4dcbD9vv8dXHv41qXbv60It0zeT9IglgSM
	BqYov5We31TNN5ZUkms7A0/xkPfOxk2gJGqw2PRhLhAU6E1pNT9nk0zGf5NFmL/9
	snRnox+TofnFU3UYyFJkjv2l1sV7rUKvo2QOd6RSgyQmeORmt5+Zl3euyyWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656926; x=1724743326; bh=FZNc52J5DrCNSP8BW+CDrnsHMhOr
	DhJ9UNvLddXosp8=; b=cANoRk+0ORttHvOrHbQzSCp8HKIyBdRUIHcN6kOBQd4S
	oyAjf3VY9ROkuUAwvtXFqzD57C+/YdhlHikEFW+z3BeMWid+x5+6IgdQU6624XSN
	4oz5r73oG18fWZIzKLVKZZk3Usu8Wm5rF4MiPrS5A8mBqPZ/FRB2nvR1I/F25gqH
	PmdyVLOyWxIXkhgwGJQTe3VMFeU6zQOCFBNaLRlAEtDHMavmi5zWsRCoKFUpk/Fz
	QOSJ1w6oObHn95Gz1SHZfJWFGhaWFa9j7/AF9dqQzBjVpWECFMGx9Lbofzu+Zssx
	dwR/0Gi4Brfqb3cccfb0QMO3Bis2QGsibSe/pl7UUg==
X-ME-Sender: <xms:Hi3MZmRJi8sFbzf7YX0UhJr4fdayoleTfY1DDfVU4bpD9iX9cZNRkw>
    <xme:Hi3MZrwzZHat5HqtQYOd7yIH4duFr-NV71YgGgv6_7_j6kjksP26nRivseUqV2CXm
    a5To7uXy4vgMLMxaA>
X-ME-Received: <xmr:Hi3MZj1H1R_fG8rqqsum88SmJNy2myLJFmB_v6xjCUhgUNKxyfIt49vpcYvssvKlc63I3e474rTQZ8Q5ia1EtT9m13A0L1jKo3ofLatdwRXrCDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Hi3MZiCP7wJV-QAcqnp-MGxAMFNEP7qCkgkc1IJPCQIM_z4xGnJQKA>
    <xmx:Hi3MZvh0WmhSA4ymjuHWkgIAnvfe7x2_-VtV1tULv_5msH-auz1BLA>
    <xmx:Hi3MZuo5IRlxwFk0EsH-Wa4yzDOhC_apJqe_W8JD_Fh9B7uDjbUd8w>
    <xmx:Hi3MZih2g08YuWFXUJHuFZbul61WFm10Tqpe_KK_VQxbpwIcptlvkg>
    <xmx:Hi3MZnZevdUNv1Gjdmj62ey9Z30ZYdcGVwpYZz9e6OSPEDY6YnBtroxE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93b0b81d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:04 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/22] send-pack: fix leaking push cert nonce
Message-ID: <138a5ded35a43d3aeaa5058ba316a45b7b50b9ef.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

When retrieving the push cert nonce from the server, we first store the
constant returned by `server_feature_value()` and then, if the nonce is
valid, we duplicate the nonce memory to extend its lifetime. We never
free the latter and thus cause a memory leak.

Fix this by storing the limited-lifetime nonce into a scope-local
variable such that the long-lived, allocated nonce can be easily freed
without having to cast away its constness.

This leak was exposed by t5534, but fixing it is not sufficient to make
the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index b224ef9fc5e..c37f6ab3c07 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -501,7 +501,7 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
-	const char *push_cert_nonce = NULL;
+	char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 	int use_bitmaps;
 
@@ -550,10 +550,11 @@ int send_pack(struct send_pack_args *args,
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		size_t len;
-		push_cert_nonce = server_feature_value("push-cert", &len);
-		if (push_cert_nonce) {
-			reject_invalid_nonce(push_cert_nonce, len);
-			push_cert_nonce = xmemdupz(push_cert_nonce, len);
+		const char *nonce = server_feature_value("push-cert", &len);
+
+		if (nonce) {
+			reject_invalid_nonce(nonce, len);
+			push_cert_nonce = xmemdupz(nonce, len);
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
 			die(_("the receiving end does not support --signed push"));
 		} else if (args->push_cert == SEND_PACK_PUSH_CERT_IF_ASKED) {
@@ -771,5 +772,6 @@ int send_pack(struct send_pack_args *args,
 	oid_array_clear(&commons);
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
+	free(push_cert_nonce);
 	return ret;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

