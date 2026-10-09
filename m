Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A94BD79F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545561; cv=none; b=ShQlbAU07aYcMxV4s60uNQMmZlZzR/lbEv5Jmq11eNYLskrSR1eMPx/WjkImnRW8Ab48kh/AcKpI53zBBr6rxSZFEK+eIBNdCVAgUNWB4t9tG4bYuAIFyXiaIrrufjaw6DL9G8vSs6kv9dPprKJDYOma5p8dfHKMqgdPHSoaXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545561; c=relaxed/simple;
	bh=qdRqp05TeSgh+YM6rQqmpjiflsoLCgMdZYx6USkZbcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUH1zEE83gVefoaaz+Zvcp9OuJWC1gbkX4GaVZHATFKa+yWOi02+uNmGxZbjUbgWdWCfJjcanN8fyUUpNDm4u/m4Q/ZgPiv/6O9rsq8E8Igv6JdMaFtBdzushve/R4Q8rPEl22RIPFR1veb5vwBMwy3ppw1B48PyJ1ZqHQMHqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mJlwa4tj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5L6n0Eu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mJlwa4tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5L6n0Eu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA4261400080
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 07:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545547;
	 x=1791631947; bh=2yfdk+Kqi+mRjxhesw+ROHWBj9NBl1lDgSEsHTdSNr4=; b=
	mJlwa4tjN6HuX5TBjvGalTxDHHdR6KnwkyIkkdj5XIYd9NurjeKGVL1BQY0VB3oA
	UrW6+CbXmmCzheaLDlrZYuNoMzFWDPP8Lgy6a3+w1l9Ix8VHoQKZPDULkZNAroCZ
	0cZBSjzVL7FkGl+BGWu0fka/DuJyoLAAxVT2h+uLKl2I7SvA769XZ3B03wqfXwS/
	WvYzLWSAkqPHshEEbHoIDh9ELTgMbYaWOmUe9oYD2dlsih/YU8B6wEANpb9CUnUU
	Tg0SCKovlDzgoMFj3NXoMZxcKdkWb1oVyhh05jHGM+v9BEN1DokGeqNwT2Xphbug
	B/+u/qyKduRQDXM3ZRNXYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545547; x=
	1791631947; bh=2yfdk+Kqi+mRjxhesw+ROHWBj9NBl1lDgSEsHTdSNr4=; b=L
	5L6n0EucqbA6a/mbDUXahUh20DKKnFFZ90MYxTF1bWJEd17bQPfO9H9tLJnp2JIN
	AV2RSr2j6Qnj9Oa1voZmDFfsx255HvnUuK2iTB5VTkkYFm8qiWLrWvC9z2QoW18y
	85eaWpANNEs5BhRdv18xap9kfqrogDQKf5T/clBVw2l+MuJutICNBtBoEadRm/Nr
	zzwrgUkWhsdD87vPcmpyip7ymSzBIh3x+SRWMI7uqcboEw54a02jcjpPqZk8wuLT
	aHRwTkgSF9hNz2twKx2aDWdgNtkddACUxGD4wa95pU7z2/jEcnUuKG4qappvkWtF
	tTkPCOD7wA4dU3ZjgEttg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545547; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cnXf9uOsIFwDZCqGIu0rW1114kwTB/VMXxqe8iiVRXY0bFW
	amJVkPk33G+m+hHGmpEQQp9ILEbOHEiBrjB+qUYBqlS/9cFRIQ4Eb20W8Uky7uNn
	zN8tiyKxVBd690y5ECiWhw5INbTUrcV8YFjIAWg7bK47uS0nPZv9Hm7K1vExoLN6
	Ept9rg4FSyQzkurN/hk8lyiYYEChqVvQ4t+O/d/EUOj1eaBMOhzejCgMfZiUiRiS
	+JiCbP0p4Y5PHHOnqHarJFMYD2zzjhyrgZ7/HOv6jYfMMLuAVf123IwaM9du+erm
	M6v/5yLnsEe8UG96tr1JjgPDtJu+MHXBYHm819g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G5em+kzf2qF1D/M7C7tpkWcwZ2hYvMLJVKUIMMnGBX4=:qdRqp05TeSgh+YM6rQqmpjiflsoLCgMdZYx6USkZbcU=;
X-ME-Sender: <xms:y9DIatj9EKwcAr8TfS2rR5uIy6omlHLeGXwY12F2dE9WzLXTNWxGow>
    <xme:y9DIapDlmj30daDJGWydOMxvD8eohDARz_p-Fs68kmu8zIXxh8GWsB6FvTkKmXIM4
    jS7ysy08SKShBqyH24TvT9TtfbC3UEwGW81ZQ5wdqtxVvHUly8HiQ>
X-ME-Received: <xmr:y9DIaiEs3VP4Uj0hwPnq9ijC8ym2oDK4Obl9hBtarqgtv_DA-CjIx_B0cjdDyN3Zk6dyTQ>
X-ME-Proxy-Cause: dmFkZTGE1RLvMxRAJQtr7MVhx+dGcrnDvrY7zFtlJfJoY0W/evJe5tgR80lMk13rhkpL3+
    xwZYP9AGWYBxsOTCSxS6oBF0vVq4+xl3EIuXpkmSwfcwmPim+cwXJssWgK5O3Gr5dRZOD/
    XK51MXD7NObGyulmlTuydmn0T1QbaBpfi9UdvS5d+Jb2pCfQb73Dellbvp++K8+kHUqet3
    drBWbR7jwNDhiD8YvoJwHm0NDvfBqyvJt+MvNBK1/SGSDtVo0RkGQUMqNV6xhaZfdfQs7/
    8N9M2l9VYdwrX5Eu5UAs53wqSkPppNexdGmVERX8g2pc2rHCTBXMuelytWQW7f+RAaXfWA
    1lf0/hl+RLLDS8KLNw1wcpepDE2rpyPqHQuK2Osi0e1aMlHvNMGhAdhrH2+PEfxkY2M/yi
    s8zNEM5sl3poFDp7H3edxF0uS4z8ecVy5sXEulN3q5U16LNKaljjZ7aDmFcos4ImycqzYD
    F1k4M8GyeKJUfbNnxRTlt7/s6XooNy3UtB6+yjedYaOWCvaOAPEITbgsRYE0FpsEJAp8Nw
    4imFlduyVuosiFAwH08TxwN+izlvks4f9IBWcI6Qy+5lQEFYft7pU+n14EZhx1yln+rgMn
    UHDNLAPw9rpLl7/O954qAumuWl9/+1+2BNJIF+Uu0hpzRhjzTzUIwrqPpGTQ
X-ME-Proxy: <xmx:y9DIahJ-XZBSlXPAOzh4AOEdXGS8NzzMR5jYwXGTNlh_vfuHeTuEIg>
    <xmx:y9DIamkP7Ph4ExyeoGP3xNnE3ISkTyGX8N8IMLmFUEGF00l5QiIP1A>
    <xmx:y9DIapQzvaM1B57XOG9c0ClQHv_JV1f0Q8xkM8qxD6Tp4pakwGAGvA>
    <xmx:y9DIaoIBQSCln1Cz52OUFaeNm0zT8t3YLNt3DeYmAK3XqaRiTfDfXQ>
    <xmx:y9DIahDGgOOOjVfJjItdEHquOo5L1Wred0hqj4MXUEeuTN8vY3DYclg0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 14b21062 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:03 +0200
Subject: [PATCH v2 6/8] ci: switch away from EOL'd Ubuntu version in
 linux-exotic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-6-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

The "linux-exotic" job still uses Ubuntu 20.04, which is end of life
nowadays and starting to show some cracks. Switch it over to use the
"latest" tag instead so that we don't have to constantly update it
anymore.

Now arguably, this reduces test coverage for old versions of Ubuntu.
But "latest" at least points to the most up-to-date LTS release of
Ubuntu, compared to the "rolling" tag that uses the latest release
regardless of the LTS status. So while "latest" and "rolling" are the
same right now, that's not always the case.

Furthermore, we have other jobs that test with ancient versions of
Linux, like for example the one that uses AlmaLinux 8 (2021, originally
tracking RHEL 8 from 2019) or Debian 12 (2023).

Note that this also requires us to switch away from GCC 8, which is not
supported by Ubuntu 26.04 anymore. Instead we simply use the default
version of GCC.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 4 +---
 .gitlab-ci.yml             | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d7a301ec98..5b772dab55 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -409,9 +409,7 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-exotic
-          image: ubuntu:20.04
-          cc: gcc
-          cc_package: gcc-8
+          image: ubuntu:latest
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 27a16ed086..de40434ae3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,9 +43,7 @@ test:linux:
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-exotic
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
+        image: ubuntu:latest
       - jobname: linux-breaking-changes
         image: ubuntu:rolling
         CC: gcc

-- 
2.56.0.170.g584c36229d.dirty

