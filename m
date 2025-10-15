Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC02FFDD3
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508273; cv=none; b=XZRJ0f/AkRUXSQQAgRYo0eelb45vMn6ocr3IymECEOIFr4B7R/VWkOLKSAys2p3WX5OghYDge89vODYnIBGzKV/fxk4IcyFVlhdLjE/KbB0E2Ul2tRnUQnIoZAhdB6bQkGoSdCPUGsTd7ScmVQ3mGyVtAgwHcoObDrKHXwVhs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508273; c=relaxed/simple;
	bh=prbCnmwnFFPXiMQ64Ch8tCaeVsUbtsQWXyVtvkW7mRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0RE73FUdpM6zmJBSp+4Ns+gPtYqzRflWIet7OR7vVQBWBADngiOYHL5lbQCu36VUJQ1VBAOiQyDXD3FlpAQdVFPdV8n/zykKpiXB0HBl3YSqOR98Ylrowa+0MqO8R95mYc4ukm4nuNgSaJeyCeeEDq6ZiBf8sW17HHFwFCC4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NDs5ewiU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1wtqyaN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NDs5ewiU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1wtqyaN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 327121D001C4;
	Wed, 15 Oct 2025 02:04:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 02:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508271;
	 x=1760594671; bh=Olt1QjTBYyOiBgej4FxVaf4Ke4ApkRDldGwGJmtt1fs=; b=
	NDs5ewiUjfXvdbFGRwwXIlSmKAkvkwtBBBYST3mF1I3aiUpPwqHKK7p+HntAKoJb
	pCYMWydtyubFPAL8F7AVSMCoPw2dJ3fauUdY/Zgez6UjF+mKutsDOTkOFQ5mTB6p
	7ffHVELsbOQR1cIPDmF7byRrdH/1Ww5GonzQGQY4xKUYBaFre5RFCQip1mjvdCKX
	U/TDv9agflHWpsyeVfm7F/sImbWa0q4b4M0OUOBtK/UDNgqMiMbbIf/WhK2ZgPs4
	M6UK6U9Rl8tdmARmEJySWwqJfHdz8z9MY2eZg+duAn33vlyXP/f3W5kyRMifO77T
	2FWdOhbdXE6osiP/paLMMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508271; x=
	1760594671; bh=Olt1QjTBYyOiBgej4FxVaf4Ke4ApkRDldGwGJmtt1fs=; b=Z
	1wtqyaN35lpzuiO9WgNIYBuh12KDvjB05h76fgsZGu+zoygDN6Q606MqcEmTspQV
	lP/FHn9X2fEdBJ7TwIh+ROIwDyyDsO9LQx5LKuyiclAZnKFARAu1lQy9qmkw40QH
	S6f6HMSmgcSwcLYIRNLXD+7IUL07g3LYi1ngRX1dXY7e1nH0FRFAnh0piqPserFC
	neTLHbFAMPq8w4Y92Hlo+8+JyF4pV3kuBsvUk3qqMw7rt5qOGHPJgCInYWIeXxUl
	cHGWk5Hco+23/2YW4Rrru5PsPqeOuj7bOErCXMqc6nOL6ZJteK1k4vnAX4tqY053
	FnbMFFWJQWLU/EA5MM7hg==
X-ME-Sender: <xms:bjnvaNLip30iljuq-uLFw_w2yiC5sTqDJ1utrABuJMYLqrw1905J-Q>
    <xme:bjnvaIM6RRqc98Kjso8p74mpZlIR_-eJo3Cs58yhFfMd-sBT_n8olD4rU70yfkDZU
    Q23gJI_M9E7f7tRxr7K9ZLw-s0TFfqOeZQ7h8BOy23cPgepzUANV7I>
X-ME-Received: <xmr:bjnvaL5ZXIBruYccie50ri4rt8oycH-E83JBkhwl_a8Udl7A4UtGqWRmmiDRz1yfeOjRXkR57Xg88kd_jQowOJJDRTR63tPAG0H7CuNp23qt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegffeihfetieejjeelhfejveeigeehfeelteejtdeijedtvefgheeghedvleffteen
    ucffohhmrghinhepphgvrhhfohhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpmhgrvh
    gvnhdrohhrghdpvddtvdefudduvdeludeghedtqdhrrdhshhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegvrh
    hitghsuhhnshhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghl
    nhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bjnvaK4HBJRQDEoNzQ_yBz7U6jL8dLXLIUxguokpwm7I0rwaShTHPg>
    <xmx:bjnvaJEnRMWhq28CPt87mQk_duKH2FC1yiCNinQmmqxQ-Cz4ZyTkMQ>
    <xmx:bjnvaKUc9VFeNfUhK_Ytdx3Lx_D81P6TBKuNWX15kS1iu5k0W4-AQg>
    <xmx:bjnvaNXA-B0k6s8I19Qp6YMYnnj3LRV5Mc5GieqoQpaXHMaUAtXiTg>
    <xmx:bznvaCe6ad0H0Ce3sm-Mzk2daLXlXN8jDu3O3-_oevwl8gPcLvD64LjI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a54be8d7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:09 +0200
Subject: [PATCH v3 5/6] ci: verify minimum supported Rust version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-5-13810af33bd5@pks.im>
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
2.51.0.869.ge66316f041.dirty

