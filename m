Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1391FBE90
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864939; cv=none; b=WCbpVZvIAddlSh1VURjWYz0T1J3DVFwoJR1F5KuB6FVwaMd9HJ6VkSCIYQdy89GtlKB1j1CRhKFBl4EEasi6k8DYOVIc1YLwJ6sNRFswPDhLE2X/uygT9/pDODw25QbSDVeirfw5FvG+eO40VR7YBsHg65Id+sFZodk1ItrS0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864939; c=relaxed/simple;
	bh=WssUwLC2InQsXSzyvxESPV8sJD8WxcP+4qTH/A48f7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DM3tBcgqPnmuVWrWf9r06KQel+ZwPIO2jd4uCRbbDEtC2LJ/jIQepBHFzD7qeXE5I2kTOiUE/vMYAqipCK899SaapIqHCpIvVXscOvG01L9XnqjC2bauaBRKjov7ofVeQZeCdR93QQtCmALuEOMRNwODqxTtVLyE8JgzwQjz2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DJrWY2wy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eggSvD2A; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DJrWY2wy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eggSvD2A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 587FB7A02FB
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:48:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 23:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1784864937; x=1784951337; bh=4JeYIVAqzd
	8PcjthrD2/o0apHEBl42dejRX6ZebxMJc=; b=DJrWY2wyqN2vpdp1WYlNdBpGal
	wCPSMidD1rUg9GrnH0Kce+U+O9Kczu/+Ir9OHe0P8JVZ6ScjPOZiQ15Rj7TADfY5
	3dvtBhoLmyTT+OgMwg9fSKbgSBFhEDhyrECPZn2mCkghDCdYqQS0TXAhQHyfOHwf
	yzD6CKl/YRFhzowCjC61huOdVjjr7WNLVDiR88tV9/0PdKRCo1HZ9fr62g4yL3sz
	Mi0MpfGxU1r5/Ruh07XM8jJgP2zLOmOsdhGa/f7IH0MfyPgiKKk5jEBEnQZ3sNgN
	5jmBU+ZW0SqUA0vrhLF4bYI4U8hiCtDby+fsANb2ErPwk5d3Mtodpv8vLQlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784864937; x=1784951337; bh=4JeYIVAqzd8PcjthrD2/o0apHEBl
	42dejRX6ZebxMJc=; b=eggSvD2AKUuXIhd65GYdoYtblMZ4tEame/pP603TiqAB
	CHJWTgWC+vHSRZVYJ6wwbOxLtENMXmpaNruSAIOAwfEhPo0fom/+bXTklzwYam8m
	4AeoGGtcXVBIJ6F+Xoxc53jhMup6ZEV30bN4Ht7Hb6XTeY5sFjy7ylbhiytz4Hke
	DMHpKs/PsuHpUeheCgAyoEEEQBalhlduf527ds3GkoP5A63ytS2rjArxyDeFXEBn
	zpmRF2Ie7/nd2N6RrD0GcA7Vc7SLCtZ1gIKSEM9oLgbA03pUk+pbZGdmVsAyaD46
	xWloS8x9So9CcQGWCs2cC8ynT5heb2xM45TdbJo3Ew==
X-ME-Sender: <xms:qeBiamV8RC9dVIOms6QSug8v_hUyQ8k0he1QfZUNWizGoO_tKecaDw>
    <xme:qeBiapjJp5F9OHS5NMoXzm17kZoXzYYJOw-jVISISGa03b2Uv5ILOs6B7P0ZJWVhM
    QA9YDBoKgpvr1XwjGHaX_-8BZhjLR_AEYUpdB_gq38THiE5unSvtWU>
X-ME-Received: <xmr:qeBiagDR0ecy8PrzHLAVLP4zQi6nbyY9kZa4_wTqPdocFIgSPZaTCecr5QkKpqBZIlSkoRJjwO0jHglOu8eSlX99WvWSP57KcE-_us9NCF4>
X-ME-Proxy-Cause: dmFkZTFde2wHONp6HyCidwKukoli6xqw7Y1UP5uCJGYsYo4AkGlp9WS/Uihj06aIbkUpgB
    6riX13u4mIlvlNuTqn5UFf7kxfFE3Pzqr3N0hE/TDdDZldwaEyqJhP00RjidZQIsvftWtk
    1QTDB6d9SveXbLNDEMeGPTl7A04L5RzFXjJPqzAfim1dJW+JCCdvTEPTMavps5vJ8JYZ/2
    87pXBcokvT9inWaO3zYmrNW1k/641NWhsD3/7fJB75Yu5uka6SvdEo5KfofQVwB7lpOTRx
    oKuCaMccOaqu1nIJt9OarTeqmd+ZlQDh0nasFR2jAx6lzCWqM8Q41MxN56qm2y7eAGyLNY
    UimTYvVwMg4+wfUphP/qSE1OuW/3HswBFZBIdOugP29nQqYI+qdKN9X8cJBFdMQPupUB/8
    fq8+1gS5Qvk8jq2JAa+17G03CvgXTXOmeZSLM8RDs4pY6VJwRLSCcqjZxXWBmfZ5E8GDSm
    N34L34Lmu0SVDFBOtEy8FeE4zMmqqp6ge+JWaByDW0/wxXuAam6jvYSCzg8Z9I1X5M8cfY
    mP8mtg+NATbHOXyPPCPP4xRDxPjhJGFUWVTgF4D69cQs3ShBCrKsKP+9Qz5AOUJO33Twrg
    vKjWW8PbSglk3b3nCMRs1N10EX6BnNrtxTT2Ftz4qlsWlfUtEUQr9r+5A3Dw
X-ME-Proxy: <xmx:qeBiaid-kUqgBE_YsTY5yf1t9pnmh8qAA5-RViiEvLL7cinphM6BOg>
    <xmx:qeBiage2YjY4anhk29zbtXBnFpyiLet1ZgMufCx5hiVVjbdQRihcMA>
    <xmx:qeBiaui3sHkwxY01yWhZBFcSPGdsLzscQvD28qa2R9uYga1_IafDRQ>
    <xmx:qeBiakTHV15zSIOjei1o2zXV5lo-INp7_u6xcL5PL_5zs9iJgmmmIg>
    <xmx:qeBialmljT03B8K4CWOuChuXbU4OXG_mwqZJ1DNnURJSEhqGvzmmEZ-h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:48:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cc1ed7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:48:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] odb: make creation of object database pluggable
Date: Fri, 24 Jul 2026 05:48:39 +0200
Message-Id: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQFEyqVxEXafKrYyEpmVaE0
 rsbdfkt3ttIUQVK526jipeolNxgDx3FR8h3sKRm6k3vjLeG50m5pJFjRVjAJXMSnThg8Ec/OBv
 diVo8V9zk/Rtfrn/rOj4Rl++N9v0DHPgCf3oAAAA=
X-Change-ID: 20260710-pks-odb-create-on-disk-ae8757861c69
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

when creating a new repository we create a couple of on-disk data
structures for the object database. This includes the "objects/"
directory hierarchy with "objects/info" and "objects/pack", which are
specific to the backend.

This patch series makes the creation of the on-disk data structures
pluggable. While we continue to always create "objects/" regardless of
the backend (it's required for a repository to be recognized as such),
the other subdirectories are now created by the backend. This will allow
other backends to plug in their own logic.

The series starts with a small detour into the loose-object map. This
detour is required so that we can defer initialization of the object
database itself to a later point in time.

The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).

Thanks!

Patrick

---
Patrick Steinhardt (5):
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable

 loose.c               | 25 ++++++++++----------
 loose.h               |  1 +
 odb/source-files.c    | 19 +++++++++++++++
 odb/source-files.h    |  4 +++-
 odb/source-inmemory.h |  4 +++-
 odb/source-loose.c    |  2 ++
 odb/source-loose.h    |  4 +++-
 odb/source-packed.h   |  4 +++-
 odb/source.c          | 19 +++++++++++++++
 odb/source.h          | 29 +++++++++++++++++++++++
 repository.c          |  2 --
 setup.c               | 65 +++++++++++++++++++++++++++++++++++----------------
 setup.h               |  9 +++++++
 13 files changed, 149 insertions(+), 38 deletions(-)


---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260710-pks-odb-create-on-disk-ae8757861c69

