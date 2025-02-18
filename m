Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652A22FDEE
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870536; cv=none; b=Y4kz8PGiDc5TkCme9U1kv3qy+aqMRf/QzkDy7o4bx3rNCiEk8xJ2/Vyod4SAjvbQjs2XaEf3qG8twNzw7vdAlfulWySeS8BE+wi8ZNELJ2FVulKfSIGVWQfnTttLoWJfslbrsHXDHTm7LLxBTeSecmoJmE6rL1qg180HclQKg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870536; c=relaxed/simple;
	bh=mfPjYsCgBgOcKDx/VdlQr42oOZaKtsk8LW4DIBe7mR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/2AwzlPeiJxakGT3OJRxx/5qXgrtjzRTvh006Ng63OMXGMyBxfFbj4NQHt0EK/NN2AgHzhXntc9qBC4WPbI7aS+ZUSTNQhPfP3JsKbCwgkFf/LLKuhs3HDnLtthWBsfKy9RV5vTEhwwLgqS2wrNSSabxq+k4SIvGd+EBoUwpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dd1l1Z2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzJo3kyO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dd1l1Z2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzJo3kyO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63912114022F;
	Tue, 18 Feb 2025 04:22:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 04:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870534;
	 x=1739956934; bh=E0iCZQqzqGMcmP6BLaLkigVEHin0kcqkXbwCMPSBkg0=; b=
	dd1l1Z2ZLdVjDTcJGeOzeoi7X1Iu4UkPAv1qV6I6s3OSsJiR18OQ29ofELi6ImOq
	bApP3DgjMVoTNBL/gALcJNraumvvdNtTqt6XfuKVAnOyLe2B4ODpDNfJea1BnmH4
	6cpdXZPxi0rOc2rmweRFSsBUHwQ1lQZOOn9IijBSdGnPkALTCVPKY2XlCOqYsUbn
	ZvuTUaj5SpjRQ9D9BTrDn0/Z58bGscSics/DlThmmkB1ls0fyqM36LlshNA79WoU
	eRn2A/3mWLEh7kDjg6oCmXJku26TDb4JjfSJT3Ga+1GPaPgHLQfgSaPqXumWuNO5
	VRi77P9ciPbNrmZOD4/wKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870534; x=
	1739956934; bh=E0iCZQqzqGMcmP6BLaLkigVEHin0kcqkXbwCMPSBkg0=; b=d
	zJo3kyOZ9YrUn5uvuvZCQTv9+/0ACozpv4ECfauk38DBZxZafaSTyfBeFnWIkOt0
	+e3eFYlzkpDKVr0l1g+J6bhUAEvaiQTUq3rUoLs21RYma2TP0c9ct+gdrCxGY1+m
	cq42yFgGo6AZ4l9asGI46cfjs9tPrVnllJou2nCbvJzVzukSyDmwiXuKZQ1dlDTf
	/MRiCLJLkZgw6oiuky4cD+H+eeQYxT0s5/0ctkgeE83/ytwiAGBwaSCWd1XQsL+7
	FZ4aYB6GObSeiMHbbtmXtkwB43KXux3bmBj37ulTLMlVGdbYMbDoYFA2EA3poPI3
	MMV1QNPjHX7B+6ao15CKA==
X-ME-Sender: <xms:RlG0Z6jiuo6UldLf0p0YYPkTBNX66LNBaSwd0jpw6d4rBDbufmg_wQ>
    <xme:RlG0Z7CNC5ivWKXcShD2Wp1ZULgh94BtuxMzOX_afOk1caZ4HepcYRNXGiytmK6B4
    FnRz0XX3yiPDM9oYw>
X-ME-Received: <xmr:RlG0ZyHM11MktF5SDUb27UpTwna7yVN46RoJjxPmbwCX5ZfX6NvBqsJk99nYgFBCNYhNuNX1mjRFwJqqk-AkmRMbYYRej2YefRHBV26hbRQ2v-gP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:RlG0ZzT8lqWpi_eaSb6XDa08x76sNtcqTRbm2LuZKlAIWvZANIaraw>
    <xmx:RlG0Z3zeE_wAlzpGOTABW4Fx2yDuOSMDgtqcYHsX_PC_qIhmH7ZxLg>
    <xmx:RlG0Zx6_j1GU8Q0fX7J9OR0bM_2kMTeP24UsNUggO4z4fqTiLQQEPQ>
    <xmx:RlG0Z0zlLobbq3joJiURp9IBB2pQ8ZT3dQN46EiWKfdjEmf_qtKNNQ>
    <xmx:RlG0Z-lBxhKASl69iO6QggjTt3Tl5FJXAraVCry2fq_80n5nZ4S8Mon0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1f5aca6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:54 +0100
Subject: [PATCH v6 18/18] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-18-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The reftable library does not use any of the common helpers that the Git
project has. Consequently, most of the rules that we have in Coccinelle
do not apply to the library at all and may even generate false positives
when a pattern can be converted to use a Git helper function.

Exclude reftable library sources from being checked by Coccinelle to
avoid such false positives.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cd0806e1e69..83f1df5502b 100644
--- a/Makefile
+++ b/Makefile
@@ -955,7 +955,7 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 

-- 
2.48.1.666.gff9fcf71b7.dirty

