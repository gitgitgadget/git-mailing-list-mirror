Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CB1DB15F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019050; cv=none; b=UotU/w9C6SRgQDRT8Wx0P7iTDurLn028673sR0MtKsAU22qaMzRT37jvSjsJlys4hyvdQVR7patMoHlY+nWVMToozKEFNRnFzDSlm+Rvh4vOPIcPXx8nk0oBLbWUerwihuvK3AiiIEY8tBYxIuMP8bgEAznyyxeUuo8/vR6AQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019050; c=relaxed/simple;
	bh=0UHocXob8T7CMPqijn149+Awo7oIJehey5wf2+d7ZOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vb/xHQ64rCy7FJOMh8ZJZgDYXWYON59QgYTW82KsC5bPlx87Ri0J/QEXqCFpVClJ3wYoMAXIwhoHJBNQwW0WdVAvb70yZSeerliRbjJHAw5bOdJKj8CkhuQ6LmniUsJ3rQII5xFtNpeaRnnbTFGKYxriWN6KnUhUo9Wc8ifIfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e/ZjRVQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCGuNuHg; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e/ZjRVQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCGuNuHg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF5E9254018F;
	Thu, 16 Jan 2025 04:17:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 04:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019047;
	 x=1737105447; bh=Zexu90/MTvgq5znGNBMgC/ZTbCf0BMOQJTUXf7bhuqc=; b=
	e/ZjRVQLCecRpLq7QIULOry1CeokaMlExrlvNZ1lzMl6fPDPesWDIUN4R0EYyTuV
	Is0/WIAwWbgzp7uF7kMROHn3hItxIPg7+i8NbDFudfT1YfRGrGgo6Z8C3HIrQIsp
	dLbwOg0fGPENvDkillBcUnQQBuurIr6D0H+3DTacpmaRIu9+/EoaNJpKRY+fgRcc
	hDX5dZN5MP87dpbYGHmByy60SpT/Sw9kViVrV4DmcWyoLAPlMoHefaAv2b33EYfH
	4winSpYaoHDKeL+AtLEWalWJeZwqjYtqiMM1D1vDz/317W0CKE0iLdxWMyRyH3Ht
	Lckvb5zeLffq4pDGRfqlYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019047; x=
	1737105447; bh=Zexu90/MTvgq5znGNBMgC/ZTbCf0BMOQJTUXf7bhuqc=; b=q
	CGuNuHg5hLspAJkKKPJs4OCYc7jQBx/3lqAcdXS552gHZ2oLHip5G/wW+ojQutRV
	9/foLA+Ta8FaKGBrVyxuJMhJRPA3MIYGlm4JWoYIhLVVKHVkR0ttCJrjudi10Zmy
	fDkbR/LBcbv2w809hXZo3JdCpr9FOSu7E0KUvubZbUdLdP917tnBE//4M/D+ofFI
	agt2MwUWV56/pEQ8TnlgltP+EmJ1hkDGgHemfPWiwL2XcRwcnvtXGG07+GSVxcks
	IAkJnSDq96lAoQBnoOThyb/sggSr3dcBPrtpWIHkt7jVSsBa2vSUmwYCeHO9JYTY
	OvvZq+SpdVlM/XVoKz7yQ==
X-ME-Sender: <xms:p86IZzYJvp6JYdmTkl02WoWnik0xLcU5jbHvzQHqJZNucdrc-k08wg>
    <xme:p86IZyaM7uz1kXHpoemNxuTm8GeEEg9U487yjs-fYvZmE3XUbcbS1QmxVoQ7xyvGg
    NxdOlwiB8ipv9M_1Q>
X-ME-Received: <xmr:p86IZ18o5FHXqtyXwZ9p-CXXWM8-y55gDJvlVFYVZ3wEjfYEt9dPCg1s3eSuup1OLTgGNZI_ktx3QDxr4GSeMzHQSWXv003iN0X7P2oAGhpueBYpYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteek
    gedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:p86IZ5r24bjZQf1vCB5imnWbXj5eFukdqq3xZFPXd8QwXdgeMhNo-A>
    <xmx:p86IZ-ofANr3dN1Cq41RowmpWFbJUxcMJAz-69IY4udWZvUeZWRTjA>
    <xmx:p86IZ_RuWMcWKMlEI-ntsHpHwyWdXelcFjDL7pDfFEFjX4y1qlznsg>
    <xmx:p86IZ2oH5Kfz_6ISvDvJHLPrHl_Wdbc7giMeocNWCGufIGniBM_GJg>
    <xmx:p86IZxU_PBrbBt3KOMOf8slXhVrWfqSmNxxBS2lNUwQAVI_KkPqsizVO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a02a20e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:19 +0100
Subject: [PATCH v3 06/10] compat/zlib: provide stubs for
 `deflateSetHeader()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-6-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The function `deflateSetHeader()` has been introduced with zlib v1.2.2.1,
so we don't use it when linking against an older version of it. Refactor
the code to instead provide a central stub via "compat/zlib.h" so that
we can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c        |  4 ----
 compat/zlib-compat.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e7b3489e1e..0edf13fba7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -473,9 +473,7 @@ static const char internal_gzip_command[] = "git archive gzip";
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
-#if ZLIB_VERNUM >= 0x1221
 	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
-#endif
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
 	int r;
@@ -486,10 +484,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block = tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >= 0x1221
 		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
 			BUG("deflateSetHeader() called too late");
-#endif
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 96a08811a9..2690bfce41 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,4 +7,17 @@
 # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+#if ZLIB_VERNUM < 0x1221
+struct gz_header_s {
+	int os;
+};
+
+static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
+{
+	(void)(strm);
+	(void)(head);
+	return Z_OK;
+}
+#endif
+
 #endif /* COMPAT_ZLIB_H */

-- 
2.48.0.257.gd3603152ad.dirty

