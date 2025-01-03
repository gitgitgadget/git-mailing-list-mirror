Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482171FA8C5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915629; cv=none; b=sz2x97PUyp7jwTiz7cG8qzP8FR5h8Y77ueMbxgWhYmQm34ZxaU6SW843rwm91tjaOGFGW+civQsnobEGY0uqKayhUDhFXyjIKv/nXsPWyYCGBMWF+Q8uMgOcFkkJdogb9yPTFpNxdy7sDC1UIARC/BzQ7Tv7G81ZLSXZisQ3EF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915629; c=relaxed/simple;
	bh=6gK28Fv4fgAuBM1cL/9tGtaQO7ye/Fo8PRX/x9fwvuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M+kQ5DkFUaapj8pFTvByvFgB4VFDSYEQZgiZk2DKqYidSCjisBS/ZWgas/O+J00OzhWFweGhjLBrZqmYmF9VAKeot/8HddiotMVq0U9IdcDE5PWD3v4i8haZbB0mgfndrQtbDqMsafQiW6gXpjJdog3yBNDk8+eJ8AAtYMXwbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jfqEmWru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FO0EHced; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jfqEmWru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FO0EHced"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43ACF11401A0
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 09:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735915626; x=1736002026; bh=jBUJWNa6Ok
	yxiADkA1Epv0PzNNpGHVoNgcWE9IvLqaE=; b=jfqEmWruMi28zRmrf37rgRC8NZ
	N0NRHI4PAfl/IYm7BLi+86+b3G6jvGmAjajCX2XAmwzaWAJPjPRtbbCM3pMgTSXk
	N157u5jgH7uwC2mRqa+CeFwU/hWcH101gUxYXkegH6p3Pc6mpaIxbZ2f3CMNbNvz
	EjfjzqjVLcCp2METtLn9vpL/YtEkr+pqhSZE1XWs2J4tvvjAyetv6RqAvNJ9Fvm6
	ZtqrhmGogDQwM5CGMwPOFEKoupHivp+6NN4CQPLyZR8E+uIJK5QH/CcgawxfKvSa
	WmoFFJIwRHLaFQPkCS8AIHkNCReqZ6Bw6Dzqm4dsxuleeKBTbP3GMX2IaVMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735915626; x=1736002026; bh=jBUJWNa6OkyxiADkA1Epv0PzNNpG
	HVoNgcWE9IvLqaE=; b=FO0EHcedV3IxzdszlhCe5ZtutmwUZqrJ3oQctewmO0IP
	AkbE0doLCCIqVg3RVRjkngTfaqxWAGO+ckvfL8lo5nMPdltHJVM9CaPVHbIxZcYX
	1WjYIlZhh92hU1UvSWJ91NSGX9go1P8IRuTkkFLFzBuysA///YVn30g6FTs1QCT7
	2Z+7Ufn/mUU62jID9mGVeYbKAddTjBnY5tbRAvyOcAwrUyUF+hf+xb1EfKHLXIjh
	aV2r3qcrKPpSPbCnHqACAfJ2oCcVW7KIDwkOrJEjD5wgF+BBHeJiHBKOfZU7A2dx
	uee9CThyXQ+nMEIdw4KAF7cDj/VAdkzyhgT1WSLHXQ==
X-ME-Sender: <xms:afh3Z_NKqqfDw6CyAVVbsSM_bgezkf83OEqYyuisf_Qre3aV5AcLRg>
    <xme:afh3Z59X0ny6k2li7-X5U7vqV9gDX-VSqjC-RrkU_RI3myrRG18UQlV6ZgzEP_Owq
    kCm4Ucqees-dkaRmA>
X-ME-Received: <xmr:afh3Z-SAPMCff9-PBHQM7zlQ1nzQ3-nDZZsF_afHVGLB5Zc4nY_blVDujp3zosIzm9R96EXffAYlMFCfZttZ7eoK4zEq8zXQVfsZUKLOZUtMoZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephffufffkgggtgffvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeelgfegvdelgefgtefhueeivdfhuefgteffveei
    heetueettdejjeeihfeutdeiueenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:afh3ZzslowS5o6BydVCYVe1ZmD05hpKWOAoOXk2NjLYB9fxYfOPYGg>
    <xmx:afh3Z3egkUXPhwmA5JHguy2-BrgvBUUNJLolwKYRuqDGHpOKiNbR-A>
    <xmx:afh3Z_3YxhWT11T0btqmuBr5TtS55lP9r3jbS8IAOFrSwYepZqaDXw>
    <xmx:afh3Zz9Dd85mZ2NjEV1TO5zARCrTG9WsGVv65oiPhWzwEvbapWxBLg>
    <xmx:avh3Z_F8BQ-Uzhh82T-M6RcNmFWVtjpnL29ildA0nMeTRb7stk45K6xM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c55990fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] A couple of CI improvements
Date: Fri, 03 Jan 2025 15:46:37 +0100
Message-Id: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE34d2cC/x3LQQqAIBBA0avErBtQS4quEi3UxhoCCwcikO6et
 Hx8fgGhzCQwNQUy3Sx8pgrdNhB2lzZCXqvBKGOVVh36Hq9DMDBGfkjQrMqZLnobhhHqdWX6Q53
 m5X0/vyG2NmEAAAA=
X-Change-ID: 20250103-b4-pks-ci-fixes-2d0a23fb5c78
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series addresses a couple of issues I've found while
investigating flaky CI jobs. Besides two more fixes for flaky jobs it
also removes some stale code and simplifies the setup on GitHub Actions
to always use containerized jobs on Linux.

Test runs can be found for GitLab [1] and GitHub [2].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/277
[2]: https://github.com/git/git/pull/1865

---
Patrick Steinhardt (10):
      t0060: fix EBUSY in MinGW when setting up runtime prefix
      t7422: fix flaky test caused by buffered stdout
      github: adapt containerized jobs to be rootless
      github: convert all Linux jobs to be containerized
      github: simplify computation of the job's distro
      gitlab-ci: remove the "linux-old" job
      gitlab-ci: add linux32 job testing against i386
      ci: stop special-casing for Ubuntu 16.04
      ci: use latest Ubuntu release
      ci: remove stale code for Azure Pipelines

 .github/workflows/main.yml  | 78 ++++++++++++++++++++++-----------------------
 .gitlab-ci.yml              | 19 ++++++-----
 ci/install-dependencies.sh  |  6 ++--
 ci/lib.sh                   | 34 +++-----------------
 ci/print-test-failures.sh   |  5 ---
 t/t0060-path-utils.sh       | 10 +++---
 t/t7422-submodule-output.sh | 10 ++++--
 7 files changed, 68 insertions(+), 94 deletions(-)


---
base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
change-id: 20250103-b4-pks-ci-fixes-2d0a23fb5c78

