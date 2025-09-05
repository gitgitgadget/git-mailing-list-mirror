Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7E34A334
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073078; cv=none; b=rC1O+ThO+nYkfpwvTKADGEfOwTwaETjLyjfPh78kO3IsRHNIpvdH7SMWry3TSqUM9i9FeLvNIy1OP0tliO/WCv4jvD0SBKcV/Y2SvrHHRdtULG4kQowSZiypqoc2OwEfGSir0q4w14rf73BtrfUWsUJ4lbULGKbvnIiCeL5ghPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073078; c=relaxed/simple;
	bh=pDMUQSpBS0H+9pZ1db86UuKdkMv2rNKo7qON9a4BFYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjs0YlAtmhoCmmwwKx7p5Hl9N2dlVOFtDBuAMjBQVt5QIha6JmRnEL1E+WKul4ouw9VoS9eoJEulgpCW4U6pPOdPyKcSpal2U5nUAdgeQh8HtNMoKuxwOLPsQcvYT6giKq3Tgk3ncjGyZa5zthiHbTPTT++8aClFHrydZmkpXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oZ1OO4O4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUzFcsje; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oZ1OO4O4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUzFcsje"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68B127A0392;
	Fri,  5 Sep 2025 07:51:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 07:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073075;
	 x=1757159475; bh=RR7ivmTBb5KRlAc6HlGNDtt9zK8rtjjcqITzijn+M+c=; b=
	oZ1OO4O4ivte7lB/WMNSFC2wOUh4PL2R1SF92K7l8AWHW/e0gpzJERgyA64xFi10
	fEZbFYn1JEKRclUt6MA+jH8eAfDKKfPmn38Pa5MbKFm4zmQmdb7Cwi6/XJvwqcHm
	RRHXM1fUZ55So1ZkWFcSqTfxuKbZKAQ8HBNTTX0SxzFjTgkscXBbsGQBevEFd/+x
	5ABz8oZDfDw6GE8Xx3q+CFXtIgFA68QiHkzKKgmdxAEfQFiCqM5AO6yc0qKskR/i
	/pbTZ1hLXfL90JozjLlnZCqm1jL3mSPGwjS4qg/U5t78wGU5GaJcWAw/rMBlivsJ
	5QL5V+HadmB7Dc59B+b7cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073075; x=
	1757159475; bh=RR7ivmTBb5KRlAc6HlGNDtt9zK8rtjjcqITzijn+M+c=; b=N
	UzFcsje0WXXpWmvQUNR7X3g+7vVrix2nVfpAnRXBq3sVIk1/pW6zb5FGF597zeDu
	KMIZY8kloqM36tLfVIC4syiyTv+l1nnxYnrUAEDoILHa3BEfraqA1kPA4htWrKSu
	HSJ7tuixpHDLm+yL83aY/MACZ4TtyPiX/GqIubDRAs6318MpD6/7zfDVnomle7q9
	tXwYztujGDwWYIgiTlO2eknTBnJUqH+23QeTBNemcAYhpNX3zQP4n62HYzEui5YA
	pnGMI/bCBvnl5IzbvZFfFQszjSHzC3lg86qbnkawWlchtiobh2P4UpD+Qg6zBRQX
	BRf28LHTayDv1DkRtK1Ag==
X-ME-Sender: <xms:s866aAenpo9xDpJAn-1PeXzmm042owgZJ0oohwtBgVNoUiZN6JbIsQ>
    <xme:s866aCX5NDOMowDkl2iTIbkzh2AD1zUiX1u7w_RDmmZlZzlO-2DBR3l8S4Q-HABva
    9ke3hZjoUnqaNt4zQ>
X-ME-Received: <xmr:s866aI9ntrBadv3nf35j-eKmHVugJ8sf1qZffU-sw8flBkNeIe0b7R2BOR3VVoSG7jYPiU3tW71a9VcByYstewBzG5Xm0xlnSiheP6wJE2qJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhllhhinh
    drfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgr
    nhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:s866aMgxT0UXr5IhT2y-w0fn_AgLYJv4xlrGT031qJRAm6_PNyO-3A>
    <xmx:s866aEcGORnCrguOG4BR3OnIHK9SKKAvmKCOM9tPYOpB5EwCNkMgHw>
    <xmx:s866aFJ7iuhKY6uMIHjiRBWTyRQ67FyLxThU-qRxfNxCPX8lhL23fQ>
    <xmx:s866aBmhBG2InXJ_7krowuwsetXbt1SvYZH-7ScVEpkJLiuObCRptg>
    <xmx:s866aKCtpzfbBejNAArwoR5gqtdhwYKI09uf0_pdVLPvxjecRV-ON2DF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 422700c1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:50:59 +0200
Subject: [PATCH RFC v2 3/7] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-3-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

We're about to introduce support for Rust into the core of Git, where
some (trivial) subsystems are converted to Rust. These subsystems will
also retain a C implementation though as Rust is not yet mandatory.
Consequently, it now becomes possible for a Git version to have bugs
that are specific to whether or not it is built with Rust support
overall.

Expose information about whether or not Git was built with Rust via our
build info. This means that both `git version --build-options`, but also
`git bugreport` will now expose that bit of information. Hopefully, this
should make it easier for us to discover any Rust-specific issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/help.c b/help.c
index bb20498cfd..5854dd4a7e 100644
--- a/help.c
+++ b/help.c
@@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 
+#if defined WITH_RUST
+		strbuf_addstr(buf, "rust: enabled\n");
+#else
+		strbuf_addstr(buf, "rust: disabled\n");
+#endif
+
 		if (fsmonitor_ipc__is_supported())
 			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 #if defined LIBCURL_VERSION

-- 
2.51.0.417.g1ba7204a04.dirty

