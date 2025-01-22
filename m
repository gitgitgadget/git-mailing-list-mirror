Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE12101AD
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545501; cv=none; b=IGzA6JhpasJhxEpztDvOVNccKo+6IIcfDhy1aZ3AakaA8DZ65LknhrHQrUWkQXod52wln4kII/s4xFngIgYrCMRlzp8WeaCoj/cA//kzrGc2whv49etPm0KxnGa7Yz7PR8G0np5QUNvrr35Nchdf2Lw64hn85cM7cw1SeDjkxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545501; c=relaxed/simple;
	bh=eDGUWrzUe8GZvCOv+LT8mgT9RVg//XXEcW7QZ0BcNp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF7fmA6xealPcHafBjh2+Gvc0LmQHLbNTd8Ujn4cr7ofEQhUa1zE30aDMv9s8sJy+F4z5FAhpH5Av4nfVEDknaVI7Cl0cSVWjNJPeOcvHjFdBaMLebD8+kSbk8o1zv0hNWEOcW4rCDsNUgL5/Pmvl4cJnD2OdxMnxS+lKbxYenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SpPkVoXu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGIfzGrf; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SpPkVoXu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGIfzGrf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 612FA25400EC;
	Wed, 22 Jan 2025 06:31:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jan 2025 06:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737545498;
	 x=1737631898; bh=H4NuwFvOGWLy97Jv8QTYNEHPW9H1UZ3+tkw+2VYdQJ4=; b=
	SpPkVoXulrs+fDmU+qLd1q68ScdE6N712pSC15RjsW5s2eX0Q2TTPfcBYaNRaxgY
	VCIM2IY2l535mAJTRHJ2n2ZDWzkkNRhLJ3TRgCFmG+QflUNMvD+DEMvBz4rOzKe/
	2NTQ5Dtt7pm7bWrsNuZptrcXCAumzRVMzznXSbJGreJ/Bb8AnFreTeWUnRfZ1NVK
	jrDWifKc3xfj6yMr18uLcDIzCz53WzvnchNmjR0WTNe9nbSOw8Xrw+1VAxdDYBE8
	sJbcrdJyb9pXzkLno1rvr2tBqaBQd2OzSkADmVH5YoA0aAmAk6QSETiYAwgNVL0i
	4O+9kzI3lcGSlUSYEsEK5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737545498; x=
	1737631898; bh=H4NuwFvOGWLy97Jv8QTYNEHPW9H1UZ3+tkw+2VYdQJ4=; b=j
	GIfzGrfZX6deSb7jYx/svF/0vE/LeOIgG2lp+uFbiB7h3XB4OBY5c4kbFLRnu1/0
	RrW8NDoNtdWZFk1Bun/H+Wnn2URnUXPzQyekxZucI9X/s2zDXOXe+vqv65dAKJmv
	3iaagjLkKSOhCfXJbNUZ9M1PYC7LyMWP9pykWIjOU+TO5yD4aad0v/FcU1CUgY8Q
	XgX2CF9aZtFlTQMxOIvXflFAmhB9hmyj+ieNC+8Gqg78W34YMDYy2TnfVbsLKKNF
	PtInSSeNrr2aukHnrMFBQgBamqnxJ1d2gDZGxrXphi5FRjHvU0dCQe0HrY+Baicx
	3gSI0NDG1vc+WBdcVNaoA==
X-ME-Sender: <xms:GteQZ50ednlVaiRoYFvUGaV4fMaO4CYdvn6XlauHDP3dM9s0ReB-yQ>
    <xme:GteQZwEzfn2J6sqG7IvrkqjJVsY1QI4e4GkkSJgy0q4iwyBC5x6vY1ah3Pgk1Z-sK
    ctbU_8DAvk66N3jVA>
X-ME-Received: <xmr:GteQZ5712qpzkE-Ci-2dEcSVYcU-vnFIGeORHwFy3TKKTcASmVbgTn6p2tq393K-zIMx4ZZARPuobTfl3lMCVuwdZS2VnboWOQJuaUGmfbdzQBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghs
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnhgurghl
    lhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GteQZ230cS5bF6ML6yzdEhWZE6MxonmyL5kLqoltpO1HK-Iu-9o9dw>
    <xmx:GteQZ8HE3j5IN4cTq-wvDyqo1L3qoyU3zkXvccjmbTSr3YvMwQsFEQ>
    <xmx:GteQZ3_IcSpMv8pdzGo3DoYwajSHYA7VRevp5ave_UhG0-59yqyBFQ>
    <xmx:GteQZ5kJRrb4zocn_6HmLpdlLtl8awCwb1dDJoOsXX60WPF-cr-CCA>
    <xmx:GteQZx5lzC2taDoKTcOgTfXhZ6ms34-SmALTXssKHFS04-QcFNNwezxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 06:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 895b4374 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 11:31:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 12:31:31 +0100
Subject: [PATCH v4 3/5] ci: repurpose "linux-gcc" job for deprecations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-pks-remote-branches-deprecation-v4-3-5cbf5b28afd5@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
In-Reply-To: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
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
2.48.1.321.gbf1f004a4a.dirty

