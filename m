Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3F198A24
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480325; cv=none; b=YPi1rmM6qk8tkFrsXO26E9vpyvhjf5TeCvO62z+9MjrTgFf7oGZQo7StqAlktNJEzWC2OgifulSGDwgun8LRTrUNxnkPZJjdVveUMz9LQ3dYoz/clNTq+R0sHDc+te8uTI2xkCYRoxHRw6Pqe4udHN0jN2XMab99sYTjR8F6VZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480325; c=relaxed/simple;
	bh=KrGVR2bjeKOoHiyyEm3ZL/GqOGrGyHJzuc8NN02ci34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLWxLbV+njyfIANVdJLeNlJrDmcXAOkLztAoIEEbHumgtQobAo523C2C6SKMFt1YwiDYDLzy59pxubVRukMrbXD+Fyxf39QvTcuy342gkvxZ8tPi7lNEBVzFNbdykJy7ivKXIDMveVubEIzrzRxiWwAa/nsaa6X2YT/5jWp0+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HEgGfT2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg4gk1mr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HEgGfT2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg4gk1mr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33DB7114019F;
	Wed,  9 Oct 2024 09:25:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 09:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480323; x=1728566723; bh=pdcBwyN1Vq
	F/f1ZAV1WTuvcdLJOvDh+mlvzrHHkLwdE=; b=HEgGfT2m4uy7Lw/B3qqFu6JEEJ
	FfLKbZxOuL4ZMD7KX1TA+mDcDL0z7CLV6bKOgQj0vHUWkKkxxgMOc9FeHWx9r2xG
	OK9MPmxH599G+H8LoGEi9VEKxTE6cfv+zYRoz7GhNYyVmKZdQWQJpAujt8gLkF7B
	QOMH79Di+BFB/tJWpPt3PPQ1pMqR/IZZE2Iz74LZ43eFKNorRzTGcB+tvs4zi/dC
	JlGIBqaiePb8/O2BbtlIVOlfa+Gw0DAYJEOXd948CFHvglY/AZN4vhPxrY1Z7NJn
	yV1JQmay94yB0cMlbj/mVUw6sZN9SPpa144WH4urS+5oOycxyrTvi1QErilA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480323; x=1728566723; bh=pdcBwyN1VqF/f1ZAV1WTuvcdLJOv
	Dh+mlvzrHHkLwdE=; b=Rg4gk1mrHHp7MwS3YKfMXsWF+pDTQTLe/T5yJ73NWeCD
	HPT3TQcR+SAQA1nJoQaoK3CkAs+aOuufKLjK7RaywRAahT4wDsexOWb9KOu0Aoz6
	oxq/dRz298qRPiiBL8zbcVUMU9OkHWXG5zpzuUTbBKUdWab1uuo5fkUMIGP4H7vW
	fSeKIIfQ5nzurxNeto9PAH0EIQl2AWhnRFGsSy08Xzw/RNylg2r/0YnLTBFVyy+s
	mFsn62lZuIqMWNYtj7B7dfV6CXRweh7ZOvCjpD/Uy9zMY0ahiYURytKMSl+WMLXA
	amcmaAHNPmjgA+Jda33b/SQMDlf3mqu7End/lq6yPg==
X-ME-Sender: <xms:Q4QGZ4wCp3FJNrXm0vMYeaBgEerTGkh_rz2DYyWa6U9ev74h8PTu-g>
    <xme:Q4QGZ8T5a3lHsDaJbrMKBvQ7New5QBZF33DQv26SNFjj-fUbzJESmXUthOSg4Fo_X
    INfRFT3fEiYC8OgKQ>
X-ME-Received: <xmr:Q4QGZ6XIb-VdQQ8zACvpjrt7t9jd6g2H0ChP34AhFrX1rYtG-ki5oqvUREUkeJfQ-vSzic2JkjVBjoVZroWMTKUMZzLWU8tTvCsYuFrpNrEbRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:Q4QGZ2gY3HHkLwc3tQR3cfN2I3wQnwMY_N7Dmf9bU-GKFjanmkBTng>
    <xmx:Q4QGZ6CYxyROlA6L77HGEFUbvIckAtDj_rWKDj_IZ1zg1C-ND9wvTA>
    <xmx:Q4QGZ3JYgvBskKmdK26UMqm_3lbtRkizFaVaIFauTQW4jyOOceuwkQ>
    <xmx:Q4QGZxCmq1ploIOrLfQvVWX3xe8VaHCPVFZnF4dOtvjgILBOm880sw>
    <xmx:Q4QGZ9MZceGSbpTgmSLC_Tol4Jgl6_ojLRCdyonxW8ng1mW_aZ9LXUgN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 410ad99b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:19 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/5] ci: create script to set up Git for Windows SDK
Message-ID: <9f36f2125f0f17b173aa0cf9ed2e7df66cd8e76f.1728480039.git.ps@pks.im>
References: <cover.1728480039.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728480039.git.ps@pks.im>

In order to build and test Git, we have to first set up the Git for
Windows SDK, which contains various required tools and libraries. The
SDK is basically a clone of [1], but that repository is quite large due
to all the binaries it contains. We thus use both shallow clones and
sparse checkouts to speed up the setup. To handle this complexity we use
a GitHub action that is hosted externally at [2].

Unfortunately, this makes it rather hard to reuse the logic for CI
platforms other than GitHub Actions. After chatting with Johannes
Schindelin we came to the conclusion that it would be nice if the Git
for Windows SDK would regularly publish releases that one can easily
download and extract, thus moving all of the complexity into that single
step. Like this, all that a CI job needs to do is to fetch and extract
the resulting archive. This published release comes in the form of a new
"ci-artifacts" tag that gets updated regularly [3].

Implement a new script that knows how to fetch and extract that script
and convert GitHub Actions to use it.

[1]: https://github.com/git-for-windows/git-sdk-64/
[2]: https://github.com/git-for-windows/setup-git-for-windows-sdk/
[3]: https://github.com/git-for-windows/git-sdk-64/releases/tag/ci-artifacts/

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 16 ++++++++++------
 ci/install-sdk.ps1         | 12 ++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100755 ci/install-sdk.ps1

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 916a64b673..9301a1edd6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -113,13 +113,15 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - name: setup SDK
+      shell: powershell
+      run: ci/install-sdk.ps1
     - name: build
-      shell: bash
+      shell: powershell
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
-      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+      run: git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -147,10 +149,12 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - name: setup SDK
+      shell: powershell
+      run: ci/install-sdk.ps1
     - name: test
-      shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      shell: powershell
+      run: git-sdk/usr/bin/bash.exe -l -c 'ci/run-test-slice.sh ${{matrix.nr}} 10'
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/ci/install-sdk.ps1 b/ci/install-sdk.ps1
new file mode 100755
index 0000000000..66f24838a4
--- /dev/null
+++ b/ci/install-sdk.ps1
@@ -0,0 +1,12 @@
+param(
+    [string]$directory='git-sdk',
+    [string]$url='https://github.com/git-for-windows/git-sdk-64/releases/download/ci-artifacts/git-sdk-x86_64-minimal.zip'
+)
+
+Invoke-WebRequest "$url" -OutFile git-sdk.zip
+Expand-Archive -LiteralPath git-sdk.zip -DestinationPath "$directory"
+Remove-Item -Path git-sdk.zip
+
+New-Item -Path .git/info -ItemType Directory -Force
+New-Item -Path .git/info/exclude -ItemType File -Force
+Add-Content -Path .git/info/exclude -Value "/$directory"
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

