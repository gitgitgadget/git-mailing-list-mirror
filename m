Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16772E7F3F
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599614; cv=none; b=OfWBjlZlicRCMpS+orMoIsy/DkcckkNmzf8jFnlq/p6ALnyaeTCZMbx2djOAIHcfB9L/0nv7k391A1t/zCYz3vOuBd8uKkdIXPT+HEC4dR6/yKF49GyR3zfnMgDNn1bBP2sQFEejQJrHHZQjWs51t3M2nn81ZDVpl3QHYAHAdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599614; c=relaxed/simple;
	bh=28i+A/Wtl/ljLrjdNqU4OfML3a/xfdkZ+ahIBvo3X1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lxm2KBRUOVOknugkpXQ0XP62k/fGwC3RSsMarclETYxNWSMXfnF252lGqKZ6YM/1vpRSbRpBhAVpY8SRv6exKbtx8aiStzdf8wXvVUBkcKId6/8N9/7eVDPTxRrhjhTDsyzZZfcA4usX0PRT6R89p1I29Rof2W2i5A0IJQErHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GW5Mi0uO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uvv3Y/yQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GW5Mi0uO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uvv3Y/yQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 06EF5EC00D9;
	Thu, 16 Oct 2025 03:26:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 03:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599612;
	 x=1760686012; bh=cgFbBzRFQlGEIhnLZti2x4hP0AeNUZl90aApwGi9Oj8=; b=
	GW5Mi0uOPQ9X1xA8vEmdFGUmwi5R7Ob/m6d9s97npR4Qp+Nq5xLG98oXzyVInGQL
	goOrFbosqaJR7BHBrwFBEPxt3sGV5buAR94i/cqOSquDCelzseNjfiGZblDrhas7
	V3nQcoDMGqKETwe+5GDfJ4RJZ10ZnV825o8tZv6w11YC3htBXQyuacaQOTrTyAFI
	yc5tpXzlDYim63TeCSw9PemmGUaopDydn0cvOWT7+A5TBKrwE/57508I5V38GRef
	Rn5ZZ/1DeRQ72eokJJmFhET3F+GgyoV7T2685qVgkNjwUOiV+5zb5FNkjKInk+B3
	gMd5rikit/xpIyvJmllWTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599612; x=
	1760686012; bh=cgFbBzRFQlGEIhnLZti2x4hP0AeNUZl90aApwGi9Oj8=; b=u
	vv3Y/yQURuznwQWmhxJjH706Y8NqidpCvtvPuQAGSNHEJRVXv0K1qhIdtXTR8Kok
	Yg9Cjl0HPixpc2njsjqXBRcNwJ/uZ5PfmvCS4XfNe87pfyFD0PGELXrgfV5PlEda
	3QxlhNbnJaoeDvAPndp1TiIyr4lbeaAO90otToml2FR/SCt2yGK6hCcjPary9EKa
	SFyjekDNcv8pKVXqR+ljFHru7X89gWfa24XZBbjgzJaluvxNxsZ4uk4ZSEJuK+Wb
	BZzDFYon7NNyFSK+PBTlpP5C7eTjBw/pOiLjgXqumqQs+xddguyFm16Qm1MoWOg1
	LmJCBEcud44YVtfLyezgw==
X-ME-Sender: <xms:O57waEWpIVW6YAJAYvVLdRCmYh26b564PRKLrXhWQ4EbTr46GEIh2w>
    <xme:O57waAAI1xB_NY6koisDhEmKnvWe2kuzLd2ZcGm1hRbYis8KLUus5X4iBJd4BPkkB
    QmsWkFrfuEgJc5SIExZv0pEmHp6SM4GUJIXDtBK-FLFNsEf08_U>
X-ME-Received: <xmr:O57waFxwPPEbpLP4m0w3WxGP6j3mMKjCCp67eM_NH8ikwA61UdPTXXXe34OcvvocpkT5nL-snDgPH9zqqkUW1ikbmuVHqiV7NDC-PpD_T8ZIpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:O57waNACSUnigOMkoYtbko41FPzrkBS76V6MG3RQDmotAjbQQIRBHA>
    <xmx:O57waCaOvi5Y82UTSC8tk3rsn1S5y4si_2YE5iSgVfg_pTZ7iqQo0A>
    <xmx:O57waFgrciTB-lcbglAO3b53gH0NFiEB0LXWKU8sFrAwicxG-tRrlQ>
    <xmx:O57waE6OgMpA2oUuw_3lAMHHMlPpdgTdCzU2sI40AFiSPAS1-fEphA>
    <xmx:PJ7waEf4A_oG6D7LV372tfuEljLZxXqb9zP46jyitjao2r3w9hTKNSJf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:26:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a5f50f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:26:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:33 +0200
Subject: [PATCH 2/8] builtin/gc: make `too_many_loose_objects()` reusable
 without GC config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-2-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

To decide whether or not a repository needs to be repacked we estimate
the number of loose objects. If the number exceeds a certain threshold
we perform the repack, otherwise we don't.

This is done via `too_many_loose_objects()`, which takes as parameter
the `struct gc_config`. This configuration is only used to determine the
threshold. In a subsequent commit we'll add another caller of this
function that wants to pass a different limit than the one stored in
that structure.

Refactor the function accordingly so that we only take the limit as
parameter instead of the whole structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e9772eb3a30..026d3a1d714 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -447,7 +447,7 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	return should_gc;
 }
 
-static int too_many_loose_objects(struct gc_config *cfg)
+static int too_many_loose_objects(int limit)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -469,7 +469,7 @@ static int too_many_loose_objects(struct gc_config *cfg)
 	if (!dir)
 		return 0;
 
-	auto_threshold = DIV_ROUND_UP(cfg->gc_auto_threshold, 256);
+	auto_threshold = DIV_ROUND_UP(limit, 256);
 	while ((ent = readdir(dir)) != NULL) {
 		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
 		    ent->d_name[hexsz_loose] != '\0')
@@ -703,7 +703,7 @@ static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 
 		add_repack_all_option(cfg, &keep_pack, repack_args);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects(cfg))
+	} else if (too_many_loose_objects(cfg->gc_auto_threshold))
 		add_repack_incremental_option(repack_args);
 	else
 		return 0;
@@ -1057,7 +1057,7 @@ int cmd_gc(int argc,
 					     !opts.quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (opts.auto_flag && too_many_loose_objects(&cfg))
+	if (opts.auto_flag && too_many_loose_objects(cfg.gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 

-- 
2.51.0.869.ge66316f041.dirty

