Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626A3859D9
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567664; cv=none; b=RhM05WwFnE2BwSv0nDHjsGlDdviWLqcWa97xzE0EWjiUhu3NDp9g2rveSjfIFVe4DCV8MK2z9s1h1+mSFoV3JuaxRpdAVUKLsZvs7CrVhkpxVISR1Jmd4EyR9FECIe2SIhnV/iwPKDngXcsX/9Sfry4jFiZf/5m3ZTwelsIQvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567664; c=relaxed/simple;
	bh=iVf0HS6kJMEO/32ADCj1KUXlqIC4iGbqORrf81vIdsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilx4e9buGj403WKC40WX9D1lRUKaPR7t04EzzwUG/FJkrSen+sIUrJvdf9wBaq/2A/rZtZU1WbhLmBUL8nTaxmYfydrAl/QrBoDTAsIb3xyRF7CbEGaZb4OnIGW5ZrCrKdhuPhRmUQ8i7YEDKJO3BjdKEJJM6fADCle5brUncKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZkfeO3Ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LnzznqVn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZkfeO3Ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LnzznqVn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 327A6EC0196;
	Thu,  4 Jun 2026 06:07:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 06:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567661;
	 x=1780654061; bh=xlXK1uborHlA9NEmoPmLM/4HnhPT9rXM1gcSNyrl7NE=; b=
	ZkfeO3Ps7AYcqmfVX2wRhKZvlt2Q2VonWXtg1B9y0mjVd6gb6TO/Zca/imq9nGlO
	d1lBGeM7ebkMHdgus0jLg4mB5S3qULSJf7aPopGZmaMzAFg+Fj8cLaH0TFOd2nGq
	4+oH6M8LOdBPSFLdU16f6yn8AqD27H2Ssr1XgdghfiY6MIA/jONLnqhSeS+8nrKe
	hgy4orkJtek2NaK2pcdJTY7BqlUMhB8mgsRqmkEagq6ryZgUVu7lkFA0PeC0e+Vp
	tbsgQRwPV2Psjm5uINfNuvOejvvNFubEJe0o4890ROnq8sqfcZG21fJN+b6GU9OJ
	YH0K+2ohqSiIzjp4RenSbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567661; x=
	1780654061; bh=xlXK1uborHlA9NEmoPmLM/4HnhPT9rXM1gcSNyrl7NE=; b=L
	nzznqVnHLDnAcyCAAs4maPxkZ+HVUP/Ftho6shrn1VP+458tCK3tuZZTZGheCKiA
	m92WfesHC8kHpG+bV9X5snnl3aMzz9/J8yjNCmZyJkGLvUZS/q5SS14su6NvGSqg
	cVogwkCMfl5ktUjXnTFq3nR4BqlzEoqOhSxRe7w9tG9LzaNwQ/dUWIQ6D9LHvzmw
	6uIp6nSpeKoivLLoI7ly5a6eI3zm/Kq8rPeVdxTztCEUfmZtovdCfuo1l+xltk7J
	4mj/ZOelJxGkmse1USx9bG5X1Ku2ShDi54tFbmv3LJ0MOGphfHnmFBVHuvvkIhA1
	iBalIEywkrg3XIOjbv8rA==
X-ME-Sender: <xms:bU4hahx2Z13r47p5S1TJYeXKAsrLCKs6HhX6Jdj5sGtW9CKYT5H3hw>
    <xme:bU4haotpzJTYQmWYHNo9Ypr6Z7ohWLABTNw9v0G3eE7j_c1VoZaxGDPbzIoghD4oi
    PHZImFU_vOmFmUOUUDTHrFz-nPSwvkuWa4C4t-cEOB0uYQiHT0lpw>
X-ME-Received: <xmr:bU4haovafQyqAO5fbG2-UQb4_GO9aRUrRzx3rO-WerbdJv6oM_OW_k4oJ744dus0mdaSThDWUwlxBunSvcFnqIyiwyZNAkIFDifKWqiWSDI>
X-ME-Proxy-Cause: dmFkZTGv5qh6JYHKMmSdC9Vg9XCXprVKsY1xOcnzE3jyfnm4yvnelY5rvB9nbMlVloNG2y
    D2M6/VfexMFC+bgl3RIdKr6bOuYBoCaPxza/bIrizu6KTFiaDadxZ0XavR/D0Oc1S+vsEb
    5c83gPh5yVEfk9YddSLrOwE1YUFHILOnaD46S4P87rWiMQP8C+3T3N73ksApOfrSWYC5PT
    J6mh9RG+v/Kjxho/nHOhFRGH52GxxfHZ+0NS9gwjx4pqiDPfGZvYyA0Yrq0E8FcxAe7Ctg
    xlGCvdupeyDVnCZy30lGCeF3To1QTUAuzJILrbotr9NN8oFjvWmTkxXhiWLe9fSCQJocoU
    1UB2sGiqrrMZDob/gMxTJ7dLm95k+coOHt9xNqj3mjp1/GtpKbfXcJO092MPBUYJVHschH
    llihWX7nBS9ZSUrRkysAlZsd1o4PUuIpwlJt1fkO336K+g6FXUKtYEscG3j032PIIuoSXM
    sDLRrvZ6+Ae8AP7qFsSDONafrky8pMl94CWc30Ewj7KcOe0MQaWI3WxOy+RdZrQgd7F9K9
    AKH3Dnj71wotTJxj7OrH0u9iO1/PwwzLMGZ/OewlRT2mzeV26fkwmjbVOIr7UyQ66hP1jw
    GJvgSH84/SiKmtw0/Z7EzPYLz0DunDauzHlx6GToTd8NbvDAaQllK1j9L/9w
X-ME-Proxy: <xmx:bU4hatNy3U4cW7RLJriUFcjOUAjjYrE3t7mx-HjoVrCIRcWIlQjQqg>
    <xmx:bU4ham3xWMj-iGnDSR8uyggLVvFeoTPaliGKBzByx2496qvq1q0F2g>
    <xmx:bU4hapM61FfST0-kiahB1Rso3J3QS3PWAyVgAYub-he257b4ozPYmg>
    <xmx:bU4ham0MVPmHKRSoApqbaRIkJP34Ts9nVfpjRWbM4ZSe95gbbdpLxA>
    <xmx:bU4harcBOnqzWHL9O_n8lDyNonrqBPuHvhFXmZP-jaE80ZOPFLf6CnuZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ae486ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:32 +0200
Subject: [PATCH v3 2/8] gitlab-ci: add missing Linux jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-2-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

The GitLab CI definitions are missing jobs for AlmaLinux and Debian,
both of which exist in GitHub Workflows. Plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 6 ++++++
 ci/lib.sh      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8cb41baa14..a5bdec5159 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -68,6 +68,12 @@ test:linux:
         # Supported until 2025-04-02.
       - jobname: linux32
         image: i386/ubuntu:20.04
+      # A RHEL 8 compatible distro.  Supported until 2029-05-31.
+      - jobname: almalinux-8
+        image: almalinux:8
+      # Supported until 2026-08-31.
+      - jobname: debian-11
+        image: debian:11
   artifacts:
     paths:
       - t/failed-test-artifacts
diff --git a/ci/lib.sh b/ci/lib.sh
index 6e3799cfc3..b939110a6e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -254,7 +254,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
+	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.54.0.1064.gd145956f57.dirty

