Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E8275110
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782237; cv=none; b=lXz6uQ63/wety63cFAQ3Sgc8EmXf8Ost6sOOKAAFn5aWS4EMhdmJ1jf4tquXuup++MGkpBng9PJxe7JaZpTrp3WYlEEUGktJ+SKhmEieawcckuBOso18AIIvmjgTEpgeA0coR8pVQh247NoKOyPn1eOa3mBtJsK+fKdBeSlURls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782237; c=relaxed/simple;
	bh=XS6ATJvv4dhV4USO5BkemvodvEdRTMizeafgOvWyyuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I88hMgUr8FW0jEaTvm/M9k2b280nnuASWgfVoquIIcCQeyxUpzSyCQ1XWLu78vBRdFW03cW8xYke5tS8kcsuZCg5CPMN8Rp7prOAzTGtlPuBRAiLXDXXdxjm/VQjwU7KYcgz0357f7b3pt9wLZ5gg/5Il66D0Ejwg3SqI4wKKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=me/vsYZ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHk3/Noe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="me/vsYZ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHk3/Noe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A61113801B4;
	Fri,  9 May 2025 05:17:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 05:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782233;
	 x=1746868633; bh=Hnrv9TrZ0kSR5UnBKEbPm9o3aiU7QvVp8wx8l+wmPmk=; b=
	me/vsYZ0oKkI/uoo1IbUFTD9XTERjpmShdYjdhJV5RIAWFCkbFg6VMPOqMGfdsPl
	IiZ1ty1NeK9IGy/wJcfJYb9xRS2mlzQqALy4NGkBT7sGcimDR3VAf5xaLhQKDLKF
	SZvfFiHfBp6xyoAcwfcQsi3WMJZ2g0acZ4co2R5eZycvwJv/ICKsQQxyyRWNl6dH
	k/D5Uax+j9htfHsXNAIUC/vv8OGq22169QwIH/K3mj9qCp8Sc2E0ZQebc26YmDPE
	9qopc2+1hVsycFGwhIcOSNz30lMY7A0rz2ntj3Y3Y/GMO67vECWTDDgkhzYHzflK
	k5rde7/f6Fk0pTpDu7ltAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782233; x=
	1746868633; bh=Hnrv9TrZ0kSR5UnBKEbPm9o3aiU7QvVp8wx8l+wmPmk=; b=B
	Hk3/NoeF0SIW5alHaFAWZeNy7GsXW6fhj3a0mTUARcWh/eoY/UyEu7gvwFTOJuHy
	BqKlphCOFYzDu+vffkbEeW8qQrpWKH5dv4QHGNf505aHnm5ls7dS1AQliHAurvsz
	5nhfNCRP6J+rt4ExW8qx+zWSL6lZrXZCPPeVLQMdy1esSVY/Av/5cHr+vPqkSr1e
	ZCwPtrzqfjGgmSizI/1GJ1GfaZaLbnDjoqtsfkeo9MX+8RdAIMQ8zi1qoRr2aiFt
	SLNzdKE3bl5fs5S4weNvWtS3QZKgamyJI0P6PMCXNG5W2TdoFIJ/Y9YbKP7xttSH
	Evz9zzeggcghaHwaKyNug==
X-ME-Sender: <xms:GcgdaOFn0EA5ydT_VwpmJGVDwMUYcPgR0O60njq3Bt88aBroMacncA>
    <xme:GcgdaPV8cv-aQRWS6dzr-mAjKGf7f37moo7wEci6hCGMetaLTomudKZ1URxJbqu8W
    _Utl7wGFa9PVqgG1g>
X-ME-Received: <xmr:GcgdaIKqPz8jQQCqxLoZRN2sIJbgHOzBf7jM40BQwMInZYr2zJ4Km69XQkrnexSP2rctNYbQlnXG1ZZvgVczfdcnp22cWmsAaoSZQAwQ6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmh
    hohidrfhhr
X-ME-Proxy: <xmx:GcgdaIHRB1Lc8hDcAw6Kx8yjIzUvMZCU1COQfXFRbe4X001K0FVhPA>
    <xmx:GcgdaEXevTDV8pswtD-zUQvygy-MdjGZc-PwlOZHBV5o7QgeubPQaA>
    <xmx:GcgdaLM9DJWFD1Cd7Y2E0hzFv1Zq8vc0REYc9IrInP0CDMD7GZgN7g>
    <xmx:GcgdaL2oRgPmdFvkjCfE0zsKe3RzLhCAl2w8PPOhrIjewL5jCnKuBw>
    <xmx:GcgdaDPIf88hp0l_DxR6otPDVF84jwNFhigR8-MIKpNk_QxRkenBV5Oy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc7edab6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:02 +0200
Subject: [PATCH v2 02/11] contrib: remove "examples" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-2-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

The "examples" directory used to contain scripted versions of some of
our builtins. These have all been removed in 49eb8d39c78 (Remove
contrib/examples/*, 2018-03-25), but we left a note in the directory to
make it discoverable that there used to be examples.

It is unlikely that anybody still looks at these examples more than 7
years after they have been removed. Remove the note and its directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/examples/README | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/contrib/examples/README b/contrib/examples/README
deleted file mode 100644
index 18bc60b021b..00000000000
--- a/contrib/examples/README
+++ /dev/null
@@ -1,20 +0,0 @@
-This directory used to contain scripted implementations of builtins
-that have since been rewritten in C.
-
-They have now been removed, but can be retrieved from an older commit
-that removed them from this directory.
-
-They're interesting for their reference value to any aspiring plumbing
-users who want to learn how pieces can be fit together, but in many
-cases have drifted enough from the actual implementations Git uses to
-be instructive.
-
-Other things that can be useful:
-
- * Some commands such as git-gc wrap other commands, and what they're
-   doing behind the scenes can be seen by running them under
-   GIT_TRACE=1
-
- * Doing `git log` on paths matching '*--helper.c' will show
-   incremental effort in the direction of moving existing shell
-   scripts to C.

-- 
2.49.0.1077.gc0e912fd4c.dirty

