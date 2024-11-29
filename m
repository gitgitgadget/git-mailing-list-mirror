Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39919D8AC
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886032; cv=none; b=S7foA44OyFnfcf0J7eSCojJ5EIdDYTAN3XeML23qTjsbwfxZjlP5oobbRsncvZu6FZRym2zATrK0jMBeePK3kfn4//erW3DRE/AZaHB8+caV4EXufCOBRhIR1T8Atf9Q5g98+svWK3IhspO/PWzpuhOjr1fhKJk0tyZF1yaCdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886032; c=relaxed/simple;
	bh=KB1iPDo37816jUbxvuR2sy93KKs96H5bcCpgcFLXcXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mabx1M/xd5C26icoIwcwtmUIJ+nmFDA1SRNKCLYGFxsztrn5B3O9bPpD6QqNowurEBQhgkRzpfJy67ct6b/0Ke80Ka/OPfB4jQ1EtsrYlPskc2afZzPhoq2niI3d0DgJ+1LoWBGxP012T7qPnYBXsJR6p+kqDoekhoM8c+weus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=z8o2aUWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3FZ+I7Q; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z8o2aUWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3FZ+I7Q"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 052492540178
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 29 Nov 2024 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886029;
	 x=1732972429; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=
	z8o2aUWwI5oG/jj6Y6/5VRtvMd+Z3d8f+pemyQfagkERf3WlQA8uxllfAM+6X9cQ
	UOBuAcA1COldK1v0nLPDGrIyam5Od72nmtIBe6f2w22N0DeSGlBpb2GRqVOJh9e7
	uToBScE4xMvzU9mhkFUaZ55klKAM2NtLSyDDOmjqzDBiMBLZBWv/LRhS7qlVu83d
	8r2Vj+gFsKrMtpI1OQE/1/7cQrf9rOxiw1QeHgjDlfxhzVgW6TSI6oZqJACCTHQL
	Z0y7toru3SGTOzfq9K2P8GdMFeBHEssK4eUeEIucHL5xMiJjEZYZw4UrdMAFwMRN
	Aa5hL+7j/llRppv0f7WZhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886029; x=
	1732972429; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=B
	3FZ+I7Q7QjrV80clTSUVZ6w0RBLfFCDvAV3QGYt2lvfKhCfyuexiwxvKvx9FPBos
	IXGiAAt65NRMkzmzbo1cvzZtLdfjDhw7x3Kxh7nOjju7N2OhB37A8yEkozaLiDgF
	qJZZQ5FHzdGnMwkupOcqN4vsZZIh4k/qPXCXt2jd59Z8fkpMTnQjx3dk1JxErAO0
	oZoQuwIOEkJdsKzKk4OSJbH3hzbyHLcnDAwD339E89Yc2C4U+LnMmjHS51J2RtQM
	KQ+eFlcpzb+UWCRz1UIkv1tDc6mKKnCObp1MsfOa23tb3zwu5lyH/xHHrJ7y5ruH
	MCWmZt7bPNfHRcgisVNhQ==
X-ME-Sender: <xms:Db5JZxWr_6yE2VQXysSu1bvwT3IhCcPKuB-fImtZVqOcXLvyeLJagw>
    <xme:Db5JZxnS4pGgUvQ0Rp0h9A8lUBsobWPVxYM_C6qdGH9hLaomBX8IXTsiIXSoIw0gT
    4bJumCzITfViDP1XQ>
X-ME-Received: <xmr:Db5JZ9ZCwjpT9gElDPelRz8i089-dy8jhGXmHT39zngHEU9msHveayMYlmiDMjaao93NbYNbhXxgvxVq5b-or8HT3mG7mQok5SLpWjFLslngq1P2qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqd
    etfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredt
    redtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkh
    hsrdhimheqnecuggftrfgrthhtvghrnheptdeukefghedtgeelueekvdekgfdthfefvddu
    ieeuleehleegueejtedvgfetveetnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Db5JZ0Ul7gIzT3KzHvVAIPbT47SkNn327ETQc7uVYyki67fELIRbjg>
    <xmx:Db5JZ7mgwaKlps75hpmX4onuZ8rAylrqIckJ8MVd5LaZNfGFJXiz5w>
    <xmx:Db5JZxdBSlxls2E4_-VzdH4mRLqlPjRu3kG7NXoKCKQBXYc2O63L1A>
    <xmx:Db5JZ1Hy6Wfy-_Mr4McWGfi2H-v-pM_04IB5iXnI95KZfW-mdlxWDA>
    <xmx:Db5JZzu0KKO-CFPqYBhA8tFImGraH97qJgwJEkZxmAzXFPSdvPJrOrNN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bfe6768 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:26 +0100
Subject: [PATCH 05/10] config.mak.dev: drop `-Wno-sign-compare`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-5-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There is no need anymore to disable `-Wsign-compare` now that all files
that cause warnings have been marked accordingly. Drop the option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 8eca7fa22823b46ebdf02b73d53031784fd5ba2a..0fd8cc4d355ebb7428e1d8258154926dedf8827b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -53,7 +53,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 DEVELOPER_CFLAGS += -Wno-empty-body
 DEVELOPER_CFLAGS += -Wno-missing-field-initializers
-DEVELOPER_CFLAGS += -Wno-sign-compare
 endif
 endif
 

-- 
2.47.0.366.g5daf58cba8.dirty

