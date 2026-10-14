Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5C49E5CB
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966653; cv=none; b=tqYut1znPNzAZ4op3sv3PbL8stiQMY+vlFSCHcy26krc3adHsZbTbYOC0hQNlhvGDjWvnTwqhZDdExztTGAS7dyiYKJcpQX22eIEpNepdAD1y7llmnMtchBKtxCJ8kxWsNVUtpLM4wvYIWDZhlVxCdT9LCJnWlc79zmh4S8CFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966653; c=relaxed/simple;
	bh=7mlERE066nWjwU1P47dd3zAdqDqfqrLX1/0HxkYb+kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnDcFjUvsASZdmqOhgkomAT5I1uE1ntfGnFksenvR8+eSw5SKCNh5uE8xRvA2N1JnurVnqjpRAhOU0I2FZg+c/RZksy2VvNYXXyT94pJs+T1FgAHhZGWm+a0uQQHwitHJb8Zha7FTd50BpZN+ftYk5grF8PNPwtZYkF+Kd11zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=stYJdVgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y14Cmmn8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="stYJdVgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y14Cmmn8"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D3944EC021E
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 14 Oct 2026 04:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966649;
	 x=1792053049; bh=QDPAwsrvRmFwTwnttqhGpi8RwfmfDe7ZffaQAQeCNEI=; b=
	stYJdVgEK9GY+wBreLL+88CPFU8+h1GexsQFm6Pdui/yRY669VLRUWP7zHV4xqLx
	u9OACut2i81vTr26dteXe0lDBeYAQSanN8D1xedy/W1O9jsPnDQ7Qe0MbvrfKIds
	2kUmyrFXUgywyn96Au/b2UgOukv1cHI6NQBOG0vzus4aVEETYXcUbufTikeRLVY9
	lPNQl5Xo3Oku84MqDNOnqWs5EA8GRDv+hB0LEeLC5rud7fPdkrKCqa3q8znKvONT
	Kjia4z796Pw6vSLHt3HFDVcPwfXkQncY9Euud6qpvHCDnanUEHIbS6YQDe7Hrd9f
	Cmd+JxPoGSsj1bnPFB8vdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966649; x=
	1792053049; bh=QDPAwsrvRmFwTwnttqhGpi8RwfmfDe7ZffaQAQeCNEI=; b=Y
	14Cmmn8hC/5kbPh5utsZW2YBv55JjaI8v1DXIEaWSqVvj6pTcGLDDslEUIAI6IQI
	oj/4OA1REOoPkVGL70WKP7LkQX2JXwCTTeIrWPL6q2hqYwbA7TEwH3sXveK84yaW
	WQoKBPX7nnWUSYo7t5YXZYDUKxL2IUHRzKyMFEElWkYCgGQIrpsVqcmQgAdiwKBb
	FaCLbHGs1AiJTNWHvImsrDr3i3wJyxCCLqEenFEtp3PGtAl0EovNrFU8V81wbOIK
	xdMXCgX2gZQz5IX9HOnK+EFrcNngvgY/hyF1mzFkLwq8cXcExtfIRvF6DzkdowsG
	v3vUEP/fcBEL4k5eUzOkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966649; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:udLZ945K8hO1/55c/c2YlbbaYfWNSQisAJXdRI8AjdBfJKj
	hm7MnfYm9MOodoLjDc/mGwajjokFvr3n+y4FPeL6lLzwXjeeQE0N91mo2mzreIYY
	S+/XsQmihQjhQz6MVbNFGH4LdyQFLUC5C+wGkn2cocu3l8Lkn61DdUwFl0KkH3WT
	pLOLL2onOC6+SWmo4lbovpQ5k/BhUgtGo13Sn/tj/5Fk2WRlVGeMU/iYtM7qzHT1
	UqimFYfXQfYyXg6xIVWpn3VcWr/cr8JCLn0vvJvi1VKMimubDrM77UW/TydhZdaL
	lXzVH+utRqTZo86f+l8virCVuBjKRvf0/u92S1g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Uv3kwz6E+0SqO9Nl8+uaNZlzm7PuNgJLyBEhZTaJayc=:7mlERE066nWjwU1P47dd3zAdqDqfqrLX1/0HxkYb+kA=;
X-ME-Sender: <xms:uT3Pah6SIW5at53ssz5LAbseuXCi8LB7a6BtJWDPo5W7gOm8QRLI8w>
    <xme:uT3PalwRZ-DJoiNH2vxgakgi6G-uiNLpRSGe4dwf6B2eAjJLTkYdFKrjK06cCyWep
    M3NgQCldBc41iAGzkGR_nK-pyM0Pa8Oy0zlRJw-fDalT-j0-Cv0kw>
X-ME-Received: <xmr:uT3PagyfXZHl0U5py4oFfraN8H0RwVoZHomXydgx1YHrycAchtkAJg>
X-ME-Proxy-Cause: dmFkZTE6SzrF/RMjrmroRJrOmjW541t97+9JkKtEXWPcIIQocVBp29e6gPvHrq4uuFZIVA
    sYdO+KaespEORtvjgMDFuZZlQMj0loh7+rLLPES4l9f5ZQLP0iA6HOyWN/23cqUpZ0F4K5
    39e1I8XadGc0Qccr2ydzopoEWTLpJ6aVkJSniN+W1kjmLLuLIQnRVNdeIknZfnc68BPmOa
    m/5ibopfbb3L9YFNS06OyKJahMcnn6J06N7Jy1f2LLF/BeI0oXwWJU6MOF9yfkvXDhLdbA
    pqJEno+/VKPhKuRrgC1gnfvwFLxaXk88ptmFA4jT5DpJk/0g6rOg/zbzCs29gZAz9zl1OG
    GwrfEI8713aJNP+jSHJItIjPCymBckwL76qQQcWj5pilWW/Z9lqQ1olLpCWab9Nq8Z4Z/N
    BXRTRDPV/6sE1FRxX0okzGQXeXI7IaIqJtbeqvV66yk5WBgINf6nHyEwkGpStdu5Z6niEY
    kzvqpHGhH38HSfsGFYPGP3a/WErtbaO2OYDElrOS6kcF/DNMCqYUdJvLYljNdDR0qeiZWy
    v76YNe2TL3qrzLcgtsNG43xrHTfzrCr1Ie5cBwJDIsTqgz005bRvAXfbs1togZhibpIy68
    vANpM9//Eg65yUT8QF3huCeofOStcaqvHjngflASvlXWBIgKlZ/Y5Kr0kEtA
X-ME-Proxy: <xmx:uT3Palyqco6sxOfSc6vUny6qNySFkkRoLQCc4PTyENAaEmdMWcXXEg>
    <xmx:uT3PaibuxrXEy1tXBbEoO-pQ-pnlHncwMNE92b1KMeBCvd1FO6NAyg>
    <xmx:uT3PauXjraK28DLwsCDTXsEK33THE83mwfvq72Uu10eJLc2a_bQcsw>
    <xmx:uT3PaogOH4LoAQ9mUMOTSxBqTUDm_prT-M451pbZpyNdjrKtfvmD5w>
    <xmx:uT3PauS-_4piJG_aTGUlgwY_McyPWRd-9PevYo_YRic3QmwKFITq18pt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c54cf61c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:31 +0200
Subject: [PATCH v3 5/8] ci: rename linux-TEST-vars job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-5-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

The "linux-TEST-vars" job exercises Git with a bunch of non-default
options enabled. The name of that job makes you want to cry though due
to the weird upper-casing and because it doesn't really tell you what it
even intends to do.

Rename the job to "linux-feature-testbed" instead.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d1e37c8f1..60f262db39 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -408,7 +408,7 @@ jobs:
         - jobname: linux-reftable
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-TEST-vars
+        - jobname: linux-feature-testbed
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d972f0c8b..726c1c1865 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-TEST-vars
+      - jobname: linux-feature-testbed
         image: ubuntu:20.04
         CC: gcc
         CC_PACKAGE: gcc-8
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 23e87cbbd6..611bf6e56d 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,7 +22,7 @@ fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;
-linux-TEST-vars)
+linux-feature-testbed)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true

-- 
2.56.0.212.g129ede20d9.dirty

