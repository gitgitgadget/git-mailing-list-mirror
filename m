Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24717A5A4
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687606; cv=none; b=lvPHU+1aVLXTDlDZexCTEOTjoUI/xnLzVYJvDNGmKHwpWvP4J8hGjRTxDH77HUTisMiwHtHpIHO6f/73LX/ZCgSfQj6UCimq5CjMXB6vLanb3poddllYEpOfKzWVJGDrU8yPcuNsv9mtU0rJfbO3A/9Ksl7DTAbzJGKQZuJwdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687606; c=relaxed/simple;
	bh=W9psKAvuz74AsfRxjWpJZbr/JtwTbFs+uy3iQ6niIXk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9M+45s4ubT6gpcU05nwG94WfQjbkScr9k6kyUqZ0IuAyWnEKNNd5o8jDfTo91QKPmHkoz1mv7Wh/rt4vmYIMLmCH8x1J9SRz46xXSw45ZrZKYFlJ4WmYRdgQrctSIWT/BRUhjvA71jBNslFbZLbZGSemEk6MUX7RFqYR+Wd9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N+S5IxXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbUjC4ho; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N+S5IxXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbUjC4ho"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8144C13800E7
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687603; x=1727774003; bh=Mr5lakhXG6
	HKUlD9w81t+IlvQWmoV5y8xTZB6taOt0M=; b=N+S5IxXbTe/oTgSDhnEYGeSwZj
	1vmDfO0kv+wmpRL1lzdskzPuvd54FRIpUkm6mViUw5tT8ywTq/gTN03b3EGrebDV
	U8N6mXmrMW4nfX5vrjQG/dERwgxZuXS5CSWFnXOoQEZHnw8Xek+rIXU1C+eJpo42
	yYAorSoJYsY0YgzYw6m8F4W78VEdJmR8LYviPvH2qr8rOX5mQfYM+DZw20Dh/QWz
	MQ1VUJ0z/6glXy7O+V6l8eOdgCgBrldrjWGCfOKfzE56UxfCw/odHGMT5Y3bwH7t
	E+mge2gkFq4H8OsWQ4sjNLxgIxn4yf05mRaMB8CRkgJkbkftcMpJvLeHhFPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687603; x=1727774003; bh=Mr5lakhXG6HKUlD9w81t+IlvQWmo
	V5y8xTZB6taOt0M=; b=FbUjC4hoihvSCrNv2Pe1BsciXEUDZj6YKRCwHPcGS5zQ
	T2BfAhbhz9mWHzNl0bu591e9no7iCIXwdd15McvCT1hGWVNkREFXHuzxqF2rLUnz
	74tonD4/0+MAlZL5Tq0vxPRksKBvV/qivaWhKg1p/CWdXKy48h5agpo3ZvxOEiiH
	G7utC2WFtMINHrAPFF5fTioVav08VZEbbH6EoWAXcoq4hcXcMxIAtuONu/7mOAtO
	QZZtcrjxgdMjP/oXUhg/CQGp1vAGtuFrORCy/LQjydcMki8WSfm5WWb3MyI2wmyX
	cCq4pd4ExYilVv/hAnHgJYVorT4jMx1xmO1X7aBB/Q==
X-ME-Sender: <xms:s2v6ZkZ61NfGHHnda4_pVKSXAHm2egHeC39xBqGB0vfjmxw3b0PwOg>
    <xme:s2v6ZvYP0X8Mzpq5X3SUu8AStog6HbmGPXt2a0wzOLGKsP4o3fkVp19p9oDdP_tLi
    zwz93VIUYSdd69seA>
X-ME-Received: <xmr:s2v6Zu8ng0K2ftnW8FbGWLW4Af7q9NF5EtdKCbW79mj50o9uJ4UDgdH2wa5gMzXgX9okP5GN1Im1u743Nb4yNsza-iFzRNdipEys-G2xqzn-Afc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s2v6Zuom8H5GQvF9yqDHORTrhNSStvqfPDUWLT0CAT0jonfnLGKtcQ>
    <xmx:s2v6ZvqRMte9fMIYLPoLiT5ceLe7ORoRGGzPU8bYuG3wBAzxO35E9A>
    <xmx:s2v6ZsRfDe-Sg2qmMZX076h_pMAHFM9by2hDw6Do10TWyaMuh-ysIQ>
    <xmx:s2v6ZvpvCYAbJ26MziEgHpNKJfZL8iTHsKe6C0qsIbBcq_kNvCG10A>
    <xmx:s2v6ZoBlSZYb-2GC9c0chzhfSjoXltpdNTO2wwnPvTdslYZr1jJN_9x2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40d378ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:36 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/23] scalar: fix leaking repositories
Message-ID: <fffd1c0ede66caeca677eb296d5b2be9664d666a.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

In the scalar code we iterate through multiple repositories,
initializing each of them. We never clear them though, causing memory
leaks. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 scalar.c                | 1 +
 t/t9210-scalar.sh       | 1 +
 t/t9211-scalar-clone.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/scalar.c b/scalar.c
index 09560aeab5..ede616ad4f 100644
--- a/scalar.c
+++ b/scalar.c
@@ -732,6 +732,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 			succeeded = 1;
 
 		the_repository = old_repo;
+		repo_clear(&r);
 
 loop_end:
 		if (!succeeded) {
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index e8613990e1..a131a6c029 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -2,6 +2,7 @@
 
 test_description='test the `scalar` command'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 7869f45ee6..c16ea67c1d 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -2,6 +2,7 @@
 
 test_description='test the `scalar clone` subcommand'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-terminal.sh"
 
-- 
2.46.2.852.g229c0bf0e5.dirty

