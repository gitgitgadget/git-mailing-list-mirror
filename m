Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBC1A3AA5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140587; cv=none; b=QB2oEH7cf2566Qu40dIteOfXuesC5kFCiYGMKoYf3Rv+lYrFnONcv3jAZ7ZB+s8Bp/Knq29VbAJKo2hPhm4+N7AR08AWljhQnMcKDPkdiCTrCLAAt1hp2i8XLVs30G9/hxwekC6hq937HTeqSV4IenZB3bWcM5kKvKFVcOvyA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140587; c=relaxed/simple;
	bh=CzQ2aAxrfKSjRqcRE1Xy/vWeWcIhl2V2WYhEwkT9crs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPwAVQXUW4TWVDNY4PxTmvAVCoLyxA8S4aVBpvDT2gRhcZ2NpbSukVKLoZvU0/oBdtgR5HVqFe/eoxKOKFD2q4RqcYmVX9ndPE9NEwALMfDnNVEuCWLR8rjyEXeFAWUl/L9A0vJpzsjn1S31AFsI9XPZ23L8gczmkUdxW7EoBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QBXFHfQm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Au5aiYGc; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QBXFHfQm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Au5aiYGc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A02D011405E6;
	Thu, 12 Sep 2024 07:29:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Sep 2024 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140584; x=1726226984; bh=aax87Yuv6K
	YGoHaOjvEGXCaJHy/nYHDTQF1POz3vPcI=; b=QBXFHfQmrqPsRb9Tfc5b2CySev
	v0l5KzmqWbB8lp7dfZ+oGAdlaZbZ5OKjE7/PEUC/Bwym7DQC0jtKnNV5AOYK2KpI
	FwO/HXcf0qfOECDPkMxRsdNdtTW0NzmllTipJuMaUeQaEBM6S+wqCO8UztAISrvY
	MT2iEF1zffV07JdL0AvmZXP9aW262Cfv+t7yc/cXnu34vwCG9JaWFLB/+T2twEUY
	hIJ9+HGyVlzLQetb9F2cdmAJOI6yQFqfYZuaN/L7B5TgRPnQF2nTNyJHBvyvbRQ9
	o77+P+LDDT5bfz1ebGnGhZ1hJ4vI8X+j/qE6vzzSZKZNHsAOj7jT4pUkM/zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140584; x=1726226984; bh=aax87Yuv6KYGoHaOjvEGXCaJHy/n
	YHDTQF1POz3vPcI=; b=Au5aiYGcs2bURkBh3vT4+GHiPY7t581aw0f8c7GJ1S4o
	ckqBEXMWpJDzMSvIWicPDr/ptvtBPa0eNNwc04Q7bKLClGVoVJo/31uHU6volwnl
	tMRwG3u32mKil4ZH1BLP1hPKlnS/h0RWkQTTdwqirk+SYuS9lPQoWLr6a4YVGXj5
	XcUivLLQvvbKIQ+VSQ8vcofp3Yc8xLKSXqSZ0GlM2z6ZHZQevBsvF/NO6iQbJw/8
	qW1WMNbQAQT1rqItEXrYK4yxx5CsKbb/v3T4YToOMm7KKtcFaBq69rQTKZiDbDDU
	TnN0P0S2NrYx71VTSlMs/Di/SLpxrrNp6AoU0frQZA==
X-ME-Sender: <xms:qNDiZnHGQmfdSxS4gW6UpXUiVYQSeZk5cKGmri0ElEWMOBv-rliSDA>
    <xme:qNDiZkUg2itpxS2Nw07ghQtDrWObVhGuF3MJo4rL8qscYGmNvf0E_gJXJ_EanIVVe
    YREe7vw6JHYNQTYeg>
X-ME-Received: <xmr:qNDiZpIT2jHtXs2jAPVU8jRrBxXMQZ1EzqKLLTS6Dz_aOPNbVdU4115IvdnDSJMd5hpc0iLzrm8JLsF9NIQ0AWcoLkngfzlzC6xi6A-lZok_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:qNDiZlHt6hKyXfxUneOsl9m6UECsspVwO60V3QmbZ2NyCy8ImBDK2g>
    <xmx:qNDiZtWVLWCXwaKRHWvlJjkGpTmdQPoVZIFc-lZr-ddueBkerEEd0A>
    <xmx:qNDiZgPGSD-AvDeFT_Ksliz1DN5Bxslvf5kyY0asKUH7f8sZ9_cbvg>
    <xmx:qNDiZs2SROsi3bCjvQIqNTmNEQAWcWNLrLGkMK0PcIlp6HFNRovARA>
    <xmx:qNDiZretGBu87Ban0UMRItoA6sJmVxJasqxG-ZnBjJgnfx2pEjp3pWcQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a927e33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:34 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 07/21] config: document `read_early_config()` and
 `read_very_early_config()`
Message-ID: <8c0010b439725585ffc3a9bb4f1f7eb4944a2d6f.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

It's not clear what `read_early_config()` and `read_very_early_config()`
do differently compared to `repo_read_config()` from just looking at
their names. Document both of these in the header file to clarify their
intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c |  4 ----
 config.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0b87f0f9050..a8357ea9544 100644
--- a/config.c
+++ b/config.c
@@ -2234,10 +2234,6 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
-/*
- * Read config but only enumerate system and global settings.
- * Omit any repo-local, worktree-local, or command-line settings.
- */
 void read_very_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = { 0 };
diff --git a/config.h b/config.h
index d0497157c52..f5fa833cb98 100644
--- a/config.h
+++ b/config.h
@@ -192,7 +192,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
+
+/*
+ * Read config when the Git directory has not yet been set up. In case
+ * `the_repository` has not yet been set up, try to discover the Git
+ * directory to read the configuration from.
+ */
 void read_early_config(config_fn_t cb, void *data);
+
+/*
+ * Read config but only enumerate system and global settings.
+ * Omit any repo-local, worktree-local, or command-line settings.
+ */
 void read_very_early_config(config_fn_t cb, void *data);
 
 /**
-- 
2.46.0.551.gc5ee8f2d1c.dirty

