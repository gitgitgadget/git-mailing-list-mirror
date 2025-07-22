Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0B2E2664
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183281; cv=none; b=uwnK89BJIuwhe1Oc0u+ES/K/8I9QNPT9rcckWvYuo4dl5OWjZUSzv4igQN1Tn4VRh+eRl1ENXVpgVTWwliX4tcYaBMvRFSERXh6IO2YdmIuEF1SBsUqFg/KIK49Dz8e619kdLBm5HizZaeQ1ms3pO8/ODhPpHOd3yhELNu56hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183281; c=relaxed/simple;
	bh=7X6D02mwwJEBYEP43KYlNsiG/18QD86g8v5YBf23GTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/4+IiKqz67KnViLYc/BsuZcfa28sUFWcYw4JS5a0UYh71MnV3HOevALuuMOBPeVzwiye1lGk433SNIg7xD7d2ePNeHysBXJZePJWFXKXLk8fRurxHroDX3XXeXdjh72VpPrcbzzoU25gM0tVpBGWRaiQn+Qy4SAZ6EYgWECmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDLLxZ8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF6jHXor; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDLLxZ8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF6jHXor"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D6D57A01DB;
	Tue, 22 Jul 2025 07:21:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 22 Jul 2025 07:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753183279;
	 x=1753269679; bh=w045yRVk4n3+zklZnDc2MNdQgyCRd6+07jpC6CwMMWo=; b=
	UDLLxZ8UmYn7N/0xQt2ZII+jBkAdMJ6EetaTSVJnLOumNRiRcPXORapMQ2oSGDZx
	T9f4pA7ZXP8cB5II+ktBQ6RXmZ+rSwxYFvR42zsMk+jUr2iNcfluxDwcy/iRWgTT
	Appow/A7Xc5IbEKCjetDSXRs//14uCRnzXVPI7Bq8j966GtwIqiqPPVcN0PzLxpV
	FPuM+nUDYOMZF29By/FJ11Ooqwn6SShrjTcrz75twvQsbsxk9KE4dFRnW9Xw1BwG
	oS0eulQ2dxvJerT8BqxMEXIvSK3vmrrBdkeWoqcC756rfuKiofL4pDYzoySKDqWG
	2y9m8ZkkvilYbm12iezEmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753183279; x=
	1753269679; bh=w045yRVk4n3+zklZnDc2MNdQgyCRd6+07jpC6CwMMWo=; b=P
	F6jHXor1+FL+n+OA0wcu64ahHbYZ9BfaXWP4XOmtefVBiKEp5Er8XDhx9197IHYI
	7FMPU9ZTfp/ZKU2q42s4To8cX7mty72shqBba5jmTglnp3OUr5AWj5tCNWdM/hta
	hjCwQn4DrjemRpZgIt8lxSxx92E0XrHmXc69WzJN6xqYQc5IlSoBQQpWVutDC6lb
	/NoTbyt7OJ+F7Njkbk/TDLxYojyVKtGPRAU1pO6gHtzGIopmDs1XZjT2aJ4Xef7N
	lhS2/yLXmrrBwIfsr5cXyCax7e6SkJxaoWL3uEXs6hpkBcSOD5a9/HkQQkPPJKkG
	xv7F+D6WdJ43DNVjb+84A==
X-ME-Sender: <xms:L3R_aIUlYOATFdblssuQx6R7G8FN9GnfcLIdjRlwhH4u1lgh14gjiA>
    <xme:L3R_aMxtigtSD52mY6Zp20cnnf-8TBJS2Ro37TVypp54f_3VTgK6mAoXp4fZEPHUy
    VYVuu6_GPN6Bb0w9w>
X-ME-Received: <xmr:L3R_aONQgJDXHl3gSVZdcyTjCy_kubPqX2Y75HwbElp_JC9pq-iCm0rU4cQ19RdN5lqm5WuTGvwoTQZ-EO7pMuv8UrtTo5zrX9PGKLIn_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:L3R_aF7gWCR-ZYWWSBaLO89T4VC1fAXKo_95b0Q_UCf3nP58denGGg>
    <xmx:L3R_aHPnq0v0NJ5JNiJer7NX650bkcHFw4i6IeB4g2G4TgzDYWrkYQ>
    <xmx:L3R_aLmQu51OOhUpPRQPhWEIA3UQdfKv63Hsr14QWUXJ5_ReEEntIg>
    <xmx:L3R_aGTMQDcQLgPkRr1kzTQXcDxR_Z0u0KObFXbrKzMBwyle_l14zg>
    <xmx:L3R_aL7CvBmyFdYwdLsJt4RovXkssaAUM4mRNMMC5E7roDl6uUZs4bTB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 07:21:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2cfcb419 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 11:21:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Jul 2025 13:20:54 +0200
Subject: [PATCH 5/8] ident: fix type of string length parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-pks-reflog-append-v1-5-183e5949de16@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
In-Reply-To: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
index 281e830573b..0b7aacecd7d 100644
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
2.50.1.465.gcb3da1c9e6.dirty

