Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1935212D90
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547560; cv=none; b=sWjx1cbcXjBaIDMLO5HmeRtVkJI2aKry9P6JSArIyqOGs60sY8iiCos/6hziKS+NRmfAghfZUZaKbLSC9IQHmSnCGIGZL/MgACIG1djYUYrB5E3uID60gnIrokQPOrnwk9AB4+RibKF4mBQ44UzEpvK55r7rurAyaU1+ImhDKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547560; c=relaxed/simple;
	bh=QCdvprsSXT/jvwab/Y8Dx8tYjhcfe8avTExJHVO8KcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sY3Bp5c/Xk6XnTKx3JRHdg+RyQypKUsGyXQBrv+wuX6jDYRP96O8xGiXOa2fNmNALRDnnosE8y/YNV3+yLMJ6AeybPsM1FIWcc89u06khAdNv3EtjyRRQbQg4LKVwgmzmAgU89VimC00pbPgN32nuK2AMYgATNvqx9YXG53u9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LBO/kkQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeZldScV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LBO/kkQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeZldScV"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2A9D114012E;
	Wed, 22 Jan 2025 07:05:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Jan 2025 07:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547557;
	 x=1737633957; bh=5lItKbMhgB+OCQWl488spyKjK5GQxcWb91YlyIixdjg=; b=
	LBO/kkQv9xSy92zWMK/kGAtsR8l90eGDE20eiryTT175hPM2Ir30wWe5IlDvSB0I
	p6mCsse4X3pMpzqajzFBmiHc6IL6yz318QklVo1uETM+R9DKp/jD8sQgRIqIo1Io
	rGuS969fR+K5vL2THsTu8Sm+dNIjyzaZ+2KVXSJ8ZIP5ncTUBiYTO1YN3sM25uTp
	M1HNB4TZBslzbZfnYdzR8iKgJq7irDHuvYLv3Mk8BhZUTAYNJ086JUovs/ih8GK+
	j2HsMxRA/+TN5JnacKFQEI+826BUPGNXXC8pnXJ4p+2byZwvJ7gIt9AY/bq2Xeq9
	J/6vPASX/iOjhkhNAuvzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547557; x=
	1737633957; bh=5lItKbMhgB+OCQWl488spyKjK5GQxcWb91YlyIixdjg=; b=j
	eZldScVQF7FmiA5pRtUpbsu0sAgMN99UnW9hnP1KmTRw7FIZ3LQwfrRRsu+ZnEH3
	vcE6ljuDL85xZr9Z3LEKMnR535QBLRTVvZPyO1BpHoX8w9WKV7h2sOMYcLaOTAM1
	9qkiWYjz9bqGbid58KvglIWXG6oOcBRs+6Z+oxqXcBo5k3rla/Fp07GFEk9WcEKl
	fqTO3BygAtUqdjmOj6m5yfH1oEn1ZlMgYqYNiipY8BWr3W2x2cdN+is+jfUAMPn2
	KylYqesjsDUhaykYEOr9Lum40wh7eMTTWT4uhIja5wK+Yj6syPptK0DvXUvgwfEN
	S+aVioWb3fkj6U4KOE3jA==
X-ME-Sender: <xms:Jd-QZwloQX-SfHwkhxr1wW86MQC9rhUhHnxWID3lceIlc4UvQt2BkQ>
    <xme:Jd-QZ_19k_AEk5RyvvTK7vBUjDjCnBP4O6t7ZZXFiaTEAdOCAKaybcnjngwuDgSwO
    U09RoMkraO4lj7YHA>
X-ME-Received: <xmr:Jd-QZ-pKmnRxbFce05ETcalI5UwhZXPMBI5dZFqSMH-Y303Gi69GtpHa052k4QQV7HC32rL6rxfhq8OZSYX9SC6cA7o0diFA0TUBp-ANUa9MEgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Jd-QZ8mNm4Xjf2WGiFkRG3TBuxh3MK-qmceKVnu26MdIqfUOA9ICQQ>
    <xmx:Jd-QZ-24LeQ3ospMICk2qB-wY_Eyn6ejfRODbBbYzh-wbas1WZic0A>
    <xmx:Jd-QZztH_7zcq6nzAekgedZk8ZREU4XXNahrJS9qeDx_UZsJVv_0vg>
    <xmx:Jd-QZ6XnsRnhz5BgyLhSRdIMWF3DlSTbqzWkVEfq5oZH2TWXwemgNw>
    <xmx:Jd-QZ4rh7AGNlxNo2-gkyWZociJlZv9HSk02u_JtHBIWgq6zOqMmtfkS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b811d27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:48 +0100
Subject: [PATCH v3 05/11] meson: wire up development environments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-5-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The Meson build system is able to wire up development environments. The
intent is to make build artifacts of the project available. This is
typically used to export e.g. paths to linkable libraries, which isn't
all that interesting in our context given that we don't have an official
library interface.

But what we can use this mechanism for is to expose the built Git
executables as well as the build directory. This allows users to play
around with the built Git version in the devenv, and allows them to
execute our test scripts directly with the built distribution.

Wire up this feature, which can then be used via `meson devenv` in the
build directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 4053024dad..ab4f229436 100644
--- a/meson.build
+++ b/meson.build
@@ -1939,6 +1939,14 @@ configure_file(
   configuration: build_options_config,
 )
 
+# Development environments can be used via `meson devenv -C <builddir>`. This
+# allows you to execute test scripts directly with the built Git version and
+# puts the built version of Git in your PATH.
+devenv = environment()
+devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
+devenv.prepend('PATH', meson.current_build_dir() / 'bin-wrappers')
+meson.add_devenv(devenv)
+
 summary({
   'curl': curl.found(),
   'expat': expat.found(),

-- 
2.48.1.321.gbf1f004a4a.dirty

