Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6230CDA8
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299771; cv=none; b=OtoTZdL9GF2+CWZfTeSGD31VfuNQgcLZa+NRXarMIw1xIO5l7QmXEK6RCpJvI2nwahnra4HQmSlEQxAPjl/95XQ5+NxanSDHD0y9uLnTiAXDK/WZ4aCmWZpUy1SyBxbS4jFnJxTT2Og4FnZ1PzLazGGvIzFdJG61ZJ53/CslpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299771; c=relaxed/simple;
	bh=aJMxA/CDNJYY7snIVcEM5etvm/RiFDnfZXyPVBanBJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVIxtA3q9uONPCNJxqy90tbBh2XG594mM65D0GgMyFx2wAVBmYPBnmbeTihyQ1pFUlzFd5pAfOiqLfy5+Ulwv9H/wUFqx/ldMBzs2PJfd+ftKoPwQGU6ivww2c6dYGScSYiRO7jUrGA8UbX+gIP+sNAOCAKEzLSuRYG680TlHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MLpuZySB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fl8acVVQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MLpuZySB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fl8acVVQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7E9B14001F3
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 05:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299768;
	 x=1761386168; bh=raS7J+larM2qKDctVsSBgwV/BqkNCK7bpJ5DwQ2Atgg=; b=
	MLpuZySBIlJlpg6JMy6uBaClENkx2Mbt2r4As16htTAc+x/ri6rJkF45BUawYleO
	+V1Z+1dtQvyoLSudSxf0MH32q+3pjEMafArzOoTPJp9x5Hnb3fMPIMr1/u7XRaz5
	z2AMXC96IO1WIqUKLb7H86BS7k1uACr3OcqR8vRxA/w4WtiN6j0RIZ8EF6KYpK9Y
	yTHG0TQpyHc2bc5/d3lxygVfkAPkLv8Ab4WmScF/dZdIekxLc5Qct8u534MDTV7n
	N0/XMebUoekHMwCu/WFsA9Nzj5L6wrLmq6OaZy7/vD/p+TcTUQ/8QlWbaR77HQGI
	nBfQ9z1+UAtbB/rn/pu79Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299768; x=
	1761386168; bh=raS7J+larM2qKDctVsSBgwV/BqkNCK7bpJ5DwQ2Atgg=; b=F
	l8acVVQUEZs2g/CcpQtgt6vH+EVFArLnT6nXMi8NYbcPSzKLnw3DsXzFsmvRnIWO
	WPw16KHfQgYy3QuPD35IUl3nXliwLpYBt/XW9uh4OLAJXjG4yoKEMUlJhoHYWUSu
	GoZABYaIr0rK+C0DF8NzxtqVskqjC3dv6qe/AzjA47nurzAfkIgXygZMT96BmUAT
	+OP3WcoK4ThWfFR8ZfWr8I9M7+rAKLbBQOSAxPDcEkACp2w+j0yT5i/hxcuKg8G2
	Hze/aU90dGo0aYh4OPCOoefoR4i/F4KYMGWmJGGtMImHZ4KHOdNAWR9AZn9AAFIx
	PJk50c/jWmi7BIQC2ak6w==
X-ME-Sender: <xms:OE37aKGDxCTbCmMpUITp1YwxG0lUn9z8uU7nc71Mn4EGcAguZJOFyQ>
    <xme:OE37aCTG-tK3uBOdt7xfLqyZdMlprCEcsPxVt-qLLxTj4yi9jX4-HauhcAucZHJKK
    Dc_Fxzm26wM-zY_RS0n5AjdAT7z-q9IqaUXFKzjmBbc592eNJtJ>
X-ME-Received: <xmr:OE37aJwgHYAaUpeAMiWsmzgy1cH0g89zRYSw8E5y6Zvj7jWpZkP3STE2udxF4_AFHY6hq4HU--58IAnv0yvlsA8BfQ4gX8UZD1jctwqgBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:OE37aJOL-HciaRwUm2TrPcr-OUQUIdOYLFlnopfrhGo_u0ACqlU6Dg>
    <xmx:OE37aAN14ijxn0f-vdgytpPS_m1iRTmgHM-BOvrgtsv6-KKRsLcLMA>
    <xmx:OE37aDRx-xcUVwjUBKrba4g77gfvuZG0Cy_E0RnmTdVNbRZN9LMp-Q>
    <xmx:OE37aKD0sqAUWGb3WtMWloARrjLQ5pNBLl0xLxx70JcN_DZNMeHTbQ>
    <xmx:OE37aMXlwie6bO-VPqy_nrMLxLIBwVvXMdpRsk29VgCC1EVbrwNKItH0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f760e93 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:00 +0200
Subject: [PATCH 01/13] odb: fix subtle logic to check whether an alternate
 is usable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-1-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When adding an alternate to the object database we first check whether
or not the path is usable. A path is usable if:

  - It actually exists.

  - We don't have it in our object sources yet.

While the former check is trivial enough, the latter part is somewhat
subtle and prone for bugs. This is because the function doesn't only
check whether or not the given path is usable. But if it _is_ usable, we
also store that path in the map of object sources immediately.

The tricky part here is that the path that gets stored in the map is
_not_ copied. Instead, we rely on the fact that subsequent code uses
`strbuf_detach()` to store the exact same allocated memory in the
created object source. Consequently, the memory is owned by the source
but _also_ stored in the map. This subtlety is easy to miss, so if one
decides to refactor this code one can easily end up breaking this
mechanism.

Make the relationship more explicit by not storing the path as part of
`alt_odb_usable()`. Instead, we store the path after we have created the
source now so that we can use the source's path pointer directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/odb.c b/odb.c
index 00a6e71568b..57d85ed9505 100644
--- a/odb.c
+++ b/odb.c
@@ -86,17 +86,16 @@ int odb_mkstemp(struct object_database *odb,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct object_database *o,
-			  struct strbuf *path,
-			  const char *normalized_objdir, khiter_t *pos)
+static int alt_odb_usable(struct object_database *o, const char *path,
+			  const char *normalized_objdir)
 {
 	int r;
 
 	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
+	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
-		      path->buf);
+		      path);
 		return 0;
 	}
 
@@ -113,11 +112,14 @@ static int alt_odb_usable(struct object_database *o,
 		assert(r == 1); /* never used */
 		kh_value(o->source_by_path, p) = o->sources;
 	}
-	if (fspatheq(path->buf, normalized_objdir))
+
+	if (fspatheq(path, normalized_objdir))
+		return 0;
+
+	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
 		return 0;
-	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
-	/* r: 0 = exists, 1 = never used, 2 = deleted */
-	return r == 0 ? 0 : 1;
+
+	return 1;
 }
 
 /*
@@ -148,6 +150,7 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
+	int ret;
 
 	if (!is_absolute_path(dir) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -172,20 +175,21 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	strbuf_reset(&tmp);
 	strbuf_realpath(&tmp, odb->sources->path, 1);
 
-	if (!alt_odb_usable(odb, &pathbuf, tmp.buf, &pos))
+	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
 		goto error;
 
 	CALLOC_ARRAY(alternate, 1);
 	alternate->odb = odb;
 	alternate->local = false;
-	/* pathbuf.buf is already in r->objects->source_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
 	/* add the alternate entry */
 	*odb->sources_tail = alternate;
 	odb->sources_tail = &(alternate->next);
-	alternate->next = NULL;
-	assert(odb->source_by_path);
+
+	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
+	if (!ret)
+		BUG("source must not yet exist");
 	kh_value(odb->source_by_path, pos) = alternate;
 
 	/* recursively add alternates */

-- 
2.51.1.930.gacf6e81ea2.dirty

