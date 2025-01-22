Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7C20FA9A
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545500; cv=none; b=u3/e9LIMrjmZ42Tw89ujeZvVgAbeanNdQTcdLaw744CPqIFZFGg+18KJn5C+Gh67pw27jxf6YRYbI8XYkG2ARmiBXO/HWQXK9eWfN8J5ioHTFtjX6ndImo816QSEsx4DCWzO/XaX7FqG1Ct1JkU0wCqYyx/wC/gWhAwxqPTPRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545500; c=relaxed/simple;
	bh=MBFnCrBoVuW11QfJkrrVYSbDrGut5xQzgTGFzP3SQVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUm22jE1CoLqGXLYSs3R8EmDO1HBfvgSuJbI7LhrNIQH02oZqSjGw4FyhifKc2FqvlP52ce9HMe6q9Q/M9JQU5uk9F12BGO+TwoQTWiZg/6NDKhjVNiYyzy2QX0zJddTAf6A3q3LkSNQwJ+l1TLEm74wZL8YWPMLHXy5G/uZCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjdMwa8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UB+z27lJ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjdMwa8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UB+z27lJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B7E581140123;
	Wed, 22 Jan 2025 06:31:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 06:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545497;
	 x=1737631897; bh=OsJaIhL/66BSCaKwX49vP8QcAwbh/nyoVjlbcifKxEU=; b=
	MjdMwa8wcVr91THw1qqKNj8lTb2wv5Zth9sxlJYvlu66dYPYGCJ8hceI6DDAHMfn
	OJs5BvmAGVGRu5e9FgI1Ozws6wilOiQ5SCwdYI5EJIA0I79+U87xRwTUiZx4XVrp
	DkGu35ryYh6Eb06vj4wcZ/EfEj09i21pWmsThllh1ngGse0oekEKFQryHWLS1NtZ
	2GPPmJHxwL8Ka/USUdkkBEl1kQuytrXRI/wy46nUWYrwzCJ+8KpeZD2eymbEmB8L
	Dpa5jPRUmXSVnQ4/mY+iSb8Gi/SxnWxNvbjRufyKASDFQN3FEQfzxVKwFdtZHagZ
	qfAmYepGKzNPKLyNIk0Fsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545497; x=
	1737631897; bh=OsJaIhL/66BSCaKwX49vP8QcAwbh/nyoVjlbcifKxEU=; b=U
	B+z27lJOJh6jHHtqyvjU2IxYjg6rJd34OMOmsH0ukZVMvdKD1MZpPoBysYeV1fPt
	WIm5lCkls/1xAYSPtXNV3nYZ6fSBrWZjY4GjBmMARJL6Ol6GghARgFp4dLSvFtQ2
	kc8cOBLJupC1owyK4sBDmRax5q4+zcE423gNI2RVaQY7uD9DYM2TkDad0xg20fPv
	bDO0VvNGiLp2wUxQ5jCHWpGoJKnIpz/XtW7vtJ7t0UFbN5H3/9urdx7W+v3F/VWy
	12PJPr86ttI+6PQX4ppADCxgTkjJnpMELF2ODCgmBpF2fQ7DN/rVtXHKTCjtHh6c
	dqHErX8gJDB87fenNtpTg==
X-ME-Sender: <xms:GdeQZx6wdnzWcAuWJEctQPeBdVtcbAD516tqR1sn4r8D5w1Qu4-PZg>
    <xme:GdeQZ-4MYkg6fI0G7h9yKYT4uUSDJkJF4hnNlTRHrLsBC7dPDQ94Bnn2UXGUOUndB
    4BhEt1npzJkUpIDcw>
X-ME-Received: <xmr:GdeQZ4etJTDT4CiDHI9-5X0MTaIbz945Tq0r2YT7Ps-DY32-TnP7pmH_nI1_MQNbbGEGll-wcPz-n9Vrv5w9s8NDmVAtp0WTqKTzK2vg-NrDn0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsg
    hrihgughgvrdgtrgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhih
    rdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgs
    vghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GdeQZ6KYSamp0PeXJfJppP2PWloBaNtc5FmdWHFbkZuJtUocHPWkPQ>
    <xmx:GdeQZ1JNE6GdTLi9zcsG6AtYey6JrNUGJakViLdO3qUidUGTDwu61Q>
    <xmx:GdeQZzw0LtEV0IULu5d3ssZ05z7403rpq0IkUoHnVTgfdASzSp87Lw>
    <xmx:GdeQZxK3hzUZKBmXz_u_NK4kXzGBA_pI8HWEswGBhER06EMIbVod5g>
    <xmx:GdeQZ99YiEDfIJxLtdbs1HxZ3oyhDQF9We8Kxmudg1IjgQ2eu7r1_oC9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a6bff9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 12:31:30 +0100
Subject: [PATCH v4 2/5] ci: merge linux-gcc-default into linux-gcc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pks-remote-branches-deprecation-v4-2-5cbf5b28afd5@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
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
2.48.1.321.gbf1f004a4a.dirty

