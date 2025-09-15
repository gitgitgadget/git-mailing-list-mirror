Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879C2309B2
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935402; cv=none; b=dcUy4C4i826OXXGHPa115mgQA822DflM+d7RIBrL5eWbN6DfQQFZs8OjZBw9BTgbCiyVnkZjlV8LnvMkGgcsFBgcX0kfVYobq7X9rWBTz7N//r5DU46mHys8+HAXyT1jCg2MGq9tWl7eysDQiuOiXFzFcptdyUI+QVg35DTqQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935402; c=relaxed/simple;
	bh=bstXY4IzG1jOVHrKyFhOdiVbgSEr4RdxfhfmrJtSyBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEnXbkihO0qH96e7XqnSvcVG6R4Ot3jgh5sTrqFcTD43Dgvm5069FVWYwIe9damO+XwDaf16exQ6Xd3fpJUfaOJNiIptUAgGFVbmdjkBz5f0TO5r1Kdjv8EqV6XDyGKWG5cBCkHCNvND5IKQsRWG1v+W2maG8i25KtDZT6VZQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=acgMmv5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mL3aUI2q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="acgMmv5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mL3aUI2q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 30520EC02D0;
	Mon, 15 Sep 2025 07:23:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 07:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935399;
	 x=1758021799; bh=w2rBadNyUJqJYOp8S4BEZMS3x9lQcf645ipB+BG2Els=; b=
	acgMmv5rzqR6+PT3vpijx8P7ninti+uLK0x4tkRcUoW17DfdqvqWxfOAz//CK+PM
	Mu1ppfXA1T6TBXdprrRd0OnA4z5ijnmKPhB/r/B1Qi9lM1ToWftmQSEk/t9KiUJk
	6SL39iQ5eeXPYxL+dZnP5bcW3LmwUJEzqbuXhHiKNE8W082+UWBbvgHhFjkdxgNJ
	AH7DwsfXBtpXX8qU4AZ+7oOmzVenfPBW6bDPCahHYcqMMB38k01/HYe/cVeTJPLi
	6K5WEwVFxqF5OB8kZuRwp/7sjOyYtz/CzIZ3UrO09OWwWXaKckimpN/oyrdrkS6H
	HJpFGlqul5auThIPay3Kug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935399; x=
	1758021799; bh=w2rBadNyUJqJYOp8S4BEZMS3x9lQcf645ipB+BG2Els=; b=m
	L3aUI2qSlh8Yb7c46pNxEdEpPUy6twm5bX1iajOLtuKOpNDkGT+sCIUwGjqFiUnj
	qjVSAG/R46oLtbr9LfEO+VD7LfgGi1aT5sV+eigO+6wGgDu7mbdi3+QjNCT3D0AP
	o+5Kb9wJNwqPUdPVm2DV366zIMo35jI1e7Mai1eu7Q/OmDUkjVzd9i+X8bcYjL++
	UNufaJlj0/e4cD/y4YtP/uMdjcL3L0NCRYvbJ+Nh/En51OUtAkS9vFli17qwXkZz
	Y/Jv11rRNkgi0fwjsCcDqPOYNtjYXDTph2kyY0CQ2Tb5SeyUghHTARc5Fsxm4is9
	6RYSUpAIr0nOL/MdUrRlw==
X-ME-Sender: <xms:J_fHaMnkR7o7zLixdXowpOfyNDclnq3RuN6qW4eNeu6yLZ3q_LEpIw>
    <xme:J_fHaMdvWIBi4AU7rD3OX2EB3KFULg_k_XXEFU4uk_sesYVHxFLNQMj6yfNwDD6r8
    kqJTVJuwX8aReG0lQ>
X-ME-Received: <xmr:J_fHaFwxGg7601VvaeGLKdKNXvuc0sOwAaGkSZ4Zkv6zG80qwqmtycj9uNIe4YG3zF_4P4ciLQcg_mkLYgPdUGtAYjfL4KpIeUbwtJnGnfKyRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegv
    iigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrg
    gttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtohepshgrmhesghgvnhhtohhordho
    rhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J_fHaNK2-uyTgx57uEG04TDaeyXg1xq9xsM4e5B6jXoKUnVEuViysA>
    <xmx:J_fHaOviS4Dud7XwgfXQCH8JrERObmsucXirdV52JXepDV-Fud9pyQ>
    <xmx:J_fHaPRHJN066q4KOIduNldgZBJct2fj1qBSVzeLJQ_BnSxXPCgvmA>
    <xmx:J_fHaPQYjo0CWFoQzIlkFqPWq9XIlDk-n0FXh_gGJH-1Qug3B5gZUQ>
    <xmx:J_fHaNXrP6e2_XFxsjHmyR5pqWAXlWqUJ7mXKLx-iGSpIndTzPQBLbcP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dafc3f58 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:51 +0200
Subject: [PATCH v5 4/9] help: report on whether or not Rust is enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-4-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
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
2.51.0.450.g87641ccf93.dirty

