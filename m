Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE63292B24
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059845; cv=none; b=NWMfhPX0oVdytZnISAazqjWda2A+XKnS7+cO1/vW1vWydgx2HAX1eqWbGC9QhLZiFDtVIv5j+bFNi50SM6tWZg0TXeBMZEQ+GaqkbGSo160jtW81ltqdg/LMXO0KpO98toRYS3NaQDXiSFt5qbUL5nrv8xk2NA/LMSSU1MVUWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059845; c=relaxed/simple;
	bh=IlZjma/E7nSWJzRf0wbfgp1V2SWxOFyrTEj7fMlgHyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kQ5mGw/iAWuvcoXqC649DSCIYk+e/ueFEYlK1zXahqI4nDev5uLaD0cYkVNl5KJysqWol7DqPjCqXcWowjcBT+QatkSgoT40Rkfd/y5LEovY7y0C7Gk1cjbEkBCkqA/ds327uzCZH/RDhgpCCP032O4vmTETnyZVedbHlEXXQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bsZG8EC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3alaiYS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bsZG8EC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3alaiYS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B59751400234
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 09 Jul 2025 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752059841; x=1752146241; bh=xc1n+e31Ue
	OR0Lfjsre3LVhT4pNXEMdEr8wOfxluqjQ=; b=bsZG8EC6i6IwvtScPIit7x0a/A
	rw2GyJP9N/NclMg1OTFKGm5hDHVN3Ll+LqNn0s/oLsKpbF/MikZwUb3ATtLd1xGh
	ecI3Ss+xDniLuR/SFBWI2KdPCtMItZilx4bKrnpPB0LSLm6Z4vpS3ssjKfijKZEc
	5liEKIn9GRCutqix9zlYedXoA67apGNvEwHHHsY3w7nVFrhTKgkeApnS6AF42sHR
	u8VLPAvWNigRfNkb4fcHbsRiBZ//vaIrgoUV7uzmU9lsyTJfHviNLs4bhF3E5NMQ
	rsMoYEngh+yYfgCITY8zPJBS1zMH4gqf3p/SxGsTZPY8iUHJo44j8vTDQLdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752059841; x=1752146241; bh=xc1n+e31UeOR0Lfjsre3LVhT4pNX
	EMdEr8wOfxluqjQ=; b=c3alaiYSgzQhpMeHH/KcbVyvGM9EC5e+FPSGn3MfNewZ
	beJttSmO66UqBq3ilRIVTjAKXj8veodatjuOrFkEZk4fLrtydInUVL74EoXghora
	GBMI7Es3Q5jnV1GlAY5sgEDEPfQWl8T7k8dKiHDm2Qc4PTYokDcU1vAas6ZaPUWq
	1STgeO8vASQ0aAds6t3sVWHesVJlVCkZzL1sjh+pwzjOpZC1sUa+JKP7WQW6eXfs
	9MytrkAvkMqX1+p45hXLH+fFG0vXURYIXG4b1cVKqM6XpJl8+gPlNrnW+W4njj9r
	D3VdxyCdO6mQ1XDJmbahuHxjVfSUGyQnrx/YpkcbyQ==
X-ME-Sender: <xms:wU9uaBTiqYI74KcdQpmtSaF6aAi9E0ldzU3xwDlr_mU5Z-oTKA2DlA>
    <xme:wU9uaMylBYKG8cf5og-770LBEHfrqq71quE0NGzd4-ua0df6FJyZImPcrtfVhR9s3
    3nToxebpld9VYM8jg>
X-ME-Received: <xmr:wU9uaANh4pf5XgUTCn3bviyN3CCT0uQmQjQUZQ9zNNcox3zFlcCBXSgucJUoD6PpzU5jaUTVAYBr2qiz0v5bjrljBoGFY1Lg0Vy_5qihNuhphA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wU9uaLP1dLikn2sM66WM97HWCa9N5eQmZjTv48dLowe3D6go8oaVPQ>
    <xmx:wU9uaCRcOhugsuZ4xGoyMVbPWWv5VpAJ1zzhzeKpRAww-n4OCuku3g>
    <xmx:wU9uaNCc0D6PG9sUTj4doYhR7VfId6mb0ZUxjK-mVF3NJ1rEiqpJZg>
    <xmx:wU9uaBhECfSWh5z_31CkKROmF_Z8Cht7VeKsIlBtpqqtXK0slZB4fw>
    <xmx:wU9uaGLt5AY-ugY2P_mjDD9wCPFLdRHVAnpxM0FzsHpCTPPVVhqXajx8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d25b6f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/19] object-file: get rid of `the_repository`
Date: Wed, 09 Jul 2025 13:17:10 +0200
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZPbmgC/x3NTQrCMBBA4auUWTuQxkioVxEXNZ3YUemEmeAPp
 XdvcPlt3lvBSJkMzt0KSm82lqWhP3SQ5nG5E/LUDN75k4tuwPI0lNuDUsXML8KPYJ0JlYoYV9E
 fDjn0/hhSiCFC6xSlzN//43Ldth3b2++acwAAAA==
X-Change-ID: 20250709-pks-object-file-wo-the-repository-9f41234c4747
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series refactors "object-file.c" to get rid of the dependency
on `the_repository`. In many such cases this is done by passing in a
`struct odb_source`, which prepares us for eventually converting this
into the "loose" object source with pluggable object databases.

The patch series is built on top of a30f80fde92 (The eighth batch,
2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
`read_object_with_reference()`, 2025-07-01) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (19):
      object-file: fix -Wsign-compare warnings
      object-file: stop using `the_hash_algo`
      object-file: get rid of `the_repository` in `has_loose_object()`
      object-file: inline `check_and_freshen()` functions
      object-file: get rid of `the_repository` when freshening objects
      object-file: get rid of `the_repository` in `loose_object_info()`
      object-file: get rid of `the_repository` in `finalize_object_file()`
      loose: write loose objects map via their source
      odb: introduce `odb_write_object()`
      object-file: get rid of `the_repository` when writing objects
      object-file: inline `for_each_loose_file_in_objdir_buf()`
      object-file: remove declaration for `for_each_file_in_obj_subdir()`
      object-file: get rid of `the_repository` in loose object iterators
      object-file: get rid of `the_repository` in `read_loose_object()`
      object-file: get rid of `the_repository` in `force_object_loose()`
      object-file: get rid of `the_repository` in index-related functions
      environment: move compression level into repo settings
      environment: move object creation mode into repo settings
      object-file: drop USE_THE_REPOSITORY_VARIABLE

 apply.c                  |  11 +-
 builtin/cat-file.c       |   2 +-
 builtin/checkout.c       |   2 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  12 +-
 builtin/fsck.c           |  16 +--
 builtin/gc.c             |  10 +-
 builtin/index-pack.c     |   5 +-
 builtin/merge-file.c     |   3 +-
 builtin/mktag.c          |   2 +-
 builtin/mktree.c         |   2 +-
 builtin/notes.c          |   3 +-
 builtin/pack-objects.c   |  55 ++++++---
 builtin/prune.c          |   2 +-
 builtin/receive-pack.c   |   4 +-
 builtin/replace.c        |   3 +-
 builtin/tag.c            |   4 +-
 builtin/unpack-objects.c |  15 +--
 bulk-checkin.c           |   5 +-
 cache-tree.c             |   5 +-
 commit.c                 |   4 +-
 config.c                 |  50 --------
 diff.c                   |   3 +-
 environment.c            |   7 --
 environment.h            |   8 --
 http-push.c              |   3 +-
 http.c                   |   4 +-
 loose.c                  |  16 +--
 loose.h                  |   4 +-
 match-trees.c            |   2 +-
 merge-ort.c              |   7 +-
 midx-write.c             |   2 +-
 notes-cache.c            |   3 +-
 notes.c                  |  12 +-
 object-file.c            | 314 ++++++++++++++++++++++-------------------------
 object-file.h            |  65 +++-------
 odb.c                    |  10 ++
 odb.h                    |  38 ++++++
 pack-write.c             |  16 +--
 pack.h                   |   3 +-
 prune-packed.c           |   2 +-
 reachable.c              |   2 +-
 read-cache.c             |   2 +-
 repo-settings.c          |  54 ++++++++
 repo-settings.h          |   8 ++
 tmp-objdir.c             |   2 +-
 46 files changed, 426 insertions(+), 378 deletions(-)


---
base-commit: f0228c39bf2fe539583cd594671039f05765bc9b
change-id: 20250709-pks-object-file-wo-the-repository-9f41234c4747

