Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43920D513
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513741; cv=none; b=VPdRDN3CpqGCrmnYL7HNINroz5Dvr+c5B8xzc0883brOd2I22qHJyA8zHChhIVQHAjtCA9v9b2LpiSkEXt1QGtKLSsOdPyDPh/m5+Sx8g1GcSFRoztcMxAM0ZPVpPqfJaKboSzA5AcgEenr1c3d3LfkpGS2+yae/GMYjqYviHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513741; c=relaxed/simple;
	bh=Q0h0B1eQLzPg3FS/SYy/yUjKoiSjCUXIe0N3gKmMQQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HJbYHIJgoWGrRvKTIExkcvUZSbFr8KMvBcQnjKf/TzW2kxuAtub2Jl2PDiVhAPoP++FVykrgfOzvdHG1e9MjUY9te1UzsgEtypPPwGwcQWp5HwztpN5shdjhLnyu6AGF9VBV8BmOSx7UMU0fNi5d98604cCiLNYeWq5j1c2I2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QDgkKoS7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nb1Byjj/; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QDgkKoS7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nb1Byjj/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C5B025401C9
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jan 2025 07:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513739;
	 x=1736600139; bh=5c3/jgr6TZ6fysBpKn2EcqsI1qK6O8cOoLraz4vEcWw=; b=
	QDgkKoS7TYDnY0HwpHjMee24eC3JXy0xK9Kw48rQlC4ICRMlH8jGe20WJFdeP9RI
	m71XysFwBY1d/8Og6YymQcZfbHUeiemRXQfo079OJY9DVBOHw9OBgQEU4ZvztsXj
	qBHcKd3KKFdR0mm9fM7KJSpqp62FLH4Zyuz/RDsY8mfGQ57SRNKaU8qnuxRHBGXa
	XNXBIWiyZbU3d7CrUgJHnqlzjRV+CjfYqUAoSwNJAFeiIpziXYGKxG3k266IEnUd
	ic5mqRWAH3mhBP5U8Aw7t7X7X5CIUDZPtkXpuTOMb3Ux3WdpAVb3yCOMqbCI2Zws
	Hm/0VdOfWhDuG9g34t4HdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513739; x=
	1736600139; bh=5c3/jgr6TZ6fysBpKn2EcqsI1qK6O8cOoLraz4vEcWw=; b=n
	b1Byjj/LCeHK8+yXHSM2baFysDYZeDqlbcpzjx+5yja06ZAkjXVdM0rhWMSgEHsS
	qlDYzxRclOFKUU7kpZvYdpsywVx2KgZfxdSxhaoUvXFLDmQB381wTdUhCaI7h5Lw
	9auW1+VYam9odOz22giSh88i20+yMeJy/zMTqyQmTsMwLqptJzSm4OBVIcLRCCLC
	LnAOWw13JAeARAgziBhGCi+p0IicfFOiXojEgqW06QjeuWe2MOnbip3cqVqTa/l4
	diQKUzYM/JLGjoqTC47aQ0H+Gq2OqauNnBJHsvzux0VmdkxNG4lwLjy7bimXpW/v
	UYviy+HIQFOFLtWK3aURA==
X-ME-Sender: <xms:yhiBZ4OkqeXzGuPhwFDEIAAJepL9TRXy2KuaJoCChry05lXKYidM6A>
    <xme:yhiBZ-_Zwr327sacogjduFK3Y3x14SfyiKY7-Hr4GHqN1eD7HDCBS1bv0je098pSB
    NovKFQW-IXCX1Tztg>
X-ME-Received: <xmr:yhiBZ_Tcd_1RWrh_-_LTlzPdruuK0RUk89WWpd-fRLXuOQvBMIny3Av25K4hPVIW6Tg1sl41ou41Axf1AKN2KJlIUVF5FBxfEv7wZdxeZqs7cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yhiBZwu4Xyp2d5WXajqdrhleStEmSo7o67_NPvTdkP0wBlVuZ-sM2g>
    <xmx:yhiBZwcDg3pwFFwPA8CI_1WRukIRs3E404n0ZvsYaOHLSxFHOpM3fw>
    <xmx:yhiBZ00w2zugEbI0HCiT5zpBjQIwzcIBa8E2wQMaez6duC9fmzJpaw>
    <xmx:yhiBZ09QUimbDH49InSXXS0t5nb0OLUDlmV8lOp-UlpM_UsB-5Q5zw>
    <xmx:yxiBZ8GZk3Pu7v4E8U0by0xIeQNap8thn-FJ5s_aeDSbx550b3gsUm-_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85c06b72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:32 +0100
Subject: [PATCH 5/8] compat/zlib: provide `deflateBound()` shim centrally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-5-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `deflateBound()` function has only been introduced with zlib 1.2.0.
When linking against a zlib version older than that we thus provide our
own compatibility shim. Move this shim into "compat/zlib.h" so that we
can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 4 ++++
 git-zlib.c           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index bc20b884efab72028d5f696923e9800e39b08ce3..96a08811a98ff7fa057f5682a5303a06cef40cd1 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -3,4 +3,8 @@
 
 #include <zlib.h>
 
+#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+# define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
 #endif /* COMPAT_ZLIB_H */
diff --git a/git-zlib.c b/git-zlib.c
index d43bbeb6daa4c195048f7012e0bccff8c5b4b5f1..2e973320c232438cce7c83e25cc60a6b773670fc 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -147,10 +147,6 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
-
 unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
 {
 	return deflateBound(&strm->z, size);

-- 
2.48.0.rc2.279.g1de40edade.dirty

