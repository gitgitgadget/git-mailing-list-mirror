Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472232E8E13
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904861; cv=none; b=OHl9jUORooFBc8VEuhEfgiqUDDl8PrjdvX+4kuPYRoGB1dozuEkRrJX7NzJTA2v07T4fV6s52CDEQe6d08n/53TiB3KrbFFyMX6FjRy+uIEPdoja+du3OLNR+O5FrOZwXPlmID+MfqSDYEynBqxMUkycVRYL8Wz7MQaWDC4j9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904861; c=relaxed/simple;
	bh=Eh49vDRAonKJhyQwwmll6foKOHeg7cUSlT3gDrTyZY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLgR/9XLAVzxxOHhf64JMYp/3oXJ40t9UntOAaI7VjHrl3Yw+UEyUaXrgF9FIFPyTEGWVHwZ5rCpGkM2pDXYcibDWEgOrlAY1gBHgm1RUwnBZG8YHBFCs0MZCVl4R30Il75pqJFPVOWoayX1yzzslwenUxjYR1OpmJGBMDF0gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFtRRhAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yCZvAJpo; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFtRRhAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yCZvAJpo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6AB0A1D00276;
	Wed,  8 Oct 2025 02:27:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 08 Oct 2025 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904859;
	 x=1759991259; bh=ugKjPWzpLlUTKPkrKuICWOoKx8md+kbbPlY2pwSbYVw=; b=
	EFtRRhAGXeQ7OWLmDekIQa5Exoir6eZveleBadum942yKH5CesizEACDxRT+wwUI
	br9WHdxaZYSFXc0APJJRKMxjG+p6gVcIDrEGMKkBChpjoUfc1qW6nXv/IbbOONLA
	453/1Q4cqdVk+TZtbcNt9MYnm1MXHCHeOaUbEtnG4Gb5iOZN0kdSSLRkqSMCSQFT
	Ybt/VJARWeYM5cxw5/EFl2YIKOeI/NessLZ1ArfeQZMkmYVZBAA2xUd+E1t9epu2
	mJp9E7cAYWabuuDJkp2HhjjY3j21bhkvqui4B8jG33PCwWGLkKRB+qPVSFr1VFF9
	nzkM1xsDCXDfPY8OJlXKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904859; x=
	1759991259; bh=ugKjPWzpLlUTKPkrKuICWOoKx8md+kbbPlY2pwSbYVw=; b=y
	CZvAJpoG3J1adqr1vkgaz4VeoN/MhO9kXoJt2x6UhVwICQ+LdFP0AL57lWNisGW0
	5Q+jC2k+TurY9rql7611I+IV6/th8vP9NKokx+ycxUXm1QaUcYrxKL7iuIFKSiCT
	ZHQHNpEIQB3kNtL3PfW8DIB6Xpubp+ZBbsNc42/7f0QUqVG3ud3XB0MVkJQzpo1n
	e0bc/nmqaOhgggcj+L3LPTsXdxqy339dJswhaar1MiaeMc93l4Yx6O1mqPv13Ax+
	7ZlYOk+P/JonXUketYIIF7V9xefWSrr08fR8hu29RcwHNskW3kVrFzc5Fyxat9+c
	kKYEFz+5MeUqMCQlyTgcw==
X-ME-Sender: <xms:WwTmaKrqF1XJ0YMP5wpg9WngGmz4hbGlfYx9siE0bEIXTRM6HTpaRA>
    <xme:WwTmaHuhJAetqSa5K3kLD_sEQDv9Btjw-pkk-cspKRyxA39q6S78dKWw0vm_XhAzl
    0BEQ7qt9h-aqTkwMi_6r_DXZ-cBr-lOvFz9iiFLXWBLtICuNLsw>
X-ME-Received: <xmr:WwTmaFYBng42NiR_kz5mRybm-gc-hrPJ7M7MWIKn5wNFJfnhrSgyEOe3deyjDMZwZF8TsaF23kQmsWOVFU5XMHcREcZcdy4K4pO5iWXz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivg
    hkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepvghrihgtshhunhhshhhinhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:WwTmaGbzqnLgbJRlHOPHxD1_xzk567OR5Jek7lMbUosEPiAyIJUNaw>
    <xmx:WwTmaOnUvWeDVu2i3KWtjCezM3PVUsvFzTZsQhx3GTK5gO23m8gvJg>
    <xmx:WwTmaB37oO5Pg-ZWEj5gX2hkRAVdaCt9WqwJdnIuQMS1NSbx4_5fKQ>
    <xmx:WwTmaO1JpmPExHVNbVSPFL-Z1wYI41qtCsURKZwJDw7_Ej_MuoxE6w>
    <xmx:WwTmaH_e2f14gbmBRwZS8l9Dzw2v5mmkeINc6ik0-MRS1fHVaLzjc7NG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2030e23a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:15 +0200
Subject: [PATCH v2 4/6] ci: check for common Rust mistakes via Clippy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-4-d556ee83c381@pks.im>
References: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
In-Reply-To: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Chris Torek <chris.torek@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

Introduce a CI check that uses Clippy to perform checks for common
mistakes and suggested code improvements. Clippy is the official static
analyser of the Rust project and thus the de-facto standard.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 ci/run-rust-checks.sh      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index a24b07edff..dcd22ddd95 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -129,7 +129,7 @@ StaticAnalysis)
 RustAnalysis)
 	sudo apt-get -q -y install rustup
 	rustup default stable
-	rustup component add rustfmt
+	rustup component add clippy rustfmt
 	;;
 sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
index 082eb52f11..fb5ea8991b 100755
--- a/ci/run-rust-checks.sh
+++ b/ci/run-rust-checks.sh
@@ -9,4 +9,9 @@ then
 	RET=1
 fi
 
+if ! group "Check for common Rust mistakes" cargo clippy --all-targets --all-features -- -Dwarnings
+then
+	RET=1
+fi
+
 exit $RET

-- 
2.51.0.764.g787ff6f08a.dirty

