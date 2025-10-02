Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F592D1913
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390249; cv=none; b=T+cbNpph//tJ/297GG02ayqNgaTK4V/fSo+XefGygToY/kFHHj4npqd6a/ANSYoCIzCQ35n3ajPAmXa0BF2rIO5yavDwUwA9fMbpP9cPvRgfmigD7Imxfm26eGpPynWmmg7i8Iv56nTtxndNZdDysdMEAR8X2PEOzCLEWW69Oa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390249; c=relaxed/simple;
	bh=Bbs44eM1IQg3k7c32/AWWK3YMpm7wb9GTshR02i5gc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1HL9Q3yVzvK0Axpu/2323z4AnjvaVPNQXzDPdXwhDzdoXTGiOCGxcoRk4d+2sumpEXdsGG/nAinYAnUluowQXgk/yBgydlnhaJTdkMGdX5iek7uG14nTavF/wsFBQCHn9zX15BYbaHyAH+HF5dEBJUPrKzCu0XU9fuFR1P854I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I5/7wYTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSKfXT9y; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5/7wYTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSKfXT9y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 19CA31D007F1;
	Thu,  2 Oct 2025 03:30:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 03:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390246;
	 x=1759476646; bh=k2phsx9eQbZxIYeOUqRii1W4q99lBvYmx+s4BRQEt2c=; b=
	I5/7wYTf9tvI/bfABHB89hecCbl138Vu2eUFepdirr6KiHny2ayrVV6TbUv9T1cc
	X0soPsELDVioUPxTp9/KFQTVCzFuMUwUCVdHXJ6cli7DNs5mTaLl2JLOtAbU7gFe
	uM7fOy8EPakddEEJqi5MNjugtxAgNBIZMu/5vZSsaP8IvJaLNrs4By2GJIT9HMge
	Fa8Uzuvbzaknt0ZfT7byQUbO5Eyi0jVIbaj7WjIBJlAeCuEn9n9nb5eOBEd2k22+
	eJ151pJVo3GWztADvmx+PxeXuzgmLgKIaWUuqfUwWqnkcyL/C2y2SuDtyMAlOuKN
	MdNwAaV1S9yWc8SjbraQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390246; x=
	1759476646; bh=k2phsx9eQbZxIYeOUqRii1W4q99lBvYmx+s4BRQEt2c=; b=H
	SKfXT9y8ue+eGDUl7pksaQMP9zuzjJgHuLKXy46fTdsTvx/wIhiSB11cQbEyDNYL
	Wj/BBeRgZ3VPgZBHBZc2+cWTsXu9Se/kJaCZl0CVLQWT+FmhhCgbDMsfjJnuhKWc
	QwEbdvdQNFKdQ2BPt93miYud94xR6hN0mBfTM175lLNa4mqL265N7y2YUpRdz+sT
	LgFA1rMAKZVXtJ5RFK/M0juLfkF3eTeECH8NsKM+HYb63wBLQgpWuJSE9ofOwv9P
	aWpxHDLY709PRmdBZVdPiWN3FZBiQpX3ATIqUI0f2Feq1u9RkJFm3KaFDU75Ir3f
	mL4SU9DofXMAo2FKiiysg==
X-ME-Sender: <xms:JireaNfeSKZLzTC5ixa7s3uaq1HEElD92jgtm1QQvrYMg8W7OkkhRw>
    <xme:JireaLp-GllETJNQuGNMta1bC20h6NyoZH8RPE9dAJZQ7GK5KV0srB8o9LY9CvgtS
    WRKbCLsiXEBxSLIrvv3eyZjNrV78NhLlG__KPSz3OAgQcPNkzD95w>
X-ME-Received: <xmr:JireaGSBfj5tgFy0pbCCxB3CbIexdd2LdEx2nL_xw1CflB5ZvqWpqP8nqiB5xrxGYhxonR1OLKqTHBxrTgZStayZB06dcmW1r68fnz3yKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopegtsgesvd
    ehiegsihhtrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JireaDW_3ppGRLQr0XRhzwvD6x9fQtz2E9AbNjWyNkwRU6IX7-sqVA>
    <xmx:JireaDcSKGbrxby7JRbdOdgDSkHPdG9D6wjYRbTRJxlYW-0QAqxrBw>
    <xmx:JireaOyK1K8K2sSgFo9c3EYfw7PFxzANCZnDJq_ieEfcHhN_lWWb4g>
    <xmx:JireaGG2MKBvvjCFg7KPbhhFNsW99ITLkHgeECe8pYAC7aIi99GzXg>
    <xmx:JireaCXODSIuoib5qXppVRlm7g51aVVdNqifTTnph8TqXPYB-gO2hDMu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 13218d86 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:29 +0200
Subject: [PATCH v8 4/9] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-4-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
2.51.0.700.g236ee7b076.dirty

