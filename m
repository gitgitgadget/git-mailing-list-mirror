Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B682190058
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358990; cv=none; b=ReEX3MGNH0wv+2Mid+nxFIZO6tRRNG/ILLhmaMmVzuPXb+vIjxudMZIP50V7oMlNCU0IgGZLMBiDXcLhTBRfrw2koyf6fWoPDt9f0yf1rS1SJKZwxRc+MvwdYvQfdxwZouMRdGuymUWHlNuOUYlqOza150gVGpPi6ekQSoY7cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358990; c=relaxed/simple;
	bh=KvG5jI/hrq1cdGw33Cnp/EBQ3JrmiVthSwCsPDydnkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/9SBy4mi2cxsW0/3+/e+z59hDS4X/+iLGksQy0p92vf1H23u1FefRSs5faQ3s925O3vD1X1iMDgYniKzdWe/7ACS/I0DR+3H7H0HNHh5n/CvOyBNie8isd9aM//xp71bhnxAxN8Mxjdlb4snvSrAcPiK8OIC5Ulgpjg3mdZ2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KH+Qntdp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAYoFsb6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KH+Qntdp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAYoFsb6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 940832540116;
	Mon, 20 Jan 2025 02:43:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jan 2025 02:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358987;
	 x=1737445387; bh=Ex52eUtcF83lJYvSm0+ih8tvSDC+KJLazpWTOylMqgY=; b=
	KH+QntdpBB37XR+iJJqCRl3nkwZvJHRt+pCTWr4p5n3jwt0t0qQ+5x82wVKNSi9U
	6FauNJ547xmQeOZ6rqT/cQzgFc5UHwC19bAl1eepUHMOYfz5E9jNgMG1kpfZX+Hk
	VjXArl1AIHvbs52i8ZKibkK00AQZD43E7NVAkkjxDEJCHA084EPdL5G1+l1a8tsI
	bCEn5qohPeZx7GSAjwMLBtAnZlrbizm8KLKbQVZiDsO3u5MgT7L1TcRykM9AXxIG
	w2he18jQ7FXTjCmywzbso7q7b74RVKTwlJZGQ1+Cf0TSHtR0sjb0cK9AWb9Bkyfd
	D9xdb2vPwSDStrtFxD1fGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358987; x=
	1737445387; bh=Ex52eUtcF83lJYvSm0+ih8tvSDC+KJLazpWTOylMqgY=; b=U
	AYoFsb6WmKxzSmY6/ptlsqkHOtF0da53br0oJvwxZinafLwCilQpFj94mapW7rvW
	Ik98hXG1qHklHkPTW1f+rq7kyZ4YBVIuM1ViZBS2jnHsUW8RBfvN8YP8mAoc6G/5
	SAElOrc1CZQ55j9WLW90a5c98922BND8gk+evMRJI1dkyee4q9rECSk39lWKKkgD
	1J6Unk79ekoNq/Gat4ybYJVF069iNR1PVyKD5qjS79F/qLEK0GMTE8l3yPi4nt5x
	QNfCIe2sf0MqvKFMGP91+jNmnv0xvWYGfWe7NUYUeIjtl8G0oz714OZ1Sjnfz0nl
	mhCKebcz6cfVXAY6a+w9g==
X-ME-Sender: <xms:i_6NZwFOVE-uYDeKsvcmtst6ZWeqg6g-bnvoebTsZGkQMm4oLojdAg>
    <xme:i_6NZ5U43JNakdcoaLes34So1FFngMvMDAUpChUwR9iY6HQA6OPPAckcv1uaRt2qa
    CbsiCdqphoHuugAqA>
X-ME-Received: <xmr:i_6NZ6JNVibiYLToFehqHaI9utF93-c1d8lXqj4UGt8DAhkn0-Ykz1ROSun9TlkQKdeByRQoOiZxvAdSR_olbIjgmhuPO0je8S16m3KtRyVIJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrg
    hnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:i_6NZyEGui5EvK7zJFCQHPayOUtgHHwm4BR8uJaclpoqr1AP9zi1og>
    <xmx:i_6NZ2UGZoc2IAJGaoo4OpJdNWhJN4gW0tq1s5tsRt1JUEvk90JTQA>
    <xmx:i_6NZ1MTMkyGh2E_cOfg3kK7z7G1qzfeBlTOK7KBU9RsPyf8awxAfA>
    <xmx:i_6NZ91d0KtGzJ-xhAxKGVt_GEmPe5L35EIBJt4MBTDRQvTefu_mFA>
    <xmx:i_6NZ4I15TD22iOwKy-HtvItD0tZMCDsKL4w8nYwY5IsOMp1I-IEpdbI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03acace9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 08:43:00 +0100
Subject: [PATCH v3 3/5] ci: repurpose "linux-gcc" job for deprecations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-pks-remote-branches-deprecation-v3-3-c7e539b6a84f@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

The "linux-gcc" job isn't all that interesting by itself and can be
considered more or less the "standard" job: it is running with a
reasonably up-to-date image and uses GCC as a compiler, both of which we
already cover in other jobs.

There is one exception though: we change the default branch to be "main"
instead of "master", so it is forging ahead a bit into the future to
make sure that this change does not cause havoc. So let's expand on this
a bit and also add the new "WITH_BREAKING_CHANGES" flag to the mix.

Rename the job to "linux-breaking-changes" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 32d35d2257..46b96fb96c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -269,7 +269,7 @@ jobs:
           - jobname: linux-reftable
             cc: clang
             pool: ubuntu-latest
-          - jobname: linux-gcc
+          - jobname: linux-breaking-changes
             cc: gcc
             pool: ubuntu-20.04
           - jobname: linux-TEST-vars
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b86bb0bdb3..492e5d9082 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,7 +43,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:latest
         CC: clang
-      - jobname: linux-gcc
+      - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
       - jobname: linux-TEST-vars
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20..2ccd812fb4 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -13,8 +13,9 @@ esac
 run_tests=t
 
 case "$jobname" in
-linux-gcc)
+linux-breaking-changes)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+	export WITH_BREAKING_CHANGES=YesPlease
 	;;
 linux-TEST-vars)
 	export GIT_TEST_SPLIT_INDEX=yes

-- 
2.48.0.257.gd3603152ad.dirty

