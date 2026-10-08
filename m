Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E04908B4
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453709; cv=none; b=HCGw9CUBvdAF6TiIjQuHDaaMLPeamrETptZkCuAJingJUlAGueBueoVsDb0NlrI0Ft18l4DClAP1GXdUhI2kOQ0abPRmZeWP3WzqVySq0vewSwZ0aaMuFtDp1/YU4adA1MuX3oU+bogbZFngL/6llTeZVztibh7tSfh+aBedweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453709; c=relaxed/simple;
	bh=31CI+86aqeMmo+vZpD3Kd0MXmBWqULVVO3Gr3xt6R8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7ml6yUm+J/rQHe6+F4eokN3LZW+X0ieWx2wMnIsd3BW6lB39c6UKslgOGby3oNvdHNUP23qAwOb0SWkcX4XVqSG2pw6i8sSidbgzeJYFIjvm254eeqkdeHgQtZyNlmHG05PfYELkcDy59utoVVPCNKzZSGTLn02pbsYdZPb0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L2nR/5no; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSDsTqvD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L2nR/5no";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSDsTqvD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1297CEC00FF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 06:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453708;
	 x=1791540108; bh=teVWP0zHWgpCSb2wu42B4smpM15Ty2D5/29uid8mNks=; b=
	L2nR/5noILMBNh22zhRt2P9AH+zSfw5RqFQlCnSaI/vlATo4MmJXPR9SJ1QFQsA6
	aOa0497YlSK092ysIdueFv4Jc25iRFpgPpPOWqPguTVBSXvDHEBghgzKQGgsdsPF
	fnCvgE8vSGOQSIhholqfLp7S+m5/X842JjrL0dJtClbGqh5ixz2FOTw3lGvIuofY
	PGlqCFs69o3XdwXYgwDtjaS97iPHv1Ur4kN8fwq0iCwxigjFqeE7ILiBmNrSi8ht
	iFc077udT6nM7mSUA6OKIkVwoaHEGd6LtXFy2ZyQ/rh9CeDVoDZssxtpPMSWWzJC
	FSsEKrsmHe4A4FER6lG3TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453708; x=
	1791540108; bh=teVWP0zHWgpCSb2wu42B4smpM15Ty2D5/29uid8mNks=; b=f
	SDsTqvDdHAQT4N/ZrFDuWR9gFrevsB+W70pHq90UaMlF7FMbnLGm1+93wlEmBtGF
	YFrTXyeH22VjMt9HYa91iuXaRMtpgXS4//yZkpvb7s0gF7Y+w9hMvCG/YfmdWXjc
	p40WyE2HCeJTi1rdlH1Gg14eCOYuHIakUoZIQmQ0Bpj9jV7LMVfysab/0V6DgpZF
	Drj0SQPxhUCefS6FEIsqkcHQv5IfzRviVqfKm9mmJ79IHJwrmDz1cK44ntAZdBIb
	VkT3xjZS+HKTwSA882XO8/KsmgrKVCSrfYxtpPhuPFwZyzbCKluFmr0L/CJzNh7K
	17T35ku1M5SlwO5u4gZUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453708; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:REwrh5MN9AZU5yq9PUDfqkvLcDTVQktRnm8Vy/iNDm66oLp
	jfZ/HJbRe8LtL7sQFNwa2gZNa/Mh8kuTT+l/HaVZH3IGdzf2iWyJ/pzbFodLumsq
	N9QLFTKMZEpsm0Mzstyt4feWJ1m5OfV88SVT4/Zh1K2fNvRUBXd4vkdJ9CDJbcd3
	T/B9bg0DIXl/m/ExJYTr7iVRjXUm+QDuNz3zkiGxrIjDjtxjOeF3zimJ1IkFINxJ
	NQ6tOfFOEyUprP+9vfVrrfNFHMqVNsy4MFeroEvyZymH+hUzop8p84EL7vd5Aij8
	H5imCqkYWp8ubJGuWizw/yMVr4HRYCvQYrU6dng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PWhsvuVDKBLOfIV5Q+M9FfzjKlEkE/WnckZrqj19JzY=:31CI+86aqeMmo+vZpD3Kd0MXmBWqULVVO3Gr3xt6R8o=;
X-ME-Sender: <xms:DGrHalwJbm747uod9-dBz73n6HYB7B4Qs1aYTcSFUYDUANBGOpNbgA>
    <xme:DGrHasub5PuBEweMP1AFcrFcTitvF-AaUgtT5xeW6wLZ7B7gQg1105oqIQRs0B6pu
    GZlb4_0g_qM5zbAd3063O5jgAYlYnYPW9XeyYP5JeAdJjMImRwN5Do>
X-ME-Received: <xmr:DGrHasu_8IGekARzw1gt-7_PEgwBOeB62ukwdbYb9NJ6qGALKvRq2A>
X-ME-Proxy-Cause: dmFkZTEHba/R9cYs8wh/AyfWyca685/5W12D2DThTsCbYfaUhBQKEmjCAS9ACTJTVM9qWE
    ETmXDfjrbFcJKPb+pMGc3+GARcXXyenMlrzeBm2V7QZoVVnsjezKTJmiHD8jqVi90BIRvH
    ICInPRdBfmb35ipCVaiw8nyBEORY/ZLIpxn5dCQqOiLBN1LJhMrcvb9w09Y9p2GnHYxNIN
    Lx+hcqgZ1RxelNnxeitgk96pgbQzvfVfAMzb61N1YpCsdMQpRpPld0bjX5StbwrhmYn4b5
    A6QRggQAChba1yxOxyGJXFvNslxjYQ+bLNaxQPLrZApdF/0fG279uWjy2W/iktThDaM6Sb
    2OgZYBrP+vNPkT5FZuY+Ib55AzZhbcFStiHrV7i4ha3LL958MzBuc7lRj7Bx/VSdM+0Vq1
    MZ80iL9SffAu2FKME5hlOC9QdnxESG54FBtce2/h08f1bEkt+jHyxksR/0fMXGJK8Ts4Wj
    Gvpwpmwz92J0MUvSr7am6SplSqVdStXHCP/jpRGtUy9+Lk2w3+DFR4EMGls25N30zqiY7z
    l29gowsVEMUcK3n5AU4I/GXB2ORjXF9pg3zde3tbnDdeUV84PYeXpqOyylZxf7ah59Zkdx
    GAGWKeqJLPZ7bMlnj/8YE/Yq3Jk3zG7sMm1W7m5GgtESU0scPiN/uPY7D6Jw
X-ME-Proxy: <xmx:DGrHahOPwGEZC3MliIRRSN3lmwVgyN7LXqXMtsY2-ZfQhB4UHOVrLQ>
    <xmx:DGrHaq14bWlvYl02K7-S0tTjpAHa6TwihZrE2RYxR6dt2gu4wK4Mkg>
    <xmx:DGrHatNQFY6MKLFkhK4BsYdI6osSMNZ4s3C_4e-nt-LjKNJLU3VYJw>
    <xmx:DGrHaq0FCJDsysOWdhhZtDrnF0bvnTU-efs2io8cPUKpne_OAUjh5Q>
    <xmx:DGrHavdbuBqGRk4yyEoKWD8ce1DextWxF3KLTqho8-jiRY8omk0Zf8pX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a5ed747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:26 +0200
Subject: [PATCH 8/8] ci: drop redundant linux-reftable job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-8-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "linux-reftable" job exercises Git with reftables as its default
backend. But this job is arguably redundant because we already have the
"linux-reftable-leaks" job that exercises reftables with the leak
sanitizer enabled, and it is unlikely that we will catch any extra bugs
with the leak sanitizer disabled.

Drop the job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 3 ---
 .gitlab-ci.yml             | 3 ---
 ci/run-build-and-tests.sh  | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5b772dab55..4be3f2337d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -405,9 +405,6 @@ jobs:
         - jobname: linux-sha256
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-reftable
-          image: ubuntu:rolling
-          cc: clang
         - jobname: linux-exotic
           image: ubuntu:latest
         - jobname: linux-breaking-changes
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index de40434ae3..f0424bab5b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,9 +39,6 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-reftable
-        image: ubuntu:rolling
-        CC: clang
       - jobname: linux-exotic
         image: ubuntu:latest
       - jobname: linux-breaking-changes
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 9381ff8893..df63e79319 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -40,7 +40,7 @@ linux-exotic)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;
-linux-reftable|linux-reftable-leaks|osx-reftable)
+linux-reftable-leaks|osx-reftable)
 	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
 	;;
 

-- 
2.56.0.406.ga2d225a756.dirty

