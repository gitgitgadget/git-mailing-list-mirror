Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D923958A
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959284; cv=none; b=k3xOTd19y84fUSRC9LZjftkR07SFdl0F7sGfNad1sfiJRgfHu/g/r+qUBYMNbw+2TW6rZHLmMw/c4BkdURO+85sai2xe1Dgi7Q/LtFdlTGKToQrKSkeS4cxvL85J4FWJk5AqIFf7eTZ6FWRLjKzrfhNTUFN9f0G7B1tz2h1eKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959284; c=relaxed/simple;
	bh=HmZcda7NglcDpk/4HXmBWbjREwodlJSTKmmZgGkFnDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=W9jPFdvgkvck3DF5XTNY3Jvu5wHWZkmMmEP3C7US7Eqx1vmQ1/4Un3l8ti4MVcMYp8QeOxh4P2tGDPYOWoQmGmp8F9vGaLhsjKAiP13m+IHXw4w1u0hxnmIvsEwTdK/VFBa/gcLmVm1z1gRQg8SVfEfln4nbWB9SRlBVPoBojK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M35vo1TK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZ3/Vlv3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M35vo1TK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZ3/Vlv3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A860811400DF;
	Tue,  3 Jun 2025 10:01:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Jun 2025 10:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959280;
	 x=1749045680; bh=NLLwgE9cFCO6mAByvkgVCIfyZ0lGm5EEEN78+Imu8xU=; b=
	M35vo1TK4QGzeNlYwyup7l9DQ5Lu3/ENTMrCzqZxZ8yGvbobIAmE+TaglNfCOJmQ
	1eAZfw+wO4qOouLAONS73GDLwz1HmApAdi79slHhFHC9/ZV/SPSztGUDGXj4BRpp
	a2oFrCrjjplhU7krhbkrcqSGHrPogbk8qHkqcm0fSHdSiqtZeqDRlf7he/WvP1nu
	Or5ja76YOJ+RTzA1EBfE9pGDE5YyMolKGrEnFDVPhuBMpZ+Stih21OAEBccKxDjX
	EA/+nTddRJm1Dx/IOqK0c5zBAucf/dKS1h9swgooyjq5zfs517qBhcDy5aJN9T9D
	oMztRMFSB5Gb74KmtveM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959280; x=
	1749045680; bh=NLLwgE9cFCO6mAByvkgVCIfyZ0lGm5EEEN78+Imu8xU=; b=Y
	Z3/Vlv3ifE/wKYbgq2FIE5htTmci5g7uRb8ya9kEtW5K81EBiWAZt/e+7V9ffspV
	0RZNTq61qGjsVLiD9f4rD0AxMygBaIxvzRzk6XW/um+nyVVGyKg9Z2LFQ+VL18dX
	JC54H424QxCldVQu1YM7BggLKQlFNmFNGlhJzwDe+30uEsh4Tj5X9eJO+jwGyTm4
	1yHVQZIuDr4yPJMB6t1dLU0V2Z/YMK53GWfLgv4SwZeTngMlinIL6NWQsHSc6yRD
	LoDALqgoroD4H7mRXueOMWaWb8/Ptf/5eiV8lKnvDY80XMvVqj+IZZ+ftTiRIhIF
	WdZolxLSDV2ETrQALUKrQ==
X-ME-Sender: <xms:LwA_aGJlToyQbjQXn0-bFqiav65twCupe2Cdh2c-gN8l7qRE2YMN_g>
    <xme:LwA_aOJSxeYhc5Slrq-KPR-KlwivO_qfpAo7ojL_XEoaRPJAzvdMDEP5GXdVvTkbe
    JHBYgGq5-IM7fvgBQ>
X-ME-Received: <xmr:LwA_aGuuM-ac5YdWcFMdzl2Hi_iEvHdOAt0CdsG2anMK5LzL6hCgE0EwY_RSU1Vr56Qn2L_pW8CW0bAMFQRj3saq6XIav37V2ftAdx96vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefh
    geffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
    hsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhn
    vghtfihorhhkshdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonh
    gvshdrphhluhhsrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:LwA_aLbRPEzg4DcLMsS6ont3yfBoy_tGj5Ynt4-c5XFJKNQWM0NAEw>
    <xmx:LwA_aNaSWn53RJLqt_V-IrVHGwqtWojOlFfgbhJnKulKA-wGVlhLyg>
    <xmx:LwA_aHBlq54vIGrKUM4r0s5fnDNF0R7hi1hCPOw2t0sjtxkRtFkPCQ>
    <xmx:LwA_aDZi-qFT2daUxtPfLhWRkCleYP4Bkx1Qw07f6hS6vNdFo3jVDQ>
    <xmx:MAA_aMbPKkSyZ_TpOw0UTiMV-PGI65Oeys4McxCuxTZFHD_shR0-O3iH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d1867ac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/12] builtin/maintenance: fix ref lock races when
 detaching
Date: Tue, 03 Jun 2025 16:01:08 +0200
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQAP2gC/5XNOw7CMAyA4augzBglbhIeE/dADGniQgSkVYIqE
 OrdcTvw2GD8bevzQxTKkYrYzB4iUx9LbBOHns+EP7p0IIiBW6BEIw0uodbQnQpcXExXSi55gkw
 NnFt/guy4lHJkgl2RtI1gpuN1vE0vdnvuYyzXNt+nj70ap3/gvQIJpDzVGMhZS1u+X8SLGOUeP
 7RK/qAha0FqwmZdkVHNl1a9NSvxB61izayWQWs0GHz90oZheALAcypdaQEAAA==
X-Change-ID: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series fixes races around locking the "packed-refs" file when
auto-maintenance decides to repack it. This issue has been reported e.g.
via [1] and [2].

The root cause is that git-gc(1) used to know to detach _after_ having
repacked references. As such, callers wouldn't continue with their thing
until we have already packed refs, and thus the race does not exist
there. git-maintenance(1) didn't have the same split though, so this
patch series retrofits that logic.

The series is structured as follows:

  - Patches 1 and 2 do some light refactorings.

  - Patches 3 to 5 refactor how we set up the list of tasks to not rely
    on globals anymore. Instead, we now have a single source of truth
    for which tasks exactly will be run.

  - The remaining patches introduce the split of before/after-detach
    tasks and wire them up for "pack-refs", "reflog-expire" and "gc"
    tasks.

Changes in v2:
  - A couple of commit message improvements.
  - Introduce `die(NULL)` to die with the correct exit code but no error
    message. This gets rid of some magic numbers.
  - Introduce an enum to discern the phases before and after detach.
  - Link to v1: https://lore.kernel.org/r/20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im

Changes in v3:
  - Rework logic to talk about foreground/background tasks instead of
    before/after detach.
  - Link to v2: https://lore.kernel.org/r/20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im

Changes in v4:
  - Some more massaging of commit messages.
  - Link to v3: https://lore.kernel.org/r/20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im

Thanks!

Patrick

[1]: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
[2]: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>

---
Patrick Steinhardt (12):
      builtin/gc: use designated field initializers for maintenance tasks
      builtin/gc: drop redundant local variable
      builtin/maintenance: centralize configuration of explicit tasks
      builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
      builtin/maintenance: stop modifying global array of tasks
      builtin/maintenance: extract function to run tasks
      builtin/maintenance: fix typedef for function pointers
      builtin/maintenance: split into foreground and background tasks
      builtin/maintenance: fix locking race with refs and reflogs tasks
      usage: allow dying without writing an error message
      builtin/gc: avoid global state in `gc_before_repack()`
      builtin/maintenance: fix locking race when handling "gc" task

 builtin/am.c                |   4 +-
 builtin/checkout.c          |   4 +-
 builtin/fetch.c             |   2 +-
 builtin/gc.c                | 410 +++++++++++++++++++++++++-------------------
 builtin/submodule--helper.c |  12 +-
 t/t7900-maintenance.sh      |  19 +-
 usage.c                     |   2 +
 7 files changed, 263 insertions(+), 190 deletions(-)

Range-diff versus v3:

 1:  e46a65951b9 =  1:  280f13d2895 builtin/gc: use designated field initializers for maintenance tasks
 2:  73cd67f3e1a =  2:  16a017fb819 builtin/gc: drop redundant local variable
 3:  a02452a6d6f =  3:  0ab3344ddb0 builtin/maintenance: centralize configuration of explicit tasks
 4:  ccd7691e4d5 =  4:  69e768cb54e builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
 5:  0e243fd81e6 =  5:  295e9e5ee9f builtin/maintenance: stop modifying global array of tasks
 6:  c95bd62823e =  6:  d94b0c86622 builtin/maintenance: extract function to run tasks
 7:  43d28434d8e =  7:  0bbba671cd0 builtin/maintenance: fix typedef for function pointers
 8:  d5740a5c9d9 =  8:  4ce38539bb6 builtin/maintenance: split into foreground and background tasks
 9:  168eb3a9372 !  9:  28092b9bed1 builtin/maintenance: fix locking race when packing refs and reflogs
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/maintenance: fix locking race when packing refs and reflogs
    +    builtin/maintenance: fix locking race with refs and reflogs tasks
     
         As explained in the preceding commit, git-gc(1) knows to detach only
    -    after it has already packed references and reflogs. This is done to
    -    avoid racing around their respective lockfiles.
    +    after it has already packed references and expired reflogs. This is done
    +    to avoid racing around their respective lockfiles.
     
         Adapt git-maintenance(1) accordingly and run the "pack-refs" and
         "reflog-expire" tasks in the foreground. Note that the "gc" task has the
10:  0ff01f6e2aa ! 10:  b8ed080c67d usage: allow dying without writing an error message
    @@ Commit message
         usage: allow dying without writing an error message
     
         Sometimes code wants to die in a situation where it already has written
    -    an error message. To use the same error code as `die()` we have to open
    -    code the code with a call to `exit(128)` in such cases, which is easy to
    -    get wrong and leaves magical numbers all over our codebase.
    +    an error message. To use the same error code as `die()` we have to use
    +    `exit(128)`, which is easy to get wrong and leaves magic numbers all
    +    over our codebase.
     
         Teach `die_message_builtin()` to not print any error when passed a
         `NULL` pointer as error string. Like this, such users can now call
11:  93f53000e47 = 11:  5b149886263 builtin/gc: avoid global state in `gc_before_repack()`
12:  01095d1bf88 = 12:  9ba01f143b3 builtin/maintenance: fix locking race when handling "gc" task

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f

