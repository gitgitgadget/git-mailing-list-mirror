Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD13328E6
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371607; cv=none; b=pGDCBNgPMrfbi9oRQop+b9altKD2rLgNn4kLwzLrrZQatPNHlnRk7yJmdZBXiHO6Wg9ORBHgRYSSNmHIZjcFh+ociDtmc5a2p/eCXACfgBEHShJ1erelh5jZHVz4qH1Nc0wutQb4TjBroDViTb+ScgyhPlk8/+U8wtrrEHSKpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371607; c=relaxed/simple;
	bh=KUAx4pTS5HpcmsC71g8JoU871lO69p/9428hMksb9xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZ4fW59DqJxX9mV1D+rwQm3OU/qm5dDiB3kONXFDvIumXLXc6ykTqQwM+v2UhsbrIcHzct9pefJ+LPnnqFbQEIyF9/wNXO7gc4C4NqUCv+iOrGtzCwwxdFTq1ADR5sq1f6hl5KkR0a6olkV3fFOsxocf2YFgS1aQeuUWDA2etfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=McE5qEK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEp4B46f; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="McE5qEK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEp4B46f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66452140009D;
	Thu, 16 Apr 2026 16:33:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 16:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776371605; x=1776458005; bh=P8rt2M4uJt8x4UFDhGac6mhrp8p1kWum
	A7980TPiH8o=; b=McE5qEK20cICEsF4UHoekozoLPmJnhpsxPwu/njFpuld0jjh
	vKChw3ApJSF8FffpSwVWs/WXkYSTUWJmTfcl8j1njQvKIdbsDpnv1d3WKWkbp+53
	ulYCSdnW1/3jMxlKG1RQWOWHgUYJONbhb6mI4BMC5KDr/8LxyG3BN5EzbX3SU14i
	V1uv6XsptxAu/IaktZ5Sdjap9vXRCCHObjorvkuuwj4nNqoymX1FEiLq5cdO4MhG
	eOxWUjXaLUbwgs2Vg6TW3/YTzdIHKlHz2Sd8qL8nz9sVP3L33cRcZpCyShtnLeYS
	1fP/2uIkx7c14ZsN8evFQDoEPuijHMO7LEDLbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776371605; x=
	1776458005; bh=P8rt2M4uJt8x4UFDhGac6mhrp8p1kWumA7980TPiH8o=; b=F
	Ep4B46ff/TXT9laTUgpPiJVIhCKRex9rQUK8QPzp7BvbO0qHzm23IH44zIeKjY6g
	SC8kQhL+QsNIIka1Wtf8jHR8avEOqlCEvVffNgY83ypV/P8zXuBwoA5Nn2GOK/1s
	krH+viEKZ5oijZiLYV1rtMjYcTXIPeVGvA1dd5FZVBloq91hnY3DOQwtAt1wQcHq
	HSjUvPvI5wT8B5eCvl2qJimcqlH0VP16jloVfLWzhxWGHv+o4QnAWkUBRpBzhDjb
	ADSzWHb0+sU3kQ61iWxypQ+rOap8IuXGKVKoqnV4izPZjDW17BvnP4CAZTqFBcYG
	+id+6cNysdgJxD3X2c+WA==
X-ME-Sender: <xms:lUfhaZbNqlzkRrZEWnGdsSiaSaFz_8bwdBXVwqvQwsWQ5vj8rffwpw>
    <xme:lUfhaXYN5eavKDa5Zuv6pCbnoHEXRZkIuYYLKs1KahUs9qGOWQJxvg6O7hJTHJCIm
    ludlgKgV2C1C762ghSnzD--GXDyBTwaYQbLZq57J0P_p7fegk4>
X-ME-Received: <xmr:lUfhaQ_NUERyTNW7PJYP-QfiiW6I0rI0FDkdp-MXs7sqBQBqfU2zqnTM9fxbH4h51BgvG1ehVWUKYXlkFgNiIuNVINaGuZUM0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeifeekfefhieeiudejheetgffhleejieelfefgteefueeiteffjeekieetfeffffen
    ucffohhmrghinhepmhhiugigrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lUfhaWjXlpPGfE61q64Cmcrt6Z7HtULt7S-BE8ajOEG9UQNgTkAkyg>
    <xmx:lUfhaQdd4s3-y0jKz2Rmp3guYqYt2jsApAGAVDeEROuyHArcQLAhzw>
    <xmx:lUfhadozACwqyYUlCUKz0iU_4Wj0T1gznpgGzM7zWumwK0XuWnagEQ>
    <xmx:lUfhaVADj0vn_8YC5uWla57-haG27kDT1kPnaFi3GqNvUPUcJzm4Qg>
    <xmx:lUfhaaWfLkulnzppYweLpqhqRQpBsOLQoh9VmDHqWcX7MNKHJolqchI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:33:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] midx: state what failed correctly
Date: Thu, 16 Apr 2026 13:33:23 -0700
Message-ID: <xmqqik9qzlv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A helper function load_multi_pack_index_one() was introduced in
4d80560c (multi-pack-index: load into memory, 2018-07-12) and is
used to read either the multi-pack-index file or chained set of
multi-pack-index files.  For the former, the caller calls it without
even knowing if such a file should exist (it is a totally optional
component in a repository and it is normal not to have it), but for
the latter, the names of these chained multi-pack-index files are
read from a central catalog file.

In order to avoid complaining about missing the multi-pack-index
file, a failure to open(2) the given file by this helper function
results in a silent no-op return, but it means that there won't be
any error if we fail to open a multi-pack-index file that is part of
a chain.

Give an extra "missing-ok" parameter to the helper function, and
report a failure to open the named file, unless we are told that
ENOENT is OK.  If open() failed with an error other than ENOENT,
we will report failure to open the file unconditionally.

While at it, we used to report failure to fstat(2) as "failed to
read"; the fstat() is done to learn the size of the file, and not to
read, so correct the message to say so.  We could say "failed to
fstat", but that may not be a great end-user-facing message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 midx.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git c/midx.c w/midx.c
index 81d6ab11e6..a6facc13a8 100644
--- c/midx.c
+++ w/midx.c
@@ -107,7 +107,8 @@ struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 }
 
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
-							  const char *midx_name)
+							  const char *midx_name,
+							  bool missing_ok)
 {
 	struct repository *r = source->odb->repo;
 	struct multi_pack_index *m = NULL;
@@ -122,10 +123,13 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 
 	fd = git_open(midx_name);
 
-	if (fd < 0)
+	if (fd < 0) {
+		if (!missing_ok || errno != ENOENT)
+			error_errno(_("failed to open %s"), midx_name);
 		goto cleanup_fail;
+	}
 	if (fstat(fd, &st)) {
-		error_errno(_("failed to read %s"), midx_name);
+		error_errno(_("failed to learn the size of %s"), midx_name);
 		goto cleanup_fail;
 	}
 
@@ -145,14 +149,18 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	m->source = source;
 
 	m->signature = get_be32(m->data);
-	if (m->signature != MIDX_SIGNATURE)
-		die(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+	if (m->signature != MIDX_SIGNATURE) {
+		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
 		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
 
 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
-	if (m->version != MIDX_VERSION_V1 && m->version != MIDX_VERSION_V2)
-		die(_("multi-pack-index version %d not recognized"),
+	if (m->version != MIDX_VERSION_V1 && m->version != MIDX_VERSION_V2) {
+		error(_("multi-pack-index version %d not recognized"),
 		      m->version);
+		goto cleanup_fail;
+	}
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
 	if (hash_version != oid_version(r->hash_algo)) {
@@ -339,7 +347,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
 		strbuf_reset(&buf);
 		get_split_midx_filename_ext(source, &buf,
 					    layer.hash, MIDX_EXT_MIDX);
-		m = load_multi_pack_index_one(source, buf.buf);
+		m = load_multi_pack_index_one(source, buf.buf, 0);
 
 		if (m) {
 			if (add_midx_to_chain(m, midx_chain)) {
@@ -387,7 +395,7 @@ struct multi_pack_index *load_multi_pack_index(struct odb_source *source)
 
 	get_midx_filename(source, &midx_name);
 
-	m = load_multi_pack_index_one(source, midx_name.buf);
+	m = load_multi_pack_index_one(source, midx_name.buf, true);
 	if (!m)
 		m = load_multi_pack_index_chain(source);
 
