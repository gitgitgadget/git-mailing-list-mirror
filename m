Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E064D7D2B
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545562; cv=none; b=PuRQ3CnxmiBnSLVlpttQ1HGvtCZfCOBEb52ua7l6lUldv4GXTAs1uM6VjYWm77GlQsEubwijMyfyEai9aZVdPxeJguoja07TcZBxLN4MfML6AmJBtjg/9OxB2z0CGF+IkWkHVOHaY4vRlP2IALMS0/Deb/Z4pobALmznKzk+wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545562; c=relaxed/simple;
	bh=aeE2CE2FsnSWZWvHLQ0liiIAJRFMDcu62rgzpym5lSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hpmA/lDwgnbxBZUB+slZJdkoEgmo2zUrrnWrLWnyF8FBeWeBOeSfx4xqhG2NDL785bJ6z3gyBgztSfwjwczEfJz10l3m6ySskKhA1mh0ZUyBqY5WiQ7QxZMXNCfcwTgbbjIFj7QZ0G8bKLE7XwGbgI+M3VZghSrQjJ0TIlp6lE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=urIEaRNg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCW7/UjR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="urIEaRNg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCW7/UjR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0246D140008D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 09 Oct 2026 07:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545552;
	 x=1791631952; bh=aGBliDjsuX+HJZEiSNPhqJQndycR92uU67Y6EsKo67M=; b=
	urIEaRNg8RfUAvoS/pCrJplauzEX/fFo4mXiz5TJco6GovUtN5SitNVqchXhG1sX
	4zr9IkELMZLcSEjF6Q16kT83EC0pnRXrYb3YQG80rs/166ZJgE+PVZs5cXuBVbdu
	wVoxknHvdUFTLSA3CcBsqBj1rQC+jQPNyCx6EPYSeCG4xwSQ0hT4gOckVa/cLhY3
	jfgiTiTtzGYgslgEunOeTsDPrMUMj90FyCpMLqOvdIxTuswYSDLvW4LVXBHPdfxI
	bEHWE5bEPD4x8yJzeV1OZ+ZSLu/Q/ehErbnOfCnjtw5/RmXwqN+32xBIEI8KNc8v
	nsXxW55orUrRdlE/gjt2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545552; x=
	1791631952; bh=aGBliDjsuX+HJZEiSNPhqJQndycR92uU67Y6EsKo67M=; b=S
	CW7/UjRthn6wr1PWz/vk1sFmkTFdT1cyy95hJK5fGHFJUPqLrSWoIc3VlhkXqY41
	wPgb2v1EihJMud+DDOgqtdKkV5gmUfX+1wtdttZsAdhqd+013r67nPFuKvunQhih
	77bOZjEQ7wunZayJ2nBy4uU04xJYWvkOH6LuPo9IKFRbfD3pp792sBBsd35e0idU
	o71VY+S841DSfnlJ+cgR/VtgNTMFrcVp/6GDtwi78mEPiB+CwTGPz82hyzqq2Jbk
	PjHsMHBnGg8uROnpIdh1lHnOrKjsxBa+uwFUoc+4bVAdH3GFHx1XJEg8MX11KWGq
	NRH9VCC/fudeVRvuCNNLQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545552; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fTeP+Wvm7EOUaMfvGVlQ7a61X5Gs9UT6kOkSkSG+IXF+Poh
	K+xjQHNueTFSoV2poVpC1YhZPQhME8Qk4oGK4lehL2ZLI+jAMNJmOY2XysncgxWv
	EJ3Dzw7gM+u1PB0NjY23/SNuvIspoLL3tUWeJocdqIhxf4E480i2v2/XS5QopBlU
	ND8QiVkLrJSuxg4BXOOvQDSsMIb589tx2nWJbrbF9qsrmeEW/f10lA4r6fNVDnVA
	DvzqoMmO91WuFuRoysz8Xs53YZhE/eQ2je2Jel1lTumO3PxfW6CkOqXXkdbSVD0L
	OFWynMQ/zDwj+tRIjtjbvhb2vZ0N3kI2qPtMoCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Pw4lw4vrowjJNOk4BNoFBAEt5Y4AbmmhPOqmCZO5eSg=:aeE2CE2FsnSWZWvHLQ0liiIAJRFMDcu62rgzpym5lSI=;
X-ME-Sender: <xms:0NDIah_jZzTRNoBHQTbMpKWb4ET0xZdx_wh1e8yHCctFyYABsUiApg>
    <xme:0NDIastODEzxBVIJcn4ZKweWF9V2xNofqmsmsbNf6P5AlZstcAFFvIKU9i4G-uzSh
    GSkKbaFJa9hYGtRCZR_TCQ3hrk6gsM3siclTCmDkf6rsrYpxlGP62o>
X-ME-Received: <xmr:0NDIakD8FYt3uHhOUBsPQ9uUmFDQIP-gc-JlnXTaLMb-Fk5hwkyshRSihIhUeJ4IB51yrw>
X-ME-Proxy-Cause: dmFkZTFSd4uJWEVpr59KjPEdI1xRyQch1Zr8iaaKQsBqdR3zMcEobjzR/qAeRFASLTJa4Y
    s7alI5TteVe0Ssch8yxflpjI/87nvwlrZ+tI6m2QZfeRxd95vLKph98PzEtQFtqlgBp7qG
    u0G42Bw0yq7MMZ9EdelupVu2tSqpHDdrO+v1XuNsQiNvOumURNDfiUMdKIfAQCs6U/ieOC
    /vEyg0ZypTC2TtIs9tjV1GJbmMhM6LsTe+rcivquoxztq60VE+JARdn/a4Q8b6gea8hPY+
    0H4I/3sDfFW2+EIYnlA80+ihTWt2A2Q3u2VMeeGw/lxaN0S+Y3ruLUTYC5VITT+szWxMjd
    /F9jpHAK3T46A9R0TjNefYv5q9nvrQs19FAEWf0xjQAH1NEG4nnWt3juyAuVTMomrHxdgk
    DZu8xqJwlb3OCespz2zTDKnE5EeUiPY52dfw+1bXMAy+jfNyORaJcnTD8PllfN6tsKY6az
    ifSplXT7p2N+y11dFKhRWjlcQAjHEDdTuVp3swMGDLc66LsFEjPSavij/TAoZxe4hsHu6d
    xFIk5pn1hWSkiPdxWfI0d8GH/DmRZka/3+mP7u9Diai0QqwkrWzXvU7wGLVfF2Jtmiy15P
    99hSSkQ685wz+spbBdoczSuMHn1IjOU7+4UxrdaQKLNI/InYFgcZg24/dDEg
X-ME-Proxy: <xmx:0NDIakX1Hd3NRQvQG83lbEFX4r-Np8DtAKHQE-My44J-RfW0NjPmuQ>
    <xmx:0NDIaiCi-q7JnGtMKdCkByRtLOhTBn91GJoVWMvfL_ZwNuCmYcOERg>
    <xmx:0NDIan8VdjJB5FQ2xFInZifhw_pZmbX0g6beDt3glbrzUNq3FzxTyw>
    <xmx:0NDIapFUlg7nZD0VMlWBTCsyH1L3b9KIb4gZRAgleRAPe6BsPdjefA>
    <xmx:0NDIao9G0yTSusQ1ukBXWEl55lDDjfa7VfyJ2yIieUQQ1QS0BRG5PjVb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57d12c9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:05 +0200
Subject: [PATCH v2 8/8] ci: improve reftable test coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-8-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

The "linux-reftable" job exercises Git with reftables as its default
backend. But this job is arguably redundant because we already have the
"linux-reftable-leaks" job that exercises reftables with the leak
sanitizer enabled, and it is unlikely that we will catch any extra bugs
with the leak sanitizer disabled.

One may thus be triggered to just drop the "linux-reftable" job in favor
of the leak-checking variant. But the latter disables a couple of other
tests that exercise git-p4, git-svn and other tools. Those tools may not
be an essential part of Git nowadays, but I don't quite feel comfortable
with reducing test coverage.

Instead, adapt the job to run reftables together with SHA256. which is
an area that we don't have test coverage for.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5b772dab55..0939833e57 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -405,7 +405,7 @@ jobs:
         - jobname: linux-sha256
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-reftable
+        - jobname: linux-reftable-sha256
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-exotic
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index de40434ae3..b814963ff7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,7 +39,7 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-reftable
+      - jobname: linux-reftable-sha256
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-exotic
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 9381ff8893..c6e61d5794 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -40,7 +40,11 @@ linux-exotic)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;
-linux-reftable|linux-reftable-leaks|osx-reftable)
+linux-reftable-sha256)
+	export GIT_TEST_DEFAULT_HASH=sha256
+	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
+	;;
+linux-reftable-leaks|osx-reftable)
 	export GIT_TEST_DEFAULT_REF_STORAGE_FORMAT=reftable
 	;;
 

-- 
2.56.0.170.g584c36229d.dirty

