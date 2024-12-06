Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701C20D4F8
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491536; cv=none; b=dLc6H/baGPn3c5Aw5IZZoO9mqEWxfZEqTYUxx3LWi6nGK+3AogMGNBSxvc0bwsA2yry2oXsDm4BsGqdz/JYVmW/6dAfol81dOYoTmv0ZWE8VA+MBPS+gZyDBOjYU8ooZnkBw363iDPhI1gsIHQ764BCEHWaZ/nbzeZO1PwihbFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491536; c=relaxed/simple;
	bh=7megYNrvtibGMqI8Zc4a2bPZHtWVmDTH9qhSCB75xKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qX8VpR0Q1xNpClx3nL98Nmeb9oCUhzTrMCo27PfOju9iwfp4SxfXkd4CHB/7VQva4uZO+QP+x83uYr2L4E4CYR2gvUnSafPfgqTIGmrFY6x/P/Cvw/nYt9AbJzrk6ab5zlg7/kGdTrMOudHeG6vvXKs9gZY4sPpwi5FDY0NpDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=knKFYjPe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mzXy+mqg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="knKFYjPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mzXy+mqg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CA5611401C5;
	Fri,  6 Dec 2024 08:25:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 08:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491533;
	 x=1733577933; bh=eF1CM333VfcxVLOGfxg83kv72YQaCN3SHuVMGEI/Wxo=; b=
	knKFYjPeTkCxHleO0q80/7JTIak4lEM7rsf1B18pvAzPWDkbKUAlZ/PZKWItLfRK
	nH2BQhzMU6ehCzny4pCpVWKJh3iy3Q31lSQbdisbCL9uHcYVBd/OW4dzDFiWQfCZ
	64OS5iCI8p0hZ+mNKvWsWqEi5MPe7QaZEiK1QBavTBKuqykLxVb0DQwHGiM8W7GN
	WfXJv9arsEtRQSFys3Ef/Giu+GkJ6FsWyYSZvrwUo80X4FO1Sq4WIXS06I6koxG2
	h2sbfgV+MzYMqoiIJu37QIF4Tli6i6NNQa+1qa74QbM7TFEsAkRXbku1i0mXaoHG
	VAoa4DsNFbsD4HNqvQraeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491533; x=
	1733577933; bh=eF1CM333VfcxVLOGfxg83kv72YQaCN3SHuVMGEI/Wxo=; b=m
	zXy+mqg1dCPAH7kecqhkko6zVDYwpzAo5dui/jJzlBStpiDqiX4aCXVczR2Lv5T3
	WAiYPcy5t3GNUey4PsEmQ2K2PjOXRitiNlGOSjscrkBRoQmEdXTxIURqyO5aFKfT
	gTX8SPj2XQ6IKkK/G0x7Pmeqp2zVErajiiS3UANL+PN9m2x7pZJUtjlanS/SFXKQ
	G2Mk6njSPQp/4hNgeYrmPXj8zL5xa8AbatMklNohDftU2mTbO7ewvtsEaGBrIdw+
	Xl77ahwKeDSK4b1cpyRtWR6TwPmyIfqp20/g08uziyxdW3LNmk0SEpGyaOXItbCu
	PJ8g5OlJZNHOG14L+KFlw==
X-ME-Sender: <xms:TftSZ51X4rR0fTocZqOxo4eTa-gjrCjOy0FjWa2olFEL54tyEFsq9A>
    <xme:TftSZwF4yJEaYQC_tg1ZzAkL-WDq8c8WY5WzMiPbaXOYWR93TKN1P_iZ5mXHLFI2V
    5XJlV1ZJUi8u-S-fg>
X-ME-Received: <xmr:TftSZ55WeKQ63l0FvAXNsp3qAYLwNVp9x2BGopGmK1prriwqHO-rhxVpacw6anPyo5udj4ghk2Jw2F3WJw3S-62Go4fWe8SUDU5kMujdL1_6zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggr
    vhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:TftSZ21Bmkf9c81OF6Z0ZIDEXfbokOwIOIMCLsqWYIqXCKbiV_p7Fg>
    <xmx:TftSZ8GNNSZXnWqwUUYGBk0_dS738lz9IkUDZBGCyBbvvfCpS7uP8A>
    <xmx:TftSZ39d--4VIQH-QxwW3mqmqFixQxo1oAl27ZiPa4hrupOlFj4ZGw>
    <xmx:TftSZ5l6uFwLOPLh4ZIOOZLO3R-R973e2wWLrEmBwJSy67LxbpnMNw>
    <xmx:TftSZ__Nr-AOjBB5Fruo7Z1lnRUv3jvseaGV8Tt1EiphvrBiDWN8Skh_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ebd7ce5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:48 +0100
Subject: [PATCH v11 13/26] Makefile: extract script to generate gitweb.js
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-13-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Similar to the preceding commit, also extract the script to generate the
"gitweb.js" file. While the logic itself is trivial, it helps us avoid
duplication of logic across build systems and ensures that the build
systems will remain in sync with each other in case the logic ever needs
to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile              |  3 ++-
 gitweb/generate-gitweb-js.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 16a2ef2d1e5664d99f6f1d8ff4224c36769c55fb..d5748e93594eb6181269c2fe272bf7ef980cbe68 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,9 +115,10 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
 	mv $@+ $@
 
+$(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	cat $^ >$@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
 	mv $@+ $@
 
 ### Installation rules
diff --git a/gitweb/generate-gitweb-js.sh b/gitweb/generate-gitweb-js.sh
new file mode 100755
index 0000000000000000000000000000000000000000..01bb22b04b8d8910608fec6376f07d570ab02a33
--- /dev/null
+++ b/gitweb/generate-gitweb-js.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	echo >&2 "USAGE: $0 <OUTPUT> <INPUT>..."
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+cat "$@" >"$OUTPUT"

-- 
2.47.0.366.g5daf58cba8.dirty

