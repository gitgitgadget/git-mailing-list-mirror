Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B131885A1
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687625; cv=none; b=cTyQzaF4Ir1POoc/Dc+8/mSu7qQp+vYVzGiZDuLGr9zasZo/TqBzzojavAJ0wDdYNwKmswMFr4Xv/XoOUEqH58YWjJZnv6j2xyepoZteB2o/8agX6FCbFw6e1fAKzfSKFuMxLfGHntiQ7qnqpEZ3aWtOrtpQmYcMqCUZYp697wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687625; c=relaxed/simple;
	bh=h3fwPXDOHy6lIi9z92LFBEHQ+ELo36130Al/75rK8AA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REpdlgZqbTsEK4gOB6xjSVo8N2D+Y7vrVUvJwslWfW5kXGAL8oEYL5TZHHahUiej6rjlKeAGbsj79ZiOMhYcrVOYKRliG5X+Mi2quz7bhBAjbKJyS5fg8201R94MOkFb9DLF2Z8MGcC8EYHOii2RfTz4JEdpu863wRcvBNwjXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Da4QRNOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ayIpygiE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Da4QRNOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ayIpygiE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8DA31140259
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 30 Sep 2024 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687623; x=1727774023; bh=ixRb5vdiUm
	ZSNwMuIoNE1GxAN82oLI8VTsFxgLlEpg8=; b=Da4QRNOHo07hr9nvT6HTdJgITI
	9QtawW1SgzrAU9no4E+jbwmca/8IZAcNqJBc5xPQceZ/MJ6eir3wCe5UhLKUiHg5
	8axI99/gIVh0+Qrb5LpDsO0U8uagSz4qTqCul2kYs32QXLU34S5HutUVYEB7rOA5
	mZ/ihFhmIiFMv6j8+tvcABze2n9c/tKmNvT/m919SVM9g+hT6PpZkAbvWmURMzRy
	lkcYenyk/5lRSDt5fJ9IOl/1QTnVS4m4LmHxmu3PMEk1JCFegB9Cb4r9W+lZoqHn
	cBVVEZ8+64XVXZzdkWtYsZaKNbwMdKGKyYEkxVNHCOp5QhXkL7rCM6iO3n+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687623; x=1727774023; bh=ixRb5vdiUmZSNwMuIoNE1GxAN82o
	LI8VTsFxgLlEpg8=; b=ayIpygiEBnW3NoqemRhR/GZ9Hwnk4g82VHDs972VQL10
	mSnZ154uBFD5hKnj+G7A0ic5FpOcvLvFQJPpJz5VMgJ2+6bOI0hzZ+xdjXVdzLyG
	IRXtQtwoS62b3HUYK1WNnjPvCGWKWQcoho1Sa0ioQx+VGc3GJ/cuSxfHEsfpdy5E
	Qc51pBSrkMkvGCHxsEW6T75jwA72p1L4IEHeLTg92jWIwikOIp3Lr2BX8zB/RZU3
	IjJPMrmXyP46uSRdB0Rw7t6ehaepOKBaZjLL1kjxP369PWxYiMvZSArNMwJiM4A6
	b/xdqP5oXVZaCpBxHYJ1R1gdsMxx2itW1mIJsKin9A==
X-ME-Sender: <xms:x2v6ZsDqf_I9e4UvSMQJOqv-C1IFvkUSaKL-4NuWSygcwgyl2N-PRQ>
    <xme:x2v6ZuiPVV534QMAI9mhfpCwUUs0yBMIS9jiR-JitbMenfBQTK8TdiDb3cc66RLVL
    lKCHTZiTm3I0Lle-Q>
X-ME-Received: <xmr:x2v6ZvkN-douNjzOTjORVz700hiYYnTu4QmmoEmJNN4mufhDdI1QkeIKqSfmRSJO76L9grMlkXE3HQ3SsDDG3uHjSJAxzkRnja6ycjN7Mpkpwlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x2v6ZiwVCBOK9ub6md_fDL0A0YXSU5gI48SLVG9v8nTOvjEajnpQ-A>
    <xmx:x2v6ZhRQSkbop6SPA0Gh2g7ieqa26eh8doManfIbYZlg9aAG-qU6bg>
    <xmx:x2v6Ztas7Fwi5aOfV8At-GTI3g9FuBsmAoXf7ZbmzhKP6xjUdHbMFQ>
    <xmx:x2v6ZqRs84_QBDhqbke-Cnf5eiT0Sf3PZrZUmzYCMchzThcr0YSE9A>
    <xmx:x2v6ZgIa5Pf7XmguczrTA4wUKQOVVk1kgRg2tvzdr3jPSPUipCY3xjcB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41e651e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:57 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/23] t/helper: fix leaking repository in partial-clone
 helper
Message-ID: <cfeb6205fb4d788d35559f1091d88bf057b991d8.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

We initialize but never clear a repository in the partial-clone test
helper. Plug this leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-partial-clone.c | 2 ++
 t/t0410-partial-clone.sh      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 0ead529167..a1af9710c3 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -26,6 +26,8 @@ static void object_info(const char *gitdir, const char *oid_hex)
 	if (oid_object_info_extended(&r, &oid, &oi, 0))
 		die("could not obtain object info");
 	printf("%d\n", (int) size);
+
+	repo_clear(&r);
 }
 
 int cmd__partial_clone(int argc, const char **argv)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 34bdb3ab1f..818700fbec 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -2,6 +2,7 @@
 
 test_description='partial clone'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-- 
2.46.2.852.g229c0bf0e5.dirty

