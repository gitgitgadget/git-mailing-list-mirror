Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A018859B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990194; cv=none; b=pJktSKjowMLW6iX2cgVnsrrwn7US4HC7UOAQct5w7GbK5qFOTWi6IbsF8wp/jzzGzi/05MP4c4u3KVHZB8dmvszNd0CkO59FdeM9Gv2g9XHIGpjpcq8JdyBcaCW2RhPVxXxarEaeN3xxov8BDz/i4ce80Da/cZE4Aung+ODKDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990194; c=relaxed/simple;
	bh=9whc+oGoVwAsEO/2pQpik/u8J4eZUaDrCd9m/ydzVMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Ma3t7RKJ+NwQ/84MQOm1VAQiG+UPKTzzh9nc1Hlpi63Urr4RDTuWTqaVLHFRfdUOtACh2R4VnxEKIaHTGFEr3Fa27dUzRB9LvneGyrdir/TszhAGi/zT9zYu0VvzeJ7BU+EbCME2PcTlyAxTLfjEXpE9i7dnAJOEhywo9qVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F3v9Z9pu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQN6fyZw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F3v9Z9pu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQN6fyZw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B568B140027E;
	Tue, 31 Mar 2026 16:49:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 16:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774990192;
	 x=1775076592; bh=WEasrx29tPosDRMobx0NcOYcveyTtBSysJ22umr+a4g=; b=
	F3v9Z9puQFfmzzlxzx5aULTK8LCN/JVeW7G9BY45eCSnBtgSuvcwi6Vu65NTMXzZ
	CpLK2m9l3/orgR4e7Sa9mZXqcZq3lwicRBka6LgMCpWu3COuUfTqz4gyEwQLomAu
	NNbqW8vtpRJHGOLapBDXCOZhSV1mOXdaoFtbSoXxj4z78cVq8epXG2I0+CJoZJlb
	oNau8P16p/lID6Yii+OiyCFvPDjpdS4N4xIs/JKqkJ+NshLU7g8kr6CeGO4lt7+L
	HkOhBre0qKXrvxvRAEYKgZsVz2NSENv9OoTGH/Jt5sperAKes83eCL8jTBSjQPng
	SFiQ7G4z1Ofh+v1bgkiYrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774990192; x=
	1775076592; bh=WEasrx29tPosDRMobx0NcOYcveyTtBSysJ22umr+a4g=; b=P
	QN6fyZw18g4cl7Sn5gyHNrXG4kB7FXcscbXZ/vwG46vcwsXAomJ02zeSoGSaLl1L
	Ik7QMgzI6xvKdZvbPS7k6+NLlj+Cs0K9ob5I0ucOw8op/UXc5heNlihwCbscKGo1
	xrRwa1TevuSZs2iXy3+ZKj19QcEB92z7XooLvkCFrDFmQJzOop5j5gdWM+2cBUbC
	D1qaGeZJ0qJ0dSFRX/yNCO0VMXaE7085ANB6ec9l1kLUQ/n39rGQ57vzkHh972oo
	OtsimJFHIilWhFBSGIfJNOzN3FXhp0VGKcnXNo7F0c/fhjxIGDGhczcuoUhmg2Yf
	aCgV9VZJ0nTMDEPKfCmsQ==
X-ME-Sender: <xms:cDPMaTd-Vt3d5hBLB_aupFxUeViP40qebt8abh7b2i4ixDwveFMHt2s>
    <xme:cDPMaQofv7EXR9emjbY2qNrS2ITTwVResowCLsGDvGLytHW9hKkBW_YAV8xqb-_QP
    2cdNUbSBvcR8rSO8lF1mguvXyzGIg9Ba6bpeetOR8ntVEh1ZTmzmA>
X-ME-Received: <xmr:cDPMaZ47-eEhe4wVmBsTzTJsx-0s6BhRv1sfFaHMemrIb2e980um3ai8lvLETgRPsSV0FsmmjdJC7Jpf_X8yiUSTAeI3y3o2AKGSo8yizyFx-9h-5gUpacBqjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkf
    fojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhf
    ejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cDPMaerZIAVWuMN5TTWhaBt0rvCXv9re4qlIXfn_HwVcsjkISfAkjw>
    <xmx:cDPMaTiA3uzs3hauUSDVcxhsmMRnhu-p5iIXPP6hRY6OFdVKd-Ky4A>
    <xmx:cDPMaQJpIJD4uoOssT1rrqqCto0KCqcIS_o2ipwpFycAjEqT_9If-A>
    <xmx:cDPMabCLz3PcCzou8yv3V0Nk023nECnVG5wAPFmofTrH2ViSLIWyYA>
    <xmx:cDPMaQzaOMSdmqiwfctEeVsv5M5u68abOHHBBAehLDbTvESnvIM-_Hv1>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:49:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im
Subject: [PATCH 2/3] doc: gitcvs-migration: replace config -l and rephrase
Date: Tue, 31 Mar 2026 22:48:09 +0200
Message-ID: <gitcvs_doc_link.54c@msgid.xyz>
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

Replace `git config -l` with the subcommand `list` since `-l`
is deprecated.

Let’s also change the phrasing around the `linkgit` while we’re visiting
this file.

The Git documentation pages are both manual pages and HTML pages, and in
any case we already use the section syntax to refer to them. So we don’t
have to say “the _ man page”; we can be a bit more concise and only lean
on the preposition “in”.

And in order to avoid this double “git”:

    see `git config list` in git-config(1) ...

We can rephrase to the subcommand, which is a typical pattern (config or
option followed by “in git-command(1)”).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    But this does make it more difficult to find back to later.

 Documentation/gitcvs-migration.adoc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
index 1cd1283d0f8..905d08cd5f9 100644
--- a/Documentation/gitcvs-migration.adoc
+++ b/Documentation/gitcvs-migration.adoc
@@ -49,8 +49,7 @@ them first before running git pull.
 ================================
 The 'pull' command knows where to get updates from because of certain
 configuration variables that were set by the first 'git clone'
-command; see `git config -l` and the linkgit:git-config[1] man
-page for details.
+command; see the subcommand `list` in linkgit:git-config[1] for details.
 ================================
 
 You can update the shared repository with your changes by first committing
-- 
2.53.0.32.gf6228eaf9cc

