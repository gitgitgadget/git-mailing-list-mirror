Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CE19992C
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990159; cv=none; b=nS6VDf7ky3KOb2nKFA+ok/zw9dsEn0gcTe6egyiUbEsVJ/RjarXzIRfqthw3vmNKbvT+ZBtYDL4JiY9bojvT+VhM+XL1uGOZEsRX8U//NssZO3Ev8wqsgp+oykybR/6IXgwS/i71rY98UboMNQU9mhAlofZAiaIEWHmmR7PUdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990159; c=relaxed/simple;
	bh=wDrZ5pv3VH+lJ50siYbyCcUVPaNhQclCBZ5PT3n9tgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omzAR9biyb0lqBBkOF4wCmL3Q7b41XXS76rtvY3v6DmdEuKdfvYtF0RBNn395BCfXGIEYfdT5zBeOAzN3IM68fydL9dlnHAOODS5R4d7X9aQbzcPAjY59Bjr8+IPTtCuXQm1BiP0Ai//C/U6RlAm/9KSYRcmNdv3Sp5g1Pj8ChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MB6tEvPI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G46SDsqs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MB6tEvPI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G46SDsqs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27A93140027A;
	Tue, 31 Mar 2026 16:49:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 16:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1774990156; x=1775076556; bh=4R
	YuXHB2/X/Z7j8nyDSK3IFeizEiXVkknXckY7duXyY=; b=MB6tEvPIDMddZWICNK
	q/hU7Qc35LjQt/7enMTU8yv0ubNA69mO8jxH2IHVYJg5/aCscurupusZrJ9Wf6B7
	0JHkUKj27NVAQsUgb7I88jxxKwHUCKdDf95a2eoKuNIsSQZvzE17WyVEdhBVXMm0
	32bDyinPMyqdwLvkLL3SAzIMi4qdyncRlmxoHKIw7ANP0MIYPCr5iIxuLu85Orrq
	8asBDVCYp62Ca5La1hogAWqywgnlTtig/dB78qqrukstoFGHD5ngljO+6/j26RpE
	pB6cTraAEscF9XXIZBh4q6ApgV55kCz7UtdiyQPk1k8EZsvUx74q2m243aUbfepa
	4/qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1774990156; x=1775076556; bh=4RYuXHB2/X/Z7j8nyDSK3IFeizEi
	XVkknXckY7duXyY=; b=G46SDsqspWKI5zhT1ds0g5LRzVXCP/hdg6O1/Kof2z2k
	m7TWQ4HKVFzU8AniNIEd42RCfsHbmD+lELP49gu0MBpQcMZdlXjrlMkD+Gp07X6p
	qQ7z+LvjF726Y/if3Wi581QCL8YaXNyZWUMnc9FiGYQVlB0ZwNo7HcBD8Zu846XN
	c8AgnYrGpYdjxJpNg7FN25Oxs9eS7jL6y8GNR1sP9lmpOZdmuz1NnPVBTffHgYw8
	LDBS8MBNoHDXhctNd6zMnr9zdpuLzw+hzIPDHY3aVyVWdP92xQ3wN4iSnmY8YFFc
	FwiChfFlnB9TbW5+gtrrF3PD1jfWaSyD2ugXpLcfTQ==
X-ME-Sender: <xms:TDPMaWsLxdM-Oz9yzqDt4tjXTx8dMu3BpXXT6p1kATlNzKjk0YzZItc>
    <xme:TDPMaS72nTUi5KTLVP7eO59R-Com5luoCB0DPAVYFKIlKZxIyW9qWnbWf3WyxyLRG
    hZy6nemud5zwPLCHuCCrlcyWVQ3HFOa7wzcQUhPd6dYKNetkEObfg>
X-ME-Received: <xmr:TDPMafItVcrAXn72P1VKFsWFixbkUhWbH1h54yAqjN-D9SzfC_QFhtdU4ENTGWeamZa1SESdHRyOdHwWw2mf-FABhkyc-sNX7xGDc6qwQeT8kp_q2li_HNqCjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkf
    fogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufe
    efffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthht
    ohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TDPMaa5_bs2DagDjXW08stE-Pn2m2bHOrauTCjJw3gHTT3eiTy-rpg>
    <xmx:TDPMaawsjMHgDdGlhcuhOUaj8vhd17qD8kUo9YqYlsqdIETvcrTDAQ>
    <xmx:TDPMaWYO87lvV-uEzJXlWskbS0pPHWRv2o5h2fHXruHzafMfzWe3eg>
    <xmx:TDPMaUTPR7N5NyRVCJdhuPXMNbMjeViSaL8zO_Azkoc2_toYoIocCw>
    <xmx:TDPMaTATpjS6gAAauhlRFWM94uqCo554abGtpv4S3k09HTamlzfhNgSq>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:49:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im
Subject: [PATCH 0/3] doc: replace mentions of deprecated git config --list
Date: Tue, 31 Mar 2026 22:48:07 +0200
Message-ID: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-config-no-deprecated-list-opt

Topic summary: Replace uses of deprecated `git config --list` with its
replacement `git config list` from topic ps/config-subcommands.

I found `git config -l` in git-var(1) and searched for other occurrences.
I have not considered the other deprecated options.

[1/3] doc: var: link -l to git config list
[2/3] doc: gitcvs-migration: replace config -l and rephrase
[3/3] doc: replace the rest of git config --list with `list`

 Documentation/git-var.adoc              | 5 +++--
 Documentation/gitcvs-migration.adoc     | 3 +--
 Documentation/gitprotocol-v2.adoc       | 2 +-
 Documentation/gittutorial.adoc          | 2 +-
 Documentation/technical/api-trace2.adoc | 2 +-
 Documentation/user-manual.adoc          | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.32.gf6228eaf9cc

