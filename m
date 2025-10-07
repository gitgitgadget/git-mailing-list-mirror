Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F402DF12F
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840608; cv=none; b=OoXO+R4JBnOqEMEh0nCcKpUnYdoXKMxprlRJvXVvj+NE4mYSiQyA4dW9hMhb/y4ef1xO0/Lw8zGYxhBbrYld61n+3zrFOyR/ubuiXUkD1Oeh7gFmAT2y36AGHk7LTo62l0oj/no2znRYFX/jM38SoYHidQx9Ve2WQjosCRXuoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840608; c=relaxed/simple;
	bh=u7meWkKPfmwH2yR5dY82Vvf/6dBnQ+P6iApCHl12zjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNzwBz7ll3B3xynPGYU1K/6FenPTlm7IxdD2J6y7x6vm/OEZtNDRt5ba39VFR9u6mlboTfXBgeXTE9F/kJyZ8evoH8jXFH+Eu7sABTvpBfgghN1ZkEbeoi5eSocl6jlpvft3FWJ8PevN4PtvoxxyJmPd8zTR8FGCiz2HkovG0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y8iodRLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+ChdV98; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y8iodRLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+ChdV98"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E8CB8EC0367;
	Tue,  7 Oct 2025 08:36:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 08:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840605;
	 x=1759927005; bh=c+DiD0V07qQlZjuxt33senwHZxy9ktuE8OEWaiPxRCY=; b=
	Y8iodRLNp6omtoFewtRY15VMjDEvRUlDn/JKW9qA5L0KtdKTaAsI967sRaVggL1i
	aoTBLRwfkW3o4uSWyq3g9BLmwQ90s6ZKf6ZoOjSB2N1geCOHs8q5NOp3M59VUh2G
	pd65oc6q7e0xdezwFcBxccM07bTsSoDoPl601S0l5xgAXYjn0qXchFs3gTFW6dDD
	jj7QpR0bxCmCTk/hSG5cqfmq6TzgE3QBYVzF6vv7+hE7RhEz6pPavh470fKBNAnT
	DRn8OidwyS6MfTzDdLv9nDTRi1PcTgmE6o22rjYLLqM4uVSA1p3LYlXfVQEV3/ra
	lnIUzBKPLRcX6H5Te7TwqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840605; x=
	1759927005; bh=c+DiD0V07qQlZjuxt33senwHZxy9ktuE8OEWaiPxRCY=; b=X
	+ChdV98POTIly57O2uzcYNbZAPfMT3yS2C9puQQtr5Feo4wsBFKhFqmqOngTQirp
	oQby6AkVoi57pX1MlLIHsq6rFfdadeVDytbe7uD3nVD3uiqD7vVX5tWD3ve0HYWU
	UwASJhbl7BPY3HLo3i1eZuEqWJSYh9O270TuM9+WObZ/rFaSeQIJYWbNQxXTYqAc
	eXh2EkD8n35/lCs8/CT2a7VzpEEl+Up7uFVfBhQCGeBbvtdpNzdxDK19ab6DCM6F
	b4O90+ZWU1mkXRJ3TQ0ML0S85l3QO1aEFfpcEbiAOe8CqZ68fGHQwJPjKyS+0Iqj
	/BsjKuNYFKI1s8mFVUyRg==
X-ME-Sender: <xms:XQnlaBYMm-GIXNgNa2PTIdn60dKP4V7bMWqCbrmSo4aA0P1E4rIjjw>
    <xme:XQnlaPapVvexTHsp-0egjWr-BDhkpqwakgvGzP-ISjbeWJZIyt90V2O05sX-kWzg2
    zK_3kdRLrYuJzx5FdkkbekVLV3QuuFHpH8w7M3MTNfrxzzOnVMI>
X-ME-Received: <xmr:XQnlaI9vS53raGnb9uRwh8pLYtQoHz0HMRuRdysJFC2WfjnI1AjYX_ux1KUotVu6FbUtExcMZLgsmK2v_jkfp4GLlDjpAba85qU3IYRvVjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedvfefhuedtteduhfehiedtkeehleevueeigfdvudduieeifeejkeejieeuieen
    ucffohhmrghinhepshhhqddrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XQnlaOgHTXJQwV5ogq6llkAAlBYeeJFg2DwosiCeWsYjh2DoJaw_Ag>
    <xmx:XQnlaIcDCAe1-eex9trjmqWt_Vp6OBF30M5CuAZYDQGP9H92FVraIw>
    <xmx:XQnlaFoYn9LUB3l9NzaGeoFqHMfj80rEJAyZRSlZrWlq8-8pXGgCFw>
    <xmx:XQnlaNBNgaSAYkh25hhpn1IpBmegpRHCTsHTAsxK0Rv1MP7Smu-04Q>
    <xmx:XQnlaEJGOGNwtGeYFv3X7Cx-18ez8F0f_Zn-ATTCmYlACxvAgR10hQwF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9123052 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:30 +0200
Subject: [PATCH 2/6] ci: check formatting of our Rust code
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

Introduce a CI check that verifies that our Rust code is well-formatted.
This check uses rustfmt(1), which is the de-facto standard in the Rust
world.

The rustfmt(1) tool allows to tweak the final format in theory. In
practice though, the Rust ecosystem has aligned on style "editions".
These editions only exist to ensure that any potential changes to the
style don't cause reformats to existing code bases. Other than that,
most Rust projects out there accept this default style of a specific
edition.

Let's do the same and use that default style. It may not be anyone's
favorite, but it is consistent and by making it part of our CI we also
enforce it right from the start.

Note that we don't have to pick a specific style edition here, as the
edition is automatically derived from the edition we have specified in
our "Cargo.toml" file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 15 +++++++++++++++
 .gitlab-ci.yml             | 11 +++++++++++
 ci/install-dependencies.sh |  5 +++++
 ci/run-rust-checks.sh      | 12 ++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 393ea4d1cc..9e36b5c5e3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -458,6 +458,21 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
     - run: ci/check-directional-formatting.bash
+  rust-analysis:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    env:
+      jobname: RustAnalysis
+      CI_JOB_IMAGE: ubuntu:rolling
+    runs-on: ubuntu-latest
+    container: ubuntu:rolling
+    concurrency:
+      group: rust-analysis-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
+    steps:
+    - uses: actions/checkout@v4
+    - run: ci/install-dependencies.sh
+    - run: ci/run-rust-checks.sh
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f7d57d1ee9..a47d839e39 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -212,6 +212,17 @@ static-analysis:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
 
+rust-analysis:
+  image: ubuntu:rolling
+  stage: analyze
+  needs: [ ]
+  variables:
+    jobname: RustAnalysis
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/run-rust-checks.sh
+
 check-whitespace:
   image: ubuntu:latest
   stage: analyze
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 645d035250..a24b07edff 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -126,6 +126,11 @@ StaticAnalysis)
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
+RustAnalysis)
+	sudo apt-get -q -y install rustup
+	rustup default stable
+	rustup component add rustfmt
+	;;
 sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
 		libexpat-dev gettext zlib1g-dev sparse
diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
new file mode 100755
index 0000000000..082eb52f11
--- /dev/null
+++ b/ci/run-rust-checks.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+. ${0%/*}/lib.sh
+
+set +x
+
+if ! group "Check Rust formatting" cargo fmt --all --check
+then
+	RET=1
+fi
+
+exit $RET

-- 
2.51.0.764.g787ff6f08a.dirty

