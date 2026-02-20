Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5BC336ED1
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575973; cv=none; b=mN7kIU9h8Q2bLEO/AGeT4ks8jMHopjbs3MB7bbqnxX/tJj8Y3MT0DbKbvtdJRnWN5+7SbgdkIYs1dium3PLhXwZnSkAiugHnBYx0VOVUm+puwyaOvUjjLeNaVObP8NjAQasr8KuNkxYBNw/wCPb9uQhvb6AV87oUXMAs503oNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575973; c=relaxed/simple;
	bh=lrionZRsyKY2aZx/+IkMOkgCX3Wu18+70urBU0oDdU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONPQnZVfIDyl8oL6jOksv4OF/TWwVucIyQG4eeJezf7r5B1XJFgMi9wCswvSGJREaet7iszSqst3MamS6/LBWrIPOIHHKy+RVMFVJw8DxfuIMUPoNyhmgcuSbJo7a/KCf0PGLe5xOuvm5ueVI+Hw9r6LYLviAYMByZUQ69vgYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BfnQEfTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTIABBQA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BfnQEfTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTIABBQA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 946837A0011;
	Fri, 20 Feb 2026 03:26:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575971;
	 x=1771662371; bh=Xaau4rXYqZbRbJA5U1E0W91I6LCb58EYIuJZeG2kpHM=; b=
	BfnQEfTttgB8tt5XdnWcpmDN8+FsGLFjO2/X2ilSYmkIJfmwMIHduHWlBerj/Trj
	p4PWxLQtJ1IY2ty1ia6sakSE3qKDF6uQBXYXNXLyBJqQ/A61Xc/xXLF2C2uShCJp
	xmL1EYvqpH+Dz727HixEj1NlEcaF6NTb9LTILZCVD6FhcecIO+yjwUZ4vFg1SxDa
	DrVW18Kb0KyExv36Ft9EDErO0iBtjnCLgL4NOL9XVziIyTTszjNtdqv/JukfdUW+
	QluhUDRAMlRqDd+h7PIBsC2JxYzLhJ9zeQsem2r/32vXAerAYKZbuCSWBKArdhjO
	rQqRxC3e4ypIZQq3aysrMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575971; x=
	1771662371; bh=Xaau4rXYqZbRbJA5U1E0W91I6LCb58EYIuJZeG2kpHM=; b=R
	TIABBQAk9IP5r7aMg4Fm5FPbOgHkyMsDCK8IOuLY6emdjIsteJZLlprrXklq1j3z
	6sOhwGp3J1zUG8ruJfzZ8C1GU/0JGm3DxBnZnpTWCm+/g0bK+EUsRf2+4L1/RNUS
	cUH76UoJKYfAHi8E0d1QeQa2dqDsrVjGIZzvuynFozulPIW1Lq/BucGoUtR62tZI
	+aWFZLUMaXFDZrGWEELGxwzn9mSetqWWcSIoosTOzrsFV6sLP8wcCi6oQPfhViig
	HtXQqitF9y3cHVT/Pg3cGZpQCXzUD8HAiuV/J3laqVPkRRFTjhJCyzSPGdJHYa2Z
	fR5x4THWJjM2WFvRRewpg==
X-ME-Sender: <xms:oxqYaaTO9vrAODU02uyC0j3VyZPi7-3h73-mKZXEsPclvzamqA2JrA>
    <xme:oxqYaWwUHLN1KauxZ-tHUHBm8glUxq2IN3tQhW7hvEPy8zLf98BkhmsJz-vhKuCAN
    CDpRG0q46aichQIWjHYvi3U6325NpPEDWNDBpKPTlGv-Dy5c2cJhQ>
X-ME-Received: <xmr:oxqYac3Hx2bKgfFBuo3s8iEqd9eqaadhkxqSPCPfQtyRFl4-K5gbfKxFqdlcC472Bch_BDL3Y9aw4uqliydDhn-uzJXRQgrpMGtx2QerTcn_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhstghoohhlseht
    uhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:oxqYaU5OrhDdDKLmANSn700OV3nPbAZePvFpULHCmwu8nFDbatzWZA>
    <xmx:oxqYafWgujURIzUQPwbB4ievLfPXu1_GUv65VgcsM6o6cTS2eNgX4g>
    <xmx:oxqYaTD0hLNgYPvINRdURtwpRMhcLca69L5z5j3VRTV7guADLoc1Qg>
    <xmx:oxqYae4rKicmyUt1-abvX2euSlSiOG9dZHzUpbgeDdoGMWhQEWQtAQ>
    <xmx:oxqYaS9j2GIbMwSfU9TqWck4S6HxFGBcIuywVzSoTVO6dZz7hcf-GZg1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae0638a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:26:00 +0100
Subject: [PATCH v4 2/5] t40xx: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-2-e0e6bbcaeb5b@pks.im>
References: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

We've got a couple of tests related to diffs in t40xx that use the
iconv(1) executable to convert the encoding of a commit message. All of
these tests are prepared to handle a missing ICONV prereq, in which case
they will simply use UTF-8 encoding.

But even if the ICONV prerequisite has failed we try to use the iconv(1)
executable, even though it's not safe to assume that the executable
exists in that case. And besides that, it's also unnecessary to use
iconv(1) in the first place, as we would only use it to convert from
UTF-8 to UTF-8, which should be equivalent to a no-op.

Fix the issue and skip the call to iconv(1) in case the prerequisite is
not set. This makes tests work on systems that don't have iconv at all.

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
2.53.0.414.gf7e9f6c205.dirty

