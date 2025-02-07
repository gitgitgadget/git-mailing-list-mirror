Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468471DED57
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926218; cv=none; b=R067RFPaDtQsK3HgPTt0749ktYuA5D+s4Z1u89mkKFoL7409wXWn+SWYR+QyQxUcagyQXXI6yrM3EEAPr51mmcMOlsjE6xP3QHVvOY19TlVJz5Dfs0RzPo/ycgck4Pl7iOKMhKrRshk9IPwY9u6c9DiUmeI+v2Xl4ld+T5kB29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926218; c=relaxed/simple;
	bh=lj2P9XlXu01JiSMKXCswNsqqYvej8c1MANCkStboPoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thyy8xsf0+zR2Wd6/+5FfRiCiBOCxkgrX6Q53ADe6apSdV4hQJV3WDizRa+Z5hkUO//6vabpk1bJAwZo0T86c7bBK6JOq/5WEjyQlYFa6a19G8AJDQF4uW0E3h6ICfYzOT2dy5zuVPuez/80Z8d5wASPhE7i22yuox2lvb4mNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AK5825Q8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smum6Rgx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AK5825Q8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smum6Rgx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55A1A1140127;
	Fri,  7 Feb 2025 06:03:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926216;
	 x=1739012616; bh=wzm33EqyC5g6ArrzePv0rjMMcGaMe2srUlW6r40Acy0=; b=
	AK5825Q8exJlWg0ry4JEJhA3uIdnbmm6Y2H8LGqaLmRqrRW60KaBFQUcdVEuZxxk
	msfuBZWTETyxomGNgYckcKBPLKvcBjyFwndsNaFyuyeYan3htLFu2dlJyOtPQhjb
	dqz5G6NrqITFo8O3J+VsylDcB9ujvJ+o8hGCcEwzXJcL8d6XHrEZK/Z0pF2a/VOm
	/8dd5m6wmmURcFvYRdhrUFbHjRwTMP7uTEawyQ2Ur5k0CU3e//AmaTlUM3+lB2Bl
	5OGLHxUpX0YKBXcPu817uYtc8W+AlKg+QDSTNFSJ3iQ45rVAJV0XOggUSY+8wQKB
	jhwNrR7ZmijkjtYbMMn0xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926216; x=
	1739012616; bh=wzm33EqyC5g6ArrzePv0rjMMcGaMe2srUlW6r40Acy0=; b=s
	mum6RgxhPOYUyPWunts9LV0rsr1ris5dqSIhoDt3MOaQesgiT3+ENGVaZod12bYI
	Oi19jDQ0XYeVqQuuPAFYlttKcgjmpRYZtJZMvI56HDg0YHA8WwXZ15V1CtBeffiB
	ZBk5Ipi+mPAO7/bb+sZVfZawoBRA5z/8EwhKnZhQXwXMmKXbTGY8kv8Mbavhhzjb
	WSe7MivIEMfLctcIX2o66XarWoTuiQIjwDWKkCMgYPaDmqv7h0FLOB7CpAEMbm9p
	/nd8vLo2PWLoglJ4urwGJihSN9izJgYwXfGIyq+9ggDIrgIe8/d98N81zkJhPrC9
	7hmTjBFy9ff5MbA9hlHRA==
X-ME-Sender: <xms:iOilZ6NOH_IrhCrgJSh7g8v_3TNzI-7q91uQ0_0TerOyol4xQ73INA>
    <xme:iOilZ48JNViUPhSyUW0CGDSdfPxK5iEABR_ewf5w4whGkKMc1_ouChegzlWvLJY_1
    c-mQOvWxCOwsNJmuQ>
X-ME-Received: <xmr:iOilZxTkX_50Ul4IPi7BojQ2rahP9L_QwCcTSKme5n3WZ44kt0oZCmFPR3n-pvvEksv4ualq9aVupt47cHTEh92USys3AWuo8xjRAblgfR940GnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iOilZ6uAEVWLpNvnK4o3bEdRyFsxfo4Z2d2dVY7TVSFNzB2Guq144Q>
    <xmx:iOilZycv9RVLZWGJWOxM7Vxc5bxbSA1vZaB2XZaPfl9U1RI5ajz73g>
    <xmx:iOilZ-25nGyA9eI__AeDJMz_qhpv6yYHFA1WGO4StJ-fRPDiVR2ggA>
    <xmx:iOilZ2-p32zeQBBhM2LsgtFBZvkc2fyRD9MisAEMNm_7L_RDKBoNMw>
    <xmx:iOilZy6Ql09XJgBXU8jF59AIFzN1CBJk4LM5tpY4uT_fxi3QRsLUIMg6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56effeb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:31 +0100
Subject: [PATCH v2 06/16] path: drop unused `strbuf_git_path()` function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-6-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

The `strbuf_git_path()` function isn't used anywhere, and neither should
it grow any callers because it depends on `the_repository`. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/path.h b/path.h
index 4fe523626c..8798db7469 100644
--- a/path.h
+++ b/path.h
@@ -272,19 +272,6 @@ static inline char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	return buf->buf;
 }
 
-/*
- * Construct a path into the main repository's (the_repository) git directory
- * and append it to the provided buffer `sb`.
- */
-__attribute__((format (printf, 2, 3)))
-static inline void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-{
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, sb, fmt, args);
-	va_end(args);
-}
-
 /*
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.

-- 
2.48.1.538.gc4cfc42d60.dirty

