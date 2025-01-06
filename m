Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2B2AD16
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155477; cv=none; b=qdF+bvwYXFApXbD3xFB7Qa7HHKbEpJk9QqbMciOxzI5VXBq5NZjLgNs+hPeR+W71EGSuwnB6cGnU4OattBCR/Mc6PXIWa1sKGdNULIz+ZlLS/izPcFntUUzysXCBNdCJ3SA5XKSua8/sxy0oupr51JCKkykEwdpH5S4OgSHR1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155477; c=relaxed/simple;
	bh=+jAbNhJrIvU45E46ceAq16AWwlniSeNs/Xm1qKt0p9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0L7CGmp5KQPkDQNbAvdAdBRsHxe6yc0IxL9fVDl5aMVMaD3vTSlNGBOTjbUcCTWwyKtujCKqauUauCYHzTE7aBk7U83C8hk7E8huTNHY8wp7yMaK4sOm3gaqXZmibvpPey7R/WPGXwKVaBKA7Kt+xro6z3PNCrR+1QAP6CHzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X1Hp7bjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZKqrE1V9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X1Hp7bjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZKqrE1V9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FB4B1140624;
	Mon,  6 Jan 2025 04:24:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 04:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736155473;
	 x=1736241873; bh=K0jlqDJXd8mNX8WHGUm6EzWKGWArKGngqLzSxwWr+ro=; b=
	X1Hp7bjTsZbIrcdpTXZcvb/Ko71OHBPWq48WXRBsbPAtQJO0WXNadwZ1LoliLEii
	4FK4YdL47p1Aa/+/TyN0HY8JFO/bSyYdjuFAlYL/xqUi+ka3e6hD768u0B8FuCyX
	q7HcxkpA66dTqT4yZef+jciesMg0xARSN7u+sbt9vDVduViD/gMTlJWKgs/NKszw
	V1993+FlZtXlYp+uSBnMJZiP1ZALGT6XpKNxGzgJQn1fF3z3fkH/oU3jxTk5SvTw
	ZcQPFLckrPuexbIAFidk3WRcOj3K4yjL4dW424OJ0SdEb1obtV3G/kPHYvEkgGsS
	MJnz3pmzxoBEkXUADmKr4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736155473; x=
	1736241873; bh=K0jlqDJXd8mNX8WHGUm6EzWKGWArKGngqLzSxwWr+ro=; b=Z
	KqrE1V9HUtLsgJ744GNJU3jGtM1WgB+OvADvNGY/E7vD/KB0yrI+NwbHEWCjCcoW
	BuQQ4/Fytg1aaeklLMy9kvMjzXMqfU7OucuXhAqxmwPNgWwXslUrovpgwp6RjJG7
	vgQgDcYfUdQn9eNomx/hCpkV/xnbrUMgAQU35pKV/J9/SR0JVztFcvTF/pKGeeGM
	LBDttXchFaBSAGcPlTLgmBXXQhH54NtXgs+xG+nu9WsUaimLkATMsOva/vvebHmn
	VzP+WQGA8CeWSylTE8BRIZIfh4QSU1K9v2AmMzCUJ9yZZ+S/U2f/3aL6STRDv7iR
	MfYe+FwGceR74XmwKzDAQ==
X-ME-Sender: <xms:UKF7Z0XsQVkmvzAc82EqShjFUxh8f_lyajU-H-f4Fr7OKOxs73Xl7A>
    <xme:UKF7Z4mz6Si05hNZaoPsOlgHYSUjhdK-pt2Ss0ymfZyfIrQUzyDe4XUydjZYA0I0R
    67FVXxlokmFe_s-Og>
X-ME-Received: <xmr:UKF7Z4bfeqo2Nlx0ILRd-FlL0-9tlNcyrkj6gLy64uNRcl3AN2Jj0BMQjOkHJCWRy3xnT83bbuXRzLEC2ywm5pdPaAfLl_cZF6MRPMZuxG2G2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:UKF7ZzX8joPOV5INJZL1OuZnTA45-94AMGqYJ6Y6n_LbkvV0_im8lg>
    <xmx:UKF7Z-nEmC0ThQRrF97NGwsfYyas4f-ZvbpPg_rethvdNvWBk7MGcg>
    <xmx:UKF7Z4fJp8C2F7_3J-FfQYaxFeCxFep3A4ET7moLBK2nbLNSJHlI2w>
    <xmx:UKF7ZwGqkRO8yqZUz8xN-N-SFxDut8UivRMITsvgR59pjInU8oNyQQ>
    <xmx:UaF7Zwg59-ocuh3U09jDO34T9Vg9yJyodDE3M1KP3FXaFjdZ9SmiZ7SQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 04:24:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f7212bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 09:24:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 10:24:26 +0100
Subject: [PATCH v2 2/3] object-file: don't special-case missing source file
 in collision check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-object-file-racy-collision-check-v2-2-8b3984ecbb18@pks.im>
References: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
In-Reply-To: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 0ad3d65652 (object-file: fix race in object collision check,
2024-12-30) we have started to ignore ENOENT when opening either the
source or destination file of the collision check. This was done to
handle races more gracefully in case either of the potentially-colliding
disappears.

The fix is overly broad though: while the destination file may indeed
vanish racily, this shouldn't ever happen for the source file, which is
a temporary object file (either loose or in packfile format) that we
have just created. So if any concurrent process would have removed that
temporary file it would indicate an actual issue.

Stop treating ENOENT specially for the source file so that we always
bubble up this error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index e1989236ca87e565dea4d003f57882f257889ecf..acfda5e303659195109c94f5b54b8a081fe92c59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1978,8 +1978,7 @@ static int check_collision(const char *source, const char *dest)
 
 	fd_source = open(source, O_RDONLY);
 	if (fd_source < 0) {
-		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), source);
+		ret = error_errno(_("unable to open %s"), source);
 		goto out;
 	}
 

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

