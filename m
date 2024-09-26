Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAC1714C4
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351190; cv=none; b=kOxtIPRLVwbQSNgQhGz7sQ5ad7Q05GNgxHi6/dWuFQP/wmGOVl0qa9OHGDdLAup9qDY73lYYu1GcR5SmbtLeAlNNvutNt22IdCOg0fx9ZY5e+CVvKsDdk2CDY869WC5cPm2kt4KzbjyWnLZolR4bUz73BnAduWDvSP8xMF4Ehek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351190; c=relaxed/simple;
	bh=CTTt5zg58ibnysdgV5vTdz0h56+m7eXqCbK7qVfCidg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnaNI7QXfAvmUVl8IzwzNiFiIkD63JWfkiEHj+bVzIdvFGBoUOTOHtFHG0l7T+qB+s1NVHnUGiOlhMXKP4EXYET+533btXnXygJ6r/Vk2QqQBx8uTUqq3TCqYljycFRNZW4B2EQbCJwN3kbOUDxdMm4CqhBUGSoJYrVKUJUiGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l9UdUrFw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/wyqPuD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l9UdUrFw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/wyqPuD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 10778138067E;
	Thu, 26 Sep 2024 07:46:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 07:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351188; x=1727437588; bh=5krodC0Rw6
	0VZvL9vJz1gZVB9qzxcNXAJGu/JcwQGvg=; b=l9UdUrFwt/mo2NMzFmWSo2hHIh
	9hKFiNm1H3YSA5TVccXUTsNY7ZSe07zhl6VGHcnqTvd5vDcu87ao73i8vFJKwO6e
	NY3EF4vBhtCDXqt6Kq1niG/J4b9d+nHl6oyQ5lRObCOf0jGiCvN6YMqLHOfMhWRb
	0piMi2ApN4jVoTpUICFEJQB6mfMGdm1vLtfMcNheU0B7ac2GD7f4pKCv8mJbN1Bx
	IJkpK6P3iGuOeLfPBRMfwpRHzDi3xyX5MSW4ja4IQMWpi8Fx+dgIyvnr5q/bqcSA
	8yg+4uXQsNnOulG4aY0sBZBvDM+OL90HSclX+xEt8O3XzYPOPA3OqbsAxCkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351188; x=1727437588; bh=5krodC0Rw60VZvL9vJz1gZVB9qzx
	cNXAJGu/JcwQGvg=; b=a/wyqPuDuQkqVH/mrYue+TGKi31YjHl35hH76LQbJ8cg
	6Rgpa6UQfmRoOBgRA0jdYqDrokP2mkj2Hetk/jeQ3aQwcEex7X7jdFoHtbrwZLYA
	KMhMFvsNo1+EX0G827G5+EsberNAAvyAOCUFM7lvL0VqXWelV28M6UHve5EyWVZs
	vEzOdBjCRbscpbKpNEcBt831hRXQonCCNeAFFm3lUqBW9HchBxDZ8kplmgVsFYTL
	59cR90ewH4XNQEGmU2ihmnHpclxS4CwlctrvBYQEc5F4p1HYDLZhaX5HGlvNwhEg
	OGj2vdNHGqk2qXyDKaN1k6oEYAY51bqLGBiUEOmfbA==
X-ME-Sender: <xms:k0n1ZrOoF5bSPQ5zgdSkQcEd-u_U1fH7W6naQj_5VA1P_GIUZM7i6w>
    <xme:k0n1Zl_CnTD5FT7-Je6ohL5EkSe9yvTfuoad7qnWy44mOC8hvq8uK8RtotNMFaERM
    NI5lFxFmURBTLUOug>
X-ME-Received: <xmr:k0n1ZqR0wfhXbBcJWmzcVe5uNhY4Yxwbr6JP_TZ90kVzCTJpcIhOrhAEYjsj3pNY_1fXcBUSFLqRfGjcUoUfwlCH1FanDsc9Prf3nI2diSxLiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k0n1ZvttPb1qcrTEAzxBqh1LR_8TxySl2lOiAmh1D2kP5-f7lclFQg>
    <xmx:k0n1Zjcanw2Tp3TNyOGNFFcog2ASqvHgZq2YMtjFOvx6TL-ynx1Gug>
    <xmx:k0n1Zr0v5hsolhja4NOXOMu2mXn053ioWGVEvsOg8DnX39TIeTVVjg>
    <xmx:k0n1Zv-yvwrA9eAtgzO45RSw_DY0kSaHZox_KUYFa7DmXpo0uzX2DQ>
    <xmx:lEn1Zv7vS7_rB4wxs7DGzgTeiSlWun-vRbhmr5k61V7L655YBzhJOjYF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d35125e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:49 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/23] dir: fix off by one errors for ignored and
 untracked entries
Message-ID: <fca161d389125692a9a8f0f5acb218f94f2b0062.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

In `treat_directory()` we perform some logic to handle ignored and
untracked entries. When populating a directory with entries we first
save the current number of ignored/untracked entries and then populate
new entries at the end of our arrays that keep track of those entries.
When we figure out that all entries have been ignored/are untracked we
then remove this tail of entries from those vectors again. But there is
an off by one error in both paths that causes us to not free the first
ignored and untracked entries, respectively.

Fix these off-by-one errors to plug the resulting leak. While at it,
massage the code a bit to match our modern code style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c                                              | 6 ++----
 t/t3011-common-prefixes-and-directory-traversal.sh | 1 +
 t/t7061-wtstatus-ignore.sh                         | 1 +
 t/t7521-ignored-mode.sh                            | 1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 5a23376bda..787bcb7a1a 100644
--- a/dir.c
+++ b/dir.c
@@ -2135,8 +2135,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			 */
 			state = path_none;
 		} else {
-			int i;
-			for (i = old_ignored_nr + 1; i<dir->ignored_nr; ++i)
+			for (int i = old_ignored_nr; i < dir->ignored_nr; i++)
 				FREE_AND_NULL(dir->ignored[i]);
 			dir->ignored_nr = old_ignored_nr;
 		}
@@ -2148,8 +2147,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
 	    !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
-		int i;
-		for (i = old_untracked_nr + 1; i<dir->nr; ++i)
+		for (int i = old_untracked_nr; i < dir->nr; i++)
 			FREE_AND_NULL(dir->entries[i]);
 		dir->nr = old_untracked_nr;
 	}
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 3da5b2b6e7..69e44c387f 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -2,6 +2,7 @@
 
 test_description='directory traversal handling, especially with common prefixes'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 2f9bea9793..64145a05b1 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -2,6 +2,7 @@
 
 test_description='git-status ignored files'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<\EOF
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index a88b02b06e..edce10f998 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -2,6 +2,7 @@
 
 test_description='git status ignored modes'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup initial commit and ignore file' '
-- 
2.46.2.852.g229c0bf0e5.dirty

