Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5917E015
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358990; cv=none; b=VcDbWy6D/OqVdJsgono+D0pPb55t7yVtZOpKEldyWCcwSqlZI9LsbbpO+jcL9NxNBh46Y5TSDgPLn1YaWJ270j9nY3NueBu3x7R71k+qBZ+zJLCw4QPkSVI3jrchgsnMTpXZTO+ONNMQPBn6nE6EawE61YkLjzLWN8nTILPGmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358990; c=relaxed/simple;
	bh=9EEihKmkitqNWQrxZQDCJJjt/xCnMiMhQrF4CmvvqbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olJ68VKkhAVR+DsyQgH1RlFtdYVdHje2+xzJjOE+5vzwLbdUO0/DdFO93+k2CirfEE2lw7NDrtIMExdQ5KcsTRZNg7HoDpCGHFfzVhpR4ol43AJdH08+5fon9rtsgvQn/SWYkdAhkmzzb+rmdjNPvQ7lqeFzUWqQS994Lzj2yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gFF9VzHT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDMnqlzb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gFF9VzHT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDMnqlzb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D930B11400E5;
	Mon, 20 Jan 2025 02:43:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 20 Jan 2025 02:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358986;
	 x=1737445386; bh=XIsdY7j+Im1DZvQ/PieUsySE+is2IsH57UR1AnEo+Dk=; b=
	gFF9VzHTci+0vQzcurvMstujNFHdCSVlZgOr88ho312GYmF6SI8ffA8uR6PLs5f8
	qB+RVlEViM2HK8AYIXGbTPG0p5q9Pc3y3O46WNgo14YlAQlEg7Qx3GcJSO3cAf12
	sa+s0aNJ6HSyOHUjQ6Bt4Pl8eaC/vDO4K/50GHb9kgtpGmKno1C/S5NhNvS0TYMk
	CSyPvxKbRl1AOrcnFK6FV5RUht2jIGixe05MLKYBXKnB1ZBWT6Vi/AwyZp9ug6ET
	Zz24zI0JCthKyh3Sdbynfcwu8XYo1SSVJ+sbDBr8sct3S34M3yqKAnG+bhUxvbHN
	bX5Fwu67CAklPsJ+3pU7HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358986; x=
	1737445386; bh=XIsdY7j+Im1DZvQ/PieUsySE+is2IsH57UR1AnEo+Dk=; b=q
	DMnqlzbSeQ/6FIYMmtYcgDlh6Li7lnJNAeQUDShYs4aa1AdijuLvOgJqPePjXBaB
	N+p6gEfjVm4VHIde9Lw2IB1NuhRAgrOdqHkFREB1XdchYAVrFtqDntTVKFZtLctT
	MPSSHTGXyCKr7UhmvMqVDRi5Vwjk+YPbhud2xLjJieusClbji8TAOosJwfQBz1xE
	BM9vbjxv6xweVlivhJ+5OjD8Q0AGjrcO++reW3Cs1xqvzvEsmAtUOi6G36epL3QS
	nzjfPoTSwIZV9O8ipAgTdD3PE4BXatAN5U1fAXHTJQM6gUm/BhNbjkN7e6+mBwG8
	xBc5dYJPTcuZU3Ycwbouw==
X-ME-Sender: <xms:iv6NZ7wfhdZQ5niaEej7Of6ZfzhfPxtn6hAfyuMFClW4Oow0A5Q6cA>
    <xme:iv6NZzSHd4LgQCXxDxaawA4WRFXjQXEpZ-lWpNvtl4GsqO4olHVHhJzA9hXK66N-N
    JEBYG7juNldcph5DA>
X-ME-Received: <xmr:iv6NZ1WhraP6ENdT8rIbGFikC5OLdXcA0eU_iyf7tkaxnJZhgZuZYMBggnRyndgUIUbvBqW-HA5qT_chFsSX5br3PvFKZ7MQxfSrMF1ja9jdxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsg
    hrihgughgvrdgtrgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhih
    rdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskh
    hoohhrughinhgrthgvshdrtghomh
X-ME-Proxy: <xmx:iv6NZ1h7H2XWvh6ua7FIBXETGG_jN_mRumCLxsin0bI7t4TytzfKrQ>
    <xmx:iv6NZ9BYnJjoAlvvJ2LVkZ9TrAlGdeZ74QqGnX284V6iI-GaIIsQfg>
    <xmx:iv6NZ-JMAzM8SMYio9V-ybXEJa8aEvvQHixENwDrkAGboV4SPX0cYw>
    <xmx:iv6NZ8BZcP4cZ_xf3aSeLHaxAD6hHppJemiJ6h-jg8IE1fXJ63yGFw>
    <xmx:iv6NZ_3rqQ5bU-ujFLgW2LZQXCK3-ZF0xokHCe30kE7nqVuWfatdmr_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82197cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 08:42:59 +0100
Subject: [PATCH v3 2/5] ci: merge linux-gcc-default into linux-gcc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-pks-remote-branches-deprecation-v3-2-c7e539b6a84f@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
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

  - We use "ubuntu:20.04" in one job and "ubuntu:latest" in another. We
    already have a couple other jobs testing these respectively.

So overall, the job does not add much to our test coverage.

Drop the "linux-gcc-default" job and adapt "linux-gcc" to start using
the default GCC compiler, effectively merging those two jobs into one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 ----
 .gitlab-ci.yml             | 4 ----
 ci/lib.sh                  | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 808ddc19b8..32d35d2257 100644
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
index a1bc92893f..b86bb0bdb3 100644
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
index 930f98d722..e67c481d4f 100755
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
2.48.0.257.gd3603152ad.dirty

