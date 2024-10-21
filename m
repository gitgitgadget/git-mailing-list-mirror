Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72601E1C0F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502887; cv=none; b=QuTmpXcAL5yB8QlqHnWLpqCGHdjw3c+moEYCSVcrvZxwquyWfS1t4i+WVGqaizaymOBA6K1W9lHSE2X0AAIpNyEc41BstN4HauycETg0sil8h8r3XYKnVm8gBPgemZvZMbdrELSEMJ5koMB2TrmFJz7RoJSvofZpy3goriWBDB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502887; c=relaxed/simple;
	bh=Twi7AEBQqAf74hbH/kvNX34VUXvwYI27PP5r3JgYuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnjbThVyR00CbDwVq4rKH+wzJWHrdmWACV7xV97GxWnBnPNG723fbk5otyMb2h6bklVuEtUfgms+rLTwvxiMnxd929EjAf/TFP/7YT96vO2lyaew/bLtlFsUJ2WpsAQN7MJBpSiIXKZPvVBaMQVlL6tWaJNPxGC50iNJC1vgEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=5CjSGryF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNezfQpr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5CjSGryF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNezfQpr"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DD2001380554;
	Mon, 21 Oct 2024 05:28:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502883; x=1729589283; bh=rJbuhdzqw3
	yVwMai2bTpw7S7lmDZqlwfMKSjNUuR3L4=; b=5CjSGryFCp5Ci7aXjAdg7enMEK
	0xjoTlZjPLyjFzTWExiadbnLXTGl/1/l8dzejO395WLdmtueNQVYRCMhlZjyoKBl
	C/LcgDlQw/NovPGNOsl10RW2bV8IJm1nfh8R93e5wPOM5LTcWloRoNo+v9Pin/M/
	9sey/71MVBJRIQR1uFPeItdD+zpyuGQmcS0C1L/0Z7skkiVMIrrTUN2Oux0pZOes
	qVthtFy6ZAkeWFQnAnsygUrcSgZMVl3XCROIO0g5DKCa7s7TeDyUQCjRuIvSmt5E
	ZGhWoxK+TtQIk7cQjIqTtf4MvUwtdwatF2PD1rFcMGfLoxkdOAq8v0v/K9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502883; x=1729589283; bh=rJbuhdzqw3yVwMai2bTpw7S7lmDZ
	qlwfMKSjNUuR3L4=; b=KNezfQprsUgnnSbC0699JaXQKjsqfdYL3yJY4kSgIm0Q
	KpZ0OiAf72n5D18kgPjlx5ncpADqfdAWZD2+3lGoynho6EBc5o5F0Xlv02T23LBA
	BTmcLeSZs7RetWaRajSx07MAN1HQKKZ0qE1SCPL9qQsiRokb3IoGu7Mu5siOtdYP
	euRbXjlAeXB2nTFsDBdlnvkvfZKx+wRs3gaz6JNfPjZLylONPpbNyNcTRSsn1tAz
	cTUWdAIa6/T3ff5uZbS3/Q9F9L2KoJ0r+sDVLli/V2gjwQ3zmbktP4o6L7wbugU5
	6qMogGIGcfQZ9aBLpXGaCXZjBFQ9da4SUW99EVTlnw==
X-ME-Sender: <xms:ox4WZ-xazoEnvY8v8WwRcSNcZCcIeebm97Zil9BSjEFREa7vT2GE4A>
    <xme:ox4WZ6TaEmx585ea2p-qRoemVWCUTu0jQyeu5D2-cXOicZXOgwBVPDj9e1Dy5eYHP
    Q7LJeU2bZqyGCKhUQ>
X-ME-Received: <xmr:ox4WZwXIBrNjzjMDJ5qthhUkheI4RgL-aHR-DYgrKne4HDA455Cqdh55ptToCkJP4dOA6MUHrDIxjSjsHCO8B8by7CR5vuxLBMbrMMiVXGPV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:ox4WZ0gUF1FkpeWfcWrTG6kq7cXh_bjhNXH_fOJo7sgj-oi2_I1NSA>
    <xmx:ox4WZwAXsKGFunQ51HRPkYz3wxfHbU0lO4lEePMti7pRV_Uw9whZqQ>
    <xmx:ox4WZ1JnisHtjLtql7APpvJeQgTxBn7VSDYOuBtHYDZrVKIYNhhYdQ>
    <xmx:ox4WZ3A79456Cd1_sFWg0A8pHlxLe2EEuCPrGIp5A6bpV61BndGp_A>
    <xmx:ox4WZzOlhatxHcrZtcY6MUwFWrtO13rDtIYKlUBd7xiur-v9HI6qa-eZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12efa2ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:36 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 01/22] builtin/ls-remote: plug leaking server options
Message-ID: <89b66411354437a1e3a97751f185889dffb84126.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

The server options populated via `OPT_STRING_LIST()` is never cleared,
causing a memory leak. Plug it.

This leak is exposed by t5702, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f723b3bf3bb..f333821b994 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -166,6 +166,7 @@ int cmd_ls_remote(int argc,
 		status = 0; /* we found something */
 	}
 
+	string_list_clear(&server_options, 0);
 	ref_sorting_release(sorting);
 	ref_array_clear(&ref_array);
 	if (transport_disconnect(transport))
-- 
2.47.0.72.gef8ce8f3d4.dirty

