Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70321322C
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547565; cv=none; b=urwN/yRxamD1fHrxUERqoSMwku4nojHtSDbkI+HjYduH16yqv5Vyh/dFzJMUA9P/aCtZuZrFMWBdtMWBfcDrSMqY0iRpYdiV5Zs2qeYEXS2eWkXRCq5Xx73J3cBmqShmUJdYgnmqviVOVlljr736ISd9VMDdIVAnXLnVCCfpzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547565; c=relaxed/simple;
	bh=xL+4oL4PNjsyMqgax82+0oYPqsjoTQKo35juYfOqLjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Efc60NXwwFmPL43VVcrckRtxLyJFXgHoMqOH3uL2VJYnv6pFZIx4bE8ee2V0qHt4FNgqSYWxoziGEJakckRC9DClMlJnix7S5jkQrP6zi1YexJwd/LuEPAJLNqdXOHMGMJFRtwGoW3VATBX+b4rKW3aurulF7OxbbkwZp3z7Af4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qZT8orvM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ps6iizts; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qZT8orvM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ps6iizts"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C9A9A138038F;
	Wed, 22 Jan 2025 07:06:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 07:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547562;
	 x=1737633962; bh=aey3s6R1yaaRfrPVIbSbWfMSTdhiBZCeHx3Vvbyl31E=; b=
	qZT8orvM+IJDC/ephlJDYsPFpmKffz1LfVVTZ9IqI/OfLxzLX793SxWC4vd6hlPN
	JVYnnkiSye0fYyEeLkPuB9Vxn3FsuGALGW4WOn0u/YmBu41/fUMqHb9umrE/p5a3
	UY0qxoBornsAI83IHXTdUOvolcira0ivEO6wKNYaZsq9TedEmtgVQ4CeZYxf2ZD8
	CwfTQAp/N3bvZ+G8EOxOoFtS034bQRD7qA+4w6p/3mCBho4SkW0L1akJKwHxycqa
	rO+1/hEYZYaCf9JFdLJ/WWYZGcYZ6oGiYOzMLYCsfwf+6RHsXrMGBcQwvTMOZSpM
	uE2stEsuKf4fTQxU44U5KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547562; x=
	1737633962; bh=aey3s6R1yaaRfrPVIbSbWfMSTdhiBZCeHx3Vvbyl31E=; b=P
	s6iiztspZmKtFqnRttTe5z+r2DYzhgpgv3VPEbAaHL8QHQ96GUlrUvKK2cxzZlR8
	k+f4ZiPtSL01AIa8dNQRRg6UnDRCs/tsMmEVWwL89C3jMujwX1gAYesnUtQScmZh
	6J5L1drwMSNeH2JXcFDLiKt0W8W/Hnmpcghzu3uuqVcWni/bShN8Z2MFBKpDqOSo
	yIZ5npAVmi5O7MagrMN0LwzebT6JNxP3q7xRhZC3E3rYB4SFwi5PG77e6c8qnvzW
	+k5W9AVIq0CBE+rzDdjRFXnvOC8oTuPFie7kgs2aztkAND6T61x/utIZQEEhgK3t
	JKxcNvbLPQC3kBCKgwNDw==
X-ME-Sender: <xms:Kt-QZ-xsyYQJfHJoE57LTs-Vt6WbQb_CZpJB0iKJ6GMnMc53aD6C3g>
    <xme:Kt-QZ6SEJdtSWzff3JicfvWtNPhAlxTpdKpF9Dj4dLW24rWOxRT8LIEXO6xduq8Pz
    WvkeG-_67RLn_zvzg>
X-ME-Received: <xmr:Kt-QZwUqtXojHXXhsKXnwIGIDjjkSlBFhPne2f1bVsXU9jWmocmkAgyQ680wsJR5kuS8_b5a9mwJLbuzfiCiAaku85EZj8EP9Da5IzFylaDQZCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Kt-QZ0jOYlq_qrTpQVgcH5G0httyRxO6QQni3LDqAGoaf9T0Zsrayw>
    <xmx:Kt-QZwBJChiJ87zmze_RmEf7Hwc7E7IlT-i1V3XaIoEFKKFh6DtEzQ>
    <xmx:Kt-QZ1Kx3UYxnksZp-rwyFaNIcC9O619EbQTm5TimlKyES2emc1RDA>
    <xmx:Kt-QZ3C96V_zTiMNy9MvSHet6W7sPTz5Izte54OD9Iih9nmM0DTGzw>
    <xmx:Kt-QZy3lW9AUNI-br1OMZgjShWQNuZFX89CIl1w6mpcYVjslcVKnWZyz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:06:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7fbaf865 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:53 +0100
Subject: [PATCH v3 10/11] ci: raise error when Meson generates warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-10-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Meson prints warnings in several cases, like for example when using a
feature supported by the current version of Meson, but not yet supported
by the minimum required version as declared by the project. These
warnings will not cause the setup to fail by default, which makes it
quite easy to miss them.

Improve this by passing `--fatal-meson-warnings` to `meson setup` so
that our CI jobs will fail on warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c828c3b75..964322055f 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -52,6 +52,7 @@ esac
 case "$jobname" in
 *-meson)
 	group "Configure" meson setup build . \
+		--fatal-meson-warnings \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
 		-Dfuzzers=true

-- 
2.48.1.321.gbf1f004a4a.dirty

