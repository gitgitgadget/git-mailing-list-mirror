Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36A3C2BB4
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101184; cv=none; b=QdI3C877gCW7P175eyuEC28ESN17S9Jkx0OfSaEKwgJ/wlHPcwjGQuUGNUfGRPN3ciU1WGX0LDl6jelPZImFuclpbNse+rGDw675RdVFl/QOWe6CSK+mI36BNYXYMoGp8SW8lgiDUN4ZUq9SA+XvGXbz9PSZkxbhEOmB9BWZzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101184; c=relaxed/simple;
	bh=c0/P10+FIQcTzd0nLm6lv5vrYxT7I3oyB3inm6olF5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPXaLPUc5tKZb/JUR/0lWCrA0x/Crs79gmjctTIrkQQWPWVWLFq6gsIhkFtZcd8RZ55TAZ0+5C61ciz9CCv0gGdfb6QkZ/FuUKuxdCtnynx11awP1gAXfD9qAhiyse0JHvELcy9yl0eEtf2T/xznrzXI2toWS7UcYPfVQ6eI8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uzunx7ZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4tZJye9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uzunx7ZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4tZJye9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 414611D00101;
	Wed, 15 Jul 2026 03:39:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 03:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101182;
	 x=1784187582; bh=bvWEopHSZba3DcQ7aNTnEw+N//FUlSVw/rHQFTG9dNs=; b=
	Uzunx7ZBTlen3UTCStrSVCRCoWtlRRWtzqqEzxubyLk4m5Kgaohf/scX4uZdK/+/
	BkUQeAeFbNinpcmsZmjuZoYOG9ocjznoS/d5mGdNZQiv7OpiE49vUsRHbx/LYcPf
	3WGu2sajWgj3bwHiVCA8TdfgCoBnXgssxYfr3qQoxg0lshSIwTVRaCLOtrFo2dgO
	Qxu6vSUISEAhWUq9qrmDNaj+ZhWRxmAlzw9AeNiUXcjcByQ0Yc7cqOep7062XqTd
	NVwMTpHs7DwqLqob8cHIRkbvxgsyoD18as5H11KuZnQwxiA2JMLjXCSlsECidDNp
	pz+8QtK2B5YxqaqzBJ3YdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101182; x=
	1784187582; bh=bvWEopHSZba3DcQ7aNTnEw+N//FUlSVw/rHQFTG9dNs=; b=G
	4tZJye956DfdyVA6z5QqraSitLC3pcTEmG3etm8tmdsIrmnEMyECNgqNFZwR2Xul
	EuY9v396xhZQjXwtPIxxqx70OyKp7+XLuOaATMzcjTyHIe+cDoCppy4qISMsCvdB
	NiM82Csy9zVVptq61Dzt0tefPaEIPL/JJalv6ZawrGt+50vRZAcy+Y/7CHHpnXUe
	GbtI+kCG4tu2WtAUqMOkqgXfPi2zQLntxlFSMZZdZB5IigT7qHeg03XUgBIxTjOD
	lQC8Pf6taFrrvIVMoOlDYhoOiH5G1LHw1QX+mOZ0g99Ysoz8+jB/D28LkOTic/s3
	6IWZWMFmi+SVYvk0w8jHA==
X-ME-Sender: <xms:PjlXaorFGHJrczf5GPRpMobhUl85U4-QRSR9piHC7JgEllG5yyIEXg>
    <xme:PjlXakq30XXfj0X3xyBBMwHMHa7fdYZgNAUTMY0J0CDlDW8qsulqV-kl0_-pseq5D
    dU0rt2JS1Xt3Q98X6_s78d6H2ZPwB9H0oHbmDndxt8ccM3KKwxq2g>
X-ME-Received: <xmr:PjlXaq18eO2MAw8CPT5XvQbPn9sOKkuqFtVve_sKvKjT3nytufPcriTvAmA20mOew6t6lFmgIITynh6tIEsBQnu0EA57syBMbF8KWp53Xkw>
X-ME-Proxy-Cause: dmFkZTGtlESBpqxWx5VDCyzSHAFjLID+d3o017L+9t0hzoZ/HFdnZMksWAjQUpKe5mkcm2
    aeEPvI7S+GobeeC2BCcOlybP5AT8PUeK9DTyPOP4REeP/YXAf67SwpLL5/2tbBDgAB73I1
    65VyLIFoE16n9whYuM6847ToVuC6bk1LcBJvA5RtCpU1MgT4tzfJrvG4L/8v4k1G8If1CZ
    VYA0705qsr4QILUnrEU9UXR+Pte/Mn8XSZAMTzTNDXCdTNYP/5KxqorrepV1dVq41xtfLc
    rznFo3RqnfVCv9dkk95mAtSvNO4y5cQBzEbxS5nDDVudfZsteVxXo9jWe3soYdkzqZZeS/
    hHrsvlj82OlCWVDjAQdxrs/zTHSEG5hK0oi3L/CYSA/QT6Wh2MWDrujy1tSJwOZ/xx0hMb
    DvUtaDg21btuYCflqpoF1FJZt9z+3ftJVTiMa0UdhobpC8spqv8kSpMA0Y6GUQamiboCoz
    rckJQ6NPAdjBnnvThrMgwCuNWroephyziynxKeuvYkmZM0L1ctHgS+N5l6hGK7kzpL/Kd+
    tc6FS93fQFr3v+csoAit6vyHNniLrBLTADBRx4LfXqH6BLweeIEwy8yA1M+ZlVI8A1jUeP
    RS28iOSVkBfu2kvPl0k0muTxlnvcvsFfnkHQ9Nb3+G98YOgX9KbPFYgjkkRg
X-ME-Proxy: <xmx:PjlXarDMpnmXw3upE3bVeQbgGE8h-UheX-malth1GFo2F0QtKVgO-Q>
    <xmx:PjlXaqfE8ePauqk5o8E-aopIrXiGEmJ5vOrmXcaMTyOR078kGhtTvw>
    <xmx:PjlXaoiwKv5R7oFxqhNFKs0H9nJfF4KhrYsshOM-Gxy5CLHOIvwLAA>
    <xmx:PjlXaqoMvBuxtph279XOiC2zI98b4TZl9ClR7MroRBHZhitRXJJ7Og>
    <xmx:PjlXasBgAdkr7AWi4xnqqMBCM1rmuWgU2SsILfyW-TvtMudbG264e84A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10b3114c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:34 +0200
Subject: [PATCH v2 1/7] refs/packed: de-globalize handling of
 "core.packedRefsTimeout"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-1-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When locking the "packed-refs" file we allow the user to configure a
timeout for how long we try taking the lock. This is configurable via
"core.packedRefsTimeout", which we parse in `packed_refs_lock()`.

The parsed value is stored in function-static variables though, which of
course has the effect that we'll only ever use the timeout configured in
the first packed reference store that we see. Consequently, if we ever
were to handle stores from different repositories, then we'd use the
same configuration for both stores even if they diverge.

This is of course a somewhat theoretical concern -- we don't typically
handle multiple packed stores, and even if we did it's very unlikely
that the user has configured different timeout values for each of them.
But still, this is a code smell, and an unnecessary one, too.

Fix the issue by moving the value into `struct packed_ref_store` so that
it can be parsed per store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 499cb55dfa..14b27d24ec 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -162,6 +162,13 @@ struct packed_ref_store {
 	 * `packed_ref_store`) must not be freed.
 	 */
 	struct tempfile *tempfile;
+
+	/*
+	 * Timeout when taking the "packed-refs.lock" file. configurable via
+	 * "core.packedRefsTimeout".
+	 */
+	bool timeout_configured;
+	int timeout_value;
 };
 
 /*
@@ -1233,12 +1240,12 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
 				"packed_refs_lock");
-	static int timeout_configured = 0;
-	static int timeout_value = 1000;
 
-	if (!timeout_configured) {
-		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
-		timeout_configured = 1;
+	if (!refs->timeout_configured) {
+		if (repo_config_get_int(ref_store->repo, "core.packedrefstimeout",
+					&refs->timeout_value))
+			refs->timeout_value = 1000;
+		refs->timeout_configured = true;
 	}
 
 	/*
@@ -1249,7 +1256,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0) {
+			    flags, refs->timeout_value) < 0) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}

-- 
2.55.0.313.g8d093f411d.dirty

