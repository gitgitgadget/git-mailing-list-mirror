Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182837B02D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877006; cv=none; b=TgVtaPTUVtw3WRmztdItHuSbcKrn5d8eaxMrH/4kqCkDgZ+gXX8vXRn5s/mKfVLb0Ig/8wUKspADmWry0XyZvw7TaC2KnubjDhhVwwPBFwqfnO/tFSYQ8gx9lerP2RXyvUXQfUCEMF7PVMndcHT1yaKED70iKxvUiaDyYRaUgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877006; c=relaxed/simple;
	bh=hf64m8uu9p2k9O7md2Ama+d3WchErDJokyFIdlSZ+Og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hr9hDko/33dvSlU6gE909IXBAZ7IEIoQWtbJQIq2IH9Tij8x2MgRtjTM/JJE/UBuAQBBcadbKv8NlrL3hgyf3IG1ivbyK2S/f+Al33mxSUgOrNwUlabgnVUi/otstRdA+8oyxnQ5dKfIawaksOLuUC+tOlWfpeuy8jTzy5zjEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=glrCf23Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egmuXKrK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="glrCf23Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egmuXKrK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F046EC0123
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 03:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1791877004; x=1791963404; bh=Z7mqzqvWt4
	tzOf0XpRCX6n1Y0fVfYmonAdsOMJf1PJ4=; b=glrCf23QckHFmpIORL/sCH2Alb
	cLUytCRIbxNL3iemTaYYYD3rZVHJAvhS5zBaMwDKkh+XXB7qd5/AFCk63c6ANCfF
	w25Y4iDuhElvJ2ztdadEqWk2vLjeLo2/3kmjHJbreVWMNXXqOEveD3ae52ZliPKJ
	qssqrNFPPU9VHujFXTvcHCgrZ/9BA7oVpwanQw+zgiLdXRkjy+JEwjy36mdjRhTL
	UpQk8IuVQkfjUCFNjPqROC5XjoxB2ZH6rH2adCV8Ooy54A6dG8Rw2wyyCh8BiRgn
	/MlyOWMBkfSwBxXhsmSpMxN3Gmpbb+Nf75qEt0s1nadUXM9PUB4ALr+DVurg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791877004; x=1791963404; bh=Z7mqzqvWt4tzOf0XpRCX6n1Y0fVf
	YmonAdsOMJf1PJ4=; b=egmuXKrKAwHS4/VveOzlkdlm6J5brEFe7vj2SojngS5f
	LASPODykSQQEWxFCClkUMUn/zTJvDEXexEHV0sCHswnABynOo44jJbx/sfuaLPBF
	Rs7ImafHYj3XZYWJN8Ag0iT8F7ilNicE/hbBk163DRkEhl7UVoPvOTyqR094xNhF
	IbcL5RcXdjgWe86ciZ6MP7faJCy7NYBhGNY/xuxK1Tp4lE3ZV5oY4dzH781fmlVX
	aNNPETHRaNoHDK7Ge5SnZEc4pkgviNIs7/EetnlrMKL1TClr1m75I9VJpKMnnaUO
	0eJQJWuL6WmgOoiTicH7sVyjVBk828kys8NZn1Bnjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877004; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QJR9CCD8OCiEIZR+86oZRiqqACEW+aEGTXZpX/qJLfkGsfr
	Munvk7b0SZrqjnH+5fptPjq5D20AAAKaPHIiqmwRSfm5JSOudQngNuM8tUczthU/
	3Zh5nd+wk7zDizv1GeqqMhzO5jhyw2z8uRHBpuLOP3IBU2L8g8N/TsDHngPGAT7k
	GspNFa+7RW0YPKiMma91HjLcN96CRdazKf47IRMLXeaSWt+GB6JJ3elX0Y44mAVM
	VtypMKNt4RborkkYPw9X0ew0RnWEu7hEtRfV3g8HVGoV41J1sw5WtiUsOtbDttZa
	eqbMzjwcYXL9YGqda9quJodhQLynmfzzxItztpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:DaZ4CrEQFVA6MEWHlIQSekDxWUyIShgx1+/zQY/TL2s=:hf64m8uu9p2k9O7md2Ama+d3WchErDJokyFIdlSZ+Og=;
X-ME-Sender: <xms:i9_NavmsvUcTUQVf16DYHtChsMY_Hwa41av0n7OqHMflCA1LrbINnQ>
    <xme:i9_NaqRTiAoH93U_dbmj76zRwhlfuzVAA--dCHqKequO8JOrrOIMh0iCYKJN8BuBL
    Phx4u8Cu5zuExS_zBSOQ0X3z0i_sIcvC7sACbpf-gnJ4picXnWEqHc>
X-ME-Received: <xmr:i9_NajD93n5uzmbR7CbNG_k3k4rgXouwIDkaKpXAbDhiNpbimBxgUg>
X-ME-Proxy-Cause: dmFkZTFy/80JbiZw98YRCwOOJWk2VEFDNI6SpybV3Kgau4L6Vp1P20HQU+gMR+KTN0HbXq
    Sk/wx3C3EBeC19JaFvEBNX7X+TaZwsQcCqfmrwu3A4ki+Vi63EPUmJK+Tb7eTtyZgHlX60
    Afm8HyWXRPS4sY7nNcdhAOq9aKutujiSinSqV9Pnt3PNiTPAaYlmfrTr0aVg18gH3G3Wrx
    I8sWYj3uPrjlrU08HxspOeMMpEZlkB7vTIudOG+rd5p6I5KBsH4H3f48nHtnKbrsa/tiXf
    x5kNm4kxawUwITaWkX746EQvM3FP4RZ33oDP73IVvfS8nwr1jiAA+CZdo6octvvdPlvIZt
    qosbreDWYptcovgyM38ObWS1ek6nTB/k88kJKA2rfaSKtShILXm0kwaIlwYPWkujt2mB/Y
    wQ93w7R/UhVZcC27MeILVqSYv+3CFTJXM7/cqW+1c846TzSMm4pgF6aE6haff0Zt5QjRxm
    8CxqDl9NLkGEf8XUydN3oj5t96S6kjQfJYoH2P+SX6JkOikr0xpicb0XxvSst0wZ3xCAqH
    NBXMxhjw26D2jgVlZP19EHPxTc/I+63Z/HNGwd0yomEKegYyikO66lJlMK6jfwcbrLzrLU
    6x5rKDqrLcyeRm7fVTLAhwT8RUVNJac1V8kXTwkWP+OhElb+KpReDJw5yxag
X-ME-Proxy: <xmx:i9_NahRxdU2WQKHOoDYLe52ERVWICyz-Z-AFpjhOUZzcZ7LnPthEPA>
    <xmx:jN_NahqZan8A9Ee_r_u-Hq5-aPJegmbZyKNktaN51kAOVZIGllYSuA>
    <xmx:jN_NajwNesCdtOWVGXz7f9TeGParWigsQovjYSWpBizQmNJDjjeMKw>
    <xmx:jN_NamKU_kSvOjtlrOJwRXpSekOw07cgWt4F60bkkXEjIBf7ymRdOQ>
    <xmx:jN_NajMDPOS_j2Ve4yq3e7d4VePHozabSiKZ3njY8Lb7zTYS_se9WMGM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ac365c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] odb/files: cleanups and improvements for alternates
Date: Tue, 13 Oct 2026 09:36:24 +0200
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTuQhBLUq4iLdDrR0ZCGTCpC6
 d2Nunvf5n8bKFdhhfOwQeWXqCy5wx4GoHvIN0aZu8EZ560xHstTcZknjJJYMaTGNYfWJyUOeS2
 K1kZ/9ETjaXTQO6VylPfv43L9W9fpwdS+Ydj3Dw2FhSqFAAAA
X-Change-ID: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
X-Mailer: b4 0.15.2

Hi,

this patch series contains a couple of follow-up cleanups and
improvements that are now possible after having migrated alternates into
the "files" backend.

The series is built on top of 6de20f6092 (The 4th batch, 2026-10-06)
with ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
`read_alternates` callback, 2026-10-08) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      odb/source-files: fix performance when reading objects with alternates
      odb/source-files: fix performance when streaming objects with alternates
      odb/source-files: make the second read an implementation detail
      odb: remove read loop for found objects
      odb/source: drop `local` flag

 midx.c                |  2 +-
 odb.c                 | 61 +++++++++++++++++++--------------------------------
 odb.h                 | 12 ----------
 odb/source-files.c    | 26 +++++++++++++++++-----
 odb/source-inmemory.c | 10 ++++++---
 odb/source-loose.c    | 17 ++------------
 odb/source-loose.h    |  3 +--
 odb/source-packed.c   | 20 +++++------------
 odb/source-packed.h   |  7 ++++++
 odb/source.c          |  4 +---
 odb/source.h          | 20 +----------------
 repack.c              |  2 +-
 12 files changed, 71 insertions(+), 113 deletions(-)


---
base-commit: ea99757de7d4ef6c7727431bfd7b6726614102e0
change-id: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942

