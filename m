Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598028A72F
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426728; cv=none; b=i5HgxbHHhHoMMPWITSSV4AhJCRzIEZvDxRhnxCNVxOlvAwAFRZo4SUvWr3xc4M5nJflIuT30d2F9mGKU67Ck8JG5LQntn+DjdsCHTYsdDMHywWPVs4FVadh1T7BnnVYR56XxJnU2MADkZPWP6khUtl4hgBNKNL/w/0FlZCy7CK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426728; c=relaxed/simple;
	bh=0duRBF4A+zORTLC/UR/siMl22PTfng1H88K+ECV/nFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VfUCkiixb1FtUXK741Zn1PkK8pysDbgTHVgtphMs9oYazQN3lo4C9TaT1RMDX7Q2zQjB3K/fA3dWgmb+AbAW8cCZoo06jdtNBd87TINXaQkx+isoPsULYPGYD13dBlPX6dI7mPuSn9Ls0qBJBR1y7sxNZNMo9XwW/OVszfZyqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+7oy5xy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hsr/xRK9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+7oy5xy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hsr/xRK9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 856FE1400250;
	Fri, 25 Jul 2025 02:58:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 25 Jul 2025 02:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753426726;
	 x=1753513126; bh=cfjgwaVTSQhvpRSV/4yqCmlwg+RiU6vAy8nMuszzRVQ=; b=
	E+7oy5xyAReESAP0K9pCh2JyMw5lukPGb7Otx/dXZEr+Cy0aZcgKGxY/l0pXo9qb
	77B5mqRVhvy0UTyRpRgRE0MamSq1obVSD7ySbldekxaVnI3NsydFmk6YIHwinX8f
	7Rj8qKaSvL/Sy2EP5J1yxHSQfo/QGJh++ZXlrGMI405g0IaK/aGPj6tBfyP/1DuU
	a4E9FAP5rvzz/L4xA6QMydse5vvHGUR8c4FxSZghD0cY4yOEBn5Svu3DWlpiKFsF
	cNVAXEIxoQAkTqQ0E51O+7hIXu+Nm/n2XDnRU3JmWA0b/Kil0+0NBP8/YFQU3IRI
	l4AWLePdb1r4YZIa+/d9cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753426726; x=
	1753513126; bh=cfjgwaVTSQhvpRSV/4yqCmlwg+RiU6vAy8nMuszzRVQ=; b=H
	sr/xRK92aUpxuMcYjTMPOIAti46XIygLJqaJIyK/CYq3BQkmFrtqDXhnlU6R1f8o
	E84d4GHUv1nB7PZ2p0Q0fJ+V2wMtb1nu1BLMANidUoBxhVxkrBsKo8kUhOldOoq9
	Wf1xgawc5ayNwUxfhN2z1ocaULM1m+yiyr51ocel/htdAzRDInphqodPRuqvOyGx
	ubOfiA/Z/HCmF68Q+m6lfJ91YVe4EUkOzmfGs8zViSaItdvUvBZUY9MpI1PUKqzG
	q6LUKiL4H1NKLC/Z63FbNCrLVcVIOT2Sts3I0NJleBKOcgfVKJMsbaOCqKMzaSaN
	pAoSBkjlkSMyTZqcSUnfg==
X-ME-Sender: <xms:JiuDaJLu3UOZEPk67kK8gzVnrpiW819L_XRnyewn-rcn_Cs1K1resg>
    <xme:JiuDaNkaMR2y7b7Wg9CuTc8K8bsjQJphf_rQtKGaltYyt8oWW8cEM9IMMrtAFeqMz
    TGUfQFibNKld2vYxQ>
X-ME-Received: <xmr:JiuDaCLUAF7vF4mefsLeHsDKd72xRKARUH2GmrQE22IgyJgCLi3FsxmYm8PrBuHgbCRq74eulcE9_IqnkcTUbXLI4uDX1njDr7XVoR-oXJBL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JiuDaK6tvjYqlh0KxTBLhzHprJW5Gb7GfDPgqDsIDnunvdulenHnpQ>
    <xmx:JiuDaO1l0i6ao9GKPoCLs4ObeIgzHrkM-I4iMh8ccXL6B3ZFXQGWCA>
    <xmx:JiuDaIfKrIHhAclIvyC2caxjWsD1fkUkgOqaesuH-PVDEniwiAxgtg>
    <xmx:JiuDaMeJyTmEoReC6-jj6O0ycGmc3EZhgWka5CoUPjuP6WPzYmATzw>
    <xmx:JiuDaEc5A15DmLdOaEf-dHXWlNR6KaYcKfiZ_z2k7_PStwWrUYBlYDnu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 02:58:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c074327a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 06:58:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Jul 2025 08:58:27 +0200
Subject: [PATCH v2 5/8] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-pks-reflog-append-v2-5-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
In-Reply-To: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The last parameter in `split_ident_line()` is the length of the line
passed in by the caller. As such, most callers pass in either the result
of `strlen()`, `struct strbuf::len` or a pointer diff, all of which
are expected to be positive numbers. Regardless of that, the function
accepts a signed integer, which is somewhat confusing.

Fix the function signature to instead accept a `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 2 +-
 ident.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 967895d8850..a7a2d132579 100644
--- a/ident.c
+++ b/ident.c
@@ -272,7 +272,7 @@ static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
  * can still be NULL if the input line only has the name/email part
  * (e.g. reading from a reflog entry).
  */
-int split_ident_line(struct ident_split *split, const char *line, int len)
+int split_ident_line(struct ident_split *split, const char *line, size_t len)
 {
 	const char *cp;
 	size_t span;
diff --git a/ident.h b/ident.h
index 6a79febba15..3c034038791 100644
--- a/ident.h
+++ b/ident.h
@@ -35,7 +35,7 @@ void reset_ident_date(void);
  * Signals an success with 0, but time part of the result may be NULL
  * if the input lacks timestamp and zone
  */
-int split_ident_line(struct ident_split *, const char *, int);
+int split_ident_line(struct ident_split *, const char *, size_t);
 
 /*
  * Given a commit or tag object buffer and the commit or tag headers, replaces

-- 
2.50.1.565.gc32cd1483b.dirty

