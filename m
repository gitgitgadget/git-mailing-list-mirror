Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935543932C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953701; cv=none; b=cN5CBm3P87PlgHSan+Tmd+jtDI2a+p/4Ud6JHi3JmVrdIBUXwD8nxW0pg7b+aXreG/l2JveRTJ8N7/CqiY6sHESK+XrCSPcWz0CBtr9xv0uoTUFc005UZmwDiyMyomGS4czMTh1tloleiwNNMLWjyax5Bb3s0NdLmHoGc12apLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953701; c=relaxed/simple;
	bh=fc1/SarpqFEFB+mYhMt9hUdg4FX4tY3lbjOCxAMKEhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I2xR++sD2LRVUoi4/VtC4J1NLILKGPj/uPCdfS65bNj9I8rqVsU45VxSYggG3+9npDlxBgx8lqQLGxD7Iq32nUBSie4XQjr3XmWR7vynM88rmDzaXAqvRtYBbX9SyrxJh1ke8gyKQsXjJqNP6fB039zdvLJKwhjlMOnyfcj41QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CxSOQbyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CI31EQFG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CxSOQbyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CI31EQFG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 60BCC1D000D8;
	Mon, 13 Jul 2026 10:41:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 10:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953699;
	 x=1784040099; bh=jovpPEdbUbmhg+N+X4BF6IqInFOWWmxla7XnSVC+vr0=; b=
	CxSOQbyltw33PJFOKCduw3JYxrZpcclWpjnNOhhHSz+5w0YnIjDoaWc2tQbuuTww
	fAM3ujPFjMLZKxIIeC0jy/nzBm3SMgZyEQtqBJNN+DytWiMUyJi1r2ZJURBlHCYK
	NdP+7NLCkqUH4a1ViJzUgwa+YEQOrr6dk/NWj+mGpA6yQEY5k46N0wLV9zS7ARA1
	x0Dm8CD4gdyTb0Ij0YjsRVPHHPVkMw9154ZHcLV+C8xaE796YkBEh+XzPgewA5SC
	DKxg2chmcRyWJXGuaO3jyT5hQONHpA/qE6T+AT+OQ4qIAC0aKxkt8HHIyRxKKylF
	bqZv2nS47HAlRXxGHboIGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953699; x=
	1784040099; bh=jovpPEdbUbmhg+N+X4BF6IqInFOWWmxla7XnSVC+vr0=; b=C
	I31EQFGLLMXwk4wC2Mvz11dXVKdYNdQaEtZif8vGtbrPARvP1nXuiBtP17nb5ylF
	Jl0blmCVoRX9dTBVFHjPEEeF/jy599P3JyihFF2r3+7fkHmjQuX1dPSxIHK30Jtm
	rOGu/8ag7zwZeFBMULwQ7mYh+DUUGpf5cqtZU/ZKG726sFyGCTCK4Lt5qyXEjekQ
	XyWblGmrLjE70iA86ITbAZp4JrGb8v+reteVH2i8KF8djVctKvStrruowjlJpCkN
	yyXZqr/zLq7iJ4MT+J2k/NOxG9KGiqHo8wXnVhov80SD2wRiDm+XICB95mVA0rR4
	YziG9CngB4vMPmSnvrziA==
X-ME-Sender: <xms:I_lUamHUcigsWeyvyCBzJ0sTZuCvAEQ12hFlXzCBwSj5CwMqeoAkEg>
    <xme:I_lUauN5TGZD-_bvzdWEOdvhIIeKSONtAeHAtIPTlOnc1qw81MU8rWP90adr9iBZO
    MgcjykdgDvqTgbm_1j_Adh8XODQOQxXPgSvouhP1uLOTFjsW7Jk5bU>
X-ME-Received: <xmr:I_lUaodqaB4-e4Oq7RX6lnMwHjcdq5pWQVCTlZ8wD0c2LrmTaKgEr9Rz7z-1_OWa00TGAKFXAilUytfEw7pI02z6d41wD1twBlJJZ5Gq>
X-ME-Proxy-Cause: dmFkZTExU3AaOgeG5BObJ1W8JdQQ7fecPK0PCMuQHCnglnCgDOzkQC0YGMEj1qcLJSgMeY
    LASbvC4Tndv63coRGptPYG0Us/QPdorbjTjJ5eG4DbvGXhIArpLYSfP1Equ8XG1heJbryq
    UDpFgrp5VTZtDpEG/07Jwy4Ag/vYtEFOYaVrF84nTGMkk2meJjHZ4oqMYl9DO/bcxScRj0
    raM+378SqfjY/MjDn56wLasjqjj0AnRoiM+HE2+qWeFjm8zVJqFwrMNDwJJ51dMxeJILN0
    DY3JMGfUUBMmVXNdlp1KiUwRzg3BnBn+tX0Xx+zOe7dMF8plSZ04smH2o1tFL5zomOi5kF
    bJMaG5db4r2FEgKTek0QDJ+QZ30Xonq5SCZReV/kHLp+vZfQ//Kxc02QvZp082W+gKytjG
    gtFYmzKg5yGepZo2MIn0t1LzLzl/nWlI1l6XkM9q+EbCruT7LUk2POb5J5ZbwRzdgXVreY
    H3ECOET4ZNNLU9eaNmXzA8TlWm/BG9pQFSx9g+MLftv3TCoWFayywJ57xzh4K30L71xNaP
    2dPb6npJFuFkPKuB/sXp9kqhbSzZp0kURwrQayPMUVyGdgd35Ff0fmM/C4TbJ1zqUgebay
    IiesstZklgZf5KWztOdjiShDXUd12csPzTOFm5UUkovjRenkEt3jUJDkSa0g
X-ME-Proxy: <xmx:I_lUarvPP468GJJj2br3mLIgFOX6TMfktDoRPjVp8_qhSuAgZICjuw>
    <xmx:I_lUapkxR8WHxSbhWrTftiyB6icn99YZ_psp_8urm4k7LixzmvbrBw>
    <xmx:I_lUatzt52AgYoIZsh293cBZDHpxrsO1a1xEwkHPt9pvQysMLRQWjw>
    <xmx:I_lUarM2fQdQasRzIrdR9Gr6Kgzc7j4UHMvqyzdYdF_sWATn5tQlmA>
    <xmx:I_lUamChOnqX2e8hY1P40V5YIFZAlOyiHYE36CwTpqviu_t4BPC3SXiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71d2102a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:27 +0200
Subject: [PATCH v3 3/9] pack-objects: drop unused return value from
 add_object_entry()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-3-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
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

