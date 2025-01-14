Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D8234D06
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855877; cv=none; b=YRQ9odnsEEY3u7Knv/1ryS4obEIXrtzh+J+ETB93CfXJlsdc07EuHYok4eT7LtNyr8qxCBDqcRoLZ+WAiy3m3+kVeirqMnpHWscPF524f37Viy0A13l99JffYJ3MCz10k5HP1BuN1ew2/Dn0ioDMSdHCORiPfjt0U82zyrTxXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855877; c=relaxed/simple;
	bh=r4rwZyzZHLIWtYqLqD8MmQnB266kRxTp1Mwa8mZapz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSd7NpTMr9cFVSJYn3WjYXvjSWIRnZG0v8eaHm3eos22oj/wiAJkolXcfTMsGcVX8IlF5mt57duT5FB2riU8i25nDstCkG3choEdP0f9Es3PuTRt+ha+amRADn3CzFt5d84+bkxNc94cL4B5neJqs/xvcic9rl24kiHH6DUUK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BPWnTLjZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/+8IsPW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BPWnTLjZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/+8IsPW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9A38114015B;
	Tue, 14 Jan 2025 06:57:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 06:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855875;
	 x=1736942275; bh=0qFE4We6SZ7pOyiT7RV1pzTcJVkIzCTQdsce9iHa2pI=; b=
	BPWnTLjZ/jxvMjgCEsWMB3GM2mG0xjxlsL7J/G/4Oc/norTkJ00iTyitqTZXnHVO
	7XISqB6WHH9o93kNDlY4NtZxSEqBfvM2fCJ/jba5S5iM5+ohejiCYR0Rs49MLKbN
	jT6uuYFVOKRKs+h2ZDFrQHzUgXunrr3HLeeLSVNKAERvzTCvIhywvagJTxqlmIXs
	D96xjP0UZUZihy6CMuSA43FfhQFR7z4MTUpOXBLfrCQrBoM/frbHJYvWiofUSfun
	WhOMqd6DGmAuLxOEPidY1sluQFXRKDMX3ZPXmX6S87f/OYVU0qsf2Jwti0gSR6Hy
	6RHjeDJLkrsSxeJ50w+Gyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855875; x=
	1736942275; bh=0qFE4We6SZ7pOyiT7RV1pzTcJVkIzCTQdsce9iHa2pI=; b=N
	/+8IsPW5zxOj5ZetU+N0kJJafRWEQHEoA57FvFlCfgDq9na9QMLatj5cqHrC26yN
	e8omnNbvERxI4DUgv/mTJb61b7mlUO6/LDvKTlV39vy8/58ihVlsUFUSCEpS/SMH
	0lDQvNPecfkWnkBgiibzoiD6u2DHBO4K1JC+H7LOOCnQBQTyBQQW3jM7I8WaL5UM
	ZvLEmK4aGKAb0Pwwiz9VSBLep5BuZQsstf6bv/bEs/SwNXr5TVkb2PdxfAtUZEcx
	E/Ppguwz/1tBTCTKMk4BP2QpKrIEFkBmuWhOZeeXH2sQCIucbmwLpcFLGm1+iTEm
	hMYunCPxZuwreEVxUzz+A==
X-ME-Sender: <xms:Q1GGZ8CfGIVIIAPc3QEI0_8adIBXXQmzok-xsqiAaKiU5Oq1_ci2bw>
    <xme:Q1GGZ-ig-NeX2LIt7J5gT8aGnu8wMfywuNCmqzgjeLc6v7mNjX6ZH-S_tmyZBYVLM
    XfFGYKJ5Dco7jOH0g>
X-ME-Received: <xmr:Q1GGZ_lKrdJATgpDzhLYQE2Sj76TlI9aXVFlqh649yQSr2IdhsiY0aWFAIIaXEUNFJbNFNrYu0YjZOHwd7q3XinRrDMCv-uAi7nPVe_L3vlkSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:Q1GGZywOlLWiO2kmM1ZDG0gGJA_vXtoximx6Rx9IET1vEL-hnEeFUg>
    <xmx:Q1GGZxRVmcmeB1iKX9efVz_H9RAWR50Etr-yGGeoTxy5D7Ghu6kVVQ>
    <xmx:Q1GGZ9bND-CCApicmXl5x-1_PRo2g3oxLno5iASGsdJoNpx1OTerJQ>
    <xmx:Q1GGZ6R5jmGSAMc8zowE8yhGZbxt1KRNo7_t1_CywCd3KjoHezVdfg>
    <xmx:Q1GGZ8dwSq2Z2xVbCx3PjCvEP4Ia2PWj1931B0zjDohS4yP5wmwrCJpN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc37a002 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:51 +0100
Subject: [PATCH v2 10/10] ci: make "linux-musl" job use zlib-ng
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-10-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

We don't yet have any test coverage for the new zlib-ng backend as part
of our CI. Add it by installing zlib-ng in Alpine Linux, which causes
Meson to pick it up automatically.

Note that we are somewhat limited with regards to where we run that job:
Debian-based distributions don't have zlib-ng in their repositories,
Fedora has it but doesn't run tests, and Alma Linux doesn't have the
package either. Alpine Linux does have it available and is running our
test suite, which is why it was picked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5ae80b0486c65833825352019b2873498e801db0..be7ab4b1bfe972f4b5437c8372c0b9935f4e638d 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -25,7 +25,7 @@ fi
 case "$distro" in
 alpine-*)
 	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;

-- 
2.48.0.257.gd3603152ad.dirty

