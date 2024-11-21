Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66351C9DDC
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221831; cv=none; b=CoOGYHLBDEu7/BljeqeGZlZHnudDOZXi9KCxv0s0cuLDZxFEMeMZifYNbdmofeqCQr4BvqBeyv0FfjLae4ZXQbIeYsz5Hd5ZRlvur6HGJYH+vvEofxkbcwGa8zGJelWS+T7NhJm3wuWJOBJrLSL6jAVW64ujEssaPQgFXe1Ucps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221831; c=relaxed/simple;
	bh=vy7egpIhAQqoT4jIujRV0GCfyzathQjw8snkXub0pko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiDhR1U5ALqngVkr3NtLt09/PZq1fOcjV57EWDOefSLlzYpB/e9rAm8yEcY58zRzTzcEYPMCC9IS4bfgk/UNtr4EBeXNuXidBvXSgxBC0YMq/Ut024aEZclFnut9Mr0HoPPenV+w9crG9foYC0+pzo11+8zCp+TGARqBJ5LjHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+6ruaZe; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+6ruaZe"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2965e65ce89so963686fac.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221828; x=1732826628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jN3sBOzlKd39Vgucdi9eleor6mcVQf1KInecyJ6eBSs=;
        b=G+6ruaZeK9aNpe43cHNzE/yqUs7wRtsMwBoIRVPpJIw1hRjGDS2jB8TIM4DNJlM/m8
         aTuJQ7dolZ0t88/b8/ZxosIYpD4A+8IyZ5y2p2MnLIxWKUk20Da8dQ2aM/EfGar16jue
         STHK/gRpv06D1V/N27Y4b3Lg8zmYo63K1XhAuut5dy7OAFVK5hyrX+q3RA3HQxU+4T2L
         8bhTIyHGaCysMsrzt/eXTb2YqOtF1fdD6+i2IcC3JIQAt26T9RpO5f5xQQGymZJYB2Xn
         2IwztsMF8NChmN0sKYkvijm/ZXG1tNX6R97PocecWz1ZrUq68n8sbSkhVWmRmyuL5YhF
         EQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221828; x=1732826628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN3sBOzlKd39Vgucdi9eleor6mcVQf1KInecyJ6eBSs=;
        b=IyP5AIY3RIycKy23++dwvivUnOoSPK9Zwcei6h9UTwLokc0B9bDaVmPORbC+hozg25
         zR3lU4uueLuWeHarBOmVdnyjuW5j2QcRqHn9BkqE8QUMX/foOQnxQXVds9+MeeUD/8NR
         H9O+BjS9amgNl27uqOcw0smiRJd5PYfSrB+ckrxxJ909H0XocerkepgQe0GNBrrd0CZT
         01kBUDycxEADH+hxD3DwQm2W7n1Mv05bCMy3rdrHYmBj0ynlgwCD7PonSY6eP/l9mD1J
         ZEPolqqBtQSc83TH8ZUJqO0h3m/UQD2DCdoohW2cB0AIwyDQIqPMwotW3oJ9eOQPDHaz
         9bIw==
X-Gm-Message-State: AOJu0Yz/xxrqakbB46yiGObtYgYTAz67f29oS+SyVUzfCdeXQtxR62jO
	slvalY+bTQh9FW0t3YoD1yMyJLkdVuQ15C1RR9iQOlmbN1F/loa3aBfKgA==
X-Gm-Gg: ASbGnctHwLeVtLthWhljzCcaJYrbR3M2Pk3CvoHvqkY6ln0GcQl3n97agw1AQvHgDZO
	iJl6R0NS6m1A2ytmFOrEOX42Jj+xTo+OSArdI9PsTFQmNWb1DYA7FPjJtk7sKQUsv50W9TsAj2V
	D2U/hRyGfTSdzUc/q7RxEg3q6kgg7S8Z5fce0J5ZjEScJZlblWoPIex6/G1tRivrZw1+ZtsBk5T
	c/WUg0bTp0+XEL2gZGsH86imB4XvLbQ3FLTceuQ6GJ34VFR6iHv/ewrmQ==
X-Google-Smtp-Source: AGHT+IG3bVuCtmK3FfNiD4Vjv069eE7fpo9Yvk9zB7ynJsqGjDJTuWa3H2V5pBuMC8eqSbBlTRqGsA==
X-Received: by 2002:a05:6871:4390:b0:296:5928:7a42 with SMTP id 586e51a60fabf-29720c41795mr356076fac.22.1732221828354;
        Thu, 21 Nov 2024 12:43:48 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:43:47 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/5] propagate fsck message severity for bundle fetch
Date: Thu, 21 Nov 2024 14:41:14 -0600
Message-ID: <20241121204119.1440773-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With 63d903ff52 (unbundle: extend object verification for fetches,
2024-06-19), fsck checks are now performed on fetched bundles depending
on `transfer.fsckObjects` and `fetch.fsckObjects` configuration. This
works, but provides no means to override the default fsck message
severity as is done for other git-fetch(1) operations. This series aims
to propagate fsck message severity configuration to the underlying
git-index-pack(1) process executed on the bundle in a similar manner as
done with git-fetch-pack(1).

  - Patches 1 and 2 adapt the bundle subsystem to support additional
    options when performing `unbundle()`.

  - Patches 3 and 4 adapt the fetch-pack subsystem to expose a means to
    generate the message configuration arguments.

  - Patch 5 wires the newly generated fsck configuration options to the
    bundle options used when fetching from a bundle.

Thanks
-Justin

Justin Tobler (5):
  bundle: add bundle verification options type
  bundle: support fsck message configuration
  fetch-pack: introduce `fetch_pack_options`
  fetch-pack: expose `fetch_pack_config_cb()`
  transport: propagate fsck configuration during bundle fetch

 builtin/bundle.c        |  2 +-
 bundle-uri.c            | 13 ++++++++-----
 bundle.c                | 17 +++++++++++------
 bundle.h                | 15 ++++++++++-----
 fetch-pack.c            | 20 +++++++++++---------
 fetch-pack.h            | 12 ++++++++++++
 t/t5607-clone-bundle.sh |  7 +++++++
 transport.c             | 11 +++++++++--
 8 files changed, 69 insertions(+), 28 deletions(-)


base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
-- 
2.47.0

