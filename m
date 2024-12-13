Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8C1ADFFE
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079751; cv=none; b=gXWQi9hcVbBqE7qO3p/e8WpTPPQ9xg1uTWsFXyMgdNnjHTAwkPsjKDk4FiDohcY/3PmF2O3xUzf/xxU5o/ZmregGWGDQkzz5w+kNxDAUL0i/b5ta6yfIbdoSuelRBV1/grFp9/jHIFbKafk6MmsVKVRlnSh+d7bQieYtnBYec6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079751; c=relaxed/simple;
	bh=jj76hJcYN2Q0VZSYaalBq9S8XZGjzwPt4WMXSEwjDZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWTo2cxgNXoWJVpq3FOx4pdxdKguiUSGt3ZWUHk8he8N4KGcgOOe/xsoY9SwpNk3woA0iqrqodwB+wuXGdtp7BGmHN9U+QemtV5osRhzuC9KTTEcTFl+0lIktVfvBRac+s/IaPxqaTxwmTyzKC/Uy8MAk7iIG1KYxGK5NE6UvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KnY5WifX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lqs6JqVL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KnY5WifX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lqs6JqVL"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 26DD31140202
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 03:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079749;
	 x=1734166149; bh=zWz19JP8BJXOLM2QYKE1v5mQ++dbiu6ZlJ7gTrPUmRk=; b=
	KnY5WifXRb7vP11JdgoJiSA8pCtAfqNxwW/1rJXqKbCwnKVMMHjWdYRyO0qYyeOV
	94AXz8wyXZggV8ArfkqJghUJ1d0aDakEc/VlLEyuhRAfJfv+QP0ChXoNYOdOlEM1
	3R0n42V5He4XhikObvjHLHRWU9VbRtvydWi0uYDf8mPD01977KMXHK3GOG02AyMq
	rUgFFdKgYNR/re+dspeEkjo1347UXvnSA4bVbDuA2RONMdDTxkEe52DouPb+iQch
	UthN4yPemEXZrFrncPHwpapm2CjUnSdLBWaGcF0XIzPDrVZeeYAxSC3OVrT0xUiY
	AQo8116zuhagoOYxY66u0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079749; x=
	1734166149; bh=zWz19JP8BJXOLM2QYKE1v5mQ++dbiu6ZlJ7gTrPUmRk=; b=L
	qs6JqVLPPkMPEng5k4kLDfPkniOwr0+SXMtQizCszb9Q2XIdQc1fGpnlwtVk4AB3
	MeKMXLKfGFD6L2ox9v8UXdyP86TpgGb0p2NU1UdCmnV4YsSIBLRMnBo4BAbOI5Gz
	PbL8pi6HLCkEiQdfprcFUxEicN55zh7UVfU1a4sV5a54IlNt0IRl7jodFKcDC4QW
	nN7HfJWrO5Kpz9BEdWM7WsdLFNZrS6DqWejJtHENkpztit8IlAM9iQCz6ce3cfnw
	NQjcYRVdH3eH2jTaXq7ae/nBbdXkvqyAJwHEMly9ambXwVRYpRY8koUi78pBpYcb
	ggn+r9ElTAxws40ae5bbA==
X-ME-Sender: <xms:BPVbZzvY41NeKQcSWaeKdX8S7TCQtCb_vgYZ5EiAidwluUW0JBHKNA>
    <xme:BPVbZ0cvojQA3jyjTzj_97ajT8bUa408hjbojFiHzUCmS6Unwr419YZTw_rz1dq_D
    DDDV85rLVMhEWr-Xw>
X-ME-Received: <xmr:BPVbZ2xDXD5aGdoT4U0VtTYsoc4WAkQVWFhCPJVavk4bQjROClVIaFdNNaelDq8QzwuJVUFl9GcSCPyxyruuVzt7Ul9U4JVa1eTJdksr3uXjYIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BPVbZyMpT4aHLlNZHiPJ4HxjTTvUsOwFef1zG04k_uUXwIy-zmRsnw>
    <xmx:BPVbZz-6MdG4RxryuOzr9teEHEPWhF-_0ggicig3KTkLAoxhw38ZHg>
    <xmx:BPVbZyWDe5TBppSsUWHyGdA13xP8wgeQ_tJdFriEUzDZ-WWnPwFVeQ>
    <xmx:BPVbZ0emI5-h6cASNDtrqX6YmF8qjNslg7FTVuWa033Gh3AEWF4c5g>
    <xmx:BPVbZ9kVJ0Uj6xN64_t5m0qv2VTGGYPnlSNTwWPD1r38RRXJ-k0HFYuG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b27359f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:39 +0100
Subject: [PATCH 10/10] meson: install static files for HTML documentation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-10-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Now that we generate man pages, articles and user manual with Meson the
only thing that is still missing in an installation of HTML documents is
a couple of static files. Wire these up to finalize Meson's support for
generating HTML documentation.

Diffing an installation that uses our Makefile with an installation that
uses Meson only surfaces a couple of discepancies now:

  - Meson doesn't install "everyday.html" and "git-remote-helpers.html".
    These files are marked as obsolete and don't contain any useful
    information anymore: they simply point to their modern equivalents.

  - Meson doesn't install "*.txt" files when asking for HTML docs. I'm
    not sure why our Makefiles do this in the first place, and it does
    seem like the resulting installation is fully functional even
    without those files.

Other than that, both layout and file contents are the exact same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 1dd84af2d6bcf3214cfa1ec78c00359f64040fca..751d32c4847289da5dbbe63efbce309d36719f4f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -382,6 +382,27 @@ foreach manpage, category : manpages
 endforeach
 
 if get_option('docs').contains('html')
+  configure_file(
+    input: 'docinfo-html.in',
+    output: 'docinfo.html',
+    copy: true,
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+
+  configure_file(
+    input: 'docbook-xsl.css',
+    output: 'docbook-xsl.css',
+    copy: true,
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+
+  install_symlink('index.html',
+    install_dir: get_option('datadir') / 'doc/git-doc',
+    pointing_to: 'git.html',
+  )
+
   xsltproc = find_program('xsltproc')
 
   user_manual_xml = custom_target(

-- 
2.47.1.668.gf74b3f243a.dirty

