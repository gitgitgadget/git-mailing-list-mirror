Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527281FF1A1
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914619; cv=none; b=FgfSsuUFYABB7sJQh3XQ8aB0NNDW8szh8W1BhpAlpjh/0veqz9DU+yNykOqeclzS2gJ7xQyqFuGdMYKaEVkEJigrWCdUSq9KahsAgrALCfVrPwz+zvl1ZqoAtYQFkxr+VYeOBSMmz8k6O7bYHzqsRNGF04ZCuRX7SchKuo0uiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914619; c=relaxed/simple;
	bh=eSUUVELttzcc7mCCmJ3L2/P4Ppgz7+1Lgt6VfuiyWrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRMgAixFYIw0YvOz4m/Y256c4e7cX9mmSOFn/SvHlqwAfIa8hxEmy+uZ7HxQkise2ib49a0YteaeN4kMSycwxV7MIBNCc/OtLQRvNtsnM8/9g3F8Rb/C06Bb/qkU1E/uaPdGv9xLaldNuVC4d91tbV6dJCo13WHQAk5403yAlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKtOM9WE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9gscX+D; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKtOM9WE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9gscX+D"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E7CD114027A
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Dec 2024 05:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914616;
	 x=1734001016; bh=NDvg+T+gkNggBLVtUWHwWZ64GfdzPSEloZCUypHt1Es=; b=
	BKtOM9WE4Xp4zx4/HBv5JEW6mSgF9tBLQWKCNYbp7e5S1ZhaM2KzqQK0O+o1H9nk
	R5nupiNf4Y5WGd4bYuV/B0u/ZebGt1ggBpi/T6gK//XwqMyIsDu9//EL0KOQ+z12
	m5RRLtw4RZb9QgoOfQNgwmdwVHEeg6wxKPvUNIQjdp3xYwy83Fln8KSqcQwCNZiv
	CyCUb/mNwhxk957mReDnvI16SsXqzOsIBCUvR3X4uYIfI3LmWphbeRY+/MpXuFOQ
	+gYErA3Aofz2eIDj7NfTtWmwqSXb1SvY2Equ4Lteg6ssGKWMKshDPGYsYmttrIbn
	uNH+3irNQJXDKDoj8Ca2cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914616; x=
	1734001016; bh=NDvg+T+gkNggBLVtUWHwWZ64GfdzPSEloZCUypHt1Es=; b=a
	9gscX+Dxyzr+tlLunhHU5l4EK3LZAziRFpqfTMZmjtbqjxBeX7r/HnUwFT0tk6+v
	rAtgwybGWRKw/sSDqiW9g33fL3cSGdT0tGLHkI2buvyPSHFTjcXmwTjO/gVNCJDE
	68WOr2N9If99XyGYUIm/LYb7Ys1/z2wPPvTm7wuZjnXnnuZmOgPoLoneZuwMAGLs
	gqzVOxAF8FK4VZwd+yadBG60rmhGYUePncteD2Ie/VBB7u+mGGA3RgIViSZFuPBA
	qdY6lHM97wrzMAfxQV2dHPM+hjRO0qDYbJ4b2Mdga8AhIwkCi0s0WdMIbPS8fC2S
	qDv7K9XqnqsbDE0YQbYpg==
X-ME-Sender: <xms:929ZZ2wwwzd2Ly9xv5r9huF_4-OYnZGpdg3bM6DBRzTeNy10xSGosw>
    <xme:929ZZyTCIq_o0w8HaOKyrou-3LxnE31V58dlfehSgA4DpeATmBCli2yhIamEISESE
    E3A9N5n9QLQid-qYg>
X-ME-Received: <xmr:929ZZ4VZyfTtqKHO5aGyjkCttdY-AwCccxbfl-dZS5vkqUYcQMClq5wwhls0XuSaGAu6hfKoKZI2qzTZS8thvGbJapYZ8L9iqW0dvUjVFdgbFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:929ZZ8gHqEE2l6VWTPyhrEWZk2sc_I_bxWkgG8VFVzO2U8QJ9TbaMg>
    <xmx:929ZZ4DELMRvfZQOHpGeZ96n8sXZC6G85zyf6ukf4nD9OnQT_dCP0w>
    <xmx:929ZZ9JGgWZaBpy0gwI4yeRj2i9LhNt0x96e7RtxIW6sTw651gbysg>
    <xmx:929ZZ_Bk4aIJm2ywqWAgiGCEv-Qj5iiUlJMtnZu68CLftG_UHtkRPg>
    <xmx:-G9ZZx5EvUYx6yCP9ly3U0xhWdiiasqmzvTK0vYWBxtVDaUbilQCvc5M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:56:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8117cc1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:55:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:56:38 +0100
Subject: [PATCH 2/5] ci: merge linux-gcc-default into linux-gcc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-remote-branches-deprecation-v1-2-1431e2369135@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
In-Reply-To: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "linux-gcc-default" job is mostly doing the same as the "linux-gcc"
job, except for a couple of minor differences:

  - We use an explicit GCC version instead of the default version
    provided by the distribution. We have other jobs that test with
    "gcc-8", making this distinction pointless.

  - We don't set up the Python version explicitly, and instead use the
    default Python version. Python 2 has been end-of-life for quite a
    while now though, making this distinction less interesting.

  - We set up the default branch name to be "main" in "linux-gcc". We
    have other testcases that don't and also some that explicitly use
    "master".

So overall, the job does not add much to our test coverage. Merge it
into our "linux-gcc" job to reduce our test matrix a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 ----
 .gitlab-ci.yml             | 4 ----
 ci/lib.sh                  | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 808ddc19b8a799abc414c6d6ba078a6e5be6bdfb..32d35d2257812f02121b20c3cae342d626481553 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -271,7 +271,6 @@ jobs:
             pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
-            cc_package: gcc-8
             pool: ubuntu-20.04
           - jobname: linux-TEST-vars
             cc: gcc
@@ -286,9 +285,6 @@ jobs:
           - jobname: osx-gcc
             cc: gcc-13
             pool: macos-13
-          - jobname: linux-gcc-default
-            cc: gcc
-            pool: ubuntu-latest
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a1bc92893f27d6dd404133686b71c8061e55618c..b86bb0bdb3363e06e6fe4195c34babd67cf7e8cc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -46,14 +46,10 @@ test:linux:
       - jobname: linux-gcc
         image: ubuntu:20.04
         CC: gcc
-        CC_PACKAGE: gcc-8
       - jobname: linux-TEST-vars
         image: ubuntu:20.04
         CC: gcc
         CC_PACKAGE: gcc-8
-      - jobname: linux-gcc-default
-        image: ubuntu:latest
-        CC: gcc
       - jobname: linux-leaks
         image: ubuntu:latest
         CC: gcc
diff --git a/ci/lib.sh b/ci/lib.sh
index 930f98d7228166c37c236beb062b14675fb68ef3..e67c481d4fe08d0ebc3253a7a832a96f65c79ffe 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -328,11 +328,6 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$distro" in
 ubuntu-*)
-	if test "$jobname" = "linux-gcc-default"
-	then
-		break
-	fi
-
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
 	# have it anymore. We thus only test with Python 2 on older LTS
 	# releases.

-- 
2.47.1.447.ga7e8429e30.dirty

