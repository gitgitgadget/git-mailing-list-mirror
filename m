Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B924501B
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879592; cv=none; b=cO6EJpE71mCFdo0rc0ILJO/Unlp5bMHRADaEG6cdzkyQ+QcjnKuDElJTSgtRGuf1DudKW/7H9a0PNmwp0OmBA9E2pDZ7FEK+CjhMBKQF0w6FcQ8kZzvnuQoINx8cx8U/+9Ue6q96+g4I6CwCSwP0AAjP5KgzkOqDfxXfi2XI1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879592; c=relaxed/simple;
	bh=Qkokig6FZXa9urnW3auIpWxDYvnsmihJUi0TBJhEPIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Dpr+6s7AXteWIHYdwJpGkiZ9C2FXZOOJQ/7bHPrZ7iXJeMoeJpb1hGlbXbDKROkkIdacF1dQSFwWJEBeTt3Zu+HnLxC0xNCJbT+ho4qb7l6zonaDKqv5PiyzypV1pLDjnXfLw71KmOfvl0wCS3xjLXnnbtUdcFT9aMj1zwL9QMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mZ3TyOxQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0YNgTFP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mZ3TyOxQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0YNgTFP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF8701400152
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 01:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879589;
	 x=1770965989; bh=dic3KPfN8iHYK0JJ+XKtT1GQJdYfXV+HsWgramEW/Vw=; b=
	mZ3TyOxQHHQ1FkJ+z8i3IWEwFz7n6S5f4bCAPXqccJ2OR4kQFbdTdf1gA2oc+34W
	0Wg9H7J6wPFrMnxAE5G1R/wE8/m2Vi4rTRWiQBV6Au/yqNnrzFzjqwcLGfSiNGvN
	sECCsUVVtKHcreuF+Y3PQzCL12ipiHmSxTBHTbBYjs8pPz3SGFViKIe3KJYd1aGl
	bBqaWuCwkYvk/Lixrf/iOkFVAgxgrF8f8bkY92y9n3hgYBNq04LK35hparzWytRP
	OA+gt4zi5WJKCXjnBK644xgoCmTXtSqONG5EgxWWH4KDHZTme8J4HGkAuOF6mPqz
	+wTaS51e3z+t3HpVoPR4oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879589; x=
	1770965989; bh=dic3KPfN8iHYK0JJ+XKtT1GQJdYfXV+HsWgramEW/Vw=; b=U
	0YNgTFPC7nj6/r4DonWyhsj66OznYhYP3ER38CQ4Wb3DiwvGiJaDge4RRtndyPgR
	7giD/06d4sODI/UoddRuHtZ3o1xSWTDa41e5HZ0bR1vqlstOZtZr4q7N6JA5x4MA
	rz+7RLAUgdSOzFBd2ZBiMYvEhSnt8V0OIQhr3NHM4DPYcMqNVbXci1KlXChKwcQ5
	NTSPRL3koOJq/xyy7fn8QJGEEpkguByA8Yx+Ocr2BbPcO8jErpIjupRk9c35MQd9
	DiQKFc+d4KzSqPK2GOw77m5qd/O3q2sI3wpsQEaD0Ebu3TnLdcNCa2K+3KL+fiy9
	p3N+9qRT2rmFwZ1Awyasg==
X-ME-Sender: <xms:ZXqNacjf4mKnafl5O-8ob_vBlnR-4ZHVSYomInKk7g8uRx-jSgWehw>
    <xme:ZXqNab8Mp1LpkqN0PUgf0AxxMhLU9W0q11GLf98NWY-EG0tATa5ee_KHE6mgUBT1J
    Y2fpYZ1Z5v7KmDRezftZiyXqa0iMxizV_9abtQrLbsroMhqIDFBBZ4>
X-ME-Received: <xmr:ZXqNaZtyyiRNymAAMh6OrMTPTqsZa4YKnWzPMxef1C_ujruamn3jEjR6XQPYYpwTPBM5eQO6PbjtY5KmF5GLhr1JdmknGAxlDwD3Z3s-tJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfh
    heeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZXqNaSaPgwbWDKvYeSTnqKg2b4e4eHwcQ3oPx6ZdpYHuMO0SZQCZDA>
    <xmx:ZXqNaZoMzYStcBZg3Mv1LKeEAQbDe4qRZaHS59lpkkRaK0LC5Mw6zQ>
    <xmx:ZXqNaX-mQ7A0Dt17wpWWV-zwWcWda9m1nj4b89Pc9PnO0qNVwYcVpg>
    <xmx:ZXqNaY8Hd4Lk4v1M-kyr2opzAWPsEIAWQTTzyFRHqsK3mtU4RYcyXQ>
    <xmx:ZXqNaRj0sS1oKw8LzJmSOv6nRZh2qoR-C6s_8uAytqxbrbWhPtj2m0VK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1c41455 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 06:59:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] Small fixups for `OBJECT_INFO` flags
Date: Thu, 12 Feb 2026 07:59:36 +0100
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFh6jWkC/42NTQ6CMBBGr0Jm7Zi21GJceQ/Doi1TGH8oaQnRE
 O5u5QQu38uX962QKTFluFQrJFo4cxwLqEMFfrBjT8hdYVBCGSGVQadxemRMZDuM7k5+Rh5DxPC
 0fUZVG6913fjgT1AaU6LA771/awsPnOeYPvvdIn/23/IiUSCZs7JC1E42/lrGR35Bu23bF7OoV
 SzHAAAA
X-Change-ID: 20260126-b4-pks-read-object-info-flags-236c4437cfc5
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Hi,

I was kind of curious why there were gaps in the `OBJECT_INFO_*` flags,
but eventually found out that these gaps are of historic nature: there
used to be more flags, but their respective values got removed at one
point in time. So naturally, I wanted to clean this up a bit so that the
next reader wouldn't have the same question.

Surprisingly though I found out that this breaks tests, which of course
puzzled me. As it turns out though, we were incorrectly using a couple
of these flags for `odb_has_object()`, and the changed definitions had
overlap with the existing meaning of other `HAS_OBJECT_*` flags. There
isn't really any bug here as far as I can see, but this is only really
by chance.

In any case, the first two commits fix calls to `odb_has_object()` that
used invalid flags. The last commit then removes the gaps and converts
the flags to use an enum instead.

Changes in v2:
  - Add two patches on top that convert the object info and
    `odb_has_object()` flags into enums.
  - Link to v1: https://lore.kernel.org/r/20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      builtin/backfill: fix flags passed to `odb_has_object()`
      builtin/fsck: fix flags passed to `odb_has_object()`
      odb: drop gaps in object info flag values
      odb: convert object info flags into an enum
      odb: convert `odb_has_object()` flags into an enum

 builtin/backfill.c |  3 +--
 builtin/fsck.c     |  3 ++-
 object-file.c      |  3 ++-
 object-file.h      |  3 ++-
 odb.c              |  4 ++--
 odb.h              | 44 +++++++++++++++++++++++++-------------------
 packfile.c         |  2 +-
 packfile.h         |  2 +-
 8 files changed, 36 insertions(+), 28 deletions(-)

Range-diff versus v1:

1:  eec721a55b = 1:  308963f244 builtin/backfill: fix flags passed to `odb_has_object()`
2:  317893853b = 2:  7a69a648bb builtin/fsck: fix flags passed to `odb_has_object()`
3:  c785043a72 < -:  ---------- odb: drop gaps in object info flag values
-:  ---------- > 3:  0cea7f03f3 odb: drop gaps in object info flag values
-:  ---------- > 4:  ab98547370 odb: convert object info flags into an enum
-:  ---------- > 5:  414dd30e14 odb: convert `odb_has_object()` flags into an enum

---
base-commit: ea24e2c55433012a0a6c4ae947a87bc66404e484
change-id: 20260126-b4-pks-read-object-info-flags-236c4437cfc5

