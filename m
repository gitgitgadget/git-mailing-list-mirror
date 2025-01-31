Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7F1B85D3
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320818; cv=none; b=intzAPBPr7AI+EyxqK8Ezww6Iva9fm3Nb+yhIS8d4jnoxgrgIkhI8wbf0LJOkfq2Iljy8ZVXc5RcD/oZkS5U8mqEniGRZMNbaSWONMz/B3aQW8MkqBkyyeStaJOPmEFOLsBU9y2XN9F/skcc2HTpjujz7DtwSJl9MVdARBYu04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320818; c=relaxed/simple;
	bh=mAfvfkaxXwctFztc9Enha3jhagEGMfCWM5hVpe/MOfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoxNw4JTOafFPxI5Ke7IQ/WkPhNws6P63AOmg3fbNwP8oXT/vK63KW1JtS70Pmmap+juSsMlteelon+DM4VuozndicOnnTdwp4Qncqk/TANzM1Zotm6Ryt8IIdOkHpnMe16bBxEdWoziXlrtGhWODhE4K9XCIRjEv64GcnoX3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ke0KSlO8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBVnZX+u; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ke0KSlO8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBVnZX+u"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CE69113801B3;
	Fri, 31 Jan 2025 05:53:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320815;
	 x=1738407215; bh=5E9W1XzpUM6PTz3Satza/4acrK933ru5QwjkJ8LUdgA=; b=
	Ke0KSlO8BrE44dbBqR2Ax4yucMze37XkdVVX1BlJZHWtDAMhPrHssSWizUDAM5B1
	jsSyIqRxAMjHMQfrvgccgSaGlG+HUBSbvikYIqA7bi6tMCPcKQmrgVfkL/vC4mad
	RH+Kpy5DUaq6ellgd61ihF2zk39kfc/4Q6bZI+iDz0RXqXDvn+CYr6apnCY7UBT+
	0dASOaeAu2m0V2Ipq2x57su/OdONAjST/ylQyOiOmMozRkVStEdvtLZM6+zxEfba
	EQVt7+tNxHqg/kK5DMLvXn6wPPv+4zdIyI1zlKUjBY0kHdQ9W6CPzXdMJ8goJnfK
	IdE/sckyK0NjuhqBPSOO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320815; x=
	1738407215; bh=5E9W1XzpUM6PTz3Satza/4acrK933ru5QwjkJ8LUdgA=; b=f
	BVnZX+uCNfq0ccBlqmsKS3S61wjjjJfLPAwDuLGafuOtgeQBu89kpoY2nqXn/kgi
	LLpYpxHUJTgvgBzUmRdq3XLhvTd41luj3+OgYmSmZmxpOj1VuQ6r0hs484Zeja9/
	Glnb5xQ1JcVwavpwEgv2zts405udVkjDcR3LeUV/aWDjrFgA58wk2RHnoooQpcBb
	j7TcBEInuVO4ZopkaAMcyy+pwN8GJlmmFDadW/q2E29I2Ho2FSUEJ3KwqTlQjPen
	cOCq7d4i1euxJxjRodVVmpW4pjYZC/LkTEzY/ySKDPOcjr6nM0QJg7P2mNaHNcsw
	c2ChgJXADHWLz1VaaZbQQ==
X-ME-Sender: <xms:r6ucZ2M02QfmKjeAJp08mW2qcaSI-xSOlb18bV4jVqUxzXC_KBbzMw>
    <xme:r6ucZ09cxul_sQl8HLnoXtSRQ63QUg9K854Ru87hRPyeX9yaAV7f1duf0DpuWOkxd
    2_t_aOeIGn-gpXdYA>
X-ME-Received: <xmr:r6ucZ9SfmFLpt6T4LWNSYAxaA_1naxEQIRd-FRPmOIFuH3cOFzhJdfKizwyvVTND1SlysNTHd-iOGi9fhXw8uxVJOlOjZceQf8VEIaHqtsTrXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdr
    tghomh
X-ME-Proxy: <xmx:r6ucZ2vx574Zn42SP9TM8rHvTDy1cmn2lG7BklK8XGuVZtTMtwZKdQ>
    <xmx:r6ucZ-ewj0Dyi5huk96I9XSrAE0_ukjd0_zS8JbI3zBXkhqbmiAVag>
    <xmx:r6ucZ614-H0Owznh1kLTSvP42kS-WUHRfZ87BJS6v1TmOfDLXH2NgQ>
    <xmx:r6ucZy9hUJf4XbTAHLS313k_6eqpWmM4s_Cmve-flNkTCWgaUJC_og>
    <xmx:r6ucZ-5mpFm02lTFgIdI5D0-_Ni0VtsjD4WHduExBTF_0XA1uIleA9iy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6727a65c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:30 +0100
Subject: [PATCH v4 6/8] send-pack: new return code
 "ERROR_SEND_PACK_BAD_REF_STATUS"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-6-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The "push_refs" function in the transport_vtable is the handler for
git-push operation. All the "push_refs" functions for different
transports (protocols) should have the same behavior, but the behavior
of "git_transport_push()" function for builtin_smart_vtable in
"transport.c" (which calls "send_pack()" in "send-pack.c") differs from
the handler of the HTTP protocol.

The "push_refs()" function for the HTTP protocol which calls the
"push_refs_with_push()" function in "transport-helper.c" will return 0
even when a bad REF_STATUS (such as REF_STATUS_REJECT_NONFASTFORWARD)
was found. But "send_pack()" for Git smart protocol will return -1 for
a bad REF_STATUS.

We cannot ignore bad REF_STATUS directly in the "send_pack()" function,
because the function is also used in "builtin/send-pack.c". So we add a
new non-zero error code "SEND_PACK_ERROR_REF_STATUS" for "send_pack()".

Ignore the specific error code in the "git_transport_push()" function to
have the same behavior as "push_refs()" for HTTP protocol. Note that
even though we ignore the error here, we'll ultimately still end up
detecting that a subset of refs was not pushed in `transport_push()`
because we eventually call `push_had_errors()` on the remote refs.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c |  9 ++-------
 send-pack.h | 13 +++++++++++++
 transport.c |  7 +++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 772c7683a0..4448c081cc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -632,7 +632,7 @@ int send_pack(struct repository *r,
 				reject_atomic_push(remote_refs, args->send_mirror);
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
-				ret = args->porcelain ? 0 : -1;
+				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
 				goto out;
 			}
 			/* else fallthrough */
@@ -763,11 +763,6 @@ int send_pack(struct repository *r,
 	if (ret < 0)
 		goto out;
 
-	if (args->porcelain) {
-		ret = 0;
-		goto out;
-	}
-
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
@@ -775,7 +770,7 @@ int send_pack(struct repository *r,
 		case REF_STATUS_OK:
 			break;
 		default:
-			ret = -1;
+			ret = ERROR_SEND_PACK_BAD_REF_STATUS;
 			goto out;
 		}
 	}
diff --git a/send-pack.h b/send-pack.h
index d256715681..c5ded2d200 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -13,6 +13,9 @@ struct repository;
 #define SEND_PACK_PUSH_CERT_IF_ASKED 1
 #define SEND_PACK_PUSH_CERT_ALWAYS 2
 
+/* At least one reference has been rejected by the remote side. */
+#define ERROR_SEND_PACK_BAD_REF_STATUS 1
+
 struct send_pack_args {
 	const char *url;
 	unsigned verbose:1,
@@ -36,6 +39,16 @@ struct option;
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset);
 
+/*
+ * Compute a packfile and write it to a file descriptor. The `fd` array needs
+ * to contain two file descriptors: `fd[0]` is the file descriptor used as
+ * input for the packet reader, whereas `fd[1]` is the file descriptor the
+ * packfile will be written to.
+ *
+ * Returns 0 on success, non-zero otherwise. Negative return values indicate a
+ * generic error, whereas positive return values indicate specific error
+ * conditions as documented with the `ERROR_SEND_PACK_*` constants.
+ */
 int send_pack(struct repository *r, struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs, struct oid_array *extra_have);
diff --git a/transport.c b/transport.c
index 81ae8243b9..d064aff33e 100644
--- a/transport.c
+++ b/transport.c
@@ -934,6 +934,13 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	case protocol_v0:
 		ret = send_pack(the_repository, &args, data->fd, data->conn, remote_refs,
 				&data->extra_have);
+		/*
+		 * Ignore the specific error code to maintain consistent behavior
+		 * with the "push_refs()" function across different transports,
+		 * such as "push_refs_with_push()" for HTTP protocol.
+		 */
+		if (ret == ERROR_SEND_PACK_BAD_REF_STATUS)
+			ret = 0;
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");

-- 
2.48.1.502.g6dc24dfdaf.dirty

