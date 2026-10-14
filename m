Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885F4AB3CC
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966658; cv=none; b=I5WKHpC2a4a6sMsRAIhwP/E0QqpE3HGrT7Czk6UvmUrIAHDaX1TJrTeIzvyr3x3foeP2ysxOD1+wNOdJO2TKZZwo3uLf8G3rPbBqh/56RJJmro54t/GJ6InUHriEj4uwGpNeVOBRe3l/KRWWl/cej2GjS/Nr0D7OJCYh1mc7WLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966658; c=relaxed/simple;
	bh=krjcGhQ0ghWqR8sHxbwsyFXqjsg09nRm/p0F3MhKIAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nH5kEbGFVQ+7399DxDFeWo84avSW0g4t9M0VQzA6VcYd3D7hFb8+TMTpV8aVLwb36cwTB3F7gpf6E8clq33x9kAPo81XrwOgwPEJ7l6f6/LfGZGrMkiPUPVgK1sbp0HEQ/hRjKkP2uUPa+oDlgsVCoQfetgMrOVBuyMNS4DLkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qvk6JjC9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjtjxKD9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvk6JjC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjtjxKD9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73E8C1400140
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966656;
	 x=1792053056; bh=1982burEPFJadcQkPHdq9dRPfDXwyNRtn6u63060MIc=; b=
	qvk6JjC9GsjBoqo1GjnvgsHpgolb5ZWXXj5zKeMxv/3BMhYtxQWWgdBte5Ruy+Ks
	ncq4ScIObXHlXLaVxZC7+VIPYeUBNlPelc638JE5B7/1de2ap3/ZZzNvShfVrfqI
	7YXBIToiGY3yk5KbJ0JwFSypzTX8qn/C2n0qErdh4j116CPIT/ZFPvls6wWfwjYT
	QFQnSD8ejI9Bl7MU7jtUFtIQMl8PJn7hv0+GL+U/a8pSqxqcHgaO7Ohrb4bcmyGy
	Uu+n6BgnaMGFCvVifDFiTMAEUtlphBRkm8jqwnCpi8sQZfOA/WRHndMDAgwgx+Y2
	qPMTPnvI1HjB0z8wU0axvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966656; x=
	1792053056; bh=1982burEPFJadcQkPHdq9dRPfDXwyNRtn6u63060MIc=; b=T
	jtjxKD96NEMcSLpNYVsnP4TvdJtoxICzVqFdpIoyeJ/3md6MhqoeDyPaIa9wleqZ
	xSYobYC/GmRgN1tnQrL/wHiw0PoWvj6es5B6xg+D4Z9ON+JCxZJzeu8k+i30zo+J
	tIFYKmsewWSXmdcUV/VlkOdjYNdzVUxSKvPdmD1FrQ0A72O7nZtjCs+II8WTaolL
	5kpB02kRGkVW4+zDwWiqEoHjBmNcb/rmEzVh7bUseTcD7wFsh0l8LMy5vX6CGxqw
	O9f3vmuvPGdCjAVRAC6q9hrdQCh1G14ECYJ1GJIhwjrQ+D4e3Zf0w9drKWGdIP+d
	iza6gNZnqKouiGv7AwsXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966656; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YOn8JjTiAmKI+pf+JqHA1rhk23ni/4oeC7S+57jGq/T3KPT
	C4L2fzYBObl2jgzFUqdIAwp7PM4zfr7nj/FAThWmn7kEwQpC+VdTfWy8WzPVoU/f
	ztiHFPRBssULWDI8HMtMAMPiD7BOT3AcpTBcOusrXwyEP0PCF0dp1zqJ9/qzesJm
	8B4rPqi9xhGY+ad6BHJ25AZ1amNXsebnHSO5X2sMREBYM7R2HT2VkUixlOoepGcN
	v1fOqwa4JBkiXpRT4s0L3q4QJtspErN3RgcdTQ3nLl3qiPhR5e4M21EWpJ8reo4F
	TpeAq2vWhrzAiDjn5oMmQayb9VSarzLNwIxOL6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cgpfa0NNx+lS+p5ydy0j1MXjyV0GBndhLeiUx2C3mto=:krjcGhQ0ghWqR8sHxbwsyFXqjsg09nRm/p0F3MhKIAA=;
X-ME-Sender: <xms:wD3Parxu3qLK6RVq6Hx-PYvpirrJ__YfGt9aBRLWa1pMRlnFUMhPvA>
    <xme:wD3Pakw4I9NuN90rdl20iwDouVAXFLohka6wOGc0-yTPwodDfQ8xsjs2Cw-O1lhCU
    TX1IM8M3WUIF3mkbMPZ2C5TNMrEvi9s38fydqNIapTtMRYLJwqhOkQ>
X-ME-Received: <xmr:wD3Palb9uI0LDD3yHFq46sdTTKcNgWtL293JAYYbd0kWgWDKBARDjw>
X-ME-Proxy-Cause: dmFkZTE6SzrF/RMjrmroRJrOmjW541t97+9JkKtEXWPcIIQocVBp29e6gPvHrq4uuFZIVA
    sYdO+KaespEORtvjgMDFuZZlQMj0loh7+rLLPES4l9f5ZQLP0iA6HOyWN/23cqUpZ0F4K5
    39e1I8XadGc0Qccr2ydzopoEWTLpJ6aVkJSniN+W1kjmLLuLIQnRVNdeIknZfnc68BPmOa
    m/5ibopfbb3L9YFNS06OyKJahMcnn6J06N7Jy1f2LLF/BeI0oXwWJU6MOF9yfkvXDhLdbA
    pqJEno+/VKPhKuRrgC1gnfvwFLxaXk88ptmFA4jT5DpJk/0g6rOg/zbzCs29gZAz9zl1pf
    VX11AFm/QnLGRKY/CGNiLvttl0p95c2IsS4OOACpfZVtmp7VwLYqe5MKekILRfT2T+DmlI
    TputGcFVa+Q+N0S5RLBrwdk7rv9ScOnMznAKnVWfVesv0DVkNC0Z8AUin930cfu/53+qbB
    FbvvAgyABwaGTSGL0ed8ZyUWKUMUB/vHMzxM2mMUkAb9U3dnDbmEO9/zkEkNfQQTri4cB5
    sIS4csDunQD/3l3IXJccl7pFchHXio0iw3Uof7DhIO6cVSpoKHNUBDUvFxxNMALJmN8UaN
    lOMEc5X8ZzvX66f9uIscNuqwrOvR3BRyoaWSGdp9/9LDpQmcP6MFDntgiFMQ
X-ME-Proxy: <xmx:wD3PalV7o67ZeWpOPBNgKE--2qGCHGx4AYNVZYTbe6LmjiZweSbx2w>
    <xmx:wD3Pajgp__oQxS6Lmqehabu5DWMyTmTf6BtVPvHBxZmNptVywosFMQ>
    <xmx:wD3PajsevqQ5tgnR_p0FU-PhBXhq2RacMfbonaBO6lNEPo7BENvPLg>
    <xmx:wD3Pas47Q0VLJJolyVP7Qi3VUKWvAKRyrbavP80mSo-tm5TwxSb7gg>
    <xmx:wD3PauNLjXC6n-V4wJHjbw8KD-OYvvMAytN6wct87i1_a8qOfJa3Ix0d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5c28b90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:34 +0200
Subject: [PATCH v3 8/8] ci: improve reftable test coverage
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
index 47f174ed0e..fe8155772a 100644
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
         - jobname: linux-feature-testbed
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3e2e6083cb..9b7698a003 100644
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
       - jobname: linux-feature-testbed
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 611bf6e56d..1c549634e0 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -40,7 +40,11 @@ linux-feature-testbed)
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
2.56.0.212.g129ede20d9.dirty

