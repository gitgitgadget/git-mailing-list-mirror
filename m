Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F62797A0
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354682; cv=none; b=UpuyKFdTVOMFApVilQpKEvdXIxh5b//cc0I+zr0X14a+G//0I3ipSyM6X7lgmN5rJBDO3Hh5uV68TS9G+maStEzaURhNSQQffNv0M1dy1Y26qQT8/Zhq0xNYy4kuJhCI4OU9y+nPuD0UqlFUM65/ZnUyXX07Sv9KKSBYDRDIDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354682; c=relaxed/simple;
	bh=crCOcT2DpL4dBynUt9wJw4u/cKp7wcU8b3AOpGx8ktA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zpe4Yqt4HhWsEF7l/yQScjoqWKhzMcekA/Aaebf+/ao/Pb7DN775nWnNUT0RNrRrAgRd4BmGnSfVhTA+JgZXgYR4um4BZp9zcAbV2DRkuxans+t1ggeGyC+TxVXNHW6cl7X/grrPDjh/Kh7yA3d5lJ3Wf4gwiSsL7z1bApmDTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i1u3Q9Sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buuKQ+KE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i1u3Q9Sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buuKQ+KE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E2E9138384F;
	Tue, 27 May 2025 10:04:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 10:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354680;
	 x=1748441080; bh=cgyg1OMC6gVRmH9yJwZyutCUulsPaLcgel9KXzWJ2YM=; b=
	i1u3Q9SyFoY4HS05lT7FYJ46Gc4H9t4LDvdfSxum+MNhLc/AgKOoMYYn/tegSlxR
	5B9janfmRbsQKMhcH3z7dDnBtHHIPVpHqeJlxNWFVpM20dsRByofh6shGx/RAPt4
	9xzbtxG5SM4gvYPzFpEPG1ErBH+XYpFGqCpa411cRVlvxAasElzn6pyISVBs19qs
	DBvNO1FcteAY6L0YpV+H5Z/8UpIcaFe5Wsa3QXglSEGs/ZShYsLBtNOpVKbPHH62
	UUytI6FwsmjxXAqNt5xClZiUhMl2NyedBKsNBV6cnC5u+vmMI29vSKLinJQg8qZi
	bliJTP8E5zFRJ/Ix+40Dvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354680; x=
	1748441080; bh=cgyg1OMC6gVRmH9yJwZyutCUulsPaLcgel9KXzWJ2YM=; b=b
	uuKQ+KEutuZh9PhEwx74rfc/La2BykqRmXGeSiCGC9AlLymCEixhuFMYmxnBdV7j
	uWnjGwFL9/IaNg5zTpFf/pO2gnBdufYBexJc7Xu2vInaecgPd6v+ZuqZEbT4M5HU
	1eSpmwPhdxB4gCpF04UOZStcoTB6XJMg4M6mGOg3ZOat+fC/od4JtLkL0x3ykeEW
	ZzgBWCfYR1zGDSvL/FZ1dngKZxvhpelYWtkxaY5FmO+i//qn0jZfHfY77zpFDqR/
	b831MD2DwSjaEPDUa9LrsE6UlE0Ec3gsYq+rAq7MdZIIAyVhqPsRtTS4sS2Vpq54
	XJvgsmlqehIHKwPGKrCIQ==
X-ME-Sender: <xms:eMY1aBWEy1SI6pqXLMWmU01AaaFMBrVL2GJ2zn4bYPPTJmgaQe2NKw>
    <xme:eMY1aBk3pDTlkwk1m0Pj1ih-XaBw1P8Qoo_7LpgUIqorpbFTntmbXsGZpTVal-qxk
    8V7-14S1VrsoO7zxw>
X-ME-Received: <xmr:eMY1aNZD2GNFMhza5GmRMeNTx5vTWvJc64m6sr-5x51SigpPi_dUxJikTpvKvUKvnhf8lSAJWPw2XHBMcE_80msPegUghFXGDQY2HmoNSIc9Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghflees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:eMY1aEWSMjKN5mxZ60mfw9ZSnDOlAdX9EBp15-eOPwz2PyQGPpfOBg>
    <xmx:eMY1aLkJ0rjvuy8wrzY7tB70P2bZuRYT3AK6YGoOc3EkPcclq93lmA>
    <xmx:eMY1aBf2nEtFW0if3yZbP5YZCksYwmdaYOiUDT6vhi-qNOBgU4ciRA>
    <xmx:eMY1aFEDv3iLT_FyE7D2G0lF7MY4SFuaOOR4b5XwduwJTriikxOweg>
    <xmx:eMY1aAwsrWoUgeJTZRdmo6uGw6A2XSH1Ek-nJY-FaUXo6pL85SJsNVB2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d79c846 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:35 +0200
Subject: [PATCH 09/11] builtin/maintenance: fix locking race when packing
 refs and reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-9-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

As explained in the preceding commit, git-gc(1) knows to detach only
after it has already packed references and reflogs. This is done to
avoid racing around their respective lockfiles.

Adapt git-maintenance(1) accordingly and run the "pack-refs" and
"reflog-expire" tasks before detaching. Note that the "gc" task has the
same issue, but the fix is a bit more involved there and will thus be
done in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 57f3bbf5344..e5d1114bd2d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1577,12 +1577,12 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.after_detach = maintenance_task_pack_refs,
+		.before_detach = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.after_detach = maintenance_task_reflog_expire,
+		.before_detach = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {

-- 
2.49.0.1266.g31b7d2e469.dirty

