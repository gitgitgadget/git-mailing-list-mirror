Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1512AEFE
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149903; cv=none; b=aX8bunVJZbD8FCKjjDRnyDGAAQq6ZhRU8C0WGwOZiuxAMC8kCczREBq95o3CZlZ6efTUbqdGM7B/rYyz+GxuW6EZUidaFJYARHCIp8MIoDUbRh+cI0Tu46iVT5gxg2anna1fd1UjJRk92a9ZGjd5u0WQ0xo0xcpYYKuMTo1LNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149903; c=relaxed/simple;
	bh=ZI4o0Vqy0nP/FNI/WSmzrXrjtpSQwqvI48Z5RvE0sOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlCznAAN4sdU25RZmx5cDVlcI9owQPbbvBRhfg724hjozVi6k1FxQWGwSFL7NU8S7r7sQWsu9DGqaX1dIT+CDbcbfJMA3DIJI767OURTaST0/NMsDUXu9JVpQK2Jcfrs4Ioezm/rEpXOYyxaF5OBytyYV9YzuZdD1y46ubHahbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y2Objk/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFub+nqO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y2Objk/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFub+nqO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F29B138093F;
	Mon,  6 Jan 2025 02:51:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 02:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149901;
	 x=1736236301; bh=TFW+ddQq6ZpTbtUkVocrRy1i6xtBKPscLEWKEohT1O4=; b=
	Y2Objk/zHdmhkYtVRVFQvR2Nf9nwXW3iL6snKf7ocE+ckJBkrjMRDO9Y/CxJQqT/
	UhMJzSij89xma43wtabCYTSAwHtG+Ta8eWUC5wovnjuF2amIYDkWHNQDrHKtS+Yj
	Y+X3lwNF9aulqylNpYtDMioFSSHDC4hOLkFAFKhLu5rkvx3Cs8gf6fZaJ/X9nf4y
	TO9koIqg+mrGlZxZa3AcWZ6gT4+1z4RDTfCWYp634ggbhub0AbLZSO0J854dk8LT
	M0/W546wDAdMhn50GuDC50WjSh4DlxN9+p6LuzYyJn681kr4rTwxs5vyzpfvzRxB
	LL9MT4NNp7mHAWqkU+wocA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149901; x=
	1736236301; bh=TFW+ddQq6ZpTbtUkVocrRy1i6xtBKPscLEWKEohT1O4=; b=h
	Fub+nqOXMRNi3iQGTLIGhFW8zcCmbn7kzPCq83nfAMAFr2pyOXI0IzkySuUWqv+K
	bX5I/YrXVAmhPVV1RcLFCXT9AKjIhU+B76Q/Ei5/8uvw1DCjOPkNqGal5Kcd/q1Y
	OL9KOzJ8uqC/XEkBr606U8WZu0CPV2okfzebB5qlzoJYPRjRMzXMkoQc9lEgvYev
	T2D1zvyw05FHs/YRBKruU4MMzLxeihid1GVNEx30j0Dk8X1mNpQHZP+7v9fNQQrH
	tjhZxWIQZQtvROdQac0t+tQJCMm6ZTkl4BU3TVSYNQvyG+EVVHI9hFxsi85S+yXi
	6ALvVJMkkWqrqWRyrUKXA==
X-ME-Sender: <xms:jYt7Z-WCZZpF534Wck11ftvjyzfP7cdXBnZAvVY6XttLJp2RhOn4rg>
    <xme:jYt7Z6mV5Hk7TYU-m9nk04kJLLyOQFMaFs9-n0x2Q85IW5PFXB-10mDlFwsLIlazo
    SQz6a6BGQ9TIZfmTQ>
X-ME-Received: <xmr:jYt7Zybn9cF8MhvM1MM2nZTdRvsu0tI0gpGGglXnIYAT2fhT3MSJUPxJKqVN9qBVeM0YpbLnMq0h5wh2Zz-MHvwJJzg3CCPR52EWNBIGSJ8Y4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jYt7Z1X7StOQ1JPaVeTStYDkqMarEw9o-oDA2rnoIJLKzL6X_hl04w>
    <xmx:jYt7Z4klW_kNGB9ENgsg2yenUROl7aQFACxSTicsSazVvIlKptY1lw>
    <xmx:jYt7Z6etuvhblL9ejlb99awXIa_dVmSWOLLY0zg5MOse7hPgN0aorQ>
    <xmx:jYt7Z6GLEfrANUwQ6GIkkxpy3W8tSjx3K1e-ZaywoFCF5qjECzB3KA>
    <xmx:jYt7Z9z6pwF48xVtZcqIHD3ONvyMqhEIdeh558UEEP9QkE9dFRcSkq8Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9775e31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 08:51:34 +0100
Subject: [PATCH v2 2/5] ci: merge linux-gcc-default into linux-gcc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
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
2.48.0.rc1.245.gb3e6e7acbc.dirty

