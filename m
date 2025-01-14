Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827D3DABE3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855786; cv=none; b=HL9VSXPPnolvYlx8oyDwON+D4Dj5tfSJ+Zf4jgZGG1T7uckhoCaF9tNLc3iPW2lsnCUMZ8XLGGVEZFqoQs6eRtJPoekjXHlDG9llaLuJkZmGEkJWNkf06AvD3+dlmiJ31FBWuBIriYaPAKsXC+QN8qh8QoyNBgnAAvIqzYSyyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855786; c=relaxed/simple;
	bh=pXZDLhfIsFDW4HiVgYHFY60hbxELcc7n7gejKucS+yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DseV3YvkZzfqARMeXgMa7zhdY4ZVjZ7ZKtQHwIvSd89N5mPZ790oEhk+H0eMBnJsYwZ92aSU9DVcYgs2jh4YssL0y5TlJfjPw7l304w3u8aNGPh5TGp3oGBIpMRnzk477F3+EFRIK3k0ckJ8TsQ4TtcugXg/0DOGDdVhJvdn2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hhfe80k2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfIoNaLs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hhfe80k2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EfIoNaLs"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 305BA13802FB;
	Tue, 14 Jan 2025 06:56:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 06:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855784;
	 x=1736942184; bh=GASN2Fh+DLEt2B1IRqXmBDtWc3S5ohSffczj+TY7KKA=; b=
	Hhfe80k23XwzduXoPfjhY2bbmNVtGHL1rM+HPdFsp/a71vE1aTRCVgCWNTfIy96p
	q3AWjHYsqsK7E2xhlPSWxoBC9tgJisKyBgZHG5Z2eMFVNjqXWiGs8DTz+sIPLYsH
	m7YbNIVQB3BQ/AgAf1bubY175sVHprxJmwZd+pYo1LL2oHtb7w2qRlk+SHz3RDI4
	8pXc+gSMW+JR1OnOmihxg2bvw9iLCF8LDdxs/ZfhsFt90a+J3dJhgIBlPqC5egOy
	siDi+wk0fDGghlWE+pbORh3NLDnibRJ4QCiwLGZHH+Yd9uRvMF89hV3AyAMu+1jA
	pXHfuNCNNRcKHJqS7mtCiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855784; x=
	1736942184; bh=GASN2Fh+DLEt2B1IRqXmBDtWc3S5ohSffczj+TY7KKA=; b=E
	fIoNaLssjZjbEQGlQzie+I48M7fxep0BtYtNTp5TIIZWMvfuwzSfs+C6tj4vqfc/
	1/3QhvP+gQAnmL1IkZwXONyR4KbSmWkVM7hKPgE7R69ghIbMFsLeRKhxPr9rHJZp
	XeYWuiEQNsNEiKrS3Iq0M+qlicdZeFAiVkv/vm3E9vVKM1QAlOQHU8iBy15MOzBj
	BDJiva4YNmLbtd0WI5lWBnm8DC1P+6XfwbvPSclLvQ9/06yNl2D0ZCRbMdn8DQ54
	PJ3xCLr83nm8uY3mpkeY4Lpt/YCMny29jZlrWvnOvQUDtm4gIPx9ryk3ftuvMck9
	KSwoHSmNRwKhT0zFVd28A==
X-ME-Sender: <xms:6FCGZ3uaMICS5c--0orZFMMIYccl8BBa-eDZvIlTryTQECcYXMV9yw>
    <xme:6FCGZ4dk1ppjAmIIQkGgWu2ATxJKQZh6n6eKc0AHoeWqyTnwYd9mEWWqBBuWFYTmx
    tPAF2K25ggCtE_lrQ>
X-ME-Received: <xmr:6FCGZ6xvbkHxN9f_yrDSqZ_AQYiy3OF4W64E_l08u0wDieDJ9Uz69Xw3zcq2dN2D_ZAaEnkUEz2ZLHHuyhZqzVxU8tqC5BBv0qVV6qoFZFmJnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevlefgtddttddvtdduieelvefhkeeuhedvtdegiedt
    leekffeiffeljedvgfeuieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhphihthh
    honhdrohhrghdphhgrgiigrdhsvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtih
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6FCGZ2OAzXNWIDW8a7sPIutsMUAtXukOxix6NUSMrCXg64tjH07uHw>
    <xmx:6FCGZ39gYGGnkPnZnRoGjSzkafscd6OJ2GSfo_RsPMr3XAeX7V65KQ>
    <xmx:6FCGZ2XMtaRC8iU47SJNDaeUTCHeN56m_thWXG1pZkj-yAIpwT37Ng>
    <xmx:6FCGZ4dWxOxpN4nWisWhOrFbkCaCrqjJw-YpLKJuTZJWdFRn3AmdBg>
    <xmx:6FCGZyl05dlG_4SY-_JkXw-2cLMwH-3Ihm3EHoWFNFSzylpmqW35W6RC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac473ee3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:21 +0100
Subject: [PATCH v2 11/11] ci: wire up Visual Studio build with Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-11-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Add a new job to GitHub Actions and GitLab CI that builds and tests
Meson-based builds with Visual Studio.

A couple notes:

  - While the build job is mandatory, the test job is marked as "manual"
    on GitLab so that it doesn't run by default. We already have a bunch
    of Windows-based jobs, and the computational overhead that these
    cause is simply out of proportion to run the test suite twice.

    The same isn't true for GitHub as I could not find a way to make a
    subset of jobs manually triggered.

  - We disable Perl. This is because we pick up Perl from Git for
    Windows, which outputs different paths ("/c/" instead of "C:\") than
    what we expect in our tests.

  - We don't use the Git for Windows SDK. Instead, the build only
    depends on Visual Studio, Meson and Git for Windows. All the other
    dependencies like curl, pcre2 and zlib get pulled in and compiled
    automatically by Meson and thus do not have to be provided by the
    system.

  - We open-code "ci/run-test-slice.sh". This is because we only have
    direct access to PowerShell, so we manually implement the logic.
    There is an upstream pull request for the Meson build system [1] to
    implement test slicing in Meson directly.

  - We don't process test artifacts for failed CI jobs. This is done to
    keep down prerequisites to a minimum.

All tests are passing.

[1]: https://github.com/mesonbuild/meson/pull/14092

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml             | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 900be9957a23fcaa64e1aefd0c8638c5f84b7997..7f55f8b3a91d6caf95934af308a2bd35a19a62f1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -248,6 +248,58 @@ jobs:
       with:
         name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+
+  windows-meson-build:
+    name: win+Meson build
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    runs-on: windows-latest
+    concurrency:
+      group: windows-meson-build-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
+    steps:
+    - uses: actions/checkout@v4
+    - uses: actions/setup-python@v5
+    - name: Set up dependencies
+      shell: pwsh
+      run: pip install meson ninja
+    - name: Setup
+      shell: pwsh
+      run: meson setup build -Dperl=disabled
+    - name: Compile
+      shell: pwsh
+      run: meson compile -C build
+    - name: Upload build artifacts
+      uses: actions/upload-artifact@v4
+      with:
+        name: windows-meson-artifacts
+        path: build
+  windows-meson-test:
+    name: win+Meson test
+    runs-on: windows-latest
+    needs: [ci-config, windows-meson-build]
+    strategy:
+      fail-fast: false
+      matrix:
+        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+    concurrency:
+      group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
+      cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
+    steps:
+    - uses: actions/checkout@v4
+    - uses: actions/setup-python@v5
+    - name: Set up dependencies
+      shell: pwsh
+      run: pip install meson ninja
+    - name: Download build artifacts
+      uses: actions/download-artifact@v4
+      with:
+        name: windows-meson-artifacts
+        path: build
+    - name: Test
+      shell: pwsh
+      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
     needs: ci-config
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9254e01583306e67dc12b6b9e0015183e1108655..4976e18a0503298f38230f5ba7348675baf48664 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -149,6 +149,44 @@ test:mingw64:
     - git-sdk/usr/bin/bash.exe -l -c 'ci/print-test-failures.sh'
   parallel: 10
 
+.msvc-meson:
+  tags:
+    - saas-windows-medium-amd64
+  before_script:
+    - choco install -y git meson ninja openssl
+    - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
+    - refreshenv
+    # The certificate store for Python on Windows is broken and fails to fetch
+    # certificates, see https://bugs.python.org/issue36011. This seems to
+    # mostly be an issue with how the GitLab image is set up as it is a
+    # non-issue on GitHub Actions. Work around the issue by importing
+    # cetrificates manually.
+    - Invoke-WebRequest https://curl.haxx.se/ca/cacert.pem -OutFile cacert.pem
+    - openssl pkcs12 -export -nokeys -in cacert.pem -out certs.pfx -passout "pass:"
+    - Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath certs.pfx
+
+build:msvc-meson:
+  extends: .msvc-meson
+  stage: build
+  script:
+    - meson setup build -Dperl=disabled
+    - meson compile -C build
+  artifacts:
+    paths:
+      - build
+
+test:msvc-meson:
+  extends: .msvc-meson
+  stage: test
+  when: manual
+  timeout: 6h
+  needs:
+    - job: "build:msvc-meson"
+      artifacts: true
+  script:
+    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
+  parallel: 10
+
 test:fuzz-smoke-tests:
   image: ubuntu:latest
   stage: test

-- 
2.48.0.257.gd3603152ad.dirty

