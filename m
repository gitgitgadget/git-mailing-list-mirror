Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AA3BD659
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158784; cv=none; b=WCdf8cp2qTmF8jbtalwdywSnvP4xQBmoYFvIBOuU22mqyVvDcGfXBQmF5zNreOQAm/HrjGdyBIOsMccLikGynZ/T7QgSg6fyABGn6Kbaz9STkFBouk+bX7dS6nCx2rZ0V78B3qBaMaWBP2bPtJnii8x1Xjz3gPFrbD9OADH7Xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158784; c=relaxed/simple;
	bh=BZwGOD4eM6EcTd5r1iqmWCpiVsGr72S2aIEjSP1nkOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JTsFREExMhA66FmwOTuUfXzatmh5UCcfHDJ3duexLnbJYcdaAxTPr+I01Cl5EaP5YuFFCr38Ckq14lvzDuZg7TLpBmiD+9+4W/QXmVajHDWJT6qLGjUIHx885OyCUjw7m7dl21AIxSAZzjIOOm6x1io9FYtn9nr/GZBvqIns02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LgJeAfjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gq6CPz8d; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LgJeAfjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gq6CPz8d"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A66427A013C;
	Mon, 31 Aug 2026 02:46:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 02:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158782;
	 x=1788245182; bh=316bo6h5ojTaUj4FVY2VEK86l+KovTBTgKgqr19Joh4=; b=
	LgJeAfjO+supXQzAK6zfU8O0SBVbpjODmQUy6Pj9K4BxLwBYrMKIGuvNAsc3iefm
	uEWiUZY7sJKB1KTp5CVXi0UOGQKBn3e9cWeOcO7HNzH/m7J1eA+iHf5m/oclrGNU
	b2W13BKDA5zP9b2gdgMABJl6r4Io0W9fN05lp/4pg4yhpk5Rh4NfxkJxRh2cC/e1
	Zcs+sCeDPkxzOlHm4Y/vFosleA7gjzPpiljO37beq4t0BBNvZjjA3kQ4qESTR61/
	2m3Crjf5rrpja22TYvFyMVPHpfTFEV62/61iOe0eCagDQFUzI3OYTelGwQVbKJDX
	9pS9ZSiWjD5BOUEamS8kQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158782; x=
	1788245182; bh=316bo6h5ojTaUj4FVY2VEK86l+KovTBTgKgqr19Joh4=; b=G
	q6CPz8dyYz9B0iiBK/lzyX+ZpKh15E9WtzrQ/Q/gZL/lehVDJLdAiLP7R7ZLm+aB
	nvi9XK2fOaqc5tkanIFJ9n7CvQ1UB3PMEuIt/SUZEqTjVeK/LuTJYGf1dtiBxHs4
	bleoH9vko5OURC31ddkx4Y+EBC0w0dS1fXUhgp/65juzYFRyfVflaRIsUjqClgx3
	//qIOAaHdmZcFk30YuSfejSsQ7w1DqEywPj+k2ED/ZrJ3sPEzt6XHwxTMYim//o/
	Ch3Mh44CQv5AzRMYeM5onftTobgom3jhm9T/YLBs1H2m5UEYkbNAJ51ew/Ev68bV
	D7g00EQP2eu5kSK7fKEdw==
X-ME-Sender: <xms:PiOVagiA5Qgn-YgW-WvjWoNylrY5qgNqGShWW1Nl1rjJkR3zTyI8fQ>
    <xme:PiOVavBSssrU_070if41ANFuqeQ5V9gi6D7ZiN0UGpelnUes167-QvVZYfAV_dHb8
    mVDTpIU6fJvqrPw_2nlqZ00qSDo9vsIZw8s0Yi3kfLH8ymbiyCWm04>
X-ME-Received: <xmr:PiOValvm-U3QyoinlWZqnBjabfwp8EB_jlXXAKFctWgA9fqfvumSCp5PfZScsn6ljKpgvA>
X-ME-Proxy-Cause: dmFkZTGJqXuGkFNWEHpKJSUQrx1K+bRo/kOWFKIRfUsvus6Nicr2eKGbsaiErXPE4cDXcA
    4mqBZBC5/PoyoeCht1bZEoRE5MwgLli0rgMzNviho0+bzwl8MzUWHn7L+LGu+qzzMC5AGG
    EVb0E1bGaGPJMtpITpZq7SpYsHybQ/acmadCnPOPw+6+XPrmu3JOogt6/KiCxBfuGh/BsT
    WtDIBb3lDZX2wQUnjspDg9TWkMekV84PPx+q6LlS7P1A76rloeJIT+HPCu5Hb5/dyYeT3/
    s3E1ID+kchwdD8Z7oJZqSrb8+wxJyUZCMgcBz+ZKfgB+adOVrRPIA7FwXK4QDdEHzQrMUM
    MLxYAgbGKQXlEyP2VDbDcc9/8Nsx41bVcSMgm5z48ZtlBSuiAfZyDVRY3anKNT5RA3SBRF
    Bfnma4Kst4qOCVE9r4XAOv3y+sEzz2WxKKd4U8ldc0o+fRDIBGl60ln2v8tWF4qmwwLLoR
    vJRSSKdnl2RSAadoel5lPtBBHMhv6BZZoTE2G8XRaGirq8Pir5m0I6BjufBajbKWX+EOpB
    8wx60W3qZs9X3tBwWeqcNOJ4XR5MCxNAk1wOuufhTeK6Y3OjGIMstffxdaRsSaUvZszjiF
    xC3VcfMpTz1HyLbd1wG6PeGAAZ5fNKnncrJmI45AWJpG+CgzxdkHnVbGQEdQ
X-ME-Proxy: <xmx:PiOVasYfGybzU76RkIn0uwR39SnpeNVM5puL4NermIz6lzhLLl0T3Q>
    <xmx:PiOVagXpZoCyitvXuZgmTrgVoZOEphDPLJtHhvpJ1ulYOf2RlFA75Q>
    <xmx:PiOVao6gX-WENYUDqW44D-ejjXHUJ-EMT8Q5Nzod0aJxFQ8Ek-7oxA>
    <xmx:PiOVajijc5YWF1JdhkZf4zMDdnz8pd9zFKY1zOFj-Sujdzqeh32XfQ>
    <xmx:PiOVaoQ7l4qaVzx8svvzK_HaJEjRLplSmeWt9xlBmLsxGYe_wy2yxy_Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2364149d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] odb: make consistency checks pluggable
Date: Mon, 31 Aug 2026 08:46:14 +0200
Message-Id: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZjSADWuvIdhYctURiIlHSAaw
 t0t6NLlS97/bwGhyCRwzhaINLNw6BPoQwauvfV3Qm4Sg1a6Uqdc4dAJhsaihCk6Qi+uQ6oKY7Q
 zRKWHtBwieX7tr9f6yzLZB7lxu9qMlmUM8b1n53zzfgVd/i3MOSq0pqwaUtbrwl+SdeQn1Ou6f
 gBkMO0CxQAAAA==
X-Change-ID: 20260810-pks-odb-source-fsck-e64772c7ee5f
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series makes object database consistency checks pluggable.

This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
with the following two dependencsie merged into it:

  - ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
    `alternates_db` field, 2026-08-17)

  - ps/odb-pluggable-pack-generation at 5176dd3d05 (bundle: generate
    packfiles via the object database, 2026-08-21)

Changes in v2:
  - Some commit message improvements.
  - Link to v1: https://patch.msgid.link/20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
      builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
      builtin/fsck: de-globalize option handling
      builtin/fsck: don't check alternates with "--no-full"
      odb: provide infrastructure for pluggable fsck checks
      builtin/fsck: move packfile verification into the packed source
      builtin/fsck: move reverse index verification into the packed source
      builtin/fsck: move bitmap verification into the packed source
      builtin/fsck: move multi-pack index verification into the packed source
      builtin/fsck: move loose object verification into the loose source

 builtin/fsck.c                | 296 ++++++++----------------------------------
 odb.c                         |   9 ++
 odb.h                         |  33 +++++
 odb/source-files.c            |  13 ++
 odb/source-inmemory.c         |   8 ++
 odb/source-loose.c            |  92 +++++++++++++
 odb/source-packed.c           | 117 +++++++++++++++++
 odb/source.h                  |  21 +++
 pack-bitmap.c                 |  26 ++--
 pack-bitmap.h                 |   2 +-
 t/t1450-fsck.sh               |   5 +
 t/t5319-multi-pack-index.sh   |  13 ++
 t/t5325-reverse-index.sh      |   8 ++
 t/t5326-multi-pack-bitmaps.sh |  10 +-
 14 files changed, 394 insertions(+), 259 deletions(-)

Range-diff versus v1:

 1:  cf49376600 !  1:  1aec903546 builtin/fsck: use `fsck_obj_buffer()` when checking loose objects
    @@ Commit message
     
         When checking loose objects we manually parse the object buffer we have
         read from the on-disk file, mark the object and then call `fsck_obj()`.
    -    Almost the exact same steps are also performed by `fsck_obj_buffer()`.
    +    The exact same steps are also performed by `fsck_obj_buffer()`.
     
         Stop open-coding this logic and call `fsck_obj_buffer()` instead.
     
 2:  da2ca27041 !  2:  3804f0339e builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
    @@ Commit message
         Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.
     
         Refactor the code by merging those two functions. This makes it obvious
    -    which function does what, and it allows us to get rid of the early in
    -    `fsck_obj()` in case `SEEN` is set as the only caller unconditionally
    -    clears that bit before calling it anyway.
    +    which function does what, and it allows us to get rid of the early
    +    return in `fsck_obj()` in case `SEEN` is set as the only caller
    +    unconditionally clears that bit before calling it anyway.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 3:  a24506f55e =  3:  b2cb9032cf builtin/fsck: de-globalize option handling
 4:  f6a407efd0 =  4:  10ee3b8baf builtin/fsck: don't check alternates with "--no-full"
 5:  31841a1f05 =  5:  1e65eec60e odb: provide infrastructure for pluggable fsck checks
 6:  2cd6d71983 =  6:  0b8cf751aa builtin/fsck: move packfile verification into the packed source
 7:  c0559f1820 =  7:  3a38a75549 builtin/fsck: move reverse index verification into the packed source
 8:  96ae1ce3c6 !  8:  dd3a4c6cea builtin/fsck: move bitmap verification into the packed source
    @@ Commit message
         instead use the generic `ERROR_OBJECT` bit.
     
         Note that this change also adapts `verify_bitmap_files()` to be
    -    focussed on a single "packed" source instead of verifying bitmaps from
    +    focused on a single "packed" source instead of verifying bitmaps from
         all sources. This change is required as we already know to loop around
         the sources in `odb_fsck()` itself.
     
 9:  4721f4b4ba =  9:  90ada56b7f builtin/fsck: move multi-pack index verification into the packed source
10:  0b36829fd9 = 10:  b0f6fccae8 builtin/fsck: move loose object verification into the loose source

---
base-commit: 6b08999fb1b3ad0bad04d492dc206ad42839e274
change-id: 20260810-pks-odb-source-fsck-e64772c7ee5f

