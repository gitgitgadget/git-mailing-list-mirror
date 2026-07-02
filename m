Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FC480350
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993687; cv=none; b=XpP32vcvgs8apTyARr2h9t/aI8SFJauVU5Az1BQwOHZiOtt92JQSp6DOFMXNSFNlQ9nGjLLhl17JDrugrE/HulkBMSIspe7C8BwGs3jJjNiioRdnPvRswoQg1r3Ryzgy4u7yGFBEjkhr8f8HQUuoxEdIe+KLZ/qkLYKcEtFykxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993687; c=relaxed/simple;
	bh=AFI+vnpH3zHNusWMuH5mKDyHt2JevXGZEh1D8qqCoRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxfyo2BvTWiZL/mXBniAGKbgE4XNWHhE/EA8spGNPpbMAt75N+GKSlCJRSwsPSYsSVqvtUE842VCIa3bvQyq1KggnhxgNOWroSgwNXM4L1uLWkeFPHB5MSSnBiRgLvLfcLVjzB9AKXpNU86g0agjdgaSOeT8Y+QSgv0r1p6I5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fB8QiP+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hptWNLEk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fB8QiP+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hptWNLEk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7958F1D000B6;
	Thu,  2 Jul 2026 08:01:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993685;
	 x=1783080085; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=
	fB8QiP+ma0kW8LSvyqqORDytsXA2HFNoZQbvkN5g9ecZUUdrq9+TbJ72588O3nii
	3e01FVzVV11uNAS6QOnGWcuhCNZSp5oCO4npJPq9NtzCJCVr4CwOklFSH49P8on2
	5w9emNbNK3E/s9LTKEimKrDewOvilLvR0VbCV9VVLkge68GFD/lMQp6NhfBkgIQQ
	A7SfTKRU7Fe0mXbx9Mr8sJL9u79b74QlO+fo9YRNTRVYS+kjNVo3YtAaR+ksWv8B
	1VmW9C4pUDH07fgolwDd114zqOui98dy9q3Pcex/xWVXEr42QYR+yJoXxR/JKdX7
	AK+GjSu+ma806RZo0hHokA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993685; x=
	1783080085; bh=MI28hU6I1+ab0W1wCoFZ8FNjDkfY5FCCAR+FXPWnib4=; b=h
	ptWNLEkrO7lFqPMs5JX/KT6ZhjRs8tZhhl5/4OzoBFL6I8UbVtfpbnejLECrhWt7
	3aj7K5uMy1z2NiHfFydjOPNSFerTBDFSrtyMpWMGDZpLqda9XFWzBOVF2DrnVue5
	/gN3V2FUE9mgg1gmt7Q/3R1POdpcUkHlKuoC3c7QoHL7ETYRIuhNZLqnS7/TMQU+
	T0sAUKw347cgJ6tYRMxCKrwQqIZWdmOpNSckGsTlGWtfySTQYr9kQvRYxs2v040R
	j2PumwpYgEfX9kIJRtdAacb7CWJrlovo/UeAkeV70BbyhxblPBreaZHSu3VndbY/
	THPnvF3n8oLq8mW4oAMcg==
X-ME-Sender: <xms:FVNGas7SZit65j8zRNXv4_tb6jQuma5j2lq9j583yQAig_0VQWAYXQ>
    <xme:FVNGalXN5oe40rAa4XrjN2ojYf0CVSX2DMQBUcw3xtPFAGNiKhqDhSPTrsKzkOFBn
    0mM8_lBtU6teKbC6-F0HmbUA5XxI1vK_6REn3Pv8a9ThU3WBvSQ-A>
X-ME-Received: <xmr:FVNGao3TmW7sX4wcvUTuA4Yhz6pDjmxUUIsvz6906MF04ib3kTLvpTCwqpw7vVH1ipYc8_pK3HZFBjXOc_e6goiuM-MHVoglJ-zq7LZ8OujTFA>
X-ME-Proxy-Cause: dmFkZTEa/pMqGTBJ2nMWyF/M4a8PLqbQYM8Nj2TBdCbtW/8Wl7krpf8gxnRGQTQoquOhdo
    6VgJXEj9fWg+vgkmD70bOAB/bFoSLAuqcan+dMt5rMioyaUEAeajHYfNi8S+goKEJa5mLz
    7k9FPiIbhwgzMYGXdRG+/bYtjak55xD22cGzf8Id2pD4S7oDrhXjEr3qh91H6PPG9SsHEF
    6UEnQGdoO6xon/2UFlM1EAZROd6jgP1h9Qa2dFAGvhB4bfjz+1W8ggIx72TWAkmcAGgitf
    nllKaA218pMDAKPeKT+Xf4UsjlCevhsTMHjAopmf4n4pQpUVY6CWxmRB98ksf+AqVdp2Fm
    jI2Z5khinK/nP8iyIjXAan1maY1Nw8qIc6T3+l+5T6U0KDbR0NHEQ/U+aleXK8cb8KQ0RS
    af4r3j+0J8xFM1V3o60TySBLntNn6oFUooVJmjdTSUwtxa15ELt+TBadckWHpnm13jyoiS
    n5+Ke7QiXQ7ZAmngfft/DkvJSwOP3q2kMnraXs7hRUxNfihUW//LIIBqlZFgAq8biigoX5
    OCGe4u1YktuZGqGqnJdoSfHV4Lgwvq9VMlK8VdM9lPiesnTNFP23rD3Zq/zrtUCS8KPdOW
    cfXSLdWm5cB3ouGnOxVmT48kyAwC+V3eCnHqyYPHIGSrErftpq3LbDI06+fw
X-ME-Proxy: <xmx:FVNGaq1EVoDuK2BEFBS8BtJpUUWOjVMhPCA7dLJtLbZYZVMUE7NYgw>
    <xmx:FVNGaj8nTOaRyGZK9LhmoUo-UD73BgogljcFj93mv6Xyw05iPjNClg>
    <xmx:FVNGav3QVFSIUKCH2dID9rmdVq86KwHZzx4VkXJYDinffxWFmXlvYg>
    <xmx:FVNGao9T75hv8gMSKep5E2tgAf7mg2F0AFzHeRsx0S_0-oykZGLuvg>
    <xmx:FVNGar7iIBJYf9YV0JUmnwBCoEs4shC-ip-V2ttkfE_5sZOCH5umtbk5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f81b3366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:01:01 +0200
Subject: [PATCH 8/9] gitlab-ci: disable RAM disk on macOS jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-8-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

