Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49241305E19
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508271; cv=none; b=aHZQD2xbm4Ts7KxH5jVUu4hxYESp2zSKZ1TR8zoBv+MJv/Hay+zrMifbs6c8w7C0vxtYrSBjv9oFpiitvcC8ocbAwHTkDhXyIrs80zbTrMWek1E+/FphW13WPoCczZ5EGzMlBKUZI6WdF687p5yO1nTSF0kBrBjT2uMrIh8tN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508271; c=relaxed/simple;
	bh=YAfNq4W28KuFphNf63YjBLXnlJTJIotPM17iBLAAIY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAT3ee6VBANRPg2An4zeskxQGd4y8tk7yNEcx6W6ujKSW1TwN98wjsddyInBW9orNQHk8kriddTrjalrLb5ImoCuHxz4ZgJtVykdxXrWTrpUYEJvKiCsB+KOB92v/sMvrEpyT1oFaPcuCRZpy/7JoTvW5/0l8q1K8b3WWrNRsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jKnfoA+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NmXEChX2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jKnfoA+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NmXEChX2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 36C551D000EC;
	Wed, 15 Oct 2025 02:04:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 02:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508268;
	 x=1760594668; bh=OEa7oh+cfBpFcItWBG8ZuDA/B8C+fKHBPjT3F6K/WA4=; b=
	jKnfoA+w2PaWXAM843KVNlxYX/XzwGmP3zcJAF1/XgCaVCMfdyzPiihwnbpkBg7g
	urU8UXJq7SBtelOwJsF0Bp10VbyA2U05UiOaebnHS5G+7qdBrQSz9qbh+MTqcyyK
	5E0RuRmhWTuqw0i+kb5y3kQs9rsi6Kz/0dS39McRZzfpBjLF4kR0i1zep7ikdrYg
	DZNCMS7RdXXU2kzYBAyanpPtwn/J/oqd8VX85WBqf+YYqEc90eW/RebZ4+IaFtkh
	mjuecp6u0algsem/Va2be+9r9HE7Nn5ydo93KNpz6P/kE8OOLUq5pJdP7s8h8UqC
	TvN2CLzDJccKDNv91EHQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508268; x=
	1760594668; bh=OEa7oh+cfBpFcItWBG8ZuDA/B8C+fKHBPjT3F6K/WA4=; b=N
	mXEChX2EWZChc5ZIlclEeYQcfH5Te0MOTgrQnkv1XHsteyC+UloMYOOuKincd0yn
	GC/8aHxTVoQ6W5MRzt2if1Mg8+qv0mR7BEzUPrBLtQKNNJZrb/jnExbbRVEFk41O
	J9qYkz2Rg8x2RScgfPrIYtiij/fKkgsmHJZInnfbAg/5sqrmOhIMnMd8MlBZlHtv
	Ztj45pWQIcofTGjoEvll7sOhY4mRRzufsvoeD8yidPry9K5mB7kjRp0iuqIqhjtZ
	36n9hW5C5v84XEdzLz/O31RjeAFpBABN67hsx3N6W5jRIQtg/kSc/4z+h9bqliGh
	gJNs/66WuiFAdhu7IPETw==
X-ME-Sender: <xms:aznvaLW9PV9seku6yiDTIUGVay9-yF9u8V66n3NP65mNSQdXArEiRA>
    <xme:aznvaCpf_2z_ntH62mPsoT0DioQuPlpvqKhwMS4mVoip2fT2U3FKl4XsY8lCFRHo4
    M8j0V584-8tKBcGXJLe6GwbxkBXF0nA_HyvCkCJPHnRw6lkGYCnGQ>
X-ME-Received: <xmr:aznvaNn-f5IW2K2_qpBO5JkvBgSzOehhRK-JvPN5UohEj872Dz8Q5mIkBYkDWnTa5U7u9Hzjxrc0xA3T1-6eMTnKs27R99SeKGgS7Rtn4KTR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrh
    hushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghrihgtshhunhhshhhinhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aznvaC2Wa_LL8gvLB3d2dGoIGUHBznajw2Jal00t5cZszv31-Ediew>
    <xmx:aznvaKTtdYBOojGFmpot0-YUdRcJ3dAeKRn6LB3trf-0u83CYBL0wg>
    <xmx:aznvaLyEn9GaiXlclQogNhEfP8pNZNxiZ9-EprFFk8-pw7nuyQ21Lw>
    <xmx:aznvaKC8P3pSBPVBBwYImC8vzat6Xd4mgQMLPVrqeFcn4wbLktPoTw>
    <xmx:bDnvaBpwf_TXWDxDm_rllvcxUGQD55oraFYWqO1m9-eqTAUDo-SWZ5xD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0fb4eb3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:08 +0200
Subject: [PATCH v3 4/6] ci: check for common Rust mistakes via Clippy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-4-13810af33bd5@pks.im>
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
In-Reply-To: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im>
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
2.51.0.869.ge66316f041.dirty

