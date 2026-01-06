Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952931C3BF7
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682522; cv=none; b=b1CGaH+Xz25O3AHzfBKkpHdlswTkdV5D7KHyEuEbvL2+CB9m6qyIGMm7DQOu+YBClWaS36O4Zty/DJwwCRnEnXBAjU89SBAC6G2clSt43h1SsJlTdxdKeLYei4LgGhQ5i5LPHqetJnvKGfq+brEoY+0fVHLhOArd0eRCKIzi2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682522; c=relaxed/simple;
	bh=VttfYulmSwt00q9I8Q5GcPomOeKoDhdJUP2Qau2rnBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8k9MkX4AJQh++g1IDOcN9UhwaJi4BTNabx8n//0/2TyMFy8ZWHHuZWi8CMN7X7NhU6IRzXDd2/5LAsYE5TvJFTzp8DQ34WS3uEPwv2cZ7S0yIQIpiWjghoSx/sVqlM2EQTf1EpXRllvZOWx7EoWvE0mSma6OkZRRylFAGhaypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CasF6Wrd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbKyykG9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CasF6Wrd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbKyykG9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C53271D000BB;
	Tue,  6 Jan 2026 01:55:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 06 Jan 2026 01:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767682519;
	 x=1767768919; bh=g9TL4f+fSGU7YAhGeweuXWdheWa0/lpiQEmnRkTIjGQ=; b=
	CasF6WrdF9K7243DJr0cCi6zrmxLeGPFcWqm97+S3D0K13w4bMcS0IE14BQNukee
	QYU47gM8vXs//1lnjOsNVkdmjt5lEHksXSOfd2STFDh9T7lPv89UN/zNXl7n/rSA
	o2qUFNuxbcNFIE0oYAgWRU6Ha5vnu8D+JntmrsRUiYvd0VTfIm9aJ21Ow1iN6mgG
	hQ2SuXtku2HSo6iLHUdIXuezJpCoXSnwMRofCo16l33yeNfkltjbuvNwq1scJLwY
	kD9FcHbA7vt7SXhHGQ01tEtEQZnsq71mlwxzp8i5FK2zwqQXHTdShPtWeLagEvVo
	Kb7umUK9BYrjUmGeKug+5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767682519; x=
	1767768919; bh=g9TL4f+fSGU7YAhGeweuXWdheWa0/lpiQEmnRkTIjGQ=; b=S
	bKyykG9eYT9G+PIIHX5uVePlz6FL4Y5aSnhpygUev5TVl1rcAYbmEgZpsQxc5lss
	gJ8PoXJZHA5wYLSc4giKSy5tANACbaEVguwjNk/KBQq10+yVFBPIG/kkI9ix5Kp6
	HDvrveUgkOdf2dGmFe6W0dEbi+avnW//jh9mjXaY1ZDZ0bvr86ccKC1XmH1YrENu
	RB3GCJz3vHpcMOXaSxqtXd5kBoEPCeo1Yqk93Hwg8EXfBY1nnEsIJvrFE+jVIpah
	2T6YFdbPNZ7Fn13AgfdCgkauJuOgmMk7IZHOa4ValerYW+Zo1i1UUKpM4g+IF680
	CWOelgZTsb06ehnq6D5dQ==
X-ME-Sender: <xms:17Fcac8UPjLg6_quLUal3X4a7wJuAQTb4JOEpFNoXc4AQBWOoNeJVA>
    <xme:17Fcabm8Iff5_fXPhnvN163FyXrZ5G_xGSKngPbXdV3deoz3gA5cSwaafPAPaVKOr
    dOcsiaQvHB21PTvXzt5EKK_hxDIeHDYPzKlkLfcjBdsezcdhXBpQA>
X-ME-Received: <xmr:17FcaaUjipRvBZQTiiAS3qm2tNNHTKmABJSWEXn-A8353KkN1dcgUrUZVnDKPtWGazD8tI1kHZJE1QHjAg9bejOE9F-ogIRqwcLKr-Vq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefhueegleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:17FcaYGVlNKFp1zzssaJukPdbqPlFX7bNMMrz3R2j4wcrSoczOtX6A>
    <xmx:17FcaedKlw0q_2MsoWqWmHCQY5Z3vIoNKnYooelMH0vzO5GTUYhJKg>
    <xmx:17FcaRLIphk3rbcZfql-fp4lAmxP2ddqsXiqitAuvLhH0DPgy5eA_w>
    <xmx:17FcabGjlCYMd3QVRgL8S8XPchFNbLUegfZ8UpYd5DwHFTQ_RJYySg>
    <xmx:17FcaWLsjn9eq7KS_3B6Gg7Sz1RQBFg0WaU8keuc5Uggyj1rANQNjMyR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 01:55:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9738f20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 06:55:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 07:55:02 +0100
Subject: [PATCH v3 6/7] packfile: skip unpacking object header for disk
 size requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-b4-pks-odb-read-object-info-improvements-v3-6-b5e02fae1fb0@pks.im>
References: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
In-Reply-To: <20260106-b4-pks-odb-read-object-info-improvements-v3-0-b5e02fae1fb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.3

While most of the object info requests for a packed object require us to
unpack its headers, reading its disk size doesn't. We still unpack the
object header in that case though, which is unnecessary work.

Skip reading the header if only the disk size is requested. This leads
to a small speedup when reading disk size, only. The following benchmark
was done in the Git repository:

    Benchmark 1: ./git rev-list --disk-usage HEAD (rev = HEAD~)
      Time (mean ± σ):     105.2 ms ±   0.6 ms    [User: 91.4 ms, System: 13.3 ms]
      Range (min … max):   103.7 ms … 106.0 ms    27 runs

    Benchmark 2: ./git rev-list --disk-usage HEAD (rev = HEAD)
      Time (mean ± σ):      96.7 ms ±   0.4 ms    [User: 86.2 ms, System: 10.0 ms]
      Range (min … max):    96.2 ms …  98.1 ms    30 runs

    Summary
      ./git rev-list --disk-usage HEAD (rev = HEAD) ran
        1.09 ± 0.01 times faster than ./git rev-list --disk-usage HEAD (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 8c6ef45a67..a2ba237ce7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1586,7 +1586,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
 	off_t curpos = obj_offset;
-	enum object_type type;
+	enum object_type type = OBJ_NONE;
 	int ret;
 
 	/*
@@ -1598,7 +1598,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-	} else {
+	} else if (oi->sizep || oi->typep || oi->delta_base_oid) {
 		type = unpack_object_header(p, &w_curs, &curpos, &size);
 	}
 
@@ -1662,6 +1662,9 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	oi->u.packed.pack = p;
 
 	switch (type) {
+	case OBJ_NONE:
+		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
+		break;
 	case OBJ_REF_DELTA:
 		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
 		break;

-- 
2.52.0.508.g883dcfc63e.dirty

