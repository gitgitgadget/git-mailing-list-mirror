Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70225C6EE
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898411; cv=none; b=Wz1xA6iyx96UJzHb+NkH/7B6xECj8vGHxu3eXqoQ/z4rArY+0tgqkcKeOdhqNadNuB5xGdQCb24unxpclKObils1HQarzIfsgqSIr8PDil4gvadusN8rWXRyZF6AZDl4BPN11M00Owyd78DBc5IGydivNksorjgtfabe0nDsPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898411; c=relaxed/simple;
	bh=8WCwuAkPVP93QN118w/8trJDDjTKnN3AF8bplL20r/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgecteaUUgTDvSXu84bGnvSCRpv1/wJmvGZPXZVULsvBv3+t6TMu1ZYP0a0Cg6UEwxAekFXcSTuuM6Wz1ktIwOBMEUAg37RjfDSlO+r5IKAyBkYMyjm2lP59HDajQYS2LWC+Ot9hlF7cjduX9/DBlszAp7adt7Kw5Qe1iPCl8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VdLiDYlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3P9ZVV8G; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VdLiDYlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3P9ZVV8G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D64B5EC0219;
	Thu, 19 Mar 2026 01:33:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 01:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898408;
	 x=1773984808; bh=bI/ubNU8GighF2ALZ+Xij2wBywzz5SdN8vzErp2yx1E=; b=
	VdLiDYlUVu2uJh97NX/KGqucSZLv2OihhwvpvRI/awAv78wF2qqLsThWwYEGWHHo
	3LuwncQh0egyFsRpeSMp+MCF1e171vHFjlKSaIbM2i96uWx4v/OdhpSC5yvmLwNM
	j/ACB1CeJLRCTF9DwDTjxGqP+JQP1glH35v+MgDu8580akl1QI/e3nxCGvzVUTOp
	3OIzLrexHyaSixN5oWj/jOyR01H171jglNNrrNSuvaqkla/vTTIa+11qno8bMIhT
	WpXDDxbVxhXGjmWlwrw9ne2rTf6NVH+DyUV0YvO17tFjogL2lnqLxAYuRA8WQBz6
	c6Jm6sawmpjggkJ5lkawrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898408; x=
	1773984808; bh=bI/ubNU8GighF2ALZ+Xij2wBywzz5SdN8vzErp2yx1E=; b=3
	P9ZVV8Gjjv4YpS/vLXTmubh5h/cpfNAXGcbG2P9uJCfBAGDmF16Es5rvcPSSJr5N
	QJgwE1MTanhVEX9dR49zLol38rex2QrgKrMjhmQDagtFssaFL0feoig44GzdrtZI
	WXyirOGVI18Xs/86JfMCFW9jknrf0JZUbp+mnnnaVKSHNoQSY9QK0j/g3t20gC8j
	uv0puBrQRiASDlbYMVq0mrzmucGKhd3LYAqUGCjmwj3HwlnFIMrnZQcc+kh36ijb
	kz0xkvl/UW+qEh3J83fz3/ddmF7M3+kaOTe8hlFcioUy1qE52UX6yRJzk7EnrWPL
	IO1p83ZbwfKTqdtk/S0dA==
X-ME-Sender: <xms:qIq7aaCz9HO-532KFCrxENzDy1kfuE-jBiEXRHvaY468eyVCt05TtQ>
    <xme:qIq7aWBlsxWks-lK1PXCR4PfLYXBYu80OZms_Q4Z8JjJYL0v5Mrf5tr5egHB31dNq
    GJPoJALuvuH28CPMBPVfKD7b9a4DtSPrvZPq-BA9jGpU_AvYHWpjg>
X-ME-Received: <xmr:qIq7adomDFQxEgHuudyqPMZ9YxqagguKR3KUhOgJYE6eH5JxJPtmRLstp_HUvgXh1xf25naoAl_EGVWHF9zYV-HeioWu4EBWkoc2WmZI7_s3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomh
X-ME-Proxy: <xmx:qIq7aYnACJUjdnKyTYBhfr_KCzVKotI3H5wuciyMSd0EXh91zd43PA>
    <xmx:qIq7aVxYOvTfHe3ibeinHEuPW3fLNsDJa1cMvvGuw54WTVKEOS0gRw>
    <xmx:qIq7aY-Ie5y6Fo6CBcDGNuCGe1jDmh7-2kHz689HlF2qzOk0QvLf-g>
    <xmx:qIq7aZL54MuXQhT_NkpK-CBERKqA0EKLz7xpi5qJgLbSUO4LcnbQng>
    <xmx:qIq7ab38q7skPoWQCxiMhNGKtQ-iLtjA4vfC8VryYl7_pYLx0aW2C96J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22bdda62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:20 +0100
Subject: [PATCH v3 1/8] Introduce new "tools/" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-1-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

According to its readme, the "contrib/" directory's main intent is to
collect stuff that is not an official part of Git, either because it is
too specialized or because it is still considered experimental. The
reality tells a bit of a different story though: while it _does_ contain
such things, it also contains other things:

  - Our credential helpers, which are being distributed by many
    packagers nowadays and which can be considered "stable".

  - A bunch of tooling that relates to our build and test
    infrastructure.

Especially the second category is somewhat of a sore spot. You really
wouldn't expect build-related tooling to be considered an optional part
of Git. Quite the opposite.

Create a new top-level "tools/" directory to fix this discrepancy. This
directory will contain all kind of tools that are related to our build
infrastructure and that Git developers are likely to use day to day.

For now, this directory doesn't contain anything yet except for a
readme and a Meson skeleton. This will change in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile          | 2 ++
 meson.build       | 1 +
 tools/README.md   | 7 +++++++
 tools/meson.build | 0
 4 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index f3264d0a37..c7cedbcd7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1066,11 +1066,13 @@ SOURCES_CMD = ( \
 		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
 		':!contrib' \
+		':!tools' \
 		2>/dev/null || \
 	$(FIND) . \
 		\( -name .git -type d -prune \) \
 		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
 		-o \( -name contrib -type d -prune \) \
+		-o \( -name tools -type d -prune \) \
 		-o \( -name build -type d -prune \) \
 		-o \( -name .build -type d -prune \) \
 		-o \( -name 'trash*' -type d -prune \) \
diff --git a/meson.build b/meson.build
index 4b536e0124..1d66b5181e 100644
--- a/meson.build
+++ b/meson.build
@@ -2149,6 +2149,7 @@ else
 endif
 
 subdir('contrib')
+subdir('tools')
 
 # Note that the target is intentionally configured after including the
 # 'contrib' directory, as some tool there also have their own manpages.
diff --git a/tools/README.md b/tools/README.md
new file mode 100644
index 0000000000..d732997136
--- /dev/null
+++ b/tools/README.md
@@ -0,0 +1,7 @@
+Developer Tooling
+-----------------
+
+This directory is expected to contain all sorts of tooling that
+relates to our build infrastructure. This includes scripts and
+inputs required by our build systems, but also scripts that
+developers are expected to run manually.
diff --git a/tools/meson.build b/tools/meson.build
new file mode 100644
index 0000000000..e69de29bb2

-- 
2.53.0.959.g497ff81fa9.dirty

