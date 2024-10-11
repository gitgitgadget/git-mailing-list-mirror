Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59A20969A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629660; cv=none; b=KL73n+xKAthlgRL0jcOUYTuYFzc3ff7dtAclj22pMTgz78yMeQkptl8By132s+/8qC94mIFW+9KWNnDRrY0jyIRS7+o9OnsOIc0Em12PHGBn1d3Ij86KM4BsF4f8A24re/EIXvRKiZLsT1ApceaCBqRgPI0e7GCSfho+5e1nOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629660; c=relaxed/simple;
	bh=Q0TGovRMYoq+iAZ3gdnabaDFY5R8We1eTHtgQv/BYcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CO7EI8Zq7Py1cewNxV2A6FtZLqOkm4DmVu9vf6WSY5Cq4j50NRdnLS50DqPZ3iaSIy5uiD1PJu+JKc2IdVb6pJ5jTdcCxXqIoNuFl535ELThzUK6eG7ZDbvJGVjrmcoVaz4o84uDmQ7zbAM4y3KSQ9DYN2qXYtaYSALb6p54oQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rSTxOWbe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWUry6yY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rSTxOWbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWUry6yY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CB9C1140126;
	Fri, 11 Oct 2024 02:54:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 11 Oct 2024 02:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629658; x=1728716058; bh=XoUtyJtv2t
	Jxqj4wB27GirB966CEOwM9U9m8r8tuGJw=; b=rSTxOWbebo5DCvK/Ol9g3StqL9
	qAohXpGeCoNcng84yXLPS59BrdWu/RbytAmwkfB+Nx6rnfCjZvAkXOOU6O2Tc+B6
	l+bQpcDrTuRGqfBLL5mUJLEp24iRhpwDZqNZTbtzdp6SRDKifQHKlcA3PEQIKqjY
	Jin5CnQiiMfDFpGi/NbXyBYp5lZYBRvrrPVsPIGGqJ9Yzs+AdEUU0S11dYQUIGnN
	89Q2BdH0WGclQ2qF0nOlqXNHfn65Fl1NjEqXq6VuxUgDITumCKJ2UEXYD8Q3vADq
	h1kUij9+Gs6yX2jad0Xvtrao2AAhJjfaHehL7G2s911Q3DMldjlGGDwjlPSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629658; x=1728716058; bh=XoUtyJtv2tJxqj4wB27GirB966CE
	OwM9U9m8r8tuGJw=; b=YWUry6yYPmzTft8yyuMps5Fi9ZdPWnKugOHdbJsfqxNM
	SraJSiFbwMIgZdVo9cn6e1YEkFKxE+BRJtsUQ3Oolu1gXDph/vtOKLDpfR2uM7Ql
	Nr2yv6+2E15gbW5nUSLdJOjKh1F74IKnW/WgQWhGngpboiLb01CUwSdGcMr+4LX5
	+7WP1S/DaSheI8WzdvPx80+ft0Ei5/LUb6HaYzCkB7SG0mtViJ2Lj0lx//edpwAZ
	Nh3EUahQOr+bdenklzOS9dhuFhxfFXM43om3ZwzgDJh47d+ZUMkrcQFQ1MSnhD8h
	VLAX5PkB14ZjliEzTC0xruoEQzcCCFReYBmzWmisFA==
X-ME-Sender: <xms:mcsIZwZcmu59pALmo9xiGqeJEK7j08irywoxTpgvnXLDbdv3adabew>
    <xme:mcsIZ7au5Jd3ZBIrUGn1SbDUZRbGHPIkPTXnuoAkiZ40yVsOCql_yIqQrqFgLAgSv
    C3SNs1lJ6Gemz0JgA>
X-ME-Received: <xmr:mcsIZ68_fvzgKbWCJ7cX4VjuiBl6wRszGhwHhESuaJo5LVHpcC5ru_JXJIExc0Q4EAYUWlsdRv5_Hcjc3_iPVrCd1iaCmh4HAX8sKcoCG_R2Z0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:mssIZ6rDL6vy5rcEh0jPA7DPagP7qT7_B2FyGWz0QyVFkUaPtEUwUQ>
    <xmx:mssIZ7rPHNb3MieQrp8Iba-BjgAw-u8BTiE_XL1sq2y6XGrhPxpthg>
    <xmx:mssIZ4QqRFkQrd9eSJNQeE20PFBDe4F8v-2cuuzLaBE2P7jyyTxMig>
    <xmx:mssIZ7pDhlwJs_j6DiqzVqnNcU4BiwTZJTC5Oayh9btOPXPJmyqpVw>
    <xmx:mssIZy1aaMevM5Ok-0z0lpBr7eQJqbjVjgsgtXE-g0N8Awy3UlYIOhlh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5628e7f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:11 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 03/10] reftable/basics: provide new `reftable_buf` interface
Message-ID: <24e31619b936166404b801dde0e2bca478328386.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

Implement a new `reftable_buf` interface that will replace Git's own
`strbuf` interface. This is done due to three reasons:

  - The `strbuf` interfaces do not handle memory allocation failures and
    instead causes us to die. This is okay in the context of Git, but is
    not context of the reftable library, which is supposed to be usable
    by third-party applications.

  - The `strbuf` interface is quite deeply tied into Git, which makes it
    hard to use the reftable library as a standalone library. Any
    dependent would have to carefully extract the relevant parts of it
    to make things work, which is not all that sensible.

  - The `strbuf` interface does not use the pluggable allocators that
    can be set up via `refatble_set_alloc()`.

So we have good reasons to use our own type, and the implementation is
rather trivial. Implement our own type. Conversion of the reftable
library will be handled in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 reftable/basics.h | 16 +++++++++++
 2 files changed, 89 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9a949e5cf80..a6abefe7f5d 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -69,6 +69,79 @@ void reftable_set_alloc(void *(*malloc)(size_t),
 	reftable_free_ptr = free;
 }
 
+void reftable_buf_init(struct reftable_buf *buf)
+{
+	struct reftable_buf empty = REFTABLE_BUF_INIT;
+	*buf = empty;
+}
+
+void reftable_buf_release(struct reftable_buf *buf)
+{
+	reftable_free(buf->buf);
+	reftable_buf_init(buf);
+}
+
+void reftable_buf_reset(struct reftable_buf *buf)
+{
+	if (buf->alloc) {
+		buf->len = 0;
+		buf->buf[0] = '\0';
+	}
+}
+
+int reftable_buf_setlen(struct reftable_buf *buf, size_t len)
+{
+	if (len > buf->len)
+		return -1;
+	if (len == buf->len)
+		return 0;
+	buf->buf[len] = '\0';
+	buf->len = len;
+	return 0;
+}
+
+int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b)
+{
+	size_t len = a->len < b->len ? a->len : b->len;
+	if (len) {
+		int cmp = memcmp(a->buf, b->buf, len);
+		if (cmp)
+			return cmp;
+	}
+	return a->len < b->len ? -1 : a->len != b->len;
+}
+
+int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len)
+{
+	size_t newlen = buf->len + len;
+
+	if (newlen + 1 > buf->alloc) {
+		char *reallocated = buf->buf;
+		REFTABLE_ALLOC_GROW(reallocated, newlen + 1, buf->alloc);
+		if (!reallocated)
+			return -1;
+		buf->buf = reallocated;
+	}
+
+	memcpy(buf->buf + buf->len, data, len);
+	buf->buf[newlen] = '\0';
+	buf->len = newlen;
+
+	return 0;
+}
+
+int reftable_buf_addstr(struct reftable_buf *buf, const char *s)
+{
+	return reftable_buf_add(buf, s, strlen(s));
+}
+
+char *reftable_buf_detach(struct reftable_buf *buf)
+{
+	char *result = buf->buf;
+	reftable_buf_init(buf);
+	return result;
+}
+
 void put_be24(uint8_t *out, uint32_t i)
 {
 	out[0] = (uint8_t)((i >> 16) & 0xff);
diff --git a/reftable/basics.h b/reftable/basics.h
index 4c9ef0fe6c5..4cf3f0e7593 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,6 +16,22 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-basics.h"
 
+struct reftable_buf {
+	size_t alloc;
+	size_t len;
+	char *buf;
+};
+#define REFTABLE_BUF_INIT { 0 }
+
+void reftable_buf_init(struct reftable_buf *buf);
+void reftable_buf_release(struct reftable_buf *buf);
+void reftable_buf_reset(struct reftable_buf *buf);
+int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
+int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
+int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
+int reftable_buf_addstr(struct reftable_buf *buf, const char *s);
+char *reftable_buf_detach(struct reftable_buf *buf);
+
 /* Bigendian en/decoding of integers */
 
 void put_be24(uint8_t *out, uint32_t i);
-- 
2.47.0.dirty

