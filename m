Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C33B42C0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070679; cv=none; b=Gm3Yi/pfl2fWHWiHGeYhNijaKHya5ihijMYWnqCM62XlIKR2gzxS9ttJ8cnpYjvpXNuGR5XLhTdToy/EpjxJYo2y3Jo4Y4aKFTdHZ0PbjG+WBhE+hCuTxg2b2fwKSzJpyDjGsFQRE3vV8Vtk0TY7LIpJCQO5DGMLcQac/oUBnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070679; c=relaxed/simple;
	bh=AFI+vnpH3zHNusWMuH5mKDyHt2JevXGZEh1D8qqCoRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2/jpgeM2VwUla+PKwwMFeBgGmLA52OuT1qXusOE3eYov/9+inRPVb9mC3M5giMYEaTDhdsQnItFo/ZR7sO1C8m8ooCIlAkZIpNaPdKsdgT6Wz75yQAo+NUudlEn1teov5UXkNzmT8PyG/9mh4Ts/CWvkdrQfK5jL2y61RtzyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jDmwmB27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FpU2n5HA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jDmwmB27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FpU2n5HA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 571187A0118;
	Fri,  3 Jul 2026 05:24:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070677;
	 x=1783157077; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=
	jDmwmB27b2zgm9yi7kXLBLMaLd8RqCBDKxlKGuZXLjmz1FspZBPVwx8Xer0ifPjq
	zCs4siSdexaURqAY42Vnn46bmj3m4nPUeYqntrxhpWQ1CSkqVX3sp9WLZP5DNcM+
	BG614PS5gh5FigP/FtkkURiao3/toWsDN+3DjrTnQd+xJDHW5Y+vup9zC1cE0W0E
	YxVdTQ+0allTwAN6/8oLJO+dDlZ5jeUEY0B+bVr7JksfltrVP6KiAkwNMpasNGIQ
	Naxt8KSbKMPcE68zM7ubcou2iChj3ynPNK+3mAsJcP+iG6JE4K3hpdYHbqV55XCZ
	mU2bQZ55FpgkNZhiaOxzKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070677; x=
	1783157077; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=F
	pU2n5HA60iJNB15CTYhZnk/GtrFjgQv85ReJLUYWXPJ9+Sz8xCEYletB9mQStJ/7
	RCFhC+Z/WAtmd0u7gEza8S3r1350uozJUeBP5qxuvwszIwUEFzO5+K4VlHiRhYxr
	aBdPJTsFc8s6UliUYtEDLSorSEhBTpd5JwZ9CRDTRczxrbpAYgV2W8AnG9wYXd3C
	xRtgb2bwBCJOyvVXuXfwF/LsIUmk1JIrMce82iLjjYeC407YQFyNwIPNU77suNqU
	mZpvL55CJZG9oEBG+o50lUhzoYeyQadkRvuJbt1EYwGNPEgb8DmJG2tQ//Vl/iqL
	fBn1cen2+nVc02MJJudHQ==
X-ME-Sender: <xms:1X9Hark_JyHjkYHw5XoJo1gxB_Uix1voZE6UXblnVi30LIdioHnVeg>
    <xme:1X9Hals-r6jMqZZWtE9eGKaQBexr-_XuJ58AbvUzft0SA_nNyfyJAwVx_2XXieedu
    a7IsITXhpdNW41jWirub6yuHRm3k6zrdholWf6iHjksdCqP9cQ>
X-ME-Received: <xmr:1X9Hap_hmU0iWBzy9PlcE1P9fsshq0RI2Hh-IcmPu_64GHvhUksdrhyYQe7QM4G273H15dza4wIwqpL6-COAYwkHiyD8L4ZHlE7-PqKHUw>
X-ME-Proxy-Cause: dmFkZTF/u6YcLzSb7it3WdOUjyMKG70BNYygUvOpQZ7y0V9Vsn79zwfJY9x58vtCat9OGn
    89Tt8Yio7dy01BQNCJ5g0a5dpsIBfV/5NV5ttzkrpTEwSbeOclxPM0WGeRAgziTTa8kM3Q
    OkIsAhvT3g+0mBay28F/QB6Kvz+zihs7SM8mIqQfNp70W6A4F0kNfp843oJXCbKce/1iX4
    dE7EVqaAeYWfBE8Ayc5QN73IA+BR2JRSo/Bg+VgQS4rlKDsZo3MhLsoD2Ycfr0CEWPRVGo
    JRbPYtJQWeib6XhhA1kTDXM0zl1RFHlh6B5y6pUkAKqsTEQyXZKd+INZ3v3ep3iNxFBEYQ
    CmqHfeLKjbUUhUfJC+JH2xmjuZiwZoJzvexMd/+cFaMc0Q5987+yy0gRcpJ1o9vCKYdpC7
    cis4ILW+mnunlUKK0ZRhm83Wvatrp03okmzAQOqUE4MCFBIuM/ZOHb6H0XeXLOHqdSWjJk
    MJJE/bAxTkKORaUROYFBh2rtAgf4hJjCPEBjKNZY+2ZaE6yx1PQzWZ77fKsgVJ9DkPH6mM
    jz7k14VFAgWWGnj0roddK9fS/K63cMD9y51Pzuv4cdKaUlAQYkY4O/+VDgKa1S8KHKwPbp
    iytR38vp+FVbvSBjnB3WGlVU1dsmDUhEJIZdAJSU6sw40LUU9H8HL2qMWfaA
X-ME-Proxy: <xmx:1X9HavMUb7EazXzR1NvFtJKh1cdPQ1j3HEPGk3FDxiQIz_iYk1gHpQ>
    <xmx:1X9HanH6N5hNlO9ZwqTgxWNj10obdW1ybFyPcTrmfmPAF4bXqMPieg>
    <xmx:1X9HatSB__yhcEWE1fMND0enFabkfrDZYDIEDeWTFuDtC1lbiV3TxQ>
    <xmx:1X9HaksHGCX8I-WgE0wG1TQOYo52_3daFNdK6ZRkYP24ENwxs-vKTw>
    <xmx:1X9Haootun85F41TDuD6AgCxY19fiWBc51QUOCmI-KoNxKYEXcYQU4d6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e3408ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:11 +0200
Subject: [PATCH v2 8/9] gitlab-ci: disable RAM disk on macOS jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-8-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

When we added the macOS jobs to GitLab CI in 56090a35ab (ci: add macOS
jobs to GitLab CI, 2024-01-18) we had to work around some very slow
disks. This workaround essentially creates a RAM disk that we mount,
where all test data is being written into RAM instead of the real disk.

In the next commit though we're about to enable "GIT_TEST_LONG", which
will make tests run that are marked with the "EXPENSIVE" prerequisite.
This change will make a couple of tests run that write up to 8GB of data
into the test output directory. As our RAM disk is only 4GB in size,
this change will cause ENOSPC errors.

We could accommodate for this by increasing the size of the RAM disk.
In c9d708b7fc (gitlab-ci: upgrade macOS runners, 2026-05-21) we have
upgraded our runners to use the "large" runners, which have 16GB of RAM
available. So we could easily expand the RAM disk to a capacity of for
example 12GB. But some test runs have shown that this is still quite
flaky overall, as we get quite close to our limits.

Instead, drop the workaround completely. This does indeed slow down
execution of the test jobs:

  - osx-clang goes from 18 minutes to 25 minutes

  - osx-meson goes from 21 minutes to 33 minutes

  - osx-reftable stays at 21 minutes

The last one seems like an outlier. The only explanation that I have is
that we end up writing significantly less files with the reftable
backend, which ultimately causes less I/O.

Overall though, it's preferable to have something that works with the
least amount of flakiness compared to having something else that is
faster but unstable. Despite that, the macOS jobs aren't even the
slowest jobs, so this doesn't extend the overall pipeline's length.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1a8e90932c..a4aebe8b71 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -88,13 +88,8 @@ test:osx:
   tags:
     - saas-macos-large-m2pro
   variables:
-    TEST_OUTPUT_DIRECTORY: "/Volumes/RAMDisk"
+    TEST_OUTPUT_DIRECTORY: "/tmp/test-output"
   before_script:
-    # Create a 4GB RAM disk that we use to store test output on. This small hack
-    # significantly speeds up tests by more than a factor of 2 because the
-    # macOS runners use network-attached storage as disks, which is _really_
-    # slow with the many small writes that our tests do.
-    - sudo diskutil apfs create $(hdiutil attach -nomount ram://8192000) RAMDisk
     - ./ci/install-dependencies.sh
   script:
     - ./ci/run-build-and-tests.sh

-- 
2.55.0.795.g602f6c329a.dirty

