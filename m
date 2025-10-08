Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED692EAB83
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904855; cv=none; b=KTZvyovsvJudSvOd1vt3COrDiADmmtQnYbH+zwUIixkKnjhH4lDFpSb/FNykHF6PeZW/m1FdykZ8xTG/FmtrhVJduJmQEbGeXqsFEKfeY7My7io6W6tHHcd2Re2t39j09KFszIdG7r3LQu5DnmF5c3HsZZxE7Z2QZEBbFxYAgyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904855; c=relaxed/simple;
	bh=zYjS6EcuakxPUXP4SiwK6P8olZtkfL6r7YEV+1XNgGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faF+gdmhW69yuoijjVGLmpP1X6JtJNReVaQxKqg38nxzwMzhs2HJ3k61An02NdhVwzEZk+OySFqUSlkkmLQEcwdwhdNvWQDsLWlWrj1j7X4AT/pbNFSwWasvBQg9W+/j75maYrxNALUL/411n2Ds0CHxRkprsPfEBwPgCSpyHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3uwMNBv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hC0O2ec1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3uwMNBv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hC0O2ec1"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 621351D00166;
	Wed,  8 Oct 2025 02:27:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 02:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759904852;
	 x=1759991252; bh=Yz303a04FW5D/MS6Pm4NBjfjrpi+lw8BiHg5gCTiedU=; b=
	e3uwMNBv58SwqZxfLlMcJQs9i2KbRioLJyZyEbqcofx5sWrBcCjHnddbIOuW0SZc
	EDEc0DzFPdU9GePnc3RCzYsUMPZxPJyN6HNnHJSA7Ofv3QJqK7229fkYzdA+R4IJ
	G2MSMB8XcTsov0QYYT5EIP8FXMnKmS9dDG7UjqZnngiK1PZ1XeF7dub5RXfOFT9e
	RcG6Y3Xj65Ug7EhhBK5oF2zBjJnz3Pvx+ITygqCmckx/hdDObVdNgeqnlwt6ec+v
	8Y14gInwJOE5hHTF/PFdcwCdYQX6w350hHoynE7E+u9CK1v4JQOfYWEwMT23Qh43
	m/2v3hIaz/JM98JfPmwnPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759904852; x=
	1759991252; bh=Yz303a04FW5D/MS6Pm4NBjfjrpi+lw8BiHg5gCTiedU=; b=h
	C0O2ec1DXNA1RSfubH18K8ghyLXobMEVSDW4d8pJmkoUCKFzPJXDQuREh2feg4MP
	hA21EIqVDl7RQTSej1kEGtDVsxaaW1sm6ovaCMzANxgzFAX/oX68kTLwhjbNjp2q
	OvB6YdRHFSzUMCvJHsLnNqAXjTxr3qGkv6SUjfEIY60a17kduyyha8D9oVm2Lcw/
	IAYxaX+smz7mpU+VgPJT3sxVIg7RvB8IkJfNzPkSd78IqDX2YRcTjNh566OJVslk
	tBp4S6vGAHs3dCsBRZjqIjSstat7C47YR4rnqlJS+8tFhyWsbWj/E4J3johZbk+X
	owOLfp1ymYjoPUGevPaQg==
X-ME-Sender: <xms:VATmaNArNA-I9maEFXVM6058K3781OjFEVnrjLszXP9MAk1Bn8DDdQ>
    <xme:VATmaKmCvKqie34ZvqT-UU0-WRGiUPQAITHIcysV9IAhmVEvFtebJsZqLXVCNmUxw
    idskCDDaBE-XfXIfSpJhFJfM8uBMyKwMZNgTu1iFbmDzteX0nkn>
X-ME-Received: <xmr:VATmaOw1AKXs8THFRGdqenN65zuoCH_jfG-SUzaocu_JAabs71bpQ1KOaqC-oGdiIbUTqGlZcDxDJWbnGbwg6h3err9UOUwCEb66zpRz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedvfefhuedtteduhfehiedtkeehleevueeigfdvudduieeifeejkeejieeuieen
    ucffohhmrghinhepshhhqddrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    tghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopegvrhhitghsuhhnshhhihhnvgesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:VATmaEQbAkSVAEkOof9US29Cw_P7h1HAugHZLSqtYfR7t4qY5eYEzQ>
    <xmx:VATmaG9CUxw_6OpSS_-py-ZsCzEu9s2SxswsN86XoAT8KyOM469hFw>
    <xmx:VATmaCsBLz6zN36rFtlOzlEGz7W_p4nlx2B7haMLc5nEvcd21QwfCQ>
    <xmx:VATmaONxd5WTJUv9fjQCOdayRHhdQ8RJ3Ixw_YFZyMKv-SewmPax8w>
    <xmx:VATmaMWHHFzIgiaWtwkzLkRRtmdqT1ELr2cM9_Q2LiKQv4pdO_BkpxLJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 02:27:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1eda9816 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 06:27:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 08:27:13 +0200
Subject: [PATCH v2 2/6] ci: check formatting of our Rust code
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ci-rust-v2-2-d556ee83c381@pks.im>
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

Introduce a CI check that verifies that our Rust code is well-formatted.
This check uses `cargo fmt`, which is a wrapper around rustfmt(1) that
executes formatting for all Rust source files. rustfmt(1) itself is the
de-facto standard for formatting code in the Rust ecosystem.

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

