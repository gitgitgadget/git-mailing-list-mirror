Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645743F0AA4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586163; cv=none; b=gcLlvhxEDQNw3uJ/AAfeS1244m0xpp9UA91pZ0pGseDFNk+7wVFbqXp0sT66C2w++paHDH6jvaDiIqVGBb1fdBJKEecc9MHTb2WCXcE7uQf+LQExLvs5T/SnlQQ80WzRT97fex65jE5QF+Vdm35yoxhXwEkvgKLtB9vWrv2w5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586163; c=relaxed/simple;
	bh=PjlgWOO1Wtq1KRSMcAuVxtHDLk3Kd4jJGNWKXCkd0uc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PiJ/W/B3/9RQuzvx74zq/WYip9xnTxHbtgLXd6ZgDvMDkjkxNYBPkBOG+C2t8v9o+8tQyl9XdDZtvg2P49kfd+NTe3hUbRQlupiPd2DokTzC/vYZrPjFeoYB0e7pZMmFypxt8Pn2J8VsiQyKuDJoI08/O1Im85+K8Fep7IDxa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nq5uoSBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bef4SPmy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nq5uoSBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bef4SPmy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D2E961D00086
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jul 2026 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1783586161; x=1783672561; bh=xx6nQ52SnG
	vsvy7mFHxh+H+3UcdI1gGQSuMgLv7TTkg=; b=Nq5uoSBg7ySa+Yx3tNBNo2gcQc
	tRBk8Ip3MfQRglUxfcV/EJ6UOrCTupDABUjftT2l25dk0uzeNRUQk0gEP53h5z6u
	P/MY68Mf5qdAxCxhXZJ7Woln5rJYFDdyil9uBh2fHWL2V8TxT1GlJhsEELpqHDwb
	3YzudWZTQPukwjLxLSGthDKnnwnfYYK5RSf9nZ7BMyUMqBmS6R9Qbd4Y+ZDjLK/y
	vHfkJuXKLIu9oQT6x/oEoecSKAuhgjEAiG2BWufHR6e3E0c7/wPU4bWOO8TuxsoV
	3Djde6ePCWkrzHQQrFLCWPeDK2RizeN2fxcB1eot/gS2SKQNA4PRzo6Pp3LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783586161; x=1783672561; bh=xx6nQ52SnGvsvy7mFHxh+H+3UcdI
	1gGQSuMgLv7TTkg=; b=bef4SPmy2+qlvJ6PkkupYhZhmknexyCxr+qlqK7yShWX
	8LThG7DQnpiA3nPk3igQypCiwIRNXviNBw5g6fbe1JdFq1Qrwrwmu2St4aGaygIn
	EL1UGfpMUR4Z947czC5S55tVPdWjvarq5sc6QcIjb64KcaCmg+xuoYV7ebSyBb/R
	UmzaPQBn+ulTywfhRV59z54h1DWsDZIXZdHy4yryNkmDgiyBWVftbeZyK6opOzNK
	y8cBDk1JOAGRSezuizaBJq0BnViGceVYMkO14nv+VMfXkzF6SzG7faSvlgBI60jI
	n+JJYMB7TW9NgrGH2sMWSPN8aOnkML+SOzjb9sreuQ==
X-ME-Sender: <xms:cV1PahtayHe-1xTvEjWRoKGby0ihjvStEqfTuXKgjBMj0xSj5FNEbA>
    <xme:cV1Paha0xiKZyMRyh_CcOC5Z9R3uRwBFFM-KlfU4YmU9pSGRyWMjev6-UnLA1waAN
    90jK-rXDeXBdy1161vVZ5kF_Yy4WqI4QrK7kvRtBAYxcmrXkVSs>
X-ME-Received: <xmr:cV1Paqbc0OiYetPSSn6o9pddezPFm2Ar_m8TRKzbEfnVswnwHDciZzx4WWh6KhmqEcRk-TiIw__URz_Yf7OJl3tdw-Fpg6k0BMcs9rBE1w>
X-ME-Proxy-Cause: dmFkZTELgXSPCILvtmvNIHKje1J9+u3a8mtvW+w1KJCiDtNSMGPbLUhu6/VqLZxF3moQIv
    eAajUj9HQ/ABykJoNlmfs2dQ4N2nprN2c7V0hN07nPxAL0MW546VSVTeWjy2See+xEYiav
    UgwRJV3HZQK/E8xn+8HHRciKERAKDymB8TyrPk2vIgJ8hWDBuFlnhDyox0nHMHbDYyLD2+
    Me4H4w1UIM3+nR2C9KllC27T4umphEuX0rOWcwxvoyxO5Y9al5yBu4r+Lrsmt2fyRwiuz6
    6SGKskoVi7zT35gRJgniT3zNhnyizhpR1BVYYKSSQegfZTYXIdFhT9RIaXfort4TyDTor8
    CncgSCGLOiWfwee0T8elipWH0GvOm/Jd4QsUu99VoTGdu5pMXD70JkY5SjY59nNE/JWxEt
    BD+hen4Tn5nrd2rxUclIz+1gWKdDpUrw5OgDHEwTTuMztKDljuMjM8pqN2ZW7W0YbH1rWW
    XF5wiu/6ez1nIfZtPU2aqSL/Be3W4JCPfj1HAOmGjTCiHZUn53wiHSHRDxTFZ3Sir0GehC
    mrP3rVEavm+5WBn6PCMYaeksaGJLjtlXmFXV79UqhKHBq0Tm4CdsKIgw+JYYduOxml5ibL
    IrTmYcG0xnwRmRp9Io96Z2QBFYGA5kggf44i06Yra0FQ46hBpkq+2KOx26Gg
X-ME-Proxy: <xmx:cV1PatWXqIzyNQmCa2f06RUHpMc0q61dley5vucgFTeZmeauAmNytg>
    <xmx:cV1Pah35sqvYqS29zRMAdmz_AUb5X6u-6cPre_fpptfDlXr-o-xxQQ>
    <xmx:cV1PakYMa3VA38oyaJJdiUvucFjsq1lIIGkxb5gAL9wkYoeGY3F_iw>
    <xmx:cV1PakonIj8nNMQEIo_hGnKFdllB7MhQ-Y72XCE6lv84rqgzvcnH4w>
    <xmx:cV1PaoeGdhb9-oKWLzh47te3FGQK_Kb8jF1v9_GymyVIPK9rflNeO6UR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18d513ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:35:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] odb: introduce object filters to
 `odb_for_each_object()`
Date: Thu, 09 Jul 2026 10:35:20 +0200
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhdT2oC/yXNQQ6CMBCF4auQWTtJaSMQrkJclHYqg4aSGTQmh
 Ltbcfkt3v92UBImhb7aQejNynkpqC8VhMkvd0KOxWCNbUxrOlwfijmOmLIg+TBhHmcKGyZ+biR
 YO9s1yburdRFKZBVK/DkPhtvf+joXvyocxxd9ZhrGggAAAA==
X-Change-ID: 20260708-pks-odb-for-each-object-filter-13286fa3523d
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series introduces object filters to `odb_for_each_object()`.
The intent of this is to make `git cat-file --batch-all-objects` work
with pluggable object databases. Right now it doesn't because it reaches
into internals of the "packed" backend to efficiently handle bitmapped
objects.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06) with ps/odb-drop-whence at 8a7ad23e11 (odb: document object
info fields, 2026-07-02) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      odb/source-packed: improve lookup when enumerating objects
      pack-bitmap: mark object filter as `const`
      pack-bitmap: allow aborting iteration of bitmapped objects
      pack-bitmap: iterate object sources when opening bitmaps
      pack-bitmap: introduce function to open bitmap for a single source
      odb: introduce object filters to `odb_for_each_object()`
      builtin/cat-file: filter objects via object database

 builtin/cat-file.c     |  76 +++-----------------------------
 builtin/pack-objects.c |   2 +-
 builtin/rev-list.c     |   2 +-
 odb.h                  |  12 ++++++
 odb/source-packed.c    |  77 ++++++++++++++++++++++++++++++---
 pack-bitmap.c          | 115 ++++++++++++++++++++++++++++---------------------
 pack-bitmap.h          |  10 ++++-
 7 files changed, 164 insertions(+), 130 deletions(-)


---
base-commit: 3c8e2790f2ce15e8b5d4b4e6ced711b12649f32a
change-id: 20260708-pks-odb-for-each-object-filter-13286fa3523d

