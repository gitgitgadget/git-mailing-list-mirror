Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E571A0AF7
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079749; cv=none; b=Sd/0qP9pg3nNEsoq95Vzb5BjU9wCrXoW0xPtPHh0RKPVcQ3PzDZhETrC09jJPo1SAGv+OsNkvA00/vRDD9KiBB6YI6YQlNK5VcOKtIo0Xjk3y+AjJzMati6X1jDJObaxRtXKY2gAOhYP9UiVzquhk0B674+EXRJGyI3kE8dDZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079749; c=relaxed/simple;
	bh=/nO8gh5c2FtG9cLdwUKkZ3ViI8ZkP/ikJ0rOEdnfhf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pA3qEdYCj+ijwOoNzTvLoNv584YqP+zvsevIZC6b66sG1tU+nKL5+A62DzOkccAAzYB5Mnqd4aIvun+bV7qVlYLnEC+1vxknK5g3dbT59Ez4s8C00ko2z5TmCq2/L5FJdndV/Fy+J0mH8+HclF76ywiHNT45sgcYe3PbmL+ue6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RwLD0WNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkBznEBr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RwLD0WNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkBznEBr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A59B411401FF
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 03:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079746;
	 x=1734166146; bh=QL5h1/IWmpyT3u2Z5dFHBbts4QXWIECKh0IijlRDPO4=; b=
	RwLD0WNrietmK+uUZDZRRnWe8M84s061qog9jMacevjLbu00Cr34Ayrz86nsVlqi
	8h+H1X3PewD2fu6BRCUBTS4i2yPQ5h2sOQk0oTJWzX3STuHGwvVTdPO5VdHeeD8W
	2m3HQG+y05qMFOx1Mr9bixxa/h61hggYfi5N/fbB3smNVZulNzlftPOpIU0IMiiv
	sjIHqrGn90vTLXSts5s3e+v5q7KX+X/aXKNxGLseBJZ6UP2NnR7oy8EgNsX8b9Fy
	/BLiltyM8rEfMOrebpmeBxRLSYhelMpfe70rQ40YFixFLSgVcrcdFxonAGDbXCbw
	4FSTUXGtfA9t7V1O5+nL6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079746; x=
	1734166146; bh=QL5h1/IWmpyT3u2Z5dFHBbts4QXWIECKh0IijlRDPO4=; b=l
	kBznEBrs6QfAFo3JQH4/pq3GCsCJFVz1ngg0m6SUKD38+PY7DnLr1f1pNHTW2ZF2
	GTZmfk78RLon7uRN2g3ulrg6KyRsvNyBBWzWPe7HJUZr7L3gQWK1GY1Dgf1C9078
	jIBT3gPCWYmlUYX2Bm4a2tqyIJVxu/Mju+pQpaDLdjQ5+K6iOXzWaOZX7aCPqF+F
	MdoEUlyEG1dYhD+Q0wZAayiQw+MEBu5pMIfu9rMw6qJfEGYsBiCFfwzOs+X/3Iss
	qB9z2wnBps2YHcT1qr2HIHRULPMg63hcGXb9EJ7Glyy3KI6JQS03d+MpczEeojtr
	mYWkkjG9i5n1nXjDThJTA==
X-ME-Sender: <xms:AvVbZ4ETIw_ifiOf7RyzvdoW3AIiHYQZrT-10xwyHKBuol3VDCH_Pw>
    <xme:AvVbZxVQVxbh_fuso9oJw8KCh4uTBNBe0iL28JemswYa_NPWJvnJbJNNbwsz07LyQ
    6Md8GSLZI7w9lgurg>
X-ME-Received: <xmr:AvVbZyJP3PXqi2ZMW2rPNfsZQr6v-gijnA50MM8kCtvhfPIF9pk0Vqu-E7xwdY78U8sgyT74_PIcR8twF5u08WZKGBxLA9aYhFbcdcJq1mbEwZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AvVbZ6GpIVKAd2LqA5d2tmtrxNixaWEY34_ZppBXcZV1gknqkl5sKA>
    <xmx:AvVbZ-Wja3G5Re5uFhiibKU5z89yR1OsgIDFYEVWhevXourHE2-EMw>
    <xmx:AvVbZ9MiFy7__44W-jP-8z1CxIt_5J-u0iC-IqMPIQZxNEsTgtGdGA>
    <xmx:AvVbZ133RPB2UuMnLG-XVC0xGd582NU3YGSL4D0izSBXUK9JJlAdHA>
    <xmx:AvVbZxfoTR2G36SZ12J0ufiYlef_Df88MWiPw5eBjOcjis8igJMRjYUe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51b049f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:32 +0100
Subject: [PATCH 03/10] meson: fix generation of merge tools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-3-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Our buildsystems generate a list of diff and merge tools that ultimately
end up in our documentation. And while Meson does wire up the logic, it
tries to use the TOOL_MODE environment variable to set up the mode. This
is wrong though: the mode is set via an argument that we have fixed to
'diff' mode by accident.

Fix this such that merge tools are properly generated.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index d23ed82795026e511379ff1e77355d2ec33ec499..0d8b58145274c7854fe3fd91de469fe9d1e0bb6f 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -316,12 +316,11 @@ foreach mode : [ 'diff', 'merge' ]
       shell,
       '@INPUT@',
       '..',
-      'diff',
+      mode,
       '@OUTPUT@'
     ],
     env: [
       'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
-      'TOOL_MODE=' + mode,
     ],
     input: 'generate-mergetool-list.sh',
     output: 'mergetools-' + mode + '.txt',

-- 
2.47.1.668.gf74b3f243a.dirty

