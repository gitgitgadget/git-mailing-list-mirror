Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0A232384
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870524; cv=none; b=iEMtFlNdqo7rRNiq8nTKyAFmmDToisgy5vATJICknPiyjca3+L6twBfGkFn+S+DelIw2rJRIKBkXrxn3ZOQN8hI9GktncxybUiTXGJC2MwcaMqoxnzn5LNQI8anlHHbRIDnQBIOv/BeRE9wbwo7t/tuKXO+q44mARZhrJJvs/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870524; c=relaxed/simple;
	bh=QAjZqgw7F1/7PkDviGFKMg1TdaZhn7d3xENF/W+Mg3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pqs5nSZF4oFnfDAEVFISi8a2By5Uasq/Bl6zCET161C4fU3BR+SeWvWhgOsj71nx+4U7hwzDH93LwjSxGn6crWPgqfr/mn8ZTYvCEHqrNSPnzpGy+y3XWWwURpAZJce/anbrnOIhzU8KI601CAaH9168Yxp6sDy8pmJAEnIq3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BqlETvCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eo7OaQi/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BqlETvCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eo7OaQi/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 065DC1140281;
	Tue, 18 Feb 2025 04:22:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 18 Feb 2025 04:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870522;
	 x=1739956922; bh=yRTaXi3+yEIzU63kuTE+gKZKFRb/Omlcpqu2u8j9z/w=; b=
	BqlETvCHHxHdUY3djsvB4CnTasq7oxdSbqWiwcLc46A/tqfAvmu3UwTOXcyNriu/
	NuwUGiUqVgW3aAkYCqH5X1stEeV6czrWvVCEClrDmzLDYqQ/MCW3r9xH9HQ9SDhu
	OYfe9WMNIthDDMrBAoW1I79sF7XUtI1E9HWNxLHB6g4WaU/ah5kNKiWkgV4dQXjP
	eBGqLAj9N5XfWpwEIsVJNoY74P91PUvoj8rl+rOR01VdlO/rlnr0w32P18XwzYhb
	87Rn6PU8aoE1+erRzeISDyC2vlWRAJt0/MCMz08J/QFKJ01x2rLBZEzBz1QAmk5F
	OP6aydLIU+3XcLj82nTHWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870522; x=
	1739956922; bh=yRTaXi3+yEIzU63kuTE+gKZKFRb/Omlcpqu2u8j9z/w=; b=e
	o7OaQi/B9+gRvdpIPF5oNCQlsRfXwo6OO7hOoyR/63jq+1gVdEfSsYYvvxILI1Er
	5DPiY7hq8aIcGgLmLKktdEWyaldU0Q12FAlVJQWOr47ML0ntqoLqcJCt19d40+EB
	sABsr2UGUWH/IFxklbmHKJeuXdss7LZtCYyYcCHk4bXWlvuCmPtvZqZqDy70W6te
	PPod6C8vdNFN/jwCkq++LAIcNW3ZFGYcFXVRtxlH54pDpfya/EOH37gxIFvWIGWS
	8g5VyfMwZ+lQFMStgszq0zN6A/Et1QoDX2oZOAYGXHcyQEsNHVdA6hl4xRoL7n2c
	9jTHx5Pg1m9MKc0YOJDbA==
X-ME-Sender: <xms:OVG0Z_vYSkHRLJAv2r9hQf5yOtlaYQfgM5sS_N3Y-hhcmIlQa1AHxg>
    <xme:OVG0ZwcBKgX1RIdSWfVCyUKkt3sOtxzMCyp5JWvO6JMgGyNRmO-Jq8z9iOuoszUDJ
    LB8I3UFql_k0XMdnQ>
X-ME-Received: <xmr:OVG0ZywSo-uBZP3CirvTEJVXU0k027IA6TT2KLGnTlhBBcB88-daP_H0l79GOnCZ_Ldkpu2770vHj-iAtO5AHJo8qITqc0Txgo2shyENIoP9JBxv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhho
    mhhsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OVG0Z-OwNQQZtn8UHh0ih6n_gFf8i2jiT7zXgtl487NRvgNWa-uh4A>
    <xmx:OVG0Z_8GUC_WSDQBzxcaIfSCpWnoR-nK18I3cFRgVVzjTfqpJ3Wn8A>
    <xmx:OVG0Z-WwViFfaJUgSB4-c-6fRXFOdt6HiXTLqYiim6ztT69n-u4qAA>
    <xmx:OVG0ZwehkDDAwphstauBVV-s1ToqKQ-qCnKr7Jk5jX3G0e6tdH2HUw>
    <xmx:OVG0Z_xy3EaS234vA-VYXIKiWpp2H2CJydcKErLiEfeaunde3ppPan7i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd5ebcd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:44 +0100
Subject: [PATCH v6 08/18] reftable/basics: stop using `st_mult()` in array
 allocators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-8-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We're using `st_mult()` as part of our macro helpers that allocate
arrays. This is bad due two two reasons:

  - `st_mult()` causes us to die in case the multiplication overflows.

  - `st_mult()` ties us to the Git codebase.

Refactor the code to instead detect overflows manually and return an
error in such cases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index a2a010a0e19..646f8d67f2d 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -117,18 +117,46 @@ void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
 char *reftable_strdup(const char *str);
 
-#define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
+static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
+{
+	if (nelem && elsize > SIZE_MAX / nelem)
+		return -1;
+	*out = nelem * elsize;
+	return 0;
+}
+
+#define REFTABLE_ALLOC_ARRAY(x, alloc) do { \
+		size_t alloc_size; \
+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
+			errno = ENOMEM; \
+			(x) = NULL; \
+		} else { \
+			(x) = reftable_malloc(alloc_size); \
+		} \
+	} while (0)
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-#define REFTABLE_REALLOC_ARRAY(x, alloc) (x) = reftable_realloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
+		size_t alloc_size; \
+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
+			errno = ENOMEM; \
+			(x) = NULL; \
+		} else { \
+			(x) = reftable_realloc((x), alloc_size); \
+		} \
+	} while (0)
 
 static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 					size_t *allocp)
 {
 	void *new_p;
-	size_t alloc = *allocp * 2 + 1;
+	size_t alloc = *allocp * 2 + 1, alloc_bytes;
 	if (alloc < nelem)
 		alloc = nelem;
-	new_p = reftable_realloc(p, st_mult(elsize, alloc));
+	if (reftable_alloc_size(elsize, alloc, &alloc_bytes) < 0) {
+		errno = ENOMEM;
+		return p;
+	}
+	new_p = reftable_realloc(p, alloc_bytes);
 	if (!new_p)
 		return p;
 	*allocp = alloc;

-- 
2.48.1.666.gff9fcf71b7.dirty

