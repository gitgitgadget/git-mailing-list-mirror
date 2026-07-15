Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627C320A14
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096569; cv=none; b=RNjjRGNEPZIFP2c3LJSemLxaJmddNOrr5S5vOkE6FSjTXtNoszT+vkStjBF9EKyBF24Ohc8lzRN4QShM0I56vE0I+inEYcxpWANlSho7LHtb8jfImpmH57cQfJ2tyQfJvY00S81RnV6XWe7nw8SN29C6XsPQZQn5uGvKWy1IgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096569; c=relaxed/simple;
	bh=fc1/SarpqFEFB+mYhMt9hUdg4FX4tY3lbjOCxAMKEhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDh8At6KMk1Z8DmeWNOcHzcN7AvhdRX5oaYH1SHfUjoVp8jYewvJ2mnryk6CtuJcqkWvx9VPpRRmGCJ+AuWWpW/OXAifozwWoW8Bu410xJ2dAfzZxaFxyM0VmzrVPHjcdthoreRsXUayOxv0OPBDpz23ZDjDgDHwa+D1cyxlx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LoiXilnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD+2W74r; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LoiXilnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD+2W74r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D8DD1D0014E;
	Wed, 15 Jul 2026 02:22:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096567;
	 x=1784182967; bh=jovpPEdbUbmhg+N+X4BF6IqInFOWWmxla7XnSVC+vr0=; b=
	LoiXilnMRCalQYeCzHTGDKQp5DibH2r16ug9YOt+KAVnPbc7HovikZm8ECQIjHjY
	kMf/y8DgctH/dndEzSpfBKuGhJkGPu4tbMfP6cI1OjksbQqr5badxxeUvXTGr0SL
	FR7BHfPhq07od306QbKavyGGUwZyZ2zkcwoxE7kwqI/C+zX65EWVbwY8wp3ov/Jt
	gEXYB6WR3hPReAeNVaUFEsCkHRm9vHQtUfEMwrxXJkV74HTaMauhaMBsSNsjUAsv
	NYyjlZ0pKka+MLb/e3In7//79hC10qCgCKjuLs17rAXrHtdRlxDtILhYaIGy5oUX
	x4zMNu5YsZZtrJyQj52tBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096567; x=
	1784182967; bh=jovpPEdbUbmhg+N+X4BF6IqInFOWWmxla7XnSVC+vr0=; b=L
	D+2W74r1QHkuGaFy2RNSSRU5EuK5K36ZpYzJGiqAN3Y6/Gxb0DovnVJxV2M/Ktos
	b4PucVgfuCYjvbOD9jusaFrRQ5J5xJxGvsAY3lUJlQulvXQ7crFPNaR8EAsZGxGn
	bxZL3AsZG1CBGXP4CDBV+CaXzw2yV/4pZ5/hDPAoowbuPor1067ZN7tsQU5Qg+eG
	7Mt9r6SGMUzNlveFCGmaP2feDfh48pKZydvVROjUjbh+9NECqmXTWvyBGH4SjQrC
	Bgj2l+JeCRAveg0j5oRzT/BI2g7bYRJFrd9VCm+6+uoS8vnycwwEjTpvPlh3Nmm7
	tw9yGfg3tNCUIu8zZnNrw==
X-ME-Sender: <xms:NydXarNGb6YaW3ErEZip9ajtUqlb9bHkcrpT8SqclUxNGJnui6extw>
    <xme:NydXapotWzVMjJlA_hbiWDmXpgTm0HanYCSZmHhaL_C4-M_hEaBPJDu7ziPVyhI02
    AQd1tPETnd12w1_e305gu3e7gHPqYJNS1DK_S1a88DEA9CGBw_JEEI>
X-ME-Received: <xmr:NydXakEhhoEAYCs_q-bkrRNnPOXAw7PUlGCps1qA-j3b8srK7d8N6qCl4ScMQSqM_t05iY-GdOR3FEePnErGkQ2ryePm24mjkJ7hOxd1Mz8>
X-ME-Proxy-Cause: dmFkZTFE+YB/+tAuPzC/TvjlXEPq4aubpa6Ljtxm2DA3nhwEKViS4QAXVCAGF2wRqpD2tG
    rjqCj7yrsh2K3uZv6BicpW5yYVDxtAn+hMsT9FU7TKtbZqakq4uWROhTjl1al8fUmioom/
    gefFG9Bba9YcV+ffziVUcMJmrNrrzA1KCy4PmFtbw9vUYPLeSjOeBKQy1qWCBKQ/50XXpB
    m/31leo7PRkC9756xsv1BKVgX6QCG7e5YYGSgPuf8wI3G3bR95XgOr9DD596qSCfzNLZcs
    S4vIMLLbl/r0AJQpYarwXHNGipYH7Jk4IaGmmUxih8kNXIrTailxiil1zVP+0fyXZKWzU4
    LE0Db0KGheNuU7cMHbS7slJWVIFeR0yLMrUBg1f9MWlOmIGQlp4J7RkHhbfG6vG+hPeai0
    Lo0/x+AY/usdE2+vm+rU4/HaBhGPs7DrOAxnL/LDSKzGl6WSG6eqp7yS0wNWxbfKPFQD3Z
    Cwl4xXE41fq3/DLX4HdOqzpk/fKAwRLEOvs133RuifjGbj4yRyELc4Xfe7NKv8FaXqEdzv
    QXZUa/4GlEobpHy04G9KE5/514B1oYJtmtLUSkgg779+VHAgjaDQErMOWuBRfw37c+fWfA
    qVVcv3+pfx53ODxsywV3uIKGguDfdlQoSitBPPDitdsOAN+OAi2HrH7YrIjA
X-ME-Proxy: <xmx:NydXamr-1ZHoPGNvwirJN7teuJkcOvS1EEUwTyodWVdxG9pRm_5esA>
    <xmx:NydXalZe3jZj23hB9rLomBp-DIDOKrLRNqr8QCXl8reT92WoW9gLEg>
    <xmx:NydXanWN5z_kRqvC7lRefOGircXjA4shCoBmwk5-MfnjngwVNNfZkw>
    <xmx:NydXam_Pkip_JrqRMvqE2ENrf-DcvB8WOZDev1ZNOUE_oPkWM-fCYw>
    <xmx:NydXaiEwJuzHlNN50CxN0AcI3GHv1vZ2WAt2yJbZ6treo7XUkLY-A8JA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01857223 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:33 +0200
Subject: [PATCH v4 3/9] pack-objects: drop unused return value from
 add_object_entry()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-3-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

From: Jeff King <peff@peff.net>

This function returns 0/1 to its caller to tell them whether we actually
added a new entry (or if we considered it redundant). But nobody has
relied on that behavior since 5379a5c5ee (Thin pack generation:
optimization., 2006-04-05).

The extra return does not hurt much, but it is a bit confusing. We have
a sister function, add_object_entry_from_bitmap(), which has the same
return value semantics. That function is about to change to always return
0 (not void, because it must conform to a callback function interface).
So with that change, we'd have two related functions which both return
an "int" but with different semantics.

Let's drop the unused "int" return from add_object_entry() entirely,
which makes it more clear that the two functions have diverged.

Signed-off-by: Jeff King <peff@peff.net>
[ps: slightly massaged the commit message]
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ea5eab4cf8..188c4f6d4b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1867,8 +1867,8 @@ static const char no_closure_warning[] = N_(
 "disabling bitmap writing, as some objects are not being packed"
 );
 
-static int add_object_entry(const struct object_id *oid, enum object_type type,
-			    const char *name, int exclude)
+static void add_object_entry(const struct object_id *oid, enum object_type type,
+			     const char *name, int exclude)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
@@ -1876,7 +1876,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 	display_progress(progress_state, ++nr_seen);
 
 	if (have_duplicate_entry(oid, exclude))
-		return 0;
+		return;
 
 	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
@@ -1885,13 +1885,12 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 				warning(_(no_closure_warning));
 			write_bitmap_index = 0;
 		}
-		return 0;
+		return;
 	}
 
 	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
-	return 1;
 }
 
 static int add_object_entry_from_bitmap(const struct object_id *oid,

-- 
2.55.0.313.g8d093f411d.dirty

