Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111611547D2
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611914; cv=none; b=YGUm5BrnL1sNYnrvMN9nO70k9AWOEfWXGMVdibd0lEeJNgNPy9OcwOhT6UyVZ3T23Kb5L/iceWNtaa/DhkXuAAgoVjCH6XcsLFRcoC/Yrm9myif1bZzzTNvIuPrJAx86YziGFVMvKXtoTqoqQfbe/gRLSko9eQjlyYTOBuNrW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611914; c=relaxed/simple;
	bh=QaUqkcee+mhUIBaIVnxwp7y6/KwI2RIEi+p+V7P7z2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwkyjVHSjhl9GwsUfe+zHteyhAhW2UcsJ7u3vXy0TzqliTFMrHBXl0ph3tG0nalPkhDeDB627RX3iMtxXmQREpf6bQXgAaHjEz0HqUp4CTlPRP4HfT1H2BacRI/73RgfWeHFcPNwhfSTQph4gxjm/BUNdFHuw6Ss4GxV/ikBFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BCZUtIQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLqNuqpJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCZUtIQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLqNuqpJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D5EB1380363;
	Fri, 30 May 2025 09:31:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 09:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611912;
	 x=1748698312; bh=JzT0xx3uSGDfvRkWQPztJVX4bJJM/LXq80wTvHV6IZk=; b=
	BCZUtIQ+2PgGxTj+4CQD+JyDoaDQCrqgwi6yGDf3imDWwuFSJNj7z3oa/jXlBBrg
	5wUjC9ZEs2+Fz8TI2eTcDp12a6RnanhlMcyOm1UnHQyiOSZEcYSBbk0asA1O+YZz
	W2EwwArlzHS5vcrXDuUuWssjzOIJ4XB/rbbLg8xRe5D6zyYVKhuHADlm1kC6+MnR
	XgNjP+sO8jv2sB3eSL8XzmyEIhljM9w1QoqIFcp02nU+2u2JgOzX7TMpjrRm66tp
	QdOCca+kshS9okU0WnqEsM7KwBpdMLWEI62JubpWGt2IondBDYWET6jEGusMyyRB
	ueZTVlkhiGwaVlmOC0E0Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611912; x=
	1748698312; bh=JzT0xx3uSGDfvRkWQPztJVX4bJJM/LXq80wTvHV6IZk=; b=D
	LqNuqpJkuAPqyZwE6/tHfR3Iika1w4XHtXg7kzBQMmc0N5a7IAHdlL5V4KF+c8pf
	jS++oLhuj0/k/wsrmQkaf9NLXejJ5OoF+BhryDJeODlIRs3a+6HZIa5r2DTASgWp
	2vqYg9aJ/jtByZFtLqR6vaDk7j0Bp/WKjD+FP5tlYDyj0xLGH+k0WlaS3L/528uX
	D71bpR4ihzPQO6G7rxrxwsM968tUec+XbjbgWWz6cCVIjAKK4Gah0v5Gutoo6Nta
	ryj9VjZGOWYYMW8RT5OQxlF1EB2HYt1bY5eZpbx8f5P4rqumlfcZuH1/lX06odqn
	JDeh7Ckuf9j0pbETG0Dlg==
X-ME-Sender: <xms:SLM5aMUqej9qejucokX_nAV8nZ7LciJKjeSrGb3bpFDDSPJ6g5_zuA>
    <xme:SLM5aAlQA1WhmPGM6d9dKeszYWJsjFduV41kMkphR12BVTUDjpIqTPdZ0mivTlwFx
    Ti3w0cT299C8MbCDA>
X-ME-Received: <xmr:SLM5aAaC_bnHm-U8gAQFzdi7CCqvDBn4fhXCFNpI0fvU1cdVEK_Sx1Pek-J6ZaXsS1M4qE4BC_ZX9ohUmxY8QU5NdFowRy1EbjrLyNh_4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigr
    rhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomh
X-ME-Proxy: <xmx:SLM5aLUsLUraL7jChCu47bjvlwfB2DWLPYyXhjpYAYyFKsoUOKX1yg>
    <xmx:SLM5aGlrhpREft5XifVrW_elYgYM7qfGCZ6VadN67hhgaKzmaee2Xg>
    <xmx:SLM5aAeubpWq27LVgNF462vP7atYPIOoN3ljpB4eMOKUvwndWcSM5g>
    <xmx:SLM5aIH0iwMcr7dOCTw96vvCrO7bxm4ewnL5dkYPh8h_41nMjUaJtw>
    <xmx:SLM5aEalQg7S-ZXOitz9VNfSivXQdwyRvhS_XIyrvDsHbKIShdv_PFWn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0e941c1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:41 +0200
Subject: [PATCH v3 03/10] t9822: use prereq to check for ISO-8859-1 support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-3-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

