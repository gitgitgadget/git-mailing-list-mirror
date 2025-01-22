Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73B21170E
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547565; cv=none; b=SbjL9QkQw8hlM7F2ySaso0scXyijv/9hNStx1IUeOCzhCzibbTgRR/B1+39s6W1YZHc1zwO4/B14pPtDArXbfzXoGCqxN9f8Bk0XElwl8bsFCXfB/yepKfu0PbI3Am4+8ZQLxKM9qloK1mBAVd3C3SvpQ9PYZZLelpcMhvjMiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547565; c=relaxed/simple;
	bh=5l9FhOrzqA1x8OonA6pzg4LbHzqdLmYx+59aHjHYyuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXJEeHAib/e5cC5YuqD+VNFcozI1KdvCBuy50WPb9MyIUGkzzUzAEKBIjzl7q+mczLEQAmyLUrememDYKuWNYGGRSueaf2G0Y/SuIsN+UxtMAPdKGub375Ew4wskkZ1X0Gkt6Pus7C+A39yNxyYB5SzuBT1qKLF+i4CwsPPDTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLUPXOKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtseLzqF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLUPXOKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtseLzqF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F6431380832;
	Wed, 22 Jan 2025 07:06:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jan 2025 07:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547563;
	 x=1737633963; bh=FYcMzuTd4LwinRyvVkDk5qDPOrGn1yKAV69erOyjicE=; b=
	cLUPXOKpcEg2HNYB3Fos0WeVy/cGbeP3eWr9LhWuYH98t1e+I3XvEZWY8AmT5S47
	GMh4c+deOjD+8+TDHVa7lZADo3Coud6a4dQBktgUO62h8L+5YeCe/0T6k3NS9kyq
	gQDbyvtJE4l0vv2A6KahcULEq613LqFvx6HBgtApbS1IE6fmXA25I7oWmAgRrVgb
	KzKlvyDwow3kSkrMeeWE2NLQZoV3qOyxA+92XBKcEDZfrYa1/x524HK9N7TjJFDJ
	zzTJLR540EtN6yOEJivMH2KHSF3g6k0i78cD1NLzSwHqcYEWxLfkuM6wNQWsvcHn
	XC1lWzZCQ76lE4pW/1ckJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547563; x=
	1737633963; bh=FYcMzuTd4LwinRyvVkDk5qDPOrGn1yKAV69erOyjicE=; b=r
	tseLzqFPkROJR28lGMWzBi8LpBDxv7sChgwvTF9veMvUSlwc3EVH9vJkXyZAGOxW
	fUqV998yHfqPD9N9CAon8MclhN9nRp6OPPRm2SQXtgjswtSwqiXNqvDxfZXybC/P
	+i3hhO2xnEXA7LooNrAtEkBgVF0ntw4/djQGmuFshc/BeF0Ehg4SBO99HRiJrSXo
	2fc/0YJueZQOjD6NUURr7DeA00oBXBWdkCYWYo6B1vlOfS0btieydGJ+u99ALBt/
	cojZIZiI2lw2zOZ/v9gUXeOo8+UO5yZStWzse0dXFCVrhOPgfR9zSOTukkNS9hO6
	3QCvKm7N0PBA3v7jg3nHw==
X-ME-Sender: <xms:K9-QZ_qqQXBKxziZj4sCZgKkAWURgtJQG660FjFcBQkKb8d-8ZidyA>
    <xme:K9-QZ5qEAH4BN3VUxpFrle78XMUBjNrlq606SFF_llsXr_culwwZXOPteBjCBIjQw
    1UlpG5aiIIgPYI7yA>
X-ME-Received: <xmr:K9-QZ8Mps95afZngYohwu8i4HXRzHiWmiIMPWx-cZlRCPbf_ACMIsqzIkD-NnHyJG1D0MIrt7to904Oa_7cZt14ZSkcSqNAwmUMcW5rgktJqXv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveelgfdttddtvddtudeileevhfekueehvddtgeei
    tdelkeffieffleejvdfgueeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpphihth
    hhohhnrdhorhhgpdhhrgiggidrshgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhope
    hmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:K9-QZy5mdagtZgnbAiRyVajyeOOWOwdJ0AM2q9M56fWSrqC0xGgjvw>
    <xmx:K9-QZ-6ZdYaVCdhLo4yAUy_f5rEyf0_LR8gKq5p4a5T9KKTh3w30QA>
    <xmx:K9-QZ6j6rLRIBIpEf7NNJO1Yu7bNh2SggTRS5h6AMw0OC4npUOH6Yw>
    <xmx:K9-QZw47V4xmkOcUDyq0ermgvqCmipwPSLPRv-DnZ9kDZrrxyl-ftA>
    <xmx:K9-QZ7vCt-hgLATkUFH1tGJZkIvUfZ1Jzcwypr-Jv5UFoHOd0riZuKGc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:06:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cad4972a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:54 +0100
Subject: [PATCH v3 11/11] ci: wire up Visual Studio build with Meson
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-11-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
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
index 900be9957a..7f55f8b3a9 100644
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
index 9254e01583..4976e18a05 100644
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
2.48.1.321.gbf1f004a4a.dirty

