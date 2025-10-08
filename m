Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702A2EACF2
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904864; cv=none; b=TFmFYCshaQbBInQGPk4B7edV4ffwtN4nwFFihBN9GYMyHMIvQXBHsXKVeJzGROV8bvtiB+yK9ke/e/ANHjkZI/vQEeBZQCfFrwFDUkgBXiVBng8G+NB4hlR0OJ43G+EF4RNj2qczqlNq50KcSjC9A9EAzpP+BKHwHOLTDc3mLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904864; c=relaxed/simple;
	bh=RDCjA3ClOkzsQHgoDs0J2xHi3hyw4iZBJN37tfrevQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBJq9jmT8qxsopUsKSgG05yfqmAg3FOi+nqOnZCjTb6zp76KUJ6TZeCWm66FxCcgS6txSDm0TFb8x300Z3CdclATJ1bcWpnnfSBqQJRdFXWhaDNbmondhzTuJMvQr57KwWnfIF9X8kq/1L1siM2azYydhOPi3YjilXMoO1lJVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P440yA2w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbthr4Gp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P440yA2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbthr4Gp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 71A071D006A0;
	Wed,  8 Oct 2025 02:27:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 02:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904862;
	 x=1759991262; bh=xsI4cfS/H4EeLFApealE2vDRyp9PaD53gtK2lSMPW08=; b=
	P440yA2wYEUHEs7/Q8h9dNlf/OoIFzfm/UlyCdocWrZxvBo7iBW0VquEh5igsl0B
	Z8vTGHXhK168SaCr4NiHgAZiATBJeACgyYnacdSbe0UOu4UFsTGfME7VmVdVBmRp
	VDpB1v16NxtlDcaViqwq0bhPQKZ/kquvdwHV/wtlD4fkJ5513v7Ps+PumUxm12KW
	R+ztYFqwv9prLzuB+m3Tyyr7bT/jcvXVnM7k7fNOrSn2fcvZYZuNamNjlFGJHGeR
	QPwplBRdKLWOO5uScUgSwX0KHNjaSLQPsUKWBq5U+GINyO46R0LR4SRTUiCgvM5e
	zXWJLv19y1YOtCRi2/+Dzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904862; x=
	1759991262; bh=xsI4cfS/H4EeLFApealE2vDRyp9PaD53gtK2lSMPW08=; b=v
	bthr4GpDztTpSN3EHFQojz0wNeX6zFYvvZ65TbZDZmCg9vPH1X1MHDXAa3L57Y0w
	9AV/8lqx3jPncN0UopWad4wmFJqQR4tZL0JVglMef4bFqPBa39dIwX4UJsfqlrxK
	W+iguwkIGWeZd++tbhqUrn6vnoCEC1w3RuxHb1snVUkZCmydwaY6wrtqhY6BFd+c
	PYLOXo8VQcMvufYQRhdwjoJoP+QZV0QnBiqsow/TFdJmJIjvXfHSX8ucnow0vMHj
	r2FhWvRi8qTMyBVFGZp46qulCB3uzDOhN0l8EM+3fi+rU5ewV8xjB3AUmO7JMYnG
	PLPuFmeeJloRjPb1lFaoQ==
X-ME-Sender: <xms:XgTmaN6ddE8ofa5STvzOVsRVHXrJkpYyXBL-3cjeQl5IdTXsH2zQYw>
    <xme:XgTmaJ-mjTWWspY-gQxfnk0BFsirqOl8Sc4tDrwqVFApsLXwb4Vk_oTC_Hk_PDFiS
    JkZLRvBieurcpjAoSHnAP5-4D85KW_KOAOkB7Inkh3eCUFk7eQtNPc>
X-ME-Received: <xmr:XgTmaKqJIyGJ2HvSJ_NRoCsewzdZ2oQO5s6se5QTukot8RZ5ZRxeWL_LkadYU5ZzDGOETGVeLMJr1D-6HUTQNvfGUntOHimuAxES9zdB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegffeihfetieejjeelhfejveeigeehfeelteejtdeijedtvefgheeghedvleffteen
    ucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpmhgrvh
    gvnhdrohhrghdpvddtvdefudduvdeludeghedtqdhrrdhshhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghsuhhn
    shhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XgTmaCp3cdPpXvMPbF3linXI7B01X7Q_Nzwz4BQJWBlr-rDbZmWehA>
    <xmx:XgTmaF0HVmfqHAXOQscQxhVT0aTXUtTmY_6f3zGnSftRln_OURrSOQ>
    <xmx:XgTmaIGusppOyDEsCp1TSgGoG9hbR8r_Xyp5-KzH4sqP7m3rfTyhQw>
    <xmx:XgTmaIGDi6YaJakPps7dziA8ef4jbu8rda-9vkPB5tzfMu6nU2GYmw>
    <xmx:XgTmaHMJQrfO-cjRY_GErQYye5lWu-7V8OI3qbFinR7bvDFggCIIU75S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 40134799 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:16 +0200
Subject: [PATCH v2 5/6] ci: verify minimum supported Rust version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-5-d556ee83c381@pks.im>
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

In the current state of our Rust code base we don't really have any
requirements for the minimum supported Rust version yet, as we don't use
any features introduced by a recent version of Rust. Consequently, we
have decided that we want to aim for a rather old version and edition of
Rust, where the hope is that using an old version will make alternatives
like gccrs viable earlier for compiling Git.

But while we specify the Rust edition, we don't yet specify a Rust
version. And even if we did, the Rust version would only be enforced for
our own code, but not for any of our dependencies.

We don't yet have any dependencies at the current point in time. But
let's add some safeguards by specifying the minimum supported Rust
version and using cargo-msrv(1) to verify that this version can be
satisfied for all of our dependencies.

Note that we fix the version of cargo-msrv(1) at v0.18.1. This is the
latest release supported by Ubuntu's Rust version.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Cargo.toml                 | 1 +
 ci/install-dependencies.sh | 8 ++++++++
 ci/run-rust-checks.sh      | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/Cargo.toml b/Cargo.toml
index 45c9b34981..2f51bf5d5f 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -2,6 +2,7 @@
 name = "gitcore"
 version = "0.1.0"
 edition = "2018"
+rust-version = "1.49.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dcd22ddd95..29e558bb9c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -10,6 +10,8 @@ begin_group "Install dependencies"
 P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 JGITWHENCE=https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
+CARGO_MSRV_VERSION=0.18.4
+CARGO_MSRV_WHENCE=https://github.com/foresterre/cargo-msrv/releases/download/v$CARGO_MSRV_VERSION/cargo-msrv-x86_64-unknown-linux-musl-v$CARGO_MSRV_VERSION.tgz
 
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root already,
@@ -130,6 +132,12 @@ RustAnalysis)
 	sudo apt-get -q -y install rustup
 	rustup default stable
 	rustup component add clippy rustfmt
+
+	wget -q "$CARGO_MSRV_WHENCE" -O "cargo-msvc.tgz"
+	sudo mkdir -p "$CUSTOM_PATH"
+	sudo tar -xf "cargo-msvc.tgz" --strip-components=1 \
+		--directory "$CUSTOM_PATH" --wildcards "*/cargo-msrv"
+	sudo chmod a+x "$CUSTOM_PATH/cargo-msrv"
 	;;
 sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
index fb5ea8991b..b5ad9e8dc6 100755
--- a/ci/run-rust-checks.sh
+++ b/ci/run-rust-checks.sh
@@ -14,4 +14,9 @@ then
 	RET=1
 fi
 
+if ! group "Check for minimum required Rust version" cargo msrv verify
+then
+	RET=1
+fi
+
 exit $RET

-- 
2.51.0.764.g787ff6f08a.dirty

