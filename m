Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09221CA0A
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617724; cv=none; b=AyiAwi7LXBGsagBQeEVIatjkz4dam4hlIbYAkdHBJlcRvHHCBOPBuAnylYVOGuqGZ3bDRL38pjkEAb2ipmAWGpTdkLKrXKXjYpdhGS+4sbLLoxGRoM9C3M4pOOnAh63tgq7rcmDg8TXlNNXIFWYBzX6YcljnVA0Q8MDMwxNrF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617724; c=relaxed/simple;
	bh=XxqdGbsj13Rmf6rVe+gRnXOSHhW+sC5a1dNRuyMa9oI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ZSBtpy+ZT7j/o6yqz4bgGp1LudtjK1XJL9NV4lYv73c240NMXwh57NiLTzGyfWKt+c1n7EIqJlxGLUL9JrgqX1YG5MoJeJCumthsjQH8C+A7rDklU9k5hHk4k0h4Sukj9Uxv+QhgF26ZX3kqR84y3uj/DncFqs8DC2C6kxaIWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hAnQEKbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+MQDw7X; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hAnQEKbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+MQDw7X"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44CD11140118;
	Fri, 30 May 2025 11:08:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 11:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617721;
	 x=1748704121; bh=9Ie2vIEif4DXdlew+KnMgeJwHv0acVYThCe7m9P5KWc=; b=
	hAnQEKbhi14kz25j2S3PbTLUocZGfhqOdwPwlGpanxJsMwC/w1zZHcIagicPngz5
	XbGyQlIGw3XjSsSW91nzWpBDQDqU5cTDb8woCxNiV3WGy2hvm2QmUNnzSD6501SW
	AUUFz1TM+ygvn/QE3qVqPSVVDhjfPTd8iMKwFpUx5MDrdYJnsR5jZx76LIODy1xt
	mGW0qF63X9kyg0Lwlml1uINnM9bVn5Of13A94ESDhY2hOQX7czilS6El6Ua3DmbI
	qy/IfP08k7PptvkG89mxBCbIXPniWXe8a2ihKSRcC3jxHDGrckZSZ/pnGvuaTaEL
	B7KFB6DSNQJx9yYDH4Ting==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617721; x=
	1748704121; bh=9Ie2vIEif4DXdlew+KnMgeJwHv0acVYThCe7m9P5KWc=; b=X
	+MQDw7XxuWxDLn6qbI/erk5jv6WzUDSw6SEpopuafTTICoEWVaWxlq3Z8dTMi2lR
	PZZtdJKnHI23x4rUkJDD8O3MB45QiMjiTQQ9YOmSOTGB11EXpFOEvsQ1rcvBkhlR
	0/OALN9ov4osIoiTMylEHd6BaGW2NPYl7tHeHbFgf9Kf0olbfoeujExaHC3ZNZBD
	0blyM5GTQjfpehWav5k2IaZnAu/pcz8DAJ8H0gZxxMon9e/gDxenawG+S+rYIeGD
	q8hkDlvRs0n6gxaLHPJdQ40dT14uGn7BsFD4ZDbTrJPqzSdmWBKtAxloEdTZ+pBy
	mcpsXouz3ahtMYAMPuoyg==
X-ME-Sender: <xms:-Mk5aMvXrvVYXr4kulwfUFXFbCfccpdl_lQqmP6EhDCCu3O3SxHbHg>
    <xme:-Mk5aJdfbPLAgVj5w5okUiVVdtBP0-COjkwmhetlV_S2nveM-rX9elNnVysp2c2xH
    be0-q5PNXJnKbasfg>
X-ME-Received: <xmr:-Mk5aHy1mp5_1ot6YmH-iRwj9ful47MXEnCkycS8VXbmPU7XG5qP9YrMZ4ivHeAx7fYsGAEzqIGHv4-lDdTBnEak0suqLxvj2W0yD96PPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleefgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedt
    ueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhs
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggr
    shhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlh
    htohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:-Mk5aPMZIKIHbP6Mvtuzf-G5EXq8JY6GV3KIgJcvUfpRisVGOxV8oA>
    <xmx:-Mk5aM8iQ8HPtOkFSArTnNu8LuEoezmzyfX4-GQOln40vSx3DP2BKQ>
    <xmx:-Mk5aHVolrT42P1ADRJvGQ7RBDw3_TYp0Jn4lljj3v2AUGdE84J3vg>
    <xmx:-Mk5aFcpXToUZZUBUT1iy5H1M10mkw6q1mw6eouxMhBlt3_OrHpN2w>
    <xmx:-ck5aFSz02kAiCbfiNzD4qlBrw8PCxCgVcuDuOAMAJZQ9nAQHLuk4HXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 335828ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] builtin/maintenance: fix ref lock races when
 detaching
Date: Fri, 30 May 2025 17:08:26 +0200
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOrJOWgC/5WNQQ6CMBBFr0Jm7Zi2sdW48h6ERSmDTJBCWkI0p
 Hd35AYu3/8/7++QKTFluFc7JNo48xwFzKmCMPj4JOROGIwyVllzxfaCy5hx8hxXij4GwkQ9vuY
 wYvJCWnuynbuRcj2IZpGa38dF3QgPnNc5fY7HTf/SP+SbRoWkA7WmI+8cPWR/5gmaUsoXsgh1N
 s0AAAA=
X-Change-ID: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
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
      builtin/maintenance: let tasks do maintenance before and after detach
      builtin/maintenance: fix locking race when packing refs and reflogs
      usage: allow dying without writing an error message
      builtin/gc: avoid global state in `gc_before_repack()`
      builtin/maintenance: fix locking race when handling "gc" task

 builtin/am.c                |   4 +-
 builtin/checkout.c          |   4 +-
 builtin/fetch.c             |   2 +-
 builtin/gc.c                | 394 +++++++++++++++++++++++++-------------------
 builtin/submodule--helper.c |  12 +-
 t/t7900-maintenance.sh      |  19 ++-
 usage.c                     |   2 +
 7 files changed, 250 insertions(+), 187 deletions(-)

Range-diff versus v1:

 1:  74fcc4e2251 =  1:  87df070a9e7 builtin/gc: use designated field initializers for maintenance tasks
 2:  1cc513a7b0f =  2:  e2acea10f7e builtin/gc: drop redundant local variable
 3:  be8c8a98892 =  3:  48a5e25c8bc builtin/maintenance: centralize configuration of explicit tasks
 4:  b19fa152c81 !  4:  680b36e2fa6 builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
    @@ Commit message
     
         The "--task=" option explicitly allows the user to say which maintenance
         tasks should be run, whereas "--schedule=" only respects the maintenance
    -    strategy configured for a specific repository. As such, it is sensible
    -    to accept both options at the same time.
    +    strategy configured for a specific repository. As such, it is not
    +    sensible to accept both options at the same time.
     
         Mark them as incompatible with one another. While at it, also convert
         the existing logic that marks "--auto" and "--schedule=" as incompatible
 5:  8f692f30829 =  5:  9eaabb93edd builtin/maintenance: stop modifying global array of tasks
 6:  fc0ea110c01 =  6:  ffee3ca3c6c builtin/maintenance: extract function to run tasks
 7:  b5821ef6cfe =  7:  66e1bb2111b builtin/maintenance: fix typedef for function pointers
 8:  42a9210e445 !  8:  4eed6a8dc9c builtin/maintenance: let tasks do maintenance before and after detach
    @@ Commit message
         the maintenance tasks are performed in the background. git-gc(1) has
         some special logic though to not perform _all_ housekeeping tasks in the
         background: both references and reflogs are still handled synchronously
    -    ni the foreground.
    +    in the foreground.
     
         This split exists because otherwise it may easily happen that git-gc(1)
    -    keeps for the "packed-refs" file locked for an extended amount of time,
    +    keeps the "packed-refs" file locked for an extended amount of time,
         where the next Git command that wants to modify any reference could now
         fail. This was especially important in the past, where git-gc(1) was
         still executed directly as part of our automatic maintenance: git-gc(1)
    @@ builtin/gc.c: typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
      		.auto_condition = rerere_gc_condition,
      	},
      };
    -@@ builtin/gc.c: static const struct maintenance_task tasks[] = {
    + 
    ++enum task_phase {
    ++	TASK_PHASE_BEFORE_DETACH,
    ++	TASK_PHASE_AFTER_DETACH,
    ++};
    ++
      static int maybe_run_task(const struct maintenance_task *task,
      			  struct repository *repo,
      			  struct maintenance_run_opts *opts,
     -			  struct gc_config *cfg)
     +			  struct gc_config *cfg,
    -+			  int before)
    ++			  enum task_phase phase)
      {
    ++	int before = (phase == TASK_PHASE_BEFORE_DETACH);
     +	maintenance_task_fn fn = before ? task->before_detach : task->after_detach;
     +	const char *region = before ? "maintenance before" : "maintenance";
      	int ret = 0;
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      	free(lock_path);
      
     +	for (size_t i = 0; i < opts->tasks_nr; i++)
    -+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 1))
    ++		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
    ++				   TASK_PHASE_BEFORE_DETACH))
     +			result = 1;
     +
      	/* Failure to daemonize is ok, we'll continue in foreground. */
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      
      	for (size_t i = 0; i < opts->tasks_nr; i++)
     -		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
    -+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg, 0))
    ++		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
    ++				   TASK_PHASE_AFTER_DETACH))
      			result = 1;
      
      	rollback_lock_file(&lk);
 9:  7859d3b9b4f =  9:  41ae51294e6 builtin/maintenance: fix locking race when packing refs and reflogs
 -:  ----------- > 10:  2e1b4deb668 usage: allow dying without writing an error message
10:  18bce954787 ! 11:  7d9be688eb4 builtin/gc: avoid global state in `gc_before_repack()`
    @@ builtin/gc.c: int cmd_gc(int argc,
      
     -		gc_before_repack(&opts, &cfg); /* dies on failure */
     +		if (gc_before_repack(&opts, &cfg) < 0)
    -+			exit(127);
    ++			die(NULL);
      		delete_tempfile(&pidfile);
      
      		/*
11:  ff92709bf6c ! 12:  291498849b8 builtin/maintenance: fix locking race when handling "gc" task
    @@ builtin/gc.c: int cmd_gc(int argc,
     +			}
      
     -		if (gc_before_repack(&opts, &cfg) < 0)
    --			exit(127);
    +-			die(NULL);
     -		delete_tempfile(&pidfile);
     +			if (gc_before_detach(&opts, &cfg) < 0)
    -+				exit(127);
    ++				die(NULL);
     +			delete_tempfile(&pidfile);
     +		}
      

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f

