Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DA348C4D
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718505; cv=none; b=P2FXqm23OAERRVUwoj2pgmHf+7UQfIYSZLZ7FjDK2UfkWfhzrpKUWQXAnTce9g+mfnb0RmV2+zWiYrfdHrcnMWVbJscmXcn+CHTa6tWjkwk5twUejytMb9xxNdtgb25KAHdDvzSAYossNBrsLOMRzT5cpP95znmG5nm+cHNin5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718505; c=relaxed/simple;
	bh=5gabyeQnZLNx4Igi9It4LlOIFcSWD7sED+xscSYU2Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRFzZb57qOR6wa+EAZRlAlnuHiry6tzzZWaWbuCnwRqCyXwrCOIjjkOzYPYJlk1VTZipLmc6ETCi2EafwmXr76o49lzdoWB9i8i5bMjSwREHsf8tlJ5Rbqu/9/l18cMiDW0KnvxGTmgpAw1WMdzlRm8n3ywZKh6gv5i4M2MsegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o0sldgYD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aZy1oW1p; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o0sldgYD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZy1oW1p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 289B87A0095;
	Mon, 29 Jun 2026 03:34:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 03:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718494;
	 x=1782804894; bh=M2W5WctozHsb4//RTPCDWn1gbLMTgqmTdPcPwv5gVKY=; b=
	o0sldgYD1H7DVW3FFzW8strkCNkIRg8/mC5O1uxVqgJyMWVNhjYoQazn3Z+UHbj5
	XqjuEiryGjP4bUpFnXr8zEoUu6PVLV02gkLNB9TsbcG/rgOY5lUtZYUuh2y4/h2s
	6jCGPw+d0QE2iz21ewi179I1BAz+hBHX3kVXz8v0Z9lIKBYGz5u12EwXl1UmNkqu
	PNXWqYA7mY/nGGoM1U5GhjEgTptxtH8VOGgL0boP+66G4josglHDnItHykB+lwXC
	hMQxKum2oZeJ4BZmtMTxeJWg87iKbqZ65gBdVWS9UUa0iXqZn3KV/fB+TMxNN1as
	8PO/O2OTETQvI6MYcH/oew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718494; x=
	1782804894; bh=M2W5WctozHsb4//RTPCDWn1gbLMTgqmTdPcPwv5gVKY=; b=a
	Zy1oW1pMVhSj+dSkGV++ABO+ISGwjxuhY6Hl9hUuppWknEQMIqUPH/H6Qe9dibt+
	50W3HuZYhzPBthL5sdJSURwluaINjefgS2+TetMlg7f8G2kCgVsThuyl0gUgJrYx
	cgj67mvlxdWagZvMEwoKi/sp7z8sCjMqGlnFqlMkmBPPbfOWrng5ukvsTAz3dvpA
	WB3Lpk5hN/n3XHIQHZqvLgZAwEqGY74HvyQLlV1XbR02K4x14v1lu/2FhwYG9KJT
	dzqSwgwPw6MFyy0nVfi0mvYx3229YtKpxjJZ8G1avV/gbUDfn3IH+9tdmNDLPYWJ
	hGigQnZJjENKTIO6YnVAQ==
X-ME-Sender: <xms:HSBCapvDs8BxlJhdUcS0OQ0-M0V8TXctHAAbuOgGM5d0XLfRwgh64A>
    <xme:HSBCarz6GC-aPwvf_UkBwIqlYYbC36ZeS1iDTw0ET2f1_xnH-iNmGgJiGYIa6q2be
    YwWMDqoDfvlE18lmf63hsXWYMEz_oJWsTPVIz_ay0PeVYggPfXD7w>
X-ME-Received: <xmr:HSBCakB5rRLJfVk9tcjc6OBVJa1tnzSSlYHYHNdxAuDUYVVv9NL3YNEPl1U7O7_mL38WemxPIMpnj58gpLvjtKWd3MmV0Nrr508_OdVzMCG6>
X-ME-Proxy-Cause: dmFkZTFtwW+jrswXR2sqyckO9gfZ6S1zTRV9x1AzwWISv4S5GQeYD39MCLhCSYQ9JC/y1c
    npLVZAirVrNTDUG1FfT8zRyjFPxjOq0YkCBphiDhd6Zl2+0Va0Ji8672uuvoNsAlkGjsby
    /fpKLxAigNdSSgUGAMPe7yYIrMRwQgGv7NtTZwjz2PJ6yYgwdXm3wmBGV/T77ZZzeNQp0Y
    xjkn2eSgvSZkg2YACzeL7DjzkuCOn39jFCLMTy7TykXuW8I/lMeMnQFpj0UOayI8eLXeRj
    qqFffAyn+OnBbxqYZqQ7RhQj+Dm6PQXec2R+tuZcr19NHYptTidYIpqKU88o0gD9KRksKk
    B3b1r3OjUMPFedq+NuInrrxEFkFWoyaZVc37OD0OPHTzc4xHHwAcV0Dl6ONjqijAn/IymH
    ljWv7bW268U0Rn7AK12qwWO8Tq6d0H8JQ4Bq7l2kQXONGUptkOIcm8qfIP3ILDZopdcfnB
    IWwGaZ45Lwdo0XMfD/tdHeErGctiqtJUehT6Py9wP/q+fX9qaPHSFv1EOwFWtL5q0z4rQ1
    x47bC+RT27sVjBoC4vpwWNl/PBLAup5m3VtVNPhwqN2fodWVUWJB8qHQMlY3R4DLZ5cep+
    S0CBycpXgqlozjQ6pw56g0G6MfDXkVHqoxM0OU8x1uT5pV8p/x4li/3eJ4sw
X-ME-Proxy: <xmx:HSBCahc__KTzcphxDCZIFxoMCbZe6b4i7uSJJdvLAj859A0SjtJukA>
    <xmx:HSBCamn9UQloXhJJpTV4Rihl3XtrIX-3OfmXg07nbGycg4F2899QsQ>
    <xmx:HSBCagFAL0vn5F2O2aMOBZaiSoYAgbNkEZiLlwlZzGewb3wuvdX4Jw>
    <xmx:HSBCam4Cz0Bq4L8O23pSxbvVpTaju-eqDOcK_4Kmf3OnzFNXFZontg>
    <xmx:HiBCajJB3a4hvfw_qQlznh8Rb8RXes9W8niPCxfeWms2xyu_qsbx-t9q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67901cdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:34 +0200
Subject: [PATCH v7 08/11] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-8-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_working_tree()` to stop updating the index tree cache.
This was done as a performance optimization: the function is only called
by "sequencer.c" and "rebase.c", both of which assume a clean index
before they perform their operation, so we know that the end result will
be a clean index, too. Consequently, we can skip recomputing the cache
as we can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_working_tree()`, and consequently we cannot prime the cache with
a given tree anymore as the index and tree will mismatch.

Adapt the logic so that we only skip the cache tree update in case we're
doing a hard reset. While we could introduce logic that only skips the
update in case the incoming index was dirty already, that doesn't really
feel worth it: after all, the mentioned commit says itself that the
performance improvement was negligible anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reset.c b/reset.c
index 06f375f296..ff87e3e357 100644
--- a/reset.c
+++ b/reset.c
@@ -167,10 +167,11 @@ int reset_working_tree(struct repository *r,
 	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
-	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (reset_hard)
+	if (reset_hard) {
+		unpack_tree_opts.skip_cache_tree_update = 1;
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	}
 
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
@@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

