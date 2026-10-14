Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C574A206F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966655; cv=none; b=XAnmgF+I34ZyxxjoULAI2ZRmfJXgmEDHQ1vAuaolPSnxUT/79suVRzd3HuH4tjKnM/lOqsu29NUfVPza8z/WzAK5pMM6xqpvxxevFD9qptSQF0Qqp1UAum4VfYbhe6cm+RPgrInRarHBpKxsjTHh0oC4Fqordl74tVJWHU91P90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966655; c=relaxed/simple;
	bh=/uSXuqH4oO8uS0lqlWqgrcej4oF5+C8hgGNW6OyLmrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzT3hweuMj2u5kJQnvxxAolEwm5wUz+fAHEXyvPl6D/sUscHYMilMByKEf6fojfFLXmt4Cl8HEzULOUMqIetafOZ3N97S34i0l5jD59Y394FNYNTJiQwO9DwWZm5xOccxrTzw8PoY9ZeANr5o4gOSM0PixCrfb/8d6RdgAPi+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ds1Qj9KJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTrnm2n7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ds1Qj9KJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTrnm2n7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 06C94EC02A8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966652;
	 x=1792053052; bh=bJuZtdK8P5w80Fi5i9ZRUP1wYcUwXO99yzQMMVoM3eQ=; b=
	ds1Qj9KJQo6udjWHa5hXMvKDhy0zttzlPUYvZBddvHjyWGl1SafxVcPeTqs8rJxQ
	f5nX0d9YEMHTmg3fdg716EuqYKMRh6rL9TefWr1yNkD1QVWzkMX3jW6Z3IxUnGJn
	ncc2uXP7iQ7FuAaw7a84t2HHy0CgY6jyrOhRFyfMami2J5njWtnrOoIQiiOktdOm
	cIWnAqXjGb4qewZ9tkbMPe1hdf8aRaJ9euaf8CR0HD2kAPVjM+x/WAOZ1LNV5Bkf
	Zm7efLHAcSlfkPaLzm1yVFnjVIbeY7Xy45otYSpK5Np0JX5C18qtaXD6BndcHqhu
	DjcYrWjw6Sytgnv5NGzjmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966652; x=
	1792053052; bh=bJuZtdK8P5w80Fi5i9ZRUP1wYcUwXO99yzQMMVoM3eQ=; b=r
	Trnm2n7bobjA9LjSRQi4ASZ7NKBRoOmqw/XOS/zPOXnt2aNlFxR0mS1ZaOFAGFXh
	xac5WbrM1M879nphn6+TmjBnqt5PfdfTzDoeg5kA8mXMufeO2qaHH2kCezz7r7f4
	WTdMZ5PA5PPrXVUgfLVsSNR0FyB0sN4NoZhC0BLVRIcmHJMwSc5pfHGqpr8oJO6Q
	3BXTYP0jxWBEMIeMvzk2NdSyyVvl9Xzs03r8ECrShHqbA7LbXiEVHQ0BnMklLlGC
	xMDGv4suYOEu2OXyzcSGOlfBcPNDqtbE2WarqsqEei8eP6OrbcxvD0q3OlWffjsH
	+K68hR2qsTkob+t9p9GfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966652; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rdaagP93MXH8WA0j7pTtiOycPcS/b1h7P2kC4ae+uc/EkfW
	AIMmmJoU2KhZNfWSh7dhHONqLXPNlUbwO2zJ1pjwBjxAmckCIDlq8VTYHdnH+M9w
	QVYEI8DqQ98llYhcZInCH+VYmxbhZjzSdtku6scw8++OpNgpoeIkW52DQeqxYUj5
	ZEMuuVp+Z8OUArGZ2ae9snLmM/oR1hVf0RHIyWuSZ79TMvKAK2AQftXkpWaj/Ltd
	w7ReRihDvOUsupecOhyXZHY+Bdz2EKk+b0elHkqVWo2UOzI4XYlff8RnnZLBgANt
	YHJ8IOnsngpMqgq1tO5H+z5oBfvHK+uxTke2v5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SeqJUq59t02lyLgt+d3oa4gTF+hnVTY4YOZjfuj0I7w=:/uSXuqH4oO8uS0lqlWqgrcej4oF5+C8hgGNW6OyLmrM=;
X-ME-Sender: <xms:uz3PajsQbGf8SDIQ6Hno40gDYMF_Z7HN8Zq8tQ80u8tc2b5h1p6Osw>
    <xme:uz3ParXRKFu17222oaUBiaza6AKgYHy_trjf3AC2HIF5cfLJjFD4e6Ad-srvb9GfU
    a37jztR9vpLcAgCNQ87XecSp7wx4G96H-elVkgfdXV0ywTZyYRX9w>
X-ME-Received: <xmr:uz3PavF6uGhhbm67_NmfLCvGHOd4rwvsjXg0Mn35tRd7LH8X7wEVYg>
X-ME-Proxy-Cause: dmFkZTGtXs+YxZqlwfiHyfXMaLuTecbXoS6c8Mukgw6JdRSuFihQFyaf6TFiYl2pq/mbd2
    gpOSeKBHTGw5cVZ4+bD/wqrk3vnTn4bYfuxM2+e+txB3aLww02efpr1oDteTFtbsuxZsPp
    x4i+qUjPzsOC9ySpAKsIgfHCDSHVF0k7AsKiG7O7d1GhBnguKtJcfFPyopxv+W/nHvvHf4
    gySpSa9oMqrO8ArflG5DTobCGctbd5ylD7r5pUZnBrt7KNOrz5ScncESHbb/mJSBFU0VQX
    K/8/qHkqM3RbxqbdQJAdfpyNVAqGxAz2KADr2NDcnSLelyf+CgFebHipFm2Yq7DeBD86GF
    KTynwRBI/HLEcc/MlEjhSVhh6uJ5QVeszxMy8NUOxs5im8cOYfFFD7+q1U5Rd/U8z5KOnq
    CbR75aI3RYdTD6GTvhkIEVPl/JIm1EW1Y7GJutcZfOyXOOc6J3fPLF2I9udXnoI72Qa+nB
    S6+4icEWeLir9/FwVE4CJcVMZEw9vJe9QwrSvvOfoobQDsCe/zEaBSMd34ZDgRiSJqKNwU
    wZC7WtObXwr79xbQyATiUIHk4TF646vpUOoiw1MvA1QCzdUU1PrSvrMLpffi2HG8S9eE7x
    2nKAph1Tmx076gg/DPeEtUDL9Fa72xjNJuN017tdcWI19vwKWBmGe9E6EQng
X-ME-Proxy: <xmx:uz3Pat0Izi57avYMS26NHkwY4N0No8uZRGh4S62JfnP5dvjfE_lr9w>
    <xmx:uz3PahMRghACvMkH5clQVgH6gCNzcBJeQkMGQ3RiP1lxOyk9D1ueWg>
    <xmx:uz3Pas6wOB7uNIGgRlzDvNzqhDp1grlIApBvAI0u4jY-YI05qoBKCQ>
    <xmx:uz3Par2jHcUeMWYAFo1dSmwi3EX32FO-tm-QAlW6IQZGPvM2O89dRQ>
    <xmx:vD3PasX_qQFO7JwxdbTdSDBbc9yCZl0SX0tn_AhuxM5dtdDOpR_ggdLz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74ad59fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:32 +0200
Subject: [PATCH v3 6/8] ci: switch away from EOL'd Ubuntu version in
 linux-feature-testbed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-6-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

The "linux-feature-testbed" job still uses Ubuntu 20.04, which is end of
life nowadays and starting to show some cracks. Switch it over to use
the "latest" tag instead so that we don't have to constantly update it
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
index 60f262db39..47f174ed0e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -409,9 +409,7 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-feature-testbed
-          image: ubuntu:20.04
-          cc: gcc
-          cc_package: gcc-8
+          image: ubuntu:latest
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 726c1c1865..3e2e6083cb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -43,9 +43,7 @@ test:linux:
         image: ubuntu:rolling
         CC: clang
       - jobname: linux-feature-testbed
-        image: ubuntu:20.04
-        CC: gcc
-        CC_PACKAGE: gcc-8
+        image: ubuntu:latest
       - jobname: linux-breaking-changes
         image: ubuntu:rolling
         CC: gcc

-- 
2.56.0.212.g129ede20d9.dirty

