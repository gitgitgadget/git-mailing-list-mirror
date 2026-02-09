Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A937754A
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640958; cv=none; b=glyhKGZF9J24imz58pYvzV2fxK+1nv+RFiVAn+PpmbXs5ilMv99xsirMdacAT9ndLYGjuruvjAUP5dHBc9PwADL4Uz9PTrBJes2pIF9zmmeZTk3aFGLgexcg9ZzoAHuZnkOQ2uhgsnkNK/00AkcLdZhszKJ6HH+2Oh8Bh1T1VKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640958; c=relaxed/simple;
	bh=hLDobCL27HVcdWOHmysbKtgrQkSsud4B184SXRC2lLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdDONDanMPOuFe3rZjQFK/zn6y+W9HkWn9V4SWMsF6ojJqVbaGxC6WBYQmCSRd8oSqYlTRadTzlafpsihIldqTQ7ZGl17wBwcBEAdAI8wkjWvq8BKIEHCjjNxrMz/oCFjsjBq8bOw4qXMiLi4mFKOLLX6Xw8sFthp8UbZIeJ1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/8dcyCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOZeM1VN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/8dcyCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOZeM1VN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A0591D0008A;
	Mon,  9 Feb 2026 07:42:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 07:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770640957;
	 x=1770727357; bh=BUoRG9SPJvJRFimBLsJfAJVkhVTQ5YLmvssSzDb3iNw=; b=
	W/8dcyCCGclJ0xtdUikxDoiixEfouSpza0VSPxrygTM1y2jfS6M89oFTxWKGFJbB
	3tVdf/Ij5XgITcN8feuTDeUEt5ofXOPh6wLmvyqgYFX4QqRAyZsgrazgWxAMKU/s
	7kXQtKGcJHTyzgOLtarnzWXKCnLgjJ5PJaCMDoo1frvuDHOwR+pntA4GPW5OwkAb
	JGEhjI8sIre31dlFvJ6369xJjj17bLl0tUuM2eBgmyPlLBQS05IhDrhpezcjsDRF
	aXS4gl7LOrbDG9+K2gDjwxx6nJyFL74h5S8wk7ptKvt5339uWWHKJwpHvWO8B1j1
	KEYFF82E9qXrYsCTQ5rVxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770640957; x=
	1770727357; bh=BUoRG9SPJvJRFimBLsJfAJVkhVTQ5YLmvssSzDb3iNw=; b=j
	OZeM1VN65j9+Syx2ko1oXteYaUzWV0oC9AQPt6OCTCGzEoeZ7RJ07nDkr9L/xLP3
	o1oEqFfjvYe4nm3uS1bDYsXYCvw3txrnETv2a/nakg/CenOO/Y3KLmPE3RikBt8q
	jkjWZXt097aVj7e8mAp939pkd189Ob2YyuEyRFP+EzM8I3K/UOlHBMNTfCTTrZaH
	aJ68kMhVYz2NLkpFqBZzw7Hc2PB53B5Zh/Bqkpd3Jk6zmWa/Muek3kVTQnicDFUd
	9Tb1/GpH5W7CDutfaKudPDf9IGhA11RCHXUOYxLxujgH2VPrjmJ/+DVAKQa/uC6E
	hRCi/4aJzWgoiB/+nVPTg==
X-ME-Sender: <xms:PdaJaWlAp04RGfPAHbtduNHgXEe0tOCuetNwOoeesJWpxaLS2BytBw>
    <xme:PdaJaT1idAhY6fXl2fgwlYMN4uXU8W1OS0bnCUd4u6sCbkc_200Fp4a0BQkZ68wnF
    9QjFXUQykctBNQJ4BbkPxIwknVgKY1kHMDwtoCDeN7qBltfGjGPOA>
X-ME-Received: <xmr:PdaJaSSYVdQZiTWXXzE7vP6KHZatFKzQouHnqk-Y7mrtGI1O89yxqhd3XneGBEUJrTz9DiIEsC3_V2Y8iMOJ8S69h5m3EV2O36b79K4xSWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:PdaJaVtoLPC0i82j4EpsDR57xD2DmXw8oUEYfc_QVmqHzHzMu7IaVw>
    <xmx:PdaJaXauVDCwbXhhBTO9tmlFC_Jhdhu3RyQrwlNiM1RhYmkMZPwFLg>
    <xmx:PdaJaas3LG-p5Z9Exq0qkzdLJOTWbBVGJpwCEKwn3RS5ObWfXLze9w>
    <xmx:PdaJaZEIEIeAisNZUwWQzrHjHLxNP2zTDaO34tOUExbrzYA04Ual1g>
    <xmx:PdaJaR-32dTOidU1lFrnlZXTGZYKkvsv_ZHjeDx64E-AcIRfqFkd-jYy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:42:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7096149a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:42:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 13:42:04 +0100
Subject: [PATCH 1/4] t4xxx: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-1-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a couple of tests that all use the iconv(1) executable to
convert the encoding of a commit message. All of these tests are
prepared to handle a missing ICONV prereq, in which case they will
simply use UTF-8 encoding.

But even if the ICONV prerequisite has failed we try to use the iconv(1)
executable. But it's not a safe to assume that the executable exists in
that case. And besides that, it's also unnecessary to use iconv(1) in
the first place, as we would only use it to convert from UTF-8 to UTF-8,
which should be equivalent to a no-op.

Fix the issue and skip the call to iconv(1) in case the prerequisite is
not set. This makes tests work on systems that don't have iconv at all.

Note that arguably, it's even unsafe to assume that the iconv(1)
executable exists only because Git has been built with support for it.
A more wholistic approach would thus be to split up the ICONV prereq
into two prereqs: one that tells us whether Git has been built with
ICONV support, and one that tells us whether the iconv(1) executable
exists. But that would lead to a bunch of changes throughout our tests,
and for arguably negligible benefit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4041-diff-submodule-option.sh             | 8 ++++++--
 t/t4059-diff-submodule-not-initialized.sh    | 8 ++++++--
 t/t4060-diff-submodule-option-diff-format.sh | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 4d4aa1650f..4dd4954260 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -37,8 +37,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 0fe81056d5..bb902ce94d 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index dbfeb7470b..d8f9213255 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -35,8 +35,12 @@ add_file () {
 			test_tick &&
 			# "git commit -m" would break MinGW, as Windows refuse to pass
 			# $test_encoding encoded parameter to git.
-			echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
-			git -c "i18n.commitEncoding=$test_encoding" commit -F -
+			message="Add $name ($added $name)" &&
+			if test_have_prereq ICONV
+			then
+				message=$(echo "$message" | iconv -f utf-8 -t $test_encoding)
+			fi &&
+			echo "$message" | git -c "i18n.commitEncoding=$test_encoding" commit -F -
 		done >/dev/null &&
 		git rev-parse --short --verify HEAD
 	)

-- 
2.53.0.295.g64333814d3.dirty

