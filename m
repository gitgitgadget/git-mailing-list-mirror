Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079812F5A13
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781833; cv=none; b=VfTeMoe1eQbDGb6ebwmunAcm6Rkmdn1ESSKsrbIMz3o2M74ei0AS4L2m+M0PZtyO0SUBf56enFTx/mvPHLntVXO+aVmPFa5uYaOJvP9egKszmJTURPFeVEHJO74I67CE0mYqDNtk4qb+6eSug/piZLoPPMMD7mMeHmjFdj2mgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781833; c=relaxed/simple;
	bh=UNHX54gw5PpaqFw+kNWwg5YnrwULQtny2HNNfjVrIs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKql6ikw9zjTiRGt40iq7Y+oPVYa2GXWzMeVhJ7Y93UNc8M78mHtwggDoMyjt4BYJ4a7EhLMzWuxjEBbTdsJ0sa0C2xQmoBMFoJsCzTOn5TAD3Wcu094MoMRo9yfeZV2FCNeWqTi8ougnDz91biKLoaBT4ub26aHn6dMMxK0TXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jpZfypTN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLLg2kCO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jpZfypTN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLLg2kCO"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD6017A0146;
	Thu, 25 Sep 2025 02:30:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 02:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781830;
	 x=1758868230; bh=am923dajXdwzMeURwCWQJ4BTdYQ5Zky299wVpsEekvo=; b=
	jpZfypTNcTdm/qa/lpzh+Js+eENln6Jk2JCcjvwnAMG9iVbCv1RgEVjH6EPB4X0J
	8ZkGcRRA/F35iUQkYrVzAzcDYlZfb+ABkv/kq6M9wnYBxpuQjTCXU/tjsAuLUCrv
	Y/jAtNQ6gZ31EP1Q+5k/Azg2W+tIcFP6QlPCGn+0hF9Z2FZO8l4ENn8sQ8L60AU6
	0dDVLhKwYXSF5cwnSZalJ686npXc92pm79Ur9PRVocQp7gnIhUS/pcJ/QUV1w2jQ
	mgCaN59niGRsS2GtGC81ODrqUNaVONkuehwqqjBzaVS4AK37wIrbKMe8bEQgMZ7Z
	bIgL6PFLjPPf+z2tCujmqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781830; x=
	1758868230; bh=am923dajXdwzMeURwCWQJ4BTdYQ5Zky299wVpsEekvo=; b=e
	LLg2kCOrm9vjvPqVLfP8f8U9u/nlt5vxup3FO/fPpnwbWeSQGcU9PBxjQKG47L0P
	GsbmRedVEhVq246lyL3zn+9+fCb1N1zrcrS4J5EcWrMDNUTtZcYoVBN2XczjGhAo
	I+QIGHvt0JkNkRkFRYbFPCbQt2QUo+jep5Zcl5G8+h7PufX2MoNoAp+go9BxxdCG
	UBPQk5YLb/jebV4hpi0+x2um7nKKXzuUkAGqOW2wLgUEEvDIEHEbTBUtQqzLKYuq
	KLVdi71eGf9LndpIhhcF1CQkaI34lUjeKEM8OeHDUgREc25OX4cgLdF2DFCrgGM4
	kA+qfhEE/t0wQWFtcb9BA==
X-ME-Sender: <xms:huHUaMs3B5_CUwT2LrWv2h5CsSfBGvuc5AQKmRpSfTUV8jLQzIe9tw>
    <xme:huHUaKGTOgza-PCLh1Afn5PLQi84OZbSB5xMD9K-fl2fxKQ71g2leFZMoBVn4D2nU
    UkYglU4rV9e-stZIAPaDHrNiGCxx5hPyiBZs5cjT70kMo5SFYwYOg>
X-ME-Received: <xmr:huHUaC5RkeKmpTdHOVSo6bOYx0wY981qKlxd6XgwdOqToh7R3NeFSJy9Ya5b8h-vQe7FPF9yf_eDmds_KpDibhvZBwCTG82HeLx0HC7Rmck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmh
    gvpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegviigvkhhivghl
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkh
    dusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:huHUaDzv4dvecNWFS72w_QB6VDNDr00C0c0iyvdM_B13wormk3vK4A>
    <xmx:huHUaA0kJuNdfIzj2nhaZMbCoTdlaa2bweutzMA5C6eD_Mt9TOf9YA>
    <xmx:huHUaG6P7pER01XW8u7u49tWK02CgVL_SFVt0bbJ8TY81-FASoXeUA>
    <xmx:huHUaOYjXvTHnCyjR_2cXo4M0YAFrZ8evcv-5crLUXUhJoZUNVXNxg>
    <xmx:huHUaLcIO6HCeaQUsDjX2iDARuz_kx0nUtvyrf7tmknpg78UJU5hNAYz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39f7f89f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:06 +0200
Subject: [PATCH v7 4/9] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-4-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty

