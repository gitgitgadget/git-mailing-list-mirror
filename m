Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190B1DD0DC
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162223; cv=none; b=FVqEeNtm5QiJyiVlfTkfaJrQdyi7anvrbAJCHr4R2MtwnOI8cRO2T63WiQ4dhonBu/FKgu1NF6xMERwQ4XMaVCxuerrZvE1oaCwIfYMe0MlWd1ikW42Sy1nL/XUkK3W8HbA3fMkAdkCCpCiXSoz0S9T0Ug94DH2lMNJMcqK9LeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162223; c=relaxed/simple;
	bh=iXUBghgz+jqbZeF0ZZx009F8BYBVHP+9neCovN2CvvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8BWo+7ONpszaze8eJVBB9N/lEtWHwimr7f2nvpQ9seuaoMaGN8OCz75+FyxPh1S70BW99cQiIpdp5FmoE6OF650d9hYHaTIrRelJext8A4s6jJPc4SKdwIp5gVeXQ1oXOEUcmzlsFLqPGhQ6gP4qV0fq3xHRTAGieNutgm/irw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JjNDPSMj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWR3LjTj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JjNDPSMj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWR3LjTj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24DF81140500;
	Mon,  6 Jan 2025 06:16:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 06:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162217;
	 x=1736248617; bh=TXisYeudCbnuQitwymqpMqWl6wW3MJ+qGP3Juusa0jQ=; b=
	JjNDPSMjIllVK5pJbRjYEWultX1au8rjyz3beFujoEUAibZj52GUcRwLgc2xw5L3
	RitJ8aerMk9VaDZfPUTRLjuGci4gjqQZ+bq8w+q94GCRxe10stm5EG9Jil2F9rYP
	ZtlXYM9uHTui/R6uc2HIvuA4siPolCt5dm05lZesAOGFPziXFznbY1KSvY6OJlOd
	wOhgK4ZAdiXNFBxbqY0VlrQ/aHIpmZs74G7yGm18f0cxEZG5xUHCcM3AG15oXmNP
	tvCgDP64CmRIANSajlt+dgUHS9rz8wsI6L8CPRELyHUsZpBH0CcanwM1srvk2Pco
	InRWqYtfhGDkodCcNisqqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162217; x=
	1736248617; bh=TXisYeudCbnuQitwymqpMqWl6wW3MJ+qGP3Juusa0jQ=; b=p
	WR3LjTjZTBDgOecKAzLRt4Szk/nJFmui4VwNieSAEtEE+0hyeRatbXv5dK43edHI
	QgpVNEcQZj82pbELJ5tDonEaWHt+/toUl0BrYLVpu+IIPR3I7hQdMgdLFwssrNly
	8PZc/jjP9Ds2dp0b2XBAq1gept2+YJQviXMNdX4zZzfMIntR3smge9aX3xSUqUMN
	ywnn98Qer660r1s1Aah5bZBXc39VwUA7npWDj+rqvdqkx37vQnx5KVzUTf0StPYj
	4RTDQ2Ibr+Mi+if4wtSj+H7ZRr4pT0nGmAtVAh6KN9iG1hv8x2wrFRiWmLovB4xl
	BzUKhRKOt2pcG8RM+5dEQ==
X-ME-Sender: <xms:qLt7Z_xJM5kB3h3jJPZesE74tQKnmIRoRwQHNcuy7sAtdE76Dzzzgw>
    <xme:qLt7Z3QElVMDYMewVvMYtyWBS9omcHAJJ4Lyude3IU7CUFq5KMoOtVPk2Ihqd_sOu
    DXz0WzFUjmE6PJltw>
X-ME-Received: <xmr:qLt7Z5V1wyIPDJZFZillL_H_VJBI_S1xZRJF5mGnSJHXp-K7Ww-SiDjmaIt_U7W3erOJKL0F5zE5y5-NhK810sBk7ljFmvwJ67vk1bhQxMPmTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepkedvueefud
    ejhfduhedukeefkeevtddvuddvfeevhfffuedvtdekffdvtdettdeknecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpvhgvtghtohhrrdgttgenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qLt7Z5haHEmVE5hb_BLsVIkoQgIqslnQBD0h01XpIEqW_oLhprfjyQ>
    <xmx:qbt7ZxDn2ioF2H-K0tNmx8blUnVWOLcjSak6ysaahTXo0tEcgyyKfg>
    <xmx:qbt7ZyJec048UN8QtE5HTBYwqmypNgLZSFRAm3ruBxpHhHTY2zMfaw>
    <xmx:qbt7ZwAyp8MDz45sdDaLa2H43Bo82-FR3uc7FS_eLJhfl7u-BrpQFQ>
    <xmx:qbt7ZwOm6GJloP_YtGTGaO5L5FoAOSqDpzCTVj2Mk15gTFijlmHrt6n9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9267307d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:53 +0100
Subject: [PATCH v2 04/10] github: convert all Linux jobs to be
 containerized
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-4-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have split the CI jobs in GitHub Workflows into two categories:

  - Those running on a machine pool directly.

  - Those running in a container on the machine pool.

The latter is more flexible because it allows us to freely pick whatever
container image we want to use for a specific job, while the former only
allows us to pick from a handful of different distros. The containerized
jobs do not have any significant downsides to the best of my knowledge:

  - They aren't significantly slower to start up. A quick comparison by
    Peff shows that the difference is mostly lost in the noise:

            job             |  old | new
        --------------------|------|------
        linux-TEST-vars      11m30s 10m54s
        linux-asan-ubsan     30m26s 31m14s
        linux-gcc             9m47s 10m6s
        linux-gcc-default     9m47s  9m41s
        linux-leaks          25m50s 25m21s
        linux-meson          10m36s 10m41s
        linux-reftable       10m25s 10m23s
        linux-reftable-leaks 27m18s 27m28s
        linux-sha256          9m54s 10m31s

    Some jobs are a bit faster, some are a bit slower, but there does
    not seem to be any significant change.

  - Containerized jobs run as root, which keeps a couple of tests from
    running. This has been addressed in the preceding commit though,
    where we now use setpriv(1) to run tests as a separate user.

  - GitHub injects a Node binary into containerized jobs, which is
    dynamically linked. This has led to some issues in the past [1], but
    only for our 32 bit jobs. The issues have since been resolved.

Overall there seem to be no downsides, but the upside is that we have
more control over the exact image that these jobs use. Convert the Linux
jobs accordingly.

[1]: https://lore.kernel.org/git/20240912094841.GD589828@coredump.intra.peff.net/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 68 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index b02f5873a540b458d38e7951b4ee3d5ca598ae23..8e5847da4fab009ad699c18e1a5a336a8b45c3ed 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -259,20 +259,6 @@ jobs:
       fail-fast: false
       matrix:
         vector:
-          - jobname: linux-sha256
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-reftable
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-gcc
-            cc: gcc
-            cc_package: gcc-8
-            pool: ubuntu-20.04
-          - jobname: linux-TEST-vars
-            cc: gcc
-            cc_package: gcc-8
-            pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
             pool: macos-13
@@ -285,21 +271,6 @@ jobs:
           - jobname: osx-meson
             cc: clang
             pool: macos-13
-          - jobname: linux-gcc-default
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-leaks
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-reftable-leaks
-            cc: gcc
-            pool: ubuntu-latest
-          - jobname: linux-asan-ubsan
-            cc: clang
-            pool: ubuntu-latest
-          - jobname: linux-meson
-            cc: gcc
-            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
@@ -342,6 +313,44 @@ jobs:
       fail-fast: false
       matrix:
         vector:
+        - jobname: linux-sha256
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-reftable
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-gcc
+          image: ubuntu:20.04
+          cc: gcc
+          cc_package: gcc-8
+          distro: ubuntu-20.04
+        - jobname: linux-TEST-vars
+          image: ubuntu:20.04
+          cc: gcc
+          cc_package: gcc-8
+          distro: ubuntu-20.04
+        - jobname: linux-gcc-default
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-leaks
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-reftable-leaks
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
+        - jobname: linux-asan-ubsan
+          image: ubuntu:latest
+          cc: clang
+          distro: ubuntu-latest
+        - jobname: linux-meson
+          image: ubuntu:latest
+          cc: gcc
+          distro: ubuntu-latest
         - jobname: linux-musl
           image: alpine
           distro: alpine-latest
@@ -363,6 +372,7 @@ jobs:
     env:
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.distro}}
+      CC: ${{matrix.vector.cc}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

