Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37438D40E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502735; cv=none; b=p5KaObTopjXNrDKta+n+gQORVkWpXt0hULIOMUq5I/iihOmhRSPTRRj00ac/3tuGNouY07iMElSEHC4+PbVozqK+GlLz/X7mIdev/htXb9Nks6Gbn0uUtl5uyz1r0u35txRiVf5kKIN75k5c1atJHhq4E19bKWc6zUjAqxSpTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502735; c=relaxed/simple;
	bh=R93OVgbxjp9EX1KevkzXdP2nxREP62X5LTO5Uciqnmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7ln7ll5AMhixK8OVeADwpmxUvCjCg3zoe33k+3I8VyIGTW64SGJg9z34Fux3LZy5aWv6PWVgJtHoVLWmRibwsg/I/qLYJ8j1hw3hzOa0FvLBKxsa5LiXRkI0r/WjRA9VKkbUZvwjNUCKt4Ix/2bPaO5hZ/orCdet7DhuProSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GpZDlwUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6se/2Yl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GpZDlwUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6se/2Yl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 42D521D00030;
	Wed,  3 Jun 2026 12:05:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780502733;
	 x=1780589133; bh=YUp2E/tKiciINtQRUeymhpSC3U/TPboxRAFuRkw+gWI=; b=
	GpZDlwUhyxW0RcUJAbJ/tvlBsw5pL3zBE+Bf6zOfO+W/2DwjE7lI7DkaAEyqy+Ef
	ViuZ0/PQDqioETKE58g5qiaVH5KIjWd87CzhN936yMPaGCXkcK5OetXfv5Su0AC7
	tg4AYgIzOKrdbziEcAWdaAo9EKmKMC8XrgTf1/Yzvgwhp1oVDQjQCfdUmo/7tVVY
	CGeVp2FBSUBmL3XCYnYU1XPevzsC0kpB+7KEkArdCG4pT2aJY8N3rIVeCFGMfRDF
	rh+CZYobABMix4dqpQFSMB4k5ksx1K+MPp0Pti5FuMiPanDTw02JH310+CSneu3x
	r2sVeIpOOvFEbL+Yv6VLJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780502733; x=
	1780589133; bh=YUp2E/tKiciINtQRUeymhpSC3U/TPboxRAFuRkw+gWI=; b=A
	6se/2Ylbh4VfJ1TCeK98tSTF2Va2ljvSlDoz0rWqGkq5MvokvJt9PgiK46v2cpVR
	P0JStAjz2GlZwOxkZpH8e1mqeXFxr40cXveecm35xWDTYq+bk3LzoM1NoNtOtMJt
	eHHYK8cIBoGCKIeTtu9iFQm30ApbBDQZH4TvlSdWWO4l0c+G3ZQURlQxBrW6g/qv
	Q27dxDX+kWSToFmzKsZj+AxyVK+e36djOHkKlelNTLCN+ddbpO8mLCM6bLR7+4yI
	iTm8ZcqVtOwxXlJCFcwE/jT7AP0gJd1aXFTMNTX8WfMqBMVk6M3UIQLWqUYRKhCT
	X3lbtDOOdSzGxHdep880w==
X-ME-Sender: <xms:zVAgat_1BeuIov8u9xLqefoI4yWz9AyKx3KbiPK_5u4uvCs2ZkYZazs>
    <xme:zVAgaovKMtvViiK9yeOphlWJwlfabga4cgeZ8m1x-2QWBQVRpMuM3mPL_PU6VEcEn
    PgDLc-Ae-xByacsIQZ2SzEbC_2Z87Dd6IJCsfw1gOJuesNQzOOEyA>
X-ME-Received: <xmr:zVAgagAtp6Z3q_l07kg14D5srwYYawjPf8PfHkKA5ZsP2pyKEd-i_vLI9DS641PGYNaO386UZQYji4PV42vd5t3c68F1SsP2A6eXalk>
X-ME-Proxy-Cause: dmFkZTFlv+d5OlHvmQRpZ1Sd5KLvnjQGCcSRYvm5/QKl7vomAdOq4syY975o7eAsUSKICL
    DSQp3cNDd0vtzzQDDmKp4I4bNFXafd4k3A8IfUB4B0kPjyhmUryRN4FbUcH3wijj2k34VF
    uTBb6WMMgpbC6NdDUeYZSxqlzhBl3qVKf2cCodX/mcr/9oymPkT0L4qXPVgUkiZj8clpQA
    1mhZ82cM3sBQ5WUFgWTXKetbNhrRwAYsCVZWk2iH8iKn88aet7RmjzP3BSl6fjW0ImBJoR
    59HPTSQJsOLozUHbeBC051MX60zb0aO5iPBanYOGa0RwoFRcEkZlS5f13CZiE/DGVJTEfc
    KZ+0Ph44YSBpHfJE6Gd7f0LcCXJ9+HbRXF2DSnDSFgMaOV0BBK+eU0e0vhJNk3aaHLcqCn
    ylPPAKn3snmidPf8GhRRoxNtaWZUl0lCbW2s1BRXbpDY4RH1H8OtJ254dFk8fQf3QHf8gy
    F9EJy2S/wIiggi3gTHqCKsFSujJhLegt5S5mKtg/mg6IBTUKDtxndDGnvGCPpZ4PI7yOhz
    GSM2Ttv62ppBaCZeh3ceZ4zdkOSHOp2kcgBghtQ3flHqrfRdQdAWsOIbEflLnIJNluJftI
    EqPVN3c3IgEip0zhqIXOOOkdKUGqTSbgKUSn1tuJ8+X4d4Xl2m3czUWL6ARQ
X-ME-Proxy: <xmx:zVAgagU3vHyI9qA43YsqJKV0nVtU6UyebPrZebYyK7xjsQHitbT1rg>
    <xmx:zVAgauAgb_Hd4NMydpCOpZ4EtjkhiSqC-ln_QvHDPUXwX1VLeEYh8A>
    <xmx:zVAgaj-N8IB89O4UCWZtJyuWuZcJ-1BeCiKUbU0FLiIib1TwkK8K9Q>
    <xmx:zVAgalHRUWVOCTjYI2lsrhA14VXLyMh6n3S6DiGz2xyK7sOh214itA>
    <xmx:zVAgajiTJNxhI_MxuB5wPkYOZae31h083yOmjxwRJt4d0e8DDz8zv5d0>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:05:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v2 3/4] doc: replay: use a nested description list
Date: Wed,  3 Jun 2026 18:04:24 +0200
Message-ID: <V2_--ref-action_definition_list.76a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_doc_replay_config.767@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V2_CV_doc_replay_config.767@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This bullet list for `--ref-action` introduces a term with a colon.
This is exactly what a description list is, structurally. Let’s be
sylistically consistent and use the desc. list markup construct.[1]

We can reuse the `::` delimiter since we use an open block.
But for consistency use the typical nested description list
delimiter, namely `;;`.

Also drop the harmless but unneeded indentation.

† 1: Same explanation as in the previous commit

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Msg: Mention that the explanation for the description list is the
      same as in the previous commit
    • Msg: It’s “description list”, not “definition list”

 Documentation/git-replay.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4de85088d6c..b4fe43ec687 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,10 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-	* `update` (default): Update refs directly using an atomic transaction.
-	  All refs are updated or none are (all-or-nothing behavior).
-	* `print`: Output update-ref commands for pipeline use. This is the
-	  traditional behavior where output can be piped to `git update-ref --stdin`.
+`update` (default);; Update refs directly using an atomic transaction.
+	All refs are updated or none are (all-or-nothing behavior).
+`print`;; Output update-ref commands for pipeline use. This is the
+	traditional behavior where output can be piped to `git update-ref --stdin`.
 --
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
-- 
2.54.0.22.g9e26862b904

