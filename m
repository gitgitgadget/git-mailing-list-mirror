Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AB18859B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990212; cv=none; b=nFjSOkTzrOPqeA05PJ/767IBcblKedHC4jyon0Pz5VXQP0AksQf4AMv+EXZVCTDT6MU4e9Bqiu4N6qul0G+Rtrf7w7WTweNpcKyCTF7TQGnP36+TMyF5+KzOHBOBO1SR6uc9lR/9/2dURTtyXslfJatsOpQEvWq1zKr4q+anrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990212; c=relaxed/simple;
	bh=i0uCyozKWTYW6NklqOhFnmF1gbjXTFq7oY8vBSqZ/ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuZmAHIgo+7LMM9r9f167JBRXZAeQaPds4jgpwGbWM2bHMhYchlFfARKWvi2AAQKoIJUb7LfRAJMTlCKdDaIwD3FAm/tGC8UTTxmh4X+Pu011Gw8LcBTr3wvhy8x1IhMuQfUSXUs4EdTtcttNviLEL4OY5/+fBrebjqA4I0bsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IxGB29ha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXsmxcR/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IxGB29ha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXsmxcR/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F5AE140027E;
	Tue, 31 Mar 2026 16:50:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 16:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774990211;
	 x=1775076611; bh=ydGdnEOi/pc4v9b7Y2ivXfE97T8IG251iIXlUfP0ZzU=; b=
	IxGB29haQgqP0znNnZ6f9vLCh5X17A8XVn5O/4JGdeno3ustspzfSipweDI9XDPN
	PFsuAxN97LLpA7WRIuwT7BHsslRpTm5AV3Zgi/CLv81mMe9X2WqMol/3gjgn8GM9
	CBDHFkZ5cujOUWPq1t85kzShUz564bN54fFlyNdRScB0N2fpyo7qH2ZMXOtXFGlU
	r2PvUq/MQAsNGW/M5x5wBq5TCV78yv6kK22Bu+ik1Quq/3YmZ9H3wWFqvG3Cv+Wh
	eD4dBB2oI7B9Skxn73pVMPUoPGJm+d+yecyGMo2EcxbaKB2KhP9AMtK/pUYnDvOn
	O0z7zS2BkEOfmdRzQnc1mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774990211; x=
	1775076611; bh=ydGdnEOi/pc4v9b7Y2ivXfE97T8IG251iIXlUfP0ZzU=; b=L
	XsmxcR/1G1fjqhgbPd/XzFTnbZG0Ty9exspr+KdfrUrzoEFrACRkYOektXX4Ve+I
	BB6VSyypDH4b9T849TRPSoT/qS9/Yn0YOMMpKsf6sDxdtBRcXiT1dAk5y+SrgOlr
	z1dqAWVNKkZWcnbmHPaPIRD1o/FcvsUxWQEFDvfc5hIdtaJG0BF3RjwKYWSXhVjp
	gxPSxKnhRQCAdfeXEHlVd/nBkeusGxV28wBn5pWa7Z8CofFlypOU01c9cK5S4CcC
	dCNMYZvSStQUfxohazxK3008WhxtDvKgH9xik8OYbg39Hb77M2CQKPcB8WLchvI8
	9HdgWqSYwp0bUwZY+SElw==
X-ME-Sender: <xms:gjPMaaKBct4FNrdi5aJT3_sJJvh4qQMBpQfmN9yARyeb2Dv0HxGVykA>
    <xme:gjPMaZm1YkbYFGLWj25i5cRxfuOBuKeR_0yneNqtPgxcAE3Hg_oRwthXaUezJJeTh
    0pgopplXCZXTp1YAr7iqLhBWBTCg8Y3DTKLBi5DIbyIOEhym8nY>
X-ME-Received: <xmr:gjPMaYHQuPI7yt1xGN5cNc9DC9YUju2e6X0PVCpdEQs-qk7w1LnRUDzXgidUidkVdfYd5R8qi9_edgD97qg3YnVSshbOdPFJuUiKmzx8gHAiz2yBbnAMThZchQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkf
    fojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhf
    ejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gjPMaZEwu2EBFn78-EmnRFKD5Cdtl_SX4Q-f_SGJHZUTVIx61XdGtQ>
    <xmx:gzPMaVNvY7iaOTbPtO86eT-xQ4zbyqnDS-vkYks9izcGij_GobcQhw>
    <xmx:gzPMaYF5cH1axvtOnrIU28Gwr_tcZ2A7Yo5UP7ARBsr77lFU-gS7Ww>
    <xmx:gzPMacOrzMSUe74ynjKT5kjLCh9t-gqbBX3BY9ho9YacyUps_PvDyA>
    <xmx:gzPMaRvkzap1sDeRS_xclRBaLLSuHO8o3Uvrsd7Rd2zb_wOtLM3_u5vy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:50:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im
Subject: [PATCH 3/3] doc: replace the rest of git config --list with `list`
Date: Tue, 31 Mar 2026 22:48:10 +0200
Message-ID: <doc_config_-l_the_rest.54d@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Replace the rest of `git config --list` (short or long) with the
subcommand `list` since `--list` is deprecated.

Note that we leave the “man page” phrasing alone in the Git tutorial
since it’s a tutorial and not a manual page. We can be more wordy in a
tutorial context.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/gitprotocol-v2.adoc       | 2 +-
 Documentation/gittutorial.adoc          | 2 +-
 Documentation/technical/api-trace2.adoc | 2 +-
 Documentation/user-manual.adoc          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index c7db103299a..ec2562fb0a1 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -659,7 +659,7 @@ use by the client, MUST indicate prerequisites (in any) with standard
 applicable.
 +
 The advertised URI may alternatively contain a plaintext file that `git
-config --list` would accept (with the `--file` option). The key-value
+config list` would accept (with the `--file` option). The key-value
 pairs in this list are in the `bundle.*` namespace (see
 linkgit:git-config[1]).
 
diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
index f89ad30cf65..519b8d8be2c 100644
--- a/Documentation/gittutorial.adoc
+++ b/Documentation/gittutorial.adoc
@@ -432,7 +432,7 @@ bob$ git config --get remote.origin.url
 -------------------------------------
 
 (The complete configuration created by `git clone` is visible using
-`git config -l`, and the linkgit:git-config[1] man page
+`git config list`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
 Git also keeps a pristine copy of Alice's `master` branch under the
diff --git a/Documentation/technical/api-trace2.adoc b/Documentation/technical/api-trace2.adoc
index cf493dae03f..918e517c2e6 100644
--- a/Documentation/technical/api-trace2.adoc
+++ b/Documentation/technical/api-trace2.adoc
@@ -1253,7 +1253,7 @@ it.
 $ git config --system color.ui never
 $ git config --global color.ui always
 $ git config --local color.ui auto
-$ git config --list --show-scope | grep 'color.ui'
+$ git config list --show-scope | grep 'color.ui'
 system  color.ui=never
 global  color.ui=always
 local   color.ui=auto
diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 76969871176..3cd94c7afa1 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -2865,7 +2865,7 @@ stored in Git configuration variables, which you can see using
 linkgit:git-config[1]:
 
 -------------------------------------------------
-$ git config -l
+$ git config list
 core.repositoryformatversion=0
 core.filemode=true
 core.logallrefupdates=true
-- 
2.53.0.32.gf6228eaf9cc

