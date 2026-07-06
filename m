Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC044963C3
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319075; cv=none; b=jAA3YvgBKvR94IZbspC24liCI95uk6X1sfRBGj03pikDr0nXWdc22/ZFIBYU86Gw1ToSvTDzryzF2rCMGtXPyjOQGjr7s6TSooOHqPa0Xd+OZ6SZ1FZDXvNFuO2WwrauzjmvSC0JropXSLQs88NuAjj53W2ccsYEnx5CrAdPbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319075; c=relaxed/simple;
	bh=AFI+vnpH3zHNusWMuH5mKDyHt2JevXGZEh1D8qqCoRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTTbWBAlcXlDWDAYBGziGGzyOM63eZ7Qbs1UYbAExK/JoLYtkCRgXnQbvcUY8l9P7Rfuk8Y7HqUAtlu0edGF7mJ5g6OndOYawE8uCyCx2unAeQQyhXmEnPzi8TfAiFWCS2aMbBJRKeIyr7a6+sj1JvcS7OM/Y2AiS4camdL26xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dIvNWcSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRIjvjli; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dIvNWcSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRIjvjli"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 812931D000B5;
	Mon,  6 Jul 2026 02:24:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jul 2026 02:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319063;
	 x=1783405463; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=
	dIvNWcSG4vmSHjf4gVEpZiJgHZyrOyufOXCVjQG4S+fpcpRmSyxoT9WRWr8WV427
	SCUOI7gUxr+K41WCvtGG8FlqXOVzrK+h+QcGKgjkf2amC5mJ1ig0nR0+GHKBGDGI
	7VAEPzqErMq3roR95JqSqsRhKkii5zgEPH1sApxGXXj2NWYsSYjMAg57F63JEruW
	BAaZtO3XcD0SfSaQRFx6okfvE1H0PhRVS0yI7lJMDaVDaMHn6Hzgw6bS7Cw0R3l7
	XfoeY97ecBFJrfM92BMlUUVf2tUmklRNIJ+U/5d2xBad7beM42ZO+LIUJXW0tkvB
	5TCyvf28lPj7OQTxmzVDJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319063; x=
	1783405463; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=C
	RIjvjlikMHGDjhwSkyV58ESN3e6XMJ8AXKNjabMTvqwnT+K6OodLeOKEyG15O4w7
	IBwDlIzhnugxoxeTwjbPM2/Y6Jdu5HUAo6XqQXGaGhTU/h8HivfIN49c48Eyr7ET
	FSfxJo+9dYZgq+1ou3Ulc1cVy6t7KX5wanU1Zj+/rfsD1LUpwVPy8AfXIcdWRcds
	//rh28Sb6yACKzT7TZTmsH1rx8CCJkSMaomhsRguLEvBTkJTJfm0/U5wT7GUzz2U
	KnGuBDmQiAJ1ihtOoeDPgw90VFSQV/gta68qKNn4V2V4HjaqzL9qquHTi/p5jz14
	m5zZGuQLQx0FuobxurREw==
X-ME-Sender: <xms:F0pLats0zvdtvRU7M973mF-Bqn5PEQTv-tclTsLqN1dMcuxhJM3kJA>
    <xme:F0pLatUpWoXazVnYzpYUxy6VzheLtRzYuQELpFIaEKuFlqFe4RJgqFyL48cM-102s
    1YdUMbXqlEFMcJf4HBNH3I4rHi2GlUyXQloe7CJMIT-IFgQ3TBbrA>
X-ME-Received: <xmr:F0pLapHAZ7J5FbGd2QpypZVZwy2uXlVfia3IATz7BIcN-o-85DsOwKXOyK1tFPcq-bcQVJLxxxWyHOo_1221j3OxDAyvbaOuTHGHV475j0Q>
X-ME-Proxy-Cause: dmFkZTFexpsNN8+D1iB4kmccXHNXSwz7Jj2Jci0dIahDOLBK3JR9GzpNXmk8ZjVQMNuAiz
    NbxPUSm/PPCoV5/3Ush0TGdOppTlxnJBxvn7l+1vf0sw9WBdKEtSWeUoeOI8fST8Mn4Nhv
    qjSftjyM2Tm9bdl+gmtQ8CVkJ6YNokwW2zLSkH4xJ27EzwvUZ/SzWJEQ6+9g2PMn/YNd1X
    gwXl+0oCzj2ubEWj5XVNiCl0luAzOyh3YEPf/A72yEFJNE0KGPybhEUrD1QNfTKFPzlhBL
    Oz6CorBRX/mF1rpMTmdXsbloSzqKJjGhncv6qKPHwGyHHt4/5bePAsn+WRPDLz0/8nkCqA
    fvHK+DaZQ6QY1ztD0zMNqzLrBicTTA4V5tFvI1+2kOxkk0vOjY2Qpagwa76UrBDrbumx/l
    TNfqIuStuQ10W0IYXZQ2oILDasDyFK34rBByvcmp9HhUlqgjDU67pRgydwQOmeIb4ULMHA
    yI4T87pOSWyrds9n1YaK5XV9d5dMMO6aiduBbCS6jZ4GMRM6R1GsfHfQK6L3kYi/Y5nZmX
    e05cHR9hMANbDsMxNCe5NJ60PLmtRdwADS7rysRi81c6x3nXO8JlMqcJHQRf/nF6o6RVfm
    wTohnCtxUh/0B/QSCJpnFAOvYx8UunMtflE2jy5m2+lxr6Cj+OGgL0P0XlIQ
X-ME-Proxy: <xmx:F0pLav1tfPbxN7ar4pBSy9pIGidallQfbtSFrtBoXIiP-q4hxqe1aQ>
    <xmx:F0pLarPfHb72SbdOKmJ1gE0z198Ee0Q-pGmjBcrk6_RFDHdzLMtqww>
    <xmx:F0pLau5qs0AnlI5G5CQ4udAzL24wGI-Xy1pLeWrUmYT2XEbrvmSbBQ>
    <xmx:F0pLal2jFwwLfpaXXHiVVFfpD130ZNQ1udCK8i61SYC951RS6LJ5Ig>
    <xmx:F0pLatQkQYXHHyC9ozCafbhsLPbMhQiOJ3SoLeZjgKsDwwEtjpaBvT1a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4753bede (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:24:03 +0200
Subject: [PATCH v3 8/9] gitlab-ci: disable RAM disk on macOS jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-8-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
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

