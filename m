Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582C23C50F
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222183; cv=none; b=Zs4xlyUNPv6roVvC6Cp1DeVhXPd3Fn2y8rJ3LVGDejUr1SJ+my8lQlNYR0ieVHtrTm1SkcBFmxKumDavNb4Lh5Plx8Z4jJIv5Lg8QBP6o6U9Axz4HVNDZvh44reXGxXhBDySjeSa2zQgfk3Xjpz/DZw99qx2FRn3QX4Icl+j5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222183; c=relaxed/simple;
	bh=/rpzEkIjWS4tnWANu9FddOCWvXZ3eFaIGCwRFxp/GtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntfRv4t7/yPO97s+PqvJQqDeF/09EwlPPdDXXZxk1+JH35azRZlj2A+yASpDyFh/W9mtNcv5974oQS556bO1miWyUvo9VPRUtW3rfMWQEGpEhuqXnuMwtTbdeoi17PLvVpA1GHH6WcKVQD7f6Df08nS6jGutruXTF6h0sbTGEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GPDgSl3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+Xs11O8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GPDgSl3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+Xs11O8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 841871D003F6;
	Mon,  3 Nov 2025 21:09:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 21:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222181; x=
	1762308581; bh=xK/wySO8AXtyqBJU0julWaBeZRoboj5/31A3TC9kpUM=; b=G
	PDgSl3Sl7Kwpbqx36nnfwaQjDVkJXeyMDBX8ZLkQY7SfpuHBpY2/v0fZicPDLx2p
	cBwgHKeFTEvrkOEZuRqfBLNkFVrPvgBYyqfEoE5ZercObYOtx+VtQDY8gu6Yx2jg
	vrxhJ55E3GauzyFZWOzzfBmy6xlKqYaqM1P6mWnf6uWkSk3PsHfcq++xqpBF3y4v
	rXZG76sHQ1lIlWuYZQBSLykNAWj2ORQ4uWgeGNZwmwrl+cZO6WPJdI3a4fki1LDP
	HlXZsnIIylDEYiliGbYyZ5SKIt3lS6JeRPGxPnGsHo0wYkofJGWK9ePoTTj/zfJB
	KbT7feIbvlA5lcnlSO19w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222181; x=1762308581; bh=xK/wySO8AXtyqBJU0julWaBeZRob
	oj5/31A3TC9kpUM=; b=J+Xs11O893F/WPD+vVPPIfCs7xNAGcdKlEaRFTfTumqf
	MKZdgP0HWM6RCLRplBowM//cy0QR88wiWYU/sOEsFzD+CyMR6A2aXRueM7LakOKd
	UrtET754S0fuB6MZljZMX8CPV4RFpTuRQxU5I9bnB84IHiavdrPz4clubyNW1AUP
	oZFbq/R8s+3HebqoJisidQpfH73Lgmilli/01WembVs6mzAWKQtfn6DKIlrzd8DF
	zZr7nyRlcGz6QLEp8d5s8q+FM8AEarHj4WKjp3y75+5aHafHXtQjSyJyN84TXdNY
	c6gieYgLVhAYCIhxTH6sPqXnz/kEvjivCMogJVhPtA==
X-ME-Sender: <xms:ZWAJad8FVkcBt4mW5EsfdwIt8aJczP8M41_st3we-u6R2jp-A98FFA>
    <xme:ZWAJaXt5Dk2K7cYQbHtwvui-JurQxuYyeq-X3EPYkH8KQ-hSxH-Do-AHwlWfYkS9l
    JUXi26KuxCfQfQkQIYjuUN3W69X3qvIsvpCL-VAilY9oOjQBZVuGw>
X-ME-Received: <xmr:ZWAJaYox-6uo6-mcUAYUW-iZQofhNm_bPFpVCAZ_MbbPEnq7QhQuQC39mmMvtK-hfF5Kuhf2wRWwE9znO_mNGd5evHU3JP3vAhEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:ZWAJaclciGdGQI6LS3lWl3ew4x7zXt2LRkUdzMuwbDu0zQf5CJSnPg>
    <xmx:ZWAJaUyVfllC0r5LfKlMvsUUWCq6wwyvFxm7qwTWvOnTdykTBZuIdw>
    <xmx:ZWAJacnEr_xRNgkzuipWFX--woXZ7bgEKI_QXGZVVjVRgxLQ5Y45hQ>
    <xmx:ZWAJaVcShBRw-R59TKYOKKTQS_QmeS2soWw12Mlzq_l88pLskm2Mpw>
    <xmx:ZWAJaZVvlrbko2A0wtDXvkbhbUiZaaloTwRoMKubDMrulbBmikRgguJo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 06/12] diff: call emit_callback ecbdata everywhere
Date: Mon,  3 Nov 2025 18:09:22 -0800
Message-ID: <20251104020928.582199-7-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everybody else, except for emit_rewrite_lines(), calls the
emit_callback data ecbdata.  Make sure we call the same thing by
the same name for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index d388d318e4..347cd9c6e9 100644
--- a/diff.c
+++ b/diff.c
@@ -1780,7 +1780,7 @@ static void add_line_count(struct strbuf *out, int count)
 	}
 }
 
-static void emit_rewrite_lines(struct emit_callback *ecb,
+static void emit_rewrite_lines(struct emit_callback *ecbdata,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
@@ -1791,17 +1791,17 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
-			ecb->lno_in_preimage++;
-			emit_del_line(ecb, data, len);
+			ecbdata->lno_in_preimage++;
+			emit_del_line(ecbdata, data, len);
 		} else {
-			ecb->lno_in_postimage++;
-			emit_add_line(ecb, data, len);
+			ecbdata->lno_in_postimage++;
+			emit_add_line(ecbdata, data, len);
 		}
 		size -= len;
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
+		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc0

