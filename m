Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75E1F130C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991661; cv=none; b=i0MwKEetWM8RoECxpb71c97oDFljPQG6hD1tx9lotxkpLMrYulLRNpI4AGvemF+S/RuhyfUwoxvfyHFro8mUG0Tu1Jp9y2cUMsPJm8UliSlW96rEvnm99tB4i5kyVPFIf0glhJDKCADzAlfQMFD2OOZRPgJS58VVQ868834Hy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991661; c=relaxed/simple;
	bh=Mc84D7HiPlZ8DNtqhFX0pei0h2FhYE1wr7UD5nXoUm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VKFBkS97NNl71BtyQtVt3T/KehcEWH1eVOnkC8vh4hTuZN8Y/JvKvdBiPkcH7YliFPman1a3YtHgpU3yHuUC5QivFrioO+h4xgHvmSMlbtP6oMLxZuefrmhHkr/QztlOLJMZdm862+oqhFXCnfa9ptejwE9kRYEGBrdiWkA5Cuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PDoGu/Xp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CqFYQlx2; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PDoGu/Xp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CqFYQlx2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CB74B114016B
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 03:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1740991656; x=1741078056; bh=tBHJdrRWpk
	+DFfseUhTQyuV4ubM2usEkfukJcm1ihJA=; b=PDoGu/XpnDXktaO4uGYpSXDtP8
	rmuCI8m9qBsNmftOfcwHa2tVU90ds+2ifUHc+H/xKQ0zRRk3rW0/BpxY8km3B6x8
	0yxlEk/8A1X3Unmgw/33vYZla+nQUVI9hQr/u0yXVUDera4e9q927MFDWvjIbcGe
	QyBBgT2XFbYV5R+HygJs9T+gjEx9VEJ1zljevyYO7d7o9DK2ApbiN0DCO3pLdzvL
	PaUcoKBz4stpoVLZ/xkMolB+1A0d3qFB8rzXexxrA70aHTrW1xP7JRCKDXGvbTHe
	8Q1UUoNSfzQaP85epzMPfGjeXSztT44Cjvyzbv43YpWzJex2Ff3MKUzU52nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740991656; x=1741078056; bh=tBHJdrRWpk+DFfseUhTQyuV4ubM2
	usEkfukJcm1ihJA=; b=CqFYQlx2VSNFwfxxAsW0ayag+TXfag12QLa26oVsT93E
	zAaGHd4Xl3bePT7E+QcXzqEjr/ghapulyVItCERbe9I6UfDpipXUw93+aEtkJpVN
	zoAoOhIwV9xrI2Asz8r2tNHOH1zn0z/BH08Se7QB/OgeoehT2pBsXCO1bAV6aW2W
	5TDn2qk8KTEuZW/L7sZ1XXlkEer5GbBrK/3PmpGGzB2uxtV3iPESHcuMuL0Ly88W
	dENmcHJvXLwP4HP7WL8Erg/jDKwBbVeilXa25ZRLECE3TErT30rbX8wdbJKIvM5c
	jXVFTE8cxrMZSyY8gE8cWfdaLiSyl5rwi6lX722U8g==
X-ME-Sender: <xms:qGzFZ42D5M2F6U8W153U15AmgiC5ZVOrNpkgpwWiSyeZ5hEahJeKIw>
    <xme:qGzFZzHNbszVxUIRbW-CNaAqmHnyocu2E0IFNrOOx94hReez20FxWelaFPUTd0D4O
    PHJu38kXyE68JZ_8w>
X-ME-Received: <xmr:qGzFZw68EzYqsZDhQSHGprQY08rCmOTXcaG8U8bAMOxnAeLZ3GRcvLroGQeLQkdW4XKeLnvu0mnzNtl6flSN4kC5P-C6Txo0LzVvfVVWV3kXQO39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtte
    eigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qGzFZx0SJ4dSYT9b1Uj_LWdp4xBm6jLNuee0e8L13wdFjKdQKoPrYA>
    <xmx:qGzFZ7GI6LqupNhalAb1t1XROAMrS-ZUokbX_gHrHjTfgH7J2wKAiA>
    <xmx:qGzFZ6_V44HgDtQ3sKv4Hp81SGoRi4qHl7C-mECb5SkneeIVjCpXWw>
    <xmx:qGzFZwnH7jE_hvLcXp4sU8CAWfJVUMKa-Jb0WaId7hNBqkuZ8mDUDw>
    <xmx:qGzFZxNk0Wz_9bO6h-1kJLa-ljr6RwVHdbA6CspUOFM9sPQv_55U98_q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a4d2941 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] Stop depending on `the_repository` in object-related
 subsystems
Date: Mon, 03 Mar 2025 09:47:29 +0100
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJsxWcC/x3NSw7CMAwA0atUXmMpDRQKV6lYNKlLDFIT2eanq
 ncnYvk2MysoCZPCpVlB6MXKealodw3ENC43Qp6qwTvfOd86DAcsD8Uc7hRN8c2W8tPQEqFQycq
 W5YvHMPb7cz+fYnRQW0Vo5s//M1y37QehqE0NdwAAAA==
X-Change-ID: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series is another step to remove our dependency on the global
`the_repository` variable. The series focusses on subsystems related to
objects.

The intent here is to work towards libification of the whole subsystem
so that we can start splitting out something like an object "backend".
It is thus part of a set of refactorings aimed at allowing pluggable
object databases eventually. I'm not discussing that bigger effort yet,
mostly because it's still taking shape. So these patch series contains
things that make sense standalone, even if pluggable ODBs never get to
be a thing.

Note that this patch series stop short of dropping `the_repository` in
"object-file.c". This is a bigger undertaking, so I'm pushing that into
the next patch series.

The series is built on top of cb0ae672aea (A bit more post -rc0,
2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
adjust last remaining users of `the_repository`, 2025-02-07) merged into
it.

Thanks!

Patrick

---
Patrick Steinhardt (12):
      csum-file: stop depending on `the_repository`
      object: stop depending on `the_repository`
      pack-write: stop depending on `the_repository` and `the_hash_algo`
      environment: move access to "core.bigFileThreshold" into repo settings
      pack-check: stop depending on `the_repository`
      pack-revindex: stop depending on `the_repository`
      pack-bitmap-write: stop depending on `the_repository`
      object-file-convert: stop depending on `the_repository`
      delta-islands: stop depending on `the_repository`
      object-file: split out logic regarding hash algorithms
      hash: fix "-Wsign-compare" warnings
      hash: stop depending on `the_repository` in `null_oid()`

 Makefile                                     |   1 +
 archive.c                                    |   4 +-
 blame.c                                      |   2 +-
 branch.c                                     |   2 +-
 builtin/checkout.c                           |   6 +-
 builtin/clone.c                              |   2 +-
 builtin/describe.c                           |   2 +-
 builtin/diff.c                               |   5 +-
 builtin/fast-export.c                        |  10 +-
 builtin/fast-import.c                        |   8 +-
 builtin/fsck.c                               |   6 +-
 builtin/grep.c                               |   4 +-
 builtin/index-pack.c                         |  16 +-
 builtin/log.c                                |   2 +-
 builtin/ls-files.c                           |   2 +-
 builtin/name-rev.c                           |   4 +-
 builtin/pack-objects.c                       |  17 +-
 builtin/prune.c                              |   2 +-
 builtin/rebase.c                             |   2 +-
 builtin/receive-pack.c                       |   2 +-
 builtin/submodule--helper.c                  |  36 ++--
 builtin/tag.c                                |   2 +-
 builtin/unpack-objects.c                     |   5 +-
 builtin/update-ref.c                         |   2 +-
 builtin/worktree.c                           |   2 +-
 bulk-checkin.c                               |   4 +-
 combine-diff.c                               |   2 +-
 commit-graph.c                               |   9 +-
 commit.c                                     |   2 +-
 config.c                                     |   5 -
 csum-file.c                                  |  28 +--
 csum-file.h                                  |  12 +-
 delta-islands.c                              |  14 +-
 delta-islands.h                              |   2 +-
 diff-lib.c                                   |  10 +-
 diff-no-index.c                              |  28 +--
 diff.c                                       |  14 +-
 diff.h                                       |   2 +-
 dir.c                                        |   2 +-
 environment.c                                |   1 -
 environment.h                                |   1 -
 grep.c                                       |   2 +-
 hash.c                                       | 277 +++++++++++++++++++++++++
 hash.h                                       |   4 +-
 log-tree.c                                   |   2 +-
 merge-ort.c                                  |  26 +--
 merge-recursive.c                            |  12 +-
 meson.build                                  |   1 +
 midx-write.c                                 |  12 +-
 midx.c                                       |   3 +-
 notes-merge.c                                |   2 +-
 notes.c                                      |   2 +-
 object-file-convert.c                        |  29 +--
 object-file-convert.h                        |   3 +-
 object-file.c                                | 292 +--------------------------
 object.c                                     |  21 +-
 object.h                                     |  10 +-
 pack-bitmap-write.c                          |  36 ++--
 pack-bitmap.c                                |  15 +-
 pack-bitmap.h                                |   1 +
 pack-check.c                                 |  12 +-
 pack-revindex.c                              |  35 ++--
 pack-write.c                                 |  55 +++--
 pack.h                                       |  11 +-
 parse-options-cb.c                           |   2 +-
 range-diff.c                                 |   2 +-
 reachable.c                                  |   6 +-
 read-cache.c                                 |   4 +-
 refs.c                                       |  12 +-
 refs/debug.c                                 |   2 +-
 refs/files-backend.c                         |   2 +-
 repo-settings.c                              |  20 ++
 repo-settings.h                              |   5 +
 reset.c                                      |   2 +-
 revision.c                                   |   3 +-
 sequencer.c                                  |  10 +-
 shallow.c                                    |  10 +-
 streaming.c                                  |   3 +-
 submodule-config.c                           |   2 +-
 submodule.c                                  |  28 +--
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/t1050-large.sh                             |   3 +-
 tree-diff.c                                  |   4 +-
 upload-pack.c                                |  14 +-
 wt-status.c                                  |   4 +-
 xdiff-interface.c                            |   2 +-
 87 files changed, 676 insertions(+), 613 deletions(-)


---
base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0

