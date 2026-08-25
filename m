Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006C459AD7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667159; cv=none; b=C4KchuG7o/ifatIQ/3far5Kx4OUN9CnSa0YCeE+mT9zvVBqLZsysP5Y1rUUea2dH90DzTormp0Aw6t+oWxfjDzoyKfOtAR7OcOVGBBuJcDcdQrkZcfKTjBCGG186okjOHfQvA54GugLJa8wOrAy7giffsYEmSCxmJt+dTk/mDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667159; c=relaxed/simple;
	bh=bV4kCVeOF1xpbEBOVbCLGaOobKjklgmWAiwiwQiW2yc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VwbQdUqOIxQi0VMyxbUA8o+lEmvzkuFVxsKfBSG/GUs9DkPPCjcDb8izAqdLefTPzWhsZs+0Z5R+EBRQHS6SRr2Kb/v0YHwsDrXjoHVR+PANV2XFxpLzqb5u2jkPirD6MaOPXfNTReCfliNd9W2jMPzTFEpcGC6tcjPolWuy1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bsZkcX0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQMufb39; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bsZkcX0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQMufb39"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FEF41D00128
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 25 Aug 2026 10:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1787667157; x=1787753557; bh=NuzskjsaIn
	iQ/T62vMmsqqV5QPDnYXtfJghnrGUpSWI=; b=bsZkcX0fwoUmX6cF8wuHpGVc73
	xY+ZYHEuy7KL6HrFcsvGU3PEUkezXRTzlZxh0NIKP9VcsbeAPjom2EO2rz8zcRmG
	Jy5coCk9KuNnc3gOc9PsA1n3RolQF/fMf2V3YYBWVoan4L9f9T9e6KU8/sE58lQS
	08Wx1tTqh7K+BNfqb1/VefAB7IJ2Ypf1mH9WECVe8C2fJDB+vfgGPF+lAFhJ05Ej
	vsMGbEvcNrlJzZ3jEkFg/NuNhL3JIxL1Ey53JAAwJyOV6D4f7v2u9FEqhprgp0aa
	G2gZV2pJuGLlecKBP7T3g767ZPIq3jJ7yfvGapAhpHz8n21Rf4Ohj5Ypp+Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787667157; x=1787753557; bh=NuzskjsaIniQ/T62vMmsqqV5QPDn
	YXtfJghnrGUpSWI=; b=fQMufb39jaU/M4v+3OFWqOpOquig+eBUBDEkq/luwHGg
	sJ0iWue0MVyKiafeaYQjEd+QNaRbXlrTfViD5OT/fAyxdfFBnrLTmD0cZAk5F3PW
	4Rk5rmhVGNwaQjdHQSjPlHTphuBSnhB0KVKw9/GG4symnEvV52nd4il02o/61NUu
	gBJbRL/QleGNmK/vJGeS70uebRr92/gbIoKYmQme0gLiB+A+HC6sFlZ8Mwh8RBAm
	trOvq4tTlCS90yRPba0lDbpjk7wKO3IB9hFQop6b8jPvyHl/Hk5Fypn6c7Z0pcaZ
	tvXe4z66Q3Vb14HAX8IY/IxpBoKYM0+BlzOLC/ncCA==
X-ME-Sender: <xms:1KKNakVrHB4G6gEaUd6rDWaiLy1UNU5xUvMVATs7n6ij8Iok2upuCQ>
    <xme:1KKNavi-tbpiD2dACEiSMH-nYBCJ7JeYaiqhL4KIcD_kgCkfAB6Wn2R7umSepmUOK
    rVBl_wePS4Wv0IpkPuFjGnuV6X-DKAwJTfDYu1HnbxIlQfpUXIGC-Y>
X-ME-Received: <xmr:1KKNauCKt2HY-K6jBplcZjnHls8hcW3fl1IlFxr_cd6gzQ7gQlSf8v0WofnedkUf1Dy6R0iCu8ooN7I6Ph3d8NH8hPh__LEEpBijox6i6Q>
X-ME-Proxy-Cause: dmFkZTGlGd29lppOwf92Gl44h4jKdGPmh9/ffuFgYGVAD0A2ctqN5gzELQgMkMFWQZobMq
    9mGsRAXQRcc5QfrAvXqWlX9p6GZttaKr+9M7AaM+FXQh+wUwoW7Bpm0D5GffWG2k+TskTv
    nsFA/AS3n+sBIPOi5nGlFGVEzWhNtcq535H55SdKfmBJjSkStLxp1/py6e6EPHCGO3dvVB
    eog/KeShBftbf5AVq7izsHgI+fIBctrbztIrj08Q4yVaTqTaXILIcEZzAeEGa6MDeMTpID
    CouVTXuKECOqo61nuYWq2vAK8XP2fS1lKSR3QzQRDtbJcQF7p238SvtnIAR4dbaWcPi2L/
    jWB3tXnSnXgL3a2uuJ0tSKhx03iCNOtVjvOF0C8Q0mcWvwdfXz1cNTKW4BFIT9zqrbG8Sr
    8b5r5UQ6EzIhtN6n+cDJ+tFinPrpdiTWu5cW2j8vOWYqzds5pzvWFl+/XaMgza7tFh+McF
    0sEWg/qOTXW1fln3ZsD5152Cw+ko8qNI12RwkkX9HNqMUfO/1rVZAdh7X77j7MIXe6hVDA
    m9rlIIYcouvFX09fiR/NUTPURWLB1Wfhs1iSdbXvk8krYQfCRLI5uZCUQM75VbwJ6cpzTo
    KQ8qK7+gYL6sdemAIgnYUNCMt6fbpswj0bWwRPxFihLXVCBcDMKU5xhlzcfA
X-ME-Proxy: <xmx:1KKNaofi4DBcEFqvd5ZbHaXJitJFNeblXiYdj-bUrIKsj7DI0SrOuw>
    <xmx:1KKNauey3mLENnhiJvjs8HUYn3ZphjZMzTI9RdmeEQcKqaS9vqOMdQ>
    <xmx:1KKNakijLC63cZlhxNHd2cz38w4FXywoAELRfT7QMEMoYiw8vwCobw>
    <xmx:1KKNaiQ_E8kz7Wu8UC3kW8MFZiq8UZMSUucDrm1aQRF29fmSu96tyg>
    <xmx:1aKNarnh_tHCf9OKYNHd2UB66Jk_A15kdYaVZeYDsa0m6bm5N_WoAzbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a483c6c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] odb: write alternates at creation time
Date: Tue, 25 Aug 2026 16:11:49 +0200
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNSQ7CMAxA0atUXmMpKVUFXAWxcBIDZmgr2wxS1
 bsTYPk2/89grMIGu2YG5aeYjENFXDWQzzScGKVUQxvaPmziGqer4VgSvlSckW7OOpCzITlmZfI
 aQJc7Y9+FGAqnbUcBam9SPsr799of/rZHunD27wCW5QM/SGAAjQAAAA==
X-Change-ID: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

writing alternates into the object database currently happens via
`odb_source_write_alternate()`. But while that creates the ability to
create alternates at arbitrary points of a source's lifetime, we don't
use that functionality in the first place. Instead, we only ever write
alternates when creating a new repository.

This design is suboptimal due to a couple of reasons:

  - It requires us to have a `write_alternates()` callback, which is
    overblown as we never even write alternates to an object database
    after it has been created.

  - We're about to make alternates an implementation detail of the
    object database's backend in a future patch series, so alternate
    implementations may not even support them.

  - The backend has more flexibility with how exactly alternates are
    configured when it itself is in full control over their setup at the
    time where it creates the object database itself.

This patch series thus refactors how we handle alternates so that we
don't write them ad-hoc anymore. Instead, the series introduces a new
option for `odb_source_create_on_disk()` that makes it handle those
alternates at creation time.

This is part of the bigger goal of moving handling of alternates into
the "files" backend.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
`alternates_db` field, 2026-08-17) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      builtin/clone: defer setup of the object database
      builtin/clone: move around `setup_reference()`
      builtin/clone: refactor handling of "--reference{,-if-able}"
      builtin/clone: move setup of alternates for shared local clones
      builtin/clone: move setup of alternates for non-shared local clones
      odb/source: support writing alternates when creating the database
      builtin/clone: write alternates via `odb_create_on_disk()`
      odb/source: remove the ability to write alternates

 builtin/clone.c            | 108 ++++++++++++++++++++++++--------------
 odb.c                      |   9 ----
 odb.h                      |   7 ---
 odb/source-files.c         | 128 +++++++++++++++++++++++++--------------------
 odb/source-inmemory.c      |   7 ---
 odb/source-loose.c         |   7 ---
 odb/source-packed.c        |   7 ---
 odb/source.h               |  44 ++++++----------
 setup.c                    |  15 ++++--
 setup.h                    |  15 ++++--
 t/t5604-clone-reference.sh |  25 +++++++++
 11 files changed, 201 insertions(+), 171 deletions(-)


---
base-commit: afa255aeb620346d56a2c01fb5ae9163513c56d7
change-id: 20260813-pks-odb-write-alternates-at-creation-time-64010deb94a0

