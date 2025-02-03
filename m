Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967E1DD9D1
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564192; cv=none; b=UQi3KSDBSDGGSaoCizqQiOSFhGa7TjzpIuEOa8qTnXblq2VWPyhxAz60GpD4OUOnHvvXb+MMy4k9yvtnnGM4v9W+Nw8ICdhIceESrQ2XfMt/6bQUkWnV6cOq4XCGYriRjMzw7mB5yyi+BtJaOCMMH8LPpTPaJzSS3yJxvyD3qAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564192; c=relaxed/simple;
	bh=mAfvfkaxXwctFztc9Enha3jhagEGMfCWM5hVpe/MOfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CohM4wMrT2gWFns0fqgyiukGaa0ztZQfXORE77OtX4r3OL1Kmp4/9ccybZqU2BSbls2JQM0otBYSjgMqKrSrRYxuIVMKeDXebuBJdaNXUXdzeYbWCKhfkH5vIDbgks+MvjeU8AvCLCSPmodoQ14gjPMOrOcBjofFxWAerfw6Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KxVReAuo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxF+gUo0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KxVReAuo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxF+gUo0"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C6581140172;
	Mon,  3 Feb 2025 01:29:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 01:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564189;
	 x=1738650589; bh=5E9W1XzpUM6PTz3Satza/4acrK933ru5QwjkJ8LUdgA=; b=
	KxVReAuoKUo3yHSxU4KW8ydgNSjdzQqDkjllIzX/LzZU6m9We6oQdejwHjcX4jRg
	LyL7R5CVmsD0dFrJyHMRjmJwr1EpvFEgCCAFhP6OIDC6+IkYgRBCqdv9BciFoWEz
	vGMRJw36LlEQrN66HXNrHElQnRfnGp9nH8eu1vdCuA3UaMb4XIEnsgB+AHa1dg35
	rVKElHI5voN2uA7JyKgfuICWrhlGU9BAhxVTk2l9z/lXD16l+fFE1X98r03dyZA+
	vZ6VwP3T5uW5H5ISJ/ozc7894qMjykrtwfVWa3Z2D5/+pJi6pYlWzB7tay695N4x
	9eCqftWamoernKRH54uxaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564189; x=
	1738650589; bh=5E9W1XzpUM6PTz3Satza/4acrK933ru5QwjkJ8LUdgA=; b=Q
	xF+gUo0YHsnwrZU5voJGS6aq+eyFVtqF7Wgk/P2R4XCgOF4SaqG7J0DYqy/sOUAA
	1TlwjG78QyL7QGfU7KiSRARDNTNKRfauwzytKbC0U6bk3KThrp0cidxjbGGSmt4Y
	y78wRB2znY+loKm/GBVD+aDtfYiO0aQxOaq5ic5/z5OfPfeny1/FN0gzErBP0Ur1
	Z6mSwvqvs/IzOW1Mgo18+D0J+MsxcgMYmIEKGU/Dgnbowuwvo+ynpkOJvP6hE5eq
	5/TFY2hlZrObo07aTjgXhswNglER53dpcEX/lBJLQ2x1O/mucVaGq/JGCU9la2iE
	r9Pgd9nj7bu+layzV7aeQ==
X-ME-Sender: <xms:XWKgZ6lcw-XMPyon2FhKE1FI-M29Wtgoq3BTVcnPxZTKAYl4A_Exug>
    <xme:XWKgZx1mMJsgjbDnLg1z7di6dSW6y-5ASFFtSVa-JIX9QmC9R9BZ9p1sxbn_09SnH
    y1Ye1mntA5PijfB0A>
X-ME-Received: <xmr:XWKgZ4rgdc_J2uhK2mz834e3FL5zA2gcF4glIKeyLQIySXEIPvMX7aa8MfLozkt-pVJ0oQXl5y9KhxcUIuNoK4nRXZTw_MtDJ4GWRJyGbAphnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:XWKgZ-kCCC2RcawihicByVEQNk10Kh1KJIdIJq0wbTkiwyfCf6u3pA>
    <xmx:XWKgZ41XFliT1PVbzMt8kIiZAbPD5STh84My4vYmIEh_mk7xHmu3fQ>
    <xmx:XWKgZ1uRDhGDSyqmCZ9Px0WgaBUbAg9gbEQ8It8p4RuMEU_L_3BGqQ>
    <xmx:XWKgZ0U3TbZG4KYYQ6lsod5olIPTfh0BkZ77PalmzFBaI6m4uPleig>
    <xmx:XWKgZ7SJMqKtIEHaA6cdVYkfZkw9GWZaN3B8P3QfgkZtMTfnEa6VTa6k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33159b3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:36 +0100
Subject: [PATCH v5 6/8] send-pack: new return code
 "ERROR_SEND_PACK_BAD_REF_STATUS"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-6-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
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

