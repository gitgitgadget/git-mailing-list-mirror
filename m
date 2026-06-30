Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D2406264
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820110; cv=none; b=Bf+iwz23OTZ18GocTgGGP7nxupr3OZbylQUGm19VitO0RoPlQsePHli2aJ93xOioR4vPLlmcDWjIO51HA7krcKXxB4O2bV5Xf+rRwM4xIDRbaffM1JXebfDmXHTU0frUioxzlB3PLuN72LJUE8jordfPXNIWjSXp/uuscrqQZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820110; c=relaxed/simple;
	bh=MuHac4r1FhWhmXIhDg1anZI3N6Pl8qqeBVUa1vQCB6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPS9rfbkqHhbj2ivn3s2jsFdlqA4QCbR6ihBSwUPDBJxx7JjC2SGpdHVREHL9rYNYmsM+BDNdUC3Ohk2rlx5Lgx+YxF1IISGAVMtZQIN1es5Za6M8Wcda+m3/2kchcjLPooYPguo/PVEgVi9tx1H6COzup6oA1Uk0j2wNQ3mnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uOU00pQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhfrpo8i; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uOU00pQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhfrpo8i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD6567A00D5
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 07:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820108;
	 x=1782906508; bh=GsAzm4Q4fCBT2gDy5/a8ozuR4AWZvzoE4o5tQI1Lz9o=; b=
	uOU00pQyLbS+nzrKgTsMDGCXqGx5u5XmN5/TLyOntjhOWb5y2+FFNXgW+TmJV/mo
	teePJqKQFGLdkG4wjQ9TjEDYRE9ICkKliwzDbvrsczzELL7sKmRZUR2wfn8Cs1D5
	pY82OmbMOzBlrCZQAd/XKBX3DABV0BL5c9QP5YilxJ7U3+Z/EMZ8xhekM/cr18U/
	xnUyzjxYO/ojGJ77HVFslc/CIrk+NzmfRjxbM/8ycF67o2pt0iAla/N0Q/46uziw
	8L8d1yKNSQIXHEoDGM/NyzVa9rySCmwqnxNvExpVV5JDauR363Nq4E7nDTNfifVf
	6PYmUc+IRsQBCeGe1Od/wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820108; x=
	1782906508; bh=GsAzm4Q4fCBT2gDy5/a8ozuR4AWZvzoE4o5tQI1Lz9o=; b=j
	hfrpo8ibRv4kSNN0wLIB610xUTZPfjUrP+Val71UKuxzJ/RHrysSxWAWhHYrl8Bq
	33CII/7+agn8Nk/F5v6zGClZn4URlpp1GP4H5M75uTG/a0hFjofVSLg623xZxdCN
	kk/0VHhutheeRdrT4yUqEXmiaZz7/F4xqdzr2Ane790GdjIhSUQa6OBvFPsR0wgI
	tb6TjZKoFKBIfanKssY7h4tr8fYn6Niq58cHlLGBeUTrsGgyihfbavStnHlIfyTm
	UDlcFiMzogFMzk6YNCJgFuv/oh+jI7Y8zeLA/oixO8+dbLqBE/qzC3T5TkoVmfaT
	vVqnlE5vi9MYXNOJgjg+w==
X-ME-Sender: <xms:DK1Dal2G2lnh6BsdNz30UGzxZCOVNwShzyLxLuXSxFbU_LMfJZnm7Q>
    <xme:DK1DajDYHsFeJ3xrLYK6ZtrXwcrvZ4EMHZvzpcZ_dAKAGqIb6avH9zVLz0jDO6wOB
    QwxWmcnj6u-gJ3we9_wSdY0BEWv0XCgZYlqfKyA4D0PDMgeaFwM>
X-ME-Received: <xmr:DK1DariXv1iLoWSV2zzWzB5V2ooZb9axKbQXzSuZJv4g-b_00oyxGsf7vbSUGhzaHD8f-b2FatSbXDa3SMYmGuKNIzBfddqqH8911QnIJ90_eA>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2Jqpb0
    Pc+4oEy3QPSfMVT4bod+QURVAuT2amIjo4XHFYC2JBWnrByci9Q5h7x5QedgCTFt1yUym7
    Gmb4y3fkirfrPYdzbaitx7+Mtl01ZkkZU5M0C5x7ZciwO/CPzRs5Nq7DzBvTKztisREfCP
    guIseAEpY7abumP7lao63EdrQdduk9iJxnPgORE6iTBIzla1ECg1P2xCsceVMl+y3/uJCO
    Sho6M3RMX+Xng28W+WFiqH2pPjTlhKSkHwMQCs7g2G4D1sEoK5Fe8x06TBucy1VIseJgwB
    k3GY3gGQn3VmrDIlA6nW1oyJnDB8As0WpcfMs+plLCoe99zSc5EHw0Y9s9ug
X-ME-Proxy: <xmx:DK1Dan9q-MFxh-auM8Qnwxd4pX-RxLYbXh-3aiS2f3UvzCFUf_Ce4Q>
    <xmx:DK1Dan9nrLa-MvVxS4qOkNs_-qAmb-vQDkQl0JoWdQIpl42UK-hgyQ>
    <xmx:DK1DagAYI_kIC0DtLwj9Ou6nmksuHCyVMhP57UAP3Uje2etO_ieIWg>
    <xmx:DK1DanxBgMoxb4cMn6uxT7uyrvtAPE6pbRT4ezN6YPqvye38iXh0qQ>
    <xmx:DK1DarFXaHS8nSY4h_7_gFpbY_LAIRK8jZeZ99_Q0nEgQ1c6e1-6HKb0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c28b5c02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:52 +0200
Subject: [PATCH 13/13] setup: mark `set_git_work_tree()` as file-local
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-13-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding commit we have removed the last callers of
`set_git_work_tree()` that is located outside of "setup.c". Remove its
declaration and mark the function as file-local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 +-
 setup.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 40e26862ca..1be040e178 100644
--- a/setup.c
+++ b/setup.c
@@ -1904,7 +1904,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
  * primarily to support git-clone to work in a new repository it just
  * created, and is not meant to flip between different work trees.
  */
-void set_git_work_tree(struct repository *repo, const char *new_work_tree)
+static void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 {
 	if (repo->worktree_initialized) {
 		struct strbuf realpath = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index bf3e3f3ea6..bb24ee8f0f 100644
--- a/setup.h
+++ b/setup.h
@@ -96,8 +96,6 @@ static inline int discover_git_directory(struct strbuf *commondir,
 	return 0;
 }
 
-void set_git_work_tree(struct repository *repo, const char *tree);
-
 /* Flags that can be passed to `enter_repo()`. */
 enum {
 	/*

-- 
2.55.0.795.g602f6c329a.dirty

