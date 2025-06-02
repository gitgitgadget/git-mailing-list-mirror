Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559B14A60C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846698; cv=none; b=AuQdr363iiZYYHMLppHcQ0Ubjp/2IrqspgKb8iGUh/nBwgFXav3eZV78FTEWCeMsLJI3e4RFyWCzdzIqFQ0sIPyWRuxSxSItz4kc5jjDROtX6BxzyFUeN1stzmSCeYDNSQUxNw8MF7ES7xZI1dExsVYsDqYGyUKSCvEPDFJjI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846698; c=relaxed/simple;
	bh=XBDtTKeo06LwYBwW1gSFmvrgFcFlZpnmkfdqzXZtR94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2ch8ll3i1Cl3H8OpJtd/j9c0j9bffzkki7K4ZYVMyJ+XOPBjUDCQO5Ze8J7OZPosIpcDVzDD1eN4xYQltoMQMjUBhVHC3EyP3oMgc6WY7/j6jLPyfgwRsGLYSfNC6wfzb3Ka+E9HOD/yqwm59vecuLao61qn5FV4JjK112npqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BCLKJShK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bA6FbUQp; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCLKJShK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bA6FbUQp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 784D4254013A;
	Mon,  2 Jun 2025 02:44:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Jun 2025 02:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846695;
	 x=1748933095; bh=m7lTmdqjKIXSsEPst5syGD/jEatjcBVgWMolrwz5BdY=; b=
	BCLKJShK/v+gaI69oPM5x43JZhrjBVo6z8T3iy0gQ6F91VzGE16JeQTtvqkLsTDc
	6rJZV2MDKDqtMCoS6LnDReuI9nn5iEDeKm7bsOs9AV1c23EN8pMDrOyfUJdJpO09
	AnKEYXpOy1snEVqolm4pPgjZmiyTNaWvkg+78IoFgvGKgP0Ygeq4HBwvZqFyBz7B
	o3m83eVxqfu0fz36pXbSWiZTA2vf6VAkbVOhOdigEI/8jTmIhCoakXrMo7BAStkH
	ShTrcG0eNv8tFKuX2kaDc99ijmLlZ307clJNXLBql5OjtM3nLmPrNYclj+5hk7Z4
	xDZeg2aCWkX0gyv92TOjQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846695; x=
	1748933095; bh=m7lTmdqjKIXSsEPst5syGD/jEatjcBVgWMolrwz5BdY=; b=b
	A6FbUQpzeP5F/M4zW4J31Tocxs3wm+jf58Lm2NJyjLemXfewt3aIJUnyndjXdxuX
	u5xJ2yIIyPy0ZZNfLvcmnVrGH7X42R/XSm2Q9Q0R09E/mASc9NuCEU6cmAGs1m+5
	xnGVFTAXYYZlLR14WIPMRkHMQa0CuE1RelHkabxxPP7UNKWJhgpUwWdr/CM4cBFy
	Q5PjAgXGaYivC01kEaPJakg4mWHjXmuT3B3nDqCz1DJ8LR/FRBH7DI48vyJM0jzv
	0oCcxh0PR6XfY4qi5QajpYSzUBUlBy6Md8ADCs4SQjSccwzZaKXCRLbhqueWrzvU
	YQmurNZoGGP8BJMUlfh1w==
X-ME-Sender: <xms:Z0g9aKBJ6LjrzxMzVtmb0ZhIvJ0gYg6tOr-wRI6UO1b30C9x_ogtQg>
    <xme:Z0g9aEg1g1Smaesa5IRYUWPaSmLeh8tVGLG1lxAHLbZdWZFOHiuUtSQLGmLCPAgOI
    WHkhA0GUs9z11EXNQ>
X-ME-Received: <xmr:Z0g9aNm3fGMuxdOd8CVQg8dUkrumv5VrLER1osP7LXFLaHOYfhLqlsXY_1lkSK4wf39B_h7U74gyZwNwG0tuEGZ28BuU9Tbq5ZoOXIjq85P-fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhht
    ohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:Z0g9aIypNlgJrAsbFZs0swiS_nLdWzUvPLeVL3IWRwuQnkeU7Qu8NQ>
    <xmx:Z0g9aPS87ZyxbhACVysD9rb43uwIpXgf4e5jpo9QQpTbVnkds7slMA>
    <xmx:Z0g9aDZI07IZ2Ya86uDvgzU46sCOk06ig569Ct_9QEWDGrmjLtWgeQ>
    <xmx:Z0g9aITUO8_eOMzYQ6oeyFUahNAFZenyJZzvFnouJcsa11boi4twMA>
    <xmx:Z0g9aHmJpBWLpe6CHo557yJAnm0ApfG7zlTy2BewiFqx72kT_m0wYg69>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74e5908d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:43 +0200
Subject: [PATCH v4 03/10] t9822: use prereq to check for ISO-8859-1 support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-3-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Tests in t9822 depend on filesystem support for ISO-8859-1 encoding. We
thus have a block of code that acts as a prerequisite -- if we fail to
write a file with an ISO-8859-1-encoded file name to disk then we skip
all tests.

When the prerequisite fails though we end up printing an error message
to stderr, which breaks the TAP format. Fix this by converting the code
to a proper prerequisite, which handles output redirection for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9822-git-p4-path-encoding.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index 572d395498e..e6e07facd4b 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -7,12 +7,17 @@ test_description='Clone repositories with non ASCII paths'
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
 ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
 
-ISO8859="$(printf "$ISO8859_ESCAPED")" &&
-echo content123 >"$ISO8859" &&
-rm "$ISO8859" || {
+test_lazy_prereq FS_ACCEPTS_ISO_8859_1 '
+	ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+	echo content123 >"$ISO8859" &&
+	rm "$ISO8859"
+'
+
+if ! test_have_prereq FS_ACCEPTS_ISO_8859_1
+then
 	skip_all="fs does not accept ISO-8859-1 filenames"
 	test_done
-}
+fi
 
 test_expect_success 'start p4d' '
 	start_p4d

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

