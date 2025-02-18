Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C651E0086
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864779; cv=none; b=Sg/1X9p4MluLyLhfeiyCtTCh8TnKk+R813JujcqH43qsv/BnuGG/lu2O7e3fAyERVYb9+u55nBiOwgG/MDUUVlSSKzy60EXFg3AMX5pUpt6gf8cyfYE5XP084lS9W+MsMoaNmAaKgtzGICMiljRgOkAAjNBjtAPIlMYV/9yXASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864779; c=relaxed/simple;
	bh=F8bI4+RJ28DC1d5SKLWRKKTsGcQML15d0zFOD4FFi/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7m4PHSiyAxQI7Hq4RNguL9l8/mqE60u7HhHSypQnrZHUl1V7mXsZe2/8uaOrsuETE6FM13mJImF2y0xJY4gfzjmkk/A3t3qJohLlMc4FJ0/E5hA/2St2u6dtyygUUnvd7PPKTOOwmDHmutryqsaGrMUooza5/d5Gxo2QqYvWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFsSMPCj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zB4EuzSw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFsSMPCj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zB4EuzSw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 052D61140195;
	Tue, 18 Feb 2025 02:46:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 02:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739864774;
	 x=1739951174; bh=kffhPVLZqZ2K2dG8bURuhhVJD3XSlGoJGWNURBQ9RY0=; b=
	TFsSMPCj+eILx6hD13PXzaS4lMwzDYwobJwE77WOGJ8dOhNQnPbN4KtE6ipEyG3K
	ipROgynPSkRQGz3wWDhdIrFVXGrLnIlsoIXlcdzpP3N6GdPIdnorMSpsA5dJfZpR
	mtsWOu9UE+zPfaFcjptOZHlT7oZDuLObLOA9Jv8YO3eIWoHpRSDRRTfKeBJae3e0
	JLPAuB3xXs7RcyeDu3Pu8eRMXM6/LMlCUEGbvXmwEfWA4S0rnOdXi5taZrin8siM
	cuKIr7JlcbT/ovurgVYAoQyAPlzHVYyaRmfi84tUVin6DLaDcSUXi2U4qRZXoMKn
	K9KWM1pBtA+Nn6wj/06Tug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739864774; x=
	1739951174; bh=kffhPVLZqZ2K2dG8bURuhhVJD3XSlGoJGWNURBQ9RY0=; b=z
	B4EuzSwDzJS/XTlAMKzu/Wz+pWeimalmy11QlO2GFWVVJqvqKJyW1hJtTfefTu55
	rx8G4Jkkvybwx7MiV0FTeTQNvnfRtHfxG9Y1Kq7NkHFnjYp8ak8BhH2ctOBErNKV
	S2FqEgN4rzWTIjUuM/JwtxMwPRGXzJm12Hi+hX4owdVOCbkOlT4/xNe92FnPm1HH
	AlTlA/o+/EkSbQUiYN++luSfOFMj7fRquP8yIyAwd5CJMVPyRKZ/mkrauCYmVfWx
	QK+WgGXUaTdRyWhRx+YJcbdsHZOrhF2TmuovFOVKoDDJZ4Lf26+LnZgiTetb5eLQ
	AI02k6pINeAi8PooytRSw==
X-ME-Sender: <xms:xTq0Z-HxcuZ4JJDR0mPnRdGrib6deqfxms7gMqN4I2ovfM57iY7zXA>
    <xme:xTq0Z_U-o8XBYIZsu0O9PCLLJ3DAg84l0g1HaIPW7kyr1ECDCQzKcysob1LCxp3q6
    KLCtQ1TtQFZOBe2Pw>
X-ME-Received: <xmr:xTq0Z4JETkggJr8n1NueoFtLAAMat-qTYwaham3-75qv69Q-zG8Uwu8smSnCzqAMhjVVsKC3cJ5l2ylbVn7VgFt7Bc2-dhNp8MHfroAz2bY-LFRu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xTq0Z4Fjm0N0YUJ0xau4JS12JMAkuHI5JnMyKrPhveBR1y0bfaOPcA>
    <xmx:xTq0Z0UIvzkf7tIVM1WBWJwtXmL984ton7-WVkUVBndjsdGdorXXyQ>
    <xmx:xTq0Z7MfRy45rEPM3lGbYK7vhb1AdApJMHbXos4jWp7GHaxbFfhsdA>
    <xmx:xTq0Z73iZICDB2gESHtu4kHLb-BM3Akm6b43Ia_TqCp_8ba_2UG9MA>
    <xmx:xTq0Zxj5huGHF5dcHncN9X14MU_UmLOnyICq_r5cYOO9fTB5hwm4uFzs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 02:46:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b1d529b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 07:46:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 08:45:57 +0100
Subject: [PATCH 09/12] gitk: extract script to build Gitk
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
In-Reply-To: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Extract the script that "builds" Gitk from our Makefile so that we can
reuse it in Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitk-git/Makefile        |  7 +++----
 gitk-git/generate-tcl.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1f0aff4a19..a396eef581e 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -8,6 +8,7 @@ gitk_libdir   ?= $(sharedir)/gitk/lib
 msgsdir    ?= $(gitk_libdir)/msgs
 msgsdir_SQ  = $(subst ','\'',$(msgsdir))
 
+SHELL_PATH ?= /bin/sh
 TCL_PATH ?= tclsh
 TCLTK_PATH ?= wish
 INSTALL ?= install
@@ -63,10 +64,8 @@ clean::
 	$(RM) gitk-wish po/*.msg GIT-TCLTK-VARS
 
 gitk-wish: gitk GIT-TCLTK-VARS
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' <gitk >$@+ && \
-	chmod +x $@+ && \
-	mv -f $@+ $@
+	$(QUIET_GEN)$(RM) $@ $@+
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-tcl.sh "$(TCLTK_PATH_SQ)" "$<" "$@"
 
 $(PO_TEMPLATE): gitk
 	$(XGETTEXT) -kmc -LTcl -o $@ gitk
diff --git a/gitk-git/generate-tcl.sh b/gitk-git/generate-tcl.sh
new file mode 100755
index 00000000000..46bba6d2464
--- /dev/null
+++ b/gitk-git/generate-tcl.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+set -e
+
+WISH=$(echo "$1" | sed 's/|/\\|/g')
+INPUT="$2"
+OUTPUT="$3"
+
+sed -e "1,3s|^exec .* \"\$0\"|exec $WISH \"\$0\"|" "$INPUT" >"$OUTPUT"+
+chmod a+x "$OUTPUT"+
+mv "$OUTPUT"+ "$OUTPUT"

-- 
2.48.1.666.gff9fcf71b7.dirty

