Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511F1F542B
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308012; cv=none; b=gwgn6d9zdBQwymx1PbRa6QyAcRSC45XLOtrNXJgSEo3Cw3U0UsK+tpa5Xy8SjHrfu/7Od45L1MLg27MU3UNeEKZeXXjU2W4IDQFfsSyzijc0I/TzAVOaQaa0V7jm6Ue2MyDkva9p5uF3AGqAgdLEhVbLfHmjg/rgb9cTxLUW1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308012; c=relaxed/simple;
	bh=PfS8PUapD8hRKzjsI5m0gpW0HxEB81tdMJ91gQvoWcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCjyA6ndw6TOFUFc99s3GfeEiB2XZuYR3XCISK9GVRQrK4sdBQELMmysyRe8tP0jC80mtqHq9zpLlnxZWBGeS1T5ss260gURpNDsqlGRi4+eYEuIjV7ZdJsdRw0Jih1ywL+SOaI5tirhQCAioNDjBaaiJ+sH72hMBwsBZ5DdjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gqQDPyP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/Uuo0AD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gqQDPyP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/Uuo0AD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E2401114012F;
	Fri, 27 Dec 2024 09:00:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Dec 2024 09:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308009;
	 x=1735394409; bh=z1gHdqMScTaw/2M3LtgZdVKtiz6Q2s1s5EBHuaRRK/U=; b=
	gqQDPyP2ef+MlcCbZWy4EY8fYFOY2DfHsvrgOuE+f97c7wY+tOOBYtlKg6rpW6tO
	GihrxcwZ9OYTkJwJOvjzcett7aMp+3qgzFN/OZrTZoDOs4U3lJt/r9fH5m4zRrst
	PQeHMPz2q5xWMrTQZiKMJ9tiQjw1eVxsj3QekOlEqxMkcixJowpzQhx2Xz8GmvMT
	MQo9rnXGLfJ6ChyNFfITxD0EGcOhi70FaYnxAinznYFJ1bE8g6FwmRl3uT1ikg/z
	4Dm0VF8NY2ye1KtZfFFoDTfigtwIXtgLagw+OGy9W0hZm6WH9+ds9CxzcQ6qBMbH
	15E6wovEvhfVUnkf4yQUiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308009; x=
	1735394409; bh=z1gHdqMScTaw/2M3LtgZdVKtiz6Q2s1s5EBHuaRRK/U=; b=m
	/Uuo0ADCke9oVLb7PY2jlNhQoEC73NPvjFaliSbEddP2iuATKffnWNRWLU40/ghY
	MOlPlagWDX7+8wyGvN0JPePGN3NoP3mOzUWGfgcnT3vhICin1m7ZkzF33VmBgqsd
	/JJwG8BXoMMjiLlLnW4HS3VFMoqnu0s0EHUJ4Iw4GSAHfJI2Ypge4h/yUL5jsTyN
	bVsV/Gbf36fP70ddAm26Ev1LkkWRUEgaJX22APSCR7HJzJppPiBP2FozNr9OJkgJ
	MAbl8MMObwOvHOYYL/xPT/gi+PD7cUl0e3HBXKvPeW6p6j0QBXef6JS8qIgfyB7T
	xsh8EvX65GHjLsfFQF0pA==
X-ME-Sender: <xms:6bJuZ6pHnQNs5KeHEGigbWAeZUyfOwWTre8s6ubMn4vJIIWyPnOslw>
    <xme:6bJuZ4pbCJ148cqUt-64mglXAl5IYUXLOc-4ySDcClJFARZu8kVxzpGb4gMl_CB6u
    _2i3nfjnzb7PWkB2Q>
X-ME-Received: <xmr:6bJuZ_NNZWUL0yB3AED0zC9iBeSJ_GWKkwaV-6-WL4yIEn1egTL5LTUnoBI5EQ3rfjNeQQm485w6xsk5rLhuuMfSToUuErxke3i4e1ChIVpAuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:6bJuZ57uEQufM4b_LuxYVP6omSDGT0wWs2vg_y1EsCg-h0SDbUyELQ>
    <xmx:6bJuZ55R8AxOeC1SvfrUxEzyWoxgp1cqHsFX6g_baxm_WN-BJ0cpFg>
    <xmx:6bJuZ5hQNS4pCcgdVtFDyuqXYEuptynazOpLCrUiyPaBVI901o_5xg>
    <xmx:6bJuZz5y2SFhamqdJlZv08_vGNng5bemp7ySS4u7okQPZ8l5g-oSew>
    <xmx:6bJuZ5G0TJjyBZGdF4kvv1e9IUGyt-cSfMhn5nlQcx-Uou0EqAK-gPNd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54d7a279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:35 +0100
Subject: [PATCH v2 07/12] Documentation: refactor "api-index.sh" for
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-7-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The "api-index.sh" script generates an index of API-related
documentation. The script does not handle out-of-tree builds and thus
cannot be used easily by Meson.

Refactor it to be independent of locations by both accepting a source
directory where the API docs live as well as a path to an output file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile               |  2 +-
 Documentation/technical/api-index.sh | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4f152077dded75bedd59abd56db5f6f0693908de..b2d146c44f4ded750b5e0766eb66b25cb5ec08e3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -367,7 +367,7 @@ user-manual.xml: user-manual.txt $(ASCIIDOC_DEPS)
 
 technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
-	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' technical/api-index.sh ./technical ./technical/api-index.txt
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
diff --git a/Documentation/technical/api-index.sh b/Documentation/technical/api-index.sh
index 9c3f4131b8586408acd81d1e60912b51688575ed..296488557434b7fff60ab25f4246a4dc270729c0 100755
--- a/Documentation/technical/api-index.sh
+++ b/Documentation/technical/api-index.sh
@@ -1,6 +1,17 @@
 #!/bin/sh
 
+if test $# -ne 2
+then
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	exit 1
+fi
+
+SOURCE_DIR="$1"
+OUTPUT="$2"
+
 (
+	cd "$SOURCE_DIR"
+
 	c=////////////////////////////////////////////////////////////////
 	skel=api-index-skel.txt
 	sed -e '/^\/\/ table of contents begin/q' "$skel"
@@ -18,11 +29,11 @@
 	done
 	echo "$c"
 	sed -n -e '/^\/\/ table of contents end/,$p' "$skel"
-) >api-index.txt+
+) >"$OUTPUT"+
 
-if test -f api-index.txt && cmp api-index.txt api-index.txt+ >/dev/null
+if test -f "$OUTPUT" && cmp "$OUTPUT" "$OUTPUT"+ >/dev/null
 then
-	rm -f api-index.txt+
+	rm -f "$OUTPUT"+
 else
-	mv api-index.txt+ api-index.txt
+	mv "$OUTPUT"+ "$OUTPUT"
 fi

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

