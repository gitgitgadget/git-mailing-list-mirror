Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B382302CAB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508265; cv=none; b=IX/k1+qSeaK5rKT7t8aVBk1RF+SWRRvgWR4zk/Zlz8hMohJyCOVKrh86qilv9ZOliUJ1YVHhDeaFvQW0rYHFu+XjzzMLUiXKnJecQDDTh107eHuQal/UeC10+ivIsXx0ctBCkKMmO1si3Y84RemXTfBzqH64dZgcPkxS0CuuLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508265; c=relaxed/simple;
	bh=TWEMxAXslWgHQkPGwiEHTojUjiiGjsoJMmY27mppzZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKdHZpAw5GlcxBMIVDzNzYO1rHfJlZ3eL+ZOUdv5HmFW4LqSH3Lw8o7acR/osfJEA9Ljb5/4Ms25s74jlLhq8wvhVwQm/9iQ9yg+mlBSsOr3/gypPa8dja8vzJI+bfdDc62ILaloeZuNmGwZuXa/zGnXkZS1eGqhoxqZX4wAl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XtTud94a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WcPxi6hA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XtTud94a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WcPxi6hA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C3521D000EC;
	Wed, 15 Oct 2025 02:04:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 02:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760508261;
	 x=1760594661; bh=kT3xT/I62h3pZ/JbwVoLjThqvEkvv1pDk9iKJU0nbQA=; b=
	XtTud94ae8X5Xpa/IO6AQMAcUkdYXnpt5JyTr0iv/pTXHNzK+y25Lvl7QbJ7Hbf5
	4W9Iqu4vnit7bQRznzhxn8OyYjM2ioyY/YEIrqN5Lw0EB54Iklx1/3nxsojPxVZf
	b2MV+RKd1mFrM4gCNFEI1A4iGm3Vzg5U29RzxZEUuXv/rhFjOepNX11iUq3R8DoF
	ws0DxCtoz+/tg07US3FF+ZVAqGFhRbolonGgv+m3GVVQtoG7q8KYV830sFycWvpK
	bisbznb9rqUalgeF0oXWn5hUiACo52s6sh5lVzhFwtAyu/d9G7Oq6He86oL80Snt
	tOoQ/4XKwfyNXW2uawQMxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760508261; x=
	1760594661; bh=kT3xT/I62h3pZ/JbwVoLjThqvEkvv1pDk9iKJU0nbQA=; b=W
	cPxi6hA4o6ASTvujHg81wFCEAUC4dVF6Vq/t3LffVjlIPQl0hx/+7ZU1j4VMDe5r
	O2YYWaEj7U4z1MBvPt+hhHQlfuN7VdqI66cUgo3anwIMZOupXQwc5LG2T0PJ/uXQ
	Nk2RhwnBhPzFTKhTOXlSwX/rBkSLKRqDjEHzEj1HzUw09k49VbhAslpFpAguF+FC
	YLpt50IJhBjdDYuuBkxZUxcHukYsfOvXMuXOdNV86CCOSuouX3Lm1vqIrVmPzHAU
	cHPu/AqGFMAx8KhyuZf2ATnyNxXbr5VOkqr3cALj5gRdxEgXxmBWn5NKCvvW2qZg
	dX9+t5JKXBYoiSZ68alIw==
X-ME-Sender: <xms:ZTnvaORtT2E0kI6qqsmRXx__S-Y5d7SX7fhwDTLQD5Ul_pFl2AQM3Q>
    <xme:ZTnvaC2dJWApaCP0oXPO3ujYUr4DK6n-Rd0srpNZ3AVaud2CaTTaYqn4PnrHtIik6
    fz1BhGercs3XPR6AmM-IgeLx2Vyk_hhRaosRkUyw3MGQrkvfhTrXg>
X-ME-Received: <xmr:ZTnvaCAYQzpWlDwfNUf1IPiWHikgLQvFTURjkuhDAUjdK30DO5eMb9nKS8OOo2o-rQbVE63qWJSv6SQzRo358SKxm0HC1ur9detdDolZmJey>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedvfefhuedtteduhfehiedtkeehleevueeigfdvudduieeifeejkeejieeuieen
    ucffohhmrghinhepshhhqddrtghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghrihgtshhunhhshhhinhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:ZTnvaGgjp4jKE_KZ_g3wHjwwsWGaJYAXa8OvG1OBmHHcQbliRIPi8w>
    <xmx:ZTnvaMMRGFXvZ3YGgZdxCU-NV8xuJkhriX1lPJpmjD5Y46oeUReYTg>
    <xmx:ZTnvaO-_sDUwox-6fUvHOtRYWNHVcwK3-jmtLkFfB5zljjRDxkLEgg>
    <xmx:ZTnvaFfDyV3hPYOGc11cnNNNovbOh3xBdqmx7raHk1DBK_8gl-F0-w>
    <xmx:ZTnvaJnbNckHYVAbNFjgIwBhD3cRxqat5qa_MiH2CLtr3un39uSbDy2N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:04:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3eaa81d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:04:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Oct 2025 08:04:06 +0200
Subject: [PATCH v3 2/6] ci: check formatting of our Rust code
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pks-ci-rust-v3-2-13810af33bd5@pks.im>
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

The implemented script looks somewhat weird as we perfom manual error
handling instead of using something like `set -e`. The intent here is
that subsequent commits will add more checks, and we want to execute all
of these checks regardless of whether or not a previous check failed.

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
2.51.0.869.ge66316f041.dirty

