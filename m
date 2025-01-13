Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE77237A38
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757251; cv=none; b=AvjLpoPiO/9DiRt9RQiAez9/IROKjMfWZKwppPZ8fZt05aZXIg/4GV+BQpsZNG6/LUHHBiW7oE/1O5I02x7+9I5/a4mFexbKkCdPzm+CI1VHrbwvm+cKq91W8Tl0mVI3epztXMOSUfu5cgYgd9ydtx0+uhsKd6WXpSIRRge98mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757251; c=relaxed/simple;
	bh=pXZDLhfIsFDW4HiVgYHFY60hbxELcc7n7gejKucS+yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9F3dJ8a/hduLqcGlA5E0XrIIaL4CyWdhGqfq4wUqs3+jFJrwIGEmuVd8ghckQsc61Mw67S3Yp6JN4/c/KlPkvhqt1pVn0JJEV3jdJyn0Y5/cOFapZgsXG5TOTkalwev1VCYHTEziUQtnzGeWEtNFK4aaaQ2EW+BCU8COgeYSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=metGph78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oyc1h8HO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="metGph78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oyc1h8HO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DDAA2540191;
	Mon, 13 Jan 2025 03:34:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 03:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757248;
	 x=1736843648; bh=GASN2Fh+DLEt2B1IRqXmBDtWc3S5ohSffczj+TY7KKA=; b=
	metGph78Uqb5LQS12D6LW1w+q1pIKTF7cHGisXytIiGshoZ233mc//7OjR61ZcHJ
	0jR6gJE4QkthAa38lKwRZlchiUQGhprIpffh654ArEb+UtGjqpOZX4qCWlzdQwHi
	kt+8mgKN8YwOBmanB6wMapwyzJebX1ogmmfs/SufR81EXFcOMCakjM9fsvO7TPnL
	LVwHDi4yTW94ZswGU3gsh28h73sc4gO8OqbEOhPj2UdIVRT6Po16qbn3e9aTO8rl
	MuHc046JnSOyYE+T8LgxJMBA0rV3OWGxNDx+h2j1c5qFw0rTUEeSnEsknqut1FeQ
	YRwD5x/znlCOOzJ1WXqzTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757248; x=
	1736843648; bh=GASN2Fh+DLEt2B1IRqXmBDtWc3S5ohSffczj+TY7KKA=; b=O
	yc1h8HOSzw9OSyhDzpOiD+zXipxVeXKzA1yutkT4NGcGWgqXt1HUk8JLRoNirtrI
	FAPYiWrRc6saxfNtoTsU6oehI7/e9V9OFXv40p5l4miGD2verTeqmQE7lei6/BWA
	yVZPAEP/2wJY1SSj+RitTcapziM08SAOR/nOVu3gxH06sowTGec0/sCAlDMqlowq
	aMWf7Iv7VKtHu7dxTn6EVxqG8MbN9SH0qJ4fCgGv7mzArI6W8EuudZ0oXGVZIq1A
	iCyjN03qok9QFyZ3tK9+CflIilTrEV932v7KOGsef+Z8QlgT6AqSHZHjnOj2OGci
	msQrrSdg3/U0VU0bnMwbA==
X-ME-Sender: <xms:_8-EZ-Qdk3pMOByvjRCX3qz_RInSvsJVssPYbf5XjPUY14q8KSagzQ>
    <xme:_8-EZzyupOtzgwY2CSpfUFSrWOgXTlYwXhZRGZQHgAXOtJZIWBoXj0gaR0TO763-V
    kRF8oxrT2PWXjceSg>
X-ME-Received: <xmr:_8-EZ71vWOinr91J1BOa-46fMxdMOF7EmY8FsLBPrjCucL8wvRdTb9P8-sivQzoZ6bxl1ikeCnF8JPpn2CxE_CEsK2jn5EIcR5wCqmZoBcy-7kNG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveelgfdttddtvddtudeileevhfekueehvddtgeei
    tdelkeffieffleejvdfgueeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpphihth
    hhohhnrdhorhhgpdhhrgiggidrshgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohho
    rdhorhhgpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_8-EZ6DNKo-zO6cEFoaLYGi0-zSJ81f9DQq9qjZjlD-NUCrn5KwSng>
    <xmx:ANCEZ3gRu_WpCFfcqqY42A-5msXTCmU-5fK94nHjdoHJh0pBjv0TZA>
    <xmx:ANCEZ2rc3l19icaLObsdpkF6xHwZWZf62CFXoPyJ_3q9QSFZ_5UiaQ>
    <xmx:ANCEZ6imQMKvz-EVvn9R6xFEXOspc0hoaFzOyRhk0vpsp9GFH2cPgA>
    <xmx:ANCEZ0ulmhsn3iNudgseMnb72LCdG9U-TQpZFcJ9GhnnWhLIb7s8Ksar>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd05dec8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:34:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:42 +0100
Subject: [PATCH 9/9] ci: wire up Visual Studio build with Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-9-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
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

