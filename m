Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9A331EB8
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505583; cv=none; b=a8QPgGPR0GAhlbn4lL7wTLTHuEn2/H2X2Nxs3Skz6JEvv6y0C/XfuoqX1+Zuatc+644YET7+6lmvib1mriTKyetj9b7tXvMI7MTUuXS/ZDfDqpLl/rwzOp9IZqv12nqbotArruFWj4bt4mvbMYMRS4lrmqcnxdPqDqr/Itmc7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505583; c=relaxed/simple;
	bh=XvuephzyA+wIrtZ091P8/wi2YxhOCdYuDybigxV0/6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Irh5Otbg34oPWF+MPu9Sbb09g+KYqCiLuNTte8cSubWy+nUGmbS4Q6sXv/PQBayUF9bLyfJ+EAE8Su4MheT5CVjfJONwfYNEe5kYLT2qIN7doNpy7ywuTnjKOhRCK2O4VXyyIT5iett+zObcFEXhj6wqXaLpJXqDR42/gUF/+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npuQTTT1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npuQTTT1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3659052a91.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505574; x=1788110374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoSLaw36gJkt9yb8oGsbj55XASWyAeZ92BSGO26M1f8=;
        b=npuQTTT1oeNnU437v00vv+gWlZpsfHu2Agx9Zrskd+IyAkbp1f8Q+613iZjwLFPh+B
         +mcKrV/fufO32jAo2WcjvmenEPZzzFiwnN3rC3Xh7/0QNWc0jNO3UqVuNNwPurDXunbM
         Zjf/bnxaQQ4aA1Lm6k8H9WPLC6smzyQCKCVsRQnao0WZ4NuGZe4uT91WC5Jm35ahiF/V
         nIDwGKAoX5DQtnbfvQteFeW8/+CA8joHl8/N+KiwJ1AVmfoWHF9BS47XvcCdc4+dQzVb
         O6x/a5Lp5UoihlsSEiF05Fd9El8wnU3s6HXYfN8pnD7oVhqlvFsKS55WJVNk8NBR16vr
         q89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505574; x=1788110374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eoSLaw36gJkt9yb8oGsbj55XASWyAeZ92BSGO26M1f8=;
        b=miFMi0Q7g1QVNFq6enmW1jjb3QN+gJ4onK+h6H4YodJv9VCVva/HV6LDhfAvBcmHJo
         zd3XeQ7ApSGafhTfdSW5uluAAXGNB37ZO6OlgEgWUSyTCFCOwoA3FeOd+5/vIXye0tiI
         hiGmOKpK8Gc3FpmHXgu0pIiCWI8SnC8FJYTp2J/dzmND+9WtGcS2eZdm7M3gLTlShqAX
         o/FkitblZkjPmbnCZgrkWreQqdGcE4BJvoofNXlpCMeNSiEs83cDgmjGB0yvJiHfrhRw
         PAUDYFw07/15oKbLrCpLk4nLiJXTSxDgVQH+UelvIAIUgAylTIEHjo/ZJFwVP7ZUFGYv
         VsTg==
X-Gm-Message-State: AFuF++k8UdE6BcaPa0877+JExdjEMzYiaywzrSw8OUQvbPlkY+Eta7bI
	gYSvYqk7QoKL9ntJSwhJpBJOHXBJd/ydf/mmu4PPgz9aD0tO2G/DZjnz8MHEiQ==
X-Gm-Gg: AR+sD13bOnWvxgeIVyWdej6A1iUtoXf+szj3xCoupKPKwc5+x8QviWPXUINtLG/LvkM
	2yFt1KnYZ26ATl1rf+MXIehRSkAfsqgEEY63MK6mTRihEWiUhrF6X6H2vUOOz8AQEt95Ifvhuxu
	z+9QGTtjIhikfxHZwTEtPL9Xk2v38qtZBbcOPMroU6Pjc2Tp7weUlu+oNUOIiMrOFReR9/zWjCY
	ike2k6rWRhg884hQqkG3AmANHn6zmGRtEgm2VSr05kIuzRWVZkXjzXkaVKeg+HE1gyNtu5KP97Z
	8WbAudcSaGyOxYAKO6ShkvRHZifQmpyHZvX93+IzK3FHViQhHoqVIW/ULELM+sUUlhjZXVcGW+3
	mLpOSSWrY7gZ9aKYBkyiGbmj+C92p7TTAVV1BcmWlJL21OZtif1Ul+1NOsM+IKFtekJcKBbS9u3
	Mx2CsP9+eWfDuAyecAqDp9Dz6laaeysR3vbz32fU4gXd1/kdb55vTwtrzZuiK84A6CcbvrjICNv
	GpmvuIYqwUcichiDEvH/yS8cCwYZoKAOqrq4scY+DpMqoICryihVLw0uzvrj4UDAkfO1fIa9nk2
	kn+X191gDaH3kOGuUZkGjQ7WTQOsr/gHqfU74D0kGmXuCA==
X-Received: by 2002:a17:90b:1c03:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-395c3a017d9mr33712918a91.12.1787505572900;
        Sun, 23 Aug 2026 10:19:32 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm16582033c88.11.2026.08.23.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:31 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 09/14] pack: gather the pack sources under pack/
Date: Sun, 23 Aug 2026 10:18:53 -0700
Message-ID: <20260823171915.2662373-10-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the 27 pack C sources and 18 headers into pack/ as renames. Repoint
every reference to their old paths to the new ones: the #include lines
across the tree, the Makefile and meson.build build entries.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                                  | 90 +++++++++----------
 Makefile                                      | 56 ++++++------
 apply.c                                       |  2 +-
 blame.c                                       |  4 +-
 builtin/backfill.c                            |  2 +-
 builtin/cat-file.c                            |  2 +-
 builtin/clone.c                               |  2 +-
 builtin/commit-graph.c                        |  2 +-
 builtin/commit.c                              |  2 +-
 builtin/count-objects.c                       |  2 +-
 builtin/fast-import.c                         |  6 +-
 builtin/fetch.c                               |  2 +-
 builtin/fsck.c                                |  8 +-
 builtin/gc.c                                  |  4 +-
 builtin/index-pack.c                          |  8 +-
 builtin/last-modified.c                       |  4 +-
 builtin/merge.c                               |  2 +-
 builtin/multi-pack-index.c                    |  2 +-
 builtin/name-rev.c                            |  2 +-
 builtin/pack-objects.c                        | 20 ++---
 builtin/pack-redundant.c                      |  2 +-
 builtin/prune-packed.c                        |  2 +-
 builtin/prune.c                               |  4 +-
 builtin/receive-pack.c                        |  6 +-
 builtin/reflog.c                              |  2 +-
 builtin/repack.c                              | 10 +--
 builtin/rev-list.c                            |  4 +-
 builtin/show-index.c                          |  2 +-
 builtin/unpack-objects.c                      |  6 +-
 builtin/update-server-info.c                  |  2 +-
 commit-reach.c                                |  2 +-
 connected.c                                   |  2 +-
 diagnose.c                                    |  2 +-
 diff.c                                        |  4 +-
 fetch-pack.c                                  |  6 +-
 http-backend.c                                |  2 +-
 http-push.c                                   |  2 +-
 http-walker.c                                 |  2 +-
 http.c                                        |  4 +-
 line-log.c                                    |  2 +-
 list-objects.c                                |  2 +-
 meson.build                                   | 54 +++++------
 odb/commit.c                                  |  2 +-
 odb/fsck.c                                    |  2 +-
 odb/object-file.c                             |  4 +-
 odb/object-name.c                             |  2 +-
 odb/object.c                                  |  2 +-
 odb/odb.c                                     |  6 +-
 odb/source-files.c                            |  6 +-
 odb/source-packed.c                           |  6 +-
 odb/source-packed.h                           |  2 +-
 odb/source.c                                  |  2 +-
 odb/tag.c                                     |  2 +-
 oss-fuzz/fuzz-commit-graph.c                  |  2 +-
 oss-fuzz/fuzz-pack-headers.c                  |  2 +-
 oss-fuzz/fuzz-pack-idx.c                      |  2 +-
 bloom.c => pack/bloom.c                       |  4 +-
 bloom.h => pack/bloom.h                       |  0
 chunk-format.c => pack/chunk-format.c         |  2 +-
 chunk-format.h => pack/chunk-format.h         |  0
 commit-graph.c => pack/commit-graph.c         |  8 +-
 commit-graph.h => pack/commit-graph.h         |  0
 delta-islands.c => pack/delta-islands.c       |  8 +-
 delta-islands.h => pack/delta-islands.h       |  0
 delta.h => pack/delta.h                       |  0
 diff-delta.c => pack/diff-delta.c             |  2 +-
 midx-write.c => pack/midx-write.c             | 10 +--
 midx.c => pack/midx.c                         | 10 +--
 midx.h => pack/midx.h                         |  0
 .../pack-bitmap-write.c                       | 12 +--
 pack-bitmap.c => pack/pack-bitmap.c           | 14 +--
 pack-bitmap.h => pack/pack-bitmap.h           |  4 +-
 pack-check.c => pack/pack-check.c             |  4 +-
 pack-mtimes.c => pack/pack-mtimes.c           |  4 +-
 pack-mtimes.h => pack/pack-mtimes.h           |  0
 pack-objects.c => pack/pack-objects.c         |  6 +-
 pack-objects.h => pack/pack-objects.h         |  4 +-
 pack-revindex.c => pack/pack-revindex.c       |  6 +-
 pack-revindex.h => pack/pack-revindex.h       |  0
 pack-write.c => pack/pack-write.c             | 10 +--
 pack.h => pack/pack.h                         |  0
 packfile-list.c => pack/packfile-list.c       |  4 +-
 packfile-list.h => pack/packfile-list.h       |  0
 packfile.c => pack/packfile.c                 | 14 +--
 packfile.h => pack/packfile.h                 |  2 +-
 patch-delta.c => pack/patch-delta.c           |  2 +-
 prune-packed.c => pack/prune-packed.c         |  4 +-
 prune-packed.h => pack/prune-packed.h         |  0
 pseudo-merge.c => pack/pseudo-merge.c         |  4 +-
 pseudo-merge.h => pack/pseudo-merge.h         |  0
 reachable.c => pack/reachable.c               |  8 +-
 reachable.h => pack/reachable.h               |  0
 repack-cruft.c => pack/repack-cruft.c         |  4 +-
 repack-filtered.c => pack/repack-filtered.c   |  2 +-
 repack-geometry.c => pack/repack-geometry.c   |  6 +-
 repack-midx.c => pack/repack-midx.c           |  6 +-
 repack-promisor.c => pack/repack-promisor.c   |  6 +-
 repack.c => pack/repack.c                     |  6 +-
 repack.h => pack/repack.h                     |  0
 server-info.c => pack/server-info.c           |  4 +-
 server-info.h => pack/server-info.h           |  0
 path.c                                        |  2 +-
 promisor-remote.c                             |  2 +-
 repo-settings.c                               |  4 +-
 revision.c                                    |  6 +-
 run-command.c                                 |  2 +-
 scalar.c                                      |  2 +-
 t/helper/test-bitmap.c                        |  4 +-
 t/helper/test-bloom.c                         |  2 +-
 t/helper/test-delta.c                         |  2 +-
 t/helper/test-find-pack.c                     |  2 +-
 t/helper/test-name-hash.c                     |  2 +-
 t/helper/test-pack-deltas.c                   |  6 +-
 t/helper/test-pack-mtimes.c                   |  4 +-
 t/helper/test-read-graph.c                    |  4 +-
 t/helper/test-read-midx.c                     |  8 +-
 t/helper/test-repository.c                    |  2 +-
 t/helper/test-synthesize.c                    |  2 +-
 transport-helper.c                            |  2 +-
 upload-pack.c                                 |  2 +-
 120 files changed, 314 insertions(+), 314 deletions(-)
 rename bloom.c => pack/bloom.c (99%)
 rename bloom.h => pack/bloom.h (100%)
 rename chunk-format.c => pack/chunk-format.c (99%)
 rename chunk-format.h => pack/chunk-format.h (100%)
 rename commit-graph.c => pack/commit-graph.c (99%)
 rename commit-graph.h => pack/commit-graph.h (100%)
 rename delta-islands.c => pack/delta-islands.c (99%)
 rename delta-islands.h => pack/delta-islands.h (100%)
 rename delta.h => pack/delta.h (100%)
 rename diff-delta.c => pack/diff-delta.c (99%)
 rename midx-write.c => pack/midx-write.c (99%)
 rename midx.c => pack/midx.c (99%)
 rename midx.h => pack/midx.h (100%)
 rename pack-bitmap-write.c => pack/pack-bitmap-write.c (99%)
 rename pack-bitmap.c => pack/pack-bitmap.c (99%)
 rename pack-bitmap.h => pack/pack-bitmap.h (99%)
 rename pack-check.c => pack/pack-check.c (99%)
 rename pack-mtimes.c => pack/pack-mtimes.c (98%)
 rename pack-mtimes.h => pack/pack-mtimes.h (100%)
 rename pack-objects.c => pack/pack-objects.c (98%)
 rename pack-objects.h => pack/pack-objects.h (99%)
 rename pack-revindex.c => pack/pack-revindex.c (99%)
 rename pack-revindex.h => pack/pack-revindex.h (100%)
 rename pack-write.c => pack/pack-write.c (99%)
 rename pack.h => pack/pack.h (100%)
 rename packfile-list.c => pack/packfile-list.c (96%)
 rename packfile-list.h => pack/packfile-list.h (100%)
 rename packfile.c => pack/packfile.c (99%)
 rename packfile.h => pack/packfile.h (99%)
 rename patch-delta.c => pack/patch-delta.c (98%)
 rename prune-packed.c => pack/prune-packed.c (94%)
 rename prune-packed.h => pack/prune-packed.h (100%)
 rename pseudo-merge.c => pack/pseudo-merge.c (99%)
 rename pseudo-merge.h => pack/pseudo-merge.h (100%)
 rename reachable.c => pack/reachable.c (98%)
 rename reachable.h => pack/reachable.h (100%)
 rename repack-cruft.c => pack/repack-cruft.c (98%)
 rename repack-filtered.c => pack/repack-filtered.c (98%)
 rename repack-geometry.c => pack/repack-geometry.c (99%)
 rename repack-midx.c => pack/repack-midx.c (99%)
 rename repack-promisor.c => pack/repack-promisor.c (98%)
 rename repack.c => pack/repack.c (99%)
 rename repack.h => pack/repack.h (100%)
 rename server-info.c => pack/server-info.c (99%)
 rename server-info.h => pack/server-info.h (100%)

diff --git a/.gitorganize b/.gitorganize
index e29497504a..533d50ed89 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -45,8 +45,6 @@ bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,set
 bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
 blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
 blame.h component=revision role=header prefix=blame includes=diff:1,odb:1 cochange=revision:19,odb:7,diff:4,archive:1,index:1
-bloom.c component=pack role=lib prefix=bloom includes=odb:4,diff:2,pack:2,setup:2 cochange=pack:38,revision:25,diff:15,odb:6,index:2
-bloom.h component=pack role=header prefix=bloom cochange=pack:28,revision:12,odb:1
 branch.c component=? role=lib prefix=branch includes=refs:3,setup:3,odb:2,submodule:1,transport:1 cochange=refs:62,transport:41,setup:28,index:19,revision:12
 branch.h component=? role=public prefix=branch cochange=setup:8,refs:4,submodule:4
 builtin.h component=? role=public prefix=builtin includes=setup:1 cochange=diff:15,index:15,transport:12,odb:6,notes:5
@@ -60,15 +58,11 @@ chdir-notify.c component=? role=lib prefix=chdir-notify includes=revision:1 coch
 chdir-notify.h component=? role=public prefix=chdir-notify
 checkout.c component=index role=lib prefix=checkout includes=setup:2,index:1,odb:1,refs:1,transport:1 cochange=transport:16,refs:6,setup:5,index:3,odb:2
 checkout.h component=index role=header prefix=checkout includes=odb:1 cochange=index:4,diff:1,odb:1,refs:1,revision:1
-chunk-format.c component=pack role=lib prefix=chunk-format includes=odb:1,pack:1 cochange=pack:20,odb:1,transport:1
-chunk-format.h component=pack role=header prefix=chunk-format includes=odb:1 cochange=pack:15,odb:2,setup:1,transport:1
 color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,index:14,revision:13,setup:7,transport:7
 color.h component=? role=public prefix=color cochange=diff:18,index:12,revision:12,transport:2,odb:1
 column.c component=? role=lib prefix=column includes=setup:1 cochange=transport:6,setup:5,diff:4,revision:3,index:2
 column.h component=? role=public prefix=column
 combine-diff.c component=diff role=lib prefix=combine-diff includes=odb:5,diff:4,revision:2,convert:1,refs:1 cochange=diff:198,revision:67,index:35,odb:16,transport:16
-commit-graph.c component=pack role=lib prefix=commit-graph includes=odb:9,pack:4,setup:2,refs:1,revision:1 cochange=pack:206,odb:125,revision:47,transport:34,setup:22
-commit-graph.h component=pack role=header prefix=commit-graph includes=odb:2 cochange=pack:92,odb:14,setup:9,revision:8,transport:5
 commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
 commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
 common-exit.c component=? role=lib prefix=common-main
@@ -95,12 +89,8 @@ date.c component=? role=lib prefix=date cochange=revision:17,odb:16,refs:14,setu
 date.h component=? role=public prefix=date cochange=refs:7,revision:4,setup:2,archive:1,odb:1
 decorate.c component=revision role=lib prefix=decorate includes=odb:1,revision:1 cochange=diff:6,odb:5,revision:5,pack:2,transport:2
 decorate.h component=revision role=header prefix=decorate cochange=revision:4,odb:1
-delta-islands.c component=pack role=lib prefix=delta-islands includes=odb:6,pack:4,diff:1,refs:1,setup:1 cochange=pack:20,odb:17,revision:7,transport:7,diff:5
-delta-islands.h component=pack role=header prefix=delta-islands cochange=pack:6
-delta.h component=pack role=header prefix=diff-delta cochange=pack:27,odb:19,diff:5,transport:3,convert:1
 diagnose.c component=? role=lib prefix=diagnose includes=archive:1,index:1,odb:1,pack:1,setup:1 cochange=index:4,revision:4,odb:3,pack:3,transport:3
 diagnose.h component=? role=public prefix=diagnose cochange=revision:2,refs:1,transport:1
-diff-delta.c component=pack role=lib prefix=diff-delta includes=pack:1 cochange=pack:24,diff:7,index:2,odb:2,transport:2
 diff-lib.c component=diff role=lib prefix=diff includes=index:6,odb:3,diff:2,revision:2,refs:1 cochange=diff:150,index:124,revision:47,submodule:18,odb:8
 diff-merges.c component=diff role=lib prefix=diff-merges includes=diff:1,revision:1 cochange=revision:18,diff:17,odb:4,refs:3,index:2
 diff-merges.h component=diff role=header prefix=diff-merges cochange=diff:11,revision:4,merge:1
@@ -218,9 +208,6 @@ merge-ort.h component=merge role=header prefix=merge-ort includes=odb:1 cochange
 merge.c component=merge role=lib prefix=merge includes=odb:4,index:2,merge:1,setup:1 cochange=index:22,merge:6,setup:4,diff:2,odb:2
 merge.h component=merge role=header prefix=merge cochange=merge:1
 mergesort.h component=? role=public prefix=mergesort cochange=odb:1
-midx-write.c component=pack role=lib prefix=midx-write includes=pack:5,odb:2,revision:2,refs:1,setup:1 cochange=pack:100,odb:20,refs:7,transport:6,setup:4
-midx.c component=pack role=lib prefix=midx includes=pack:5,index:1,odb:1,setup:1 cochange=pack:220,odb:34,transport:11,index:6,setup:4
-midx.h component=pack role=header prefix=midx cochange=pack:134,odb:5,setup:2,transport:2,refs:1
 name-hash.c component=index role=lib prefix=name-hash includes=index:3,odb:1,setup:1 cochange=diff:43,index:39,revision:18,setup:14,refs:12
 name-hash.h component=index role=header prefix=name-hash cochange=index:7
 notes-cache.c component=notes role=lib prefix=notes includes=odb:3,notes:1,refs:1,revision:1,setup:1 cochange=notes:37,odb:29,diff:10,index:10,revision:9
@@ -280,22 +267,51 @@ odb/tree-walk.c component=odb role=lib prefix=tree-walk includes=odb:4,index:3,s
 odb/tree-walk.h component=odb role=header prefix=tree-walk includes=odb:1 cochange=odb:64,diff:23,index:23,revision:21,notes:7
 odb/tree.c component=odb role=lib prefix=tree includes=odb:6,setup:2 cochange=odb:212,revision:45,index:36,pack:25,transport:21
 odb/tree.h component=odb role=header prefix=tree includes=odb:1 cochange=odb:75,revision:12,archive:8,index:6,pack:5
-pack-bitmap-write.c component=pack role=lib prefix=pack-bitmap-write includes=odb:7,pack:6,revision:2,setup:2,diff:1 cochange=pack:132,odb:32,revision:27,transport:10,diff:4
-pack-bitmap.c component=pack role=lib prefix=pack-bitmap includes=pack:7,odb:3,revision:3,setup:2,diff:1 cochange=pack:232,revision:30,odb:18,transport:14,refs:7
-pack-bitmap.h component=pack role=header prefix=pack-bitmap includes=pack:2,refs:1 cochange=pack:117,refs:5,odb:2,setup:2,revision:1
-pack-check.c component=pack role=lib prefix=pack-check includes=odb:2,pack:2,setup:2 cochange=pack:59,odb:26,transport:23,diff:11,index:10
-pack-mtimes.c component=pack role=lib prefix=pack-mtimes includes=pack:2,odb:1 cochange=pack:10,odb:3,transport:2,notes:1
-pack-mtimes.h component=pack role=header prefix=pack-mtimes cochange=pack:4,odb:2,setup:1,transport:1
-pack-objects.c component=pack role=lib prefix=pack-objects includes=pack:3,odb:1,setup:1 cochange=pack:66,diff:17,odb:16,transport:9,index:5
-pack-objects.h component=pack role=header prefix=pack-objects includes=pack:2,odb:1 cochange=pack:44,setup:5,odb:1
-pack-revindex.c component=pack role=lib prefix=pack-revindex includes=pack:3,odb:1,setup:1 cochange=pack:94,odb:7,index:6,transport:5,setup:4
-pack-revindex.h component=pack role=header prefix=pack-revindex cochange=pack:32,odb:1
-pack-write.c component=pack role=lib prefix=pack-write includes=pack:5,setup:2,odb:1,transport:1 cochange=pack:88,odb:21,transport:21,setup:14,index:10
-pack.h component=pack role=header prefix=pack-write includes=odb:1 cochange=pack:72,odb:13,transport:9,setup:5,revision:1
-packfile-list.c component=pack role=lib prefix=packfile includes=pack:2 cochange=pack:3
-packfile-list.h component=pack role=header prefix=packfile cochange=pack:3
-packfile.c component=pack role=lib prefix=packfile includes=odb:8,pack:7,setup:2,index:1,revision:1 cochange=pack:317,odb:134,transport:52,revision:36,index:27
-packfile.h component=pack role=header prefix=packfile includes=odb:3,pack:1,revision:1,setup:1 cochange=pack:234,odb:66,transport:32,revision:9,setup:7
+pack/bloom.c component=pack role=lib prefix=bloom includes=odb:4,diff:2,pack:2,setup:2 cochange=pack:38,revision:25,diff:15,odb:6,index:2
+pack/bloom.h component=pack role=header prefix=bloom cochange=pack:28,revision:12,odb:1
+pack/chunk-format.c component=pack role=lib prefix=chunk-format includes=odb:1,pack:1 cochange=pack:20,odb:1,transport:1
+pack/chunk-format.h component=pack role=header prefix=chunk-format includes=odb:1 cochange=pack:15,odb:2,setup:1,transport:1
+pack/commit-graph.c component=pack role=lib prefix=commit-graph includes=odb:9,pack:4,setup:2,refs:1,revision:1 cochange=pack:206,odb:125,revision:47,transport:34,setup:22
+pack/commit-graph.h component=pack role=header prefix=commit-graph includes=odb:2 cochange=pack:92,odb:14,setup:9,revision:8,transport:5
+pack/delta-islands.c component=pack role=lib prefix=delta-islands includes=odb:6,pack:4,diff:1,refs:1,setup:1 cochange=pack:20,odb:17,revision:7,transport:7,diff:5
+pack/delta-islands.h component=pack role=header prefix=delta-islands cochange=pack:6
+pack/delta.h component=pack role=header prefix=diff-delta cochange=pack:27,odb:19,diff:5,transport:3,convert:1
+pack/diff-delta.c component=pack role=lib prefix=diff-delta includes=pack:1 cochange=pack:24,diff:7,index:2,odb:2,transport:2
+pack/midx-write.c component=pack role=lib prefix=midx-write includes=pack:5,odb:2,revision:2,refs:1,setup:1 cochange=pack:100,odb:20,refs:7,transport:6,setup:4
+pack/midx.c component=pack role=lib prefix=midx includes=pack:5,index:1,odb:1,setup:1 cochange=pack:220,odb:34,transport:11,index:6,setup:4
+pack/midx.h component=pack role=header prefix=midx cochange=pack:134,odb:5,setup:2,transport:2,refs:1
+pack/pack-bitmap-write.c component=pack role=lib prefix=pack-bitmap-write includes=odb:7,pack:6,revision:2,setup:2,diff:1 cochange=pack:132,odb:32,revision:27,transport:10,diff:4
+pack/pack-bitmap.c component=pack role=lib prefix=pack-bitmap includes=pack:7,odb:3,revision:3,setup:2,diff:1 cochange=pack:232,revision:30,odb:18,transport:14,refs:7
+pack/pack-bitmap.h component=pack role=header prefix=pack-bitmap includes=pack:2,refs:1 cochange=pack:117,refs:5,odb:2,setup:2,revision:1
+pack/pack-check.c component=pack role=lib prefix=pack-check includes=odb:2,pack:2,setup:2 cochange=pack:59,odb:26,transport:23,diff:11,index:10
+pack/pack-mtimes.c component=pack role=lib prefix=pack-mtimes includes=pack:2,odb:1 cochange=pack:10,odb:3,transport:2,notes:1
+pack/pack-mtimes.h component=pack role=header prefix=pack-mtimes cochange=pack:4,odb:2,setup:1,transport:1
+pack/pack-objects.c component=pack role=lib prefix=pack-objects includes=pack:3,odb:1,setup:1 cochange=pack:66,diff:17,odb:16,transport:9,index:5
+pack/pack-objects.h component=pack role=header prefix=pack-objects includes=pack:2,odb:1 cochange=pack:44,setup:5,odb:1
+pack/pack-revindex.c component=pack role=lib prefix=pack-revindex includes=pack:3,odb:1,setup:1 cochange=pack:94,odb:7,index:6,transport:5,setup:4
+pack/pack-revindex.h component=pack role=header prefix=pack-revindex cochange=pack:32,odb:1
+pack/pack-write.c component=pack role=lib prefix=pack-write includes=pack:5,setup:2,odb:1,transport:1 cochange=pack:88,odb:21,transport:21,setup:14,index:10
+pack/pack.h component=pack role=header prefix=pack-write includes=odb:1 cochange=pack:72,odb:13,transport:9,setup:5,revision:1
+pack/packfile-list.c component=pack role=lib prefix=packfile includes=pack:2 cochange=pack:3
+pack/packfile-list.h component=pack role=header prefix=packfile cochange=pack:3
+pack/packfile.c component=pack role=lib prefix=packfile includes=odb:8,pack:7,setup:2,index:1,revision:1 cochange=pack:317,odb:134,transport:52,revision:36,index:27
+pack/packfile.h component=pack role=header prefix=packfile includes=odb:3,pack:1,revision:1,setup:1 cochange=pack:234,odb:66,transport:32,revision:9,setup:7
+pack/patch-delta.c component=pack role=lib prefix=patch-delta includes=pack:1 cochange=pack:23,diff:2,odb:2,transport:2,convert:1
+pack/prune-packed.c component=pack role=lib prefix=environment includes=pack:2,odb:1,setup:1 cochange=pack:13,odb:7,setup:5,diff:3,revision:3
+pack/prune-packed.h component=pack role=header prefix=? cochange=pack:1
+pack/pseudo-merge.c component=pack role=lib prefix=pseudo-merge includes=odb:3,pack:2,refs:1,setup:1 cochange=pack:21,refs:3
+pack/pseudo-merge.h component=pack role=header prefix=pseudo-merge cochange=pack:17
+pack/reachable.c component=pack role=lib prefix=reachable includes=pack:4,odb:3,refs:2,revision:2,diff:1 cochange=odb:60,pack:57,revision:47,transport:17,refs:14
+pack/reachable.h component=pack role=header prefix=prune cochange=pack:5
+pack/repack-cruft.c component=pack role=lib prefix=repack includes=pack:2,setup:1 cochange=pack:8,transport:2,odb:1
+pack/repack-filtered.c component=pack role=lib prefix=repack includes=pack:1,setup:1 cochange=pack:1
+pack/repack-geometry.c component=pack role=lib prefix=repack includes=pack:3,setup:1 cochange=pack:25,transport:2,odb:1
+pack/repack-midx.c component=pack role=lib prefix=repack includes=odb:3,pack:3,refs:1 cochange=pack:23,refs:3,setup:2,merge:1,odb:1
+pack/repack-promisor.c component=pack role=lib prefix=repack-promisor includes=pack:3,setup:1 cochange=pack:8,odb:3,revision:2
+pack/repack.c component=pack role=lib prefix=repack includes=pack:3,index:1,odb:1,setup:1 cochange=pack:31,transport:2,odb:1
+pack/repack.h component=pack role=header prefix=repack includes=revision:1 cochange=pack:28
+pack/server-info.c component=pack role=lib prefix=server-info includes=odb:5,pack:2,index:1,refs:1,setup:1 cochange=pack:40,transport:34,odb:33,setup:13,refs:10
+pack/server-info.h component=pack role=header prefix=server-info cochange=pack:2
 pager.c component=? role=lib prefix=pager includes=setup:4 cochange=setup:23,diff:9,transport:7,revision:3,submodule:3
 pager.h component=? role=public prefix=pager cochange=diff:3,setup:2,revision:1
 parallel-checkout.c component=index role=lib prefix=parallel-checkout includes=index:4,odb:1,setup:1,transport:1 cochange=index:26,transport:7,odb:6,diff:3,merge:3
@@ -305,7 +321,6 @@ parse-options.c component=? role=lib prefix=parse-options cochange=index:14,diff
 parse-options.h component=? role=public prefix=parse-options cochange=diff:7,merge:4,archive:3,index:3,refs:3
 parse.c component=? role=lib prefix=parse cochange=setup:6,index:3,pack:2,convert:1
 parse.h component=? role=public prefix=config cochange=setup:6,index:3,pack:2,convert:1
-patch-delta.c component=pack role=lib prefix=patch-delta includes=pack:1 cochange=pack:23,diff:2,odb:2,transport:2,convert:1
 patch-ids.c component=diff role=lib prefix=patch-ids includes=diff:2,odb:2 cochange=diff:73,revision:34,index:14,odb:13,refs:12
 patch-ids.h component=diff role=header prefix=patch-ids includes=diff:1 cochange=diff:15,revision:3,index:1
 path-walk.c component=? role=lib prefix=path-walk includes=odb:9,revision:3,index:1,setup:1 cochange=index:2,revision:2,transport:2,odb:1,pack:1
@@ -332,16 +347,10 @@ protocol-caps.c component=transport role=lib prefix=protocol-caps includes=odb:3
 protocol-caps.h component=transport role=header prefix=protocol-caps cochange=transport:6,refs:2
 protocol.c component=transport role=lib prefix=protocol includes=setup:2,transport:1 cochange=transport:21,index:4,setup:4,refs:2,diff:1
 protocol.h component=transport role=header prefix=protocol cochange=transport:5
-prune-packed.c component=pack role=lib prefix=environment includes=pack:2,odb:1,setup:1 cochange=pack:13,odb:7,setup:5,diff:3,revision:3
-prune-packed.h component=pack role=header prefix=? cochange=pack:1
-pseudo-merge.c component=pack role=lib prefix=pseudo-merge includes=odb:3,pack:2,refs:1,setup:1 cochange=pack:21,refs:3
-pseudo-merge.h component=pack role=header prefix=pseudo-merge cochange=pack:17
 quote.c component=? role=lib prefix=quote cochange=index:15,diff:12,transport:7,odb:6,revision:6
 quote.h component=? role=public prefix=quote cochange=diff:8,transport:6,index:5,odb:5,refs:5
 range-diff.c component=diff role=lib prefix=range-diff includes=diff:4,odb:2,revision:2,setup:2 cochange=diff:49,revision:26,index:9,submodule:8,setup:7
 range-diff.h component=diff role=header prefix=range-diff includes=diff:1 cochange=diff:13,revision:4
-reachable.c component=pack role=lib prefix=reachable includes=pack:4,odb:3,refs:2,revision:2,diff:1 cochange=odb:60,pack:57,revision:47,transport:17,refs:14
-reachable.h component=pack role=header prefix=prune cochange=pack:5
 read-cache-ll.h component=index role=header prefix=read-cache includes=index:1,odb:1 cochange=index:8,diff:1,odb:1,revision:1
 read-cache.c component=index role=lib prefix=read-cache includes=index:10,odb:6,setup:4,diff:2,submodule:2 cochange=index:240,odb:81,setup:79,diff:67,pack:46
 read-cache.h component=index role=header prefix=read-cache includes=index:2,odb:1,setup:1 cochange=index:4,setup:4,diff:2
@@ -368,13 +377,6 @@ refs/worktree.h component=refs role=header prefix=worktree includes=refs:1 cocha
 remote-curl.c component=transport role=lib prefix=remote-curl includes=transport:9,setup:3,odb:1 cochange=transport:226,diff:9,revision:6,setup:5,archive:4
 remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,transport:3,refs:2,revision:2 cochange=transport:272,refs:91,revision:56,index:51,odb:30
 remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
-repack-cruft.c component=pack role=lib prefix=repack includes=pack:2,setup:1 cochange=pack:8,transport:2,odb:1
-repack-filtered.c component=pack role=lib prefix=repack includes=pack:1,setup:1 cochange=pack:1
-repack-geometry.c component=pack role=lib prefix=repack includes=pack:3,setup:1 cochange=pack:25,transport:2,odb:1
-repack-midx.c component=pack role=lib prefix=repack includes=odb:3,pack:3,refs:1 cochange=pack:23,refs:3,setup:2,merge:1,odb:1
-repack-promisor.c component=pack role=lib prefix=repack-promisor includes=pack:3,setup:1 cochange=pack:8,odb:3,revision:2
-repack.c component=pack role=lib prefix=repack includes=pack:3,index:1,odb:1,setup:1 cochange=pack:31,transport:2,odb:1
-repack.h component=pack role=header prefix=repack includes=revision:1 cochange=pack:28
 replay.c component=? role=lib prefix=replay includes=odb:2,merge:1,refs:1,revision:1,setup:1 cochange=transport:1
 replay.h component=? role=public prefix=replay includes=odb:1
 repo-settings.c component=setup role=lib prefix=repo-settings includes=setup:4,pack:2 cochange=setup:65,pack:17,index:8,transport:8,odb:6
@@ -399,8 +401,6 @@ sequencer.c component=? role=lib prefix=sequencer includes=odb:8,index:5,merge:4
 sequencer.h component=? role=public prefix=sequencer includes=index:1 cochange=revision:5,index:4,notes:3,odb:3,transport:3
 serve.c component=transport role=lib prefix=serve includes=transport:6,setup:3,odb:1,refs:1 cochange=transport:53,refs:7,odb:4,setup:3,index:1
 serve.h component=transport role=header prefix=serve cochange=transport:9,refs:3,submodule:1
-server-info.c component=pack role=lib prefix=server-info includes=odb:5,pack:2,index:1,refs:1,setup:1 cochange=pack:40,transport:34,odb:33,setup:13,refs:10
-server-info.h component=pack role=header prefix=server-info cochange=pack:2
 setup.c component=setup role=lib prefix=setup includes=setup:4,odb:2,refs:2,index:1,revision:1 cochange=setup:177,refs:47,transport:44,index:39,odb:24
 setup.h component=setup role=header prefix=setup includes=refs:1 cochange=setup:70,refs:8,index:5,revision:4,submodule:4
 sh-i18n--envsubst.c component=? role=program prefix=sh-i18n--envsubst cochange=index:3,diff:1,transport:1
diff --git a/Makefile b/Makefile
index f733ccfee0..85d2a620a7 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,7 +1113,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += odb/blob.o
-LIB_OBJS += bloom.o
+LIB_OBJS += pack/bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
@@ -1121,11 +1121,11 @@ LIB_OBJS += cache-tree.o
 LIB_OBJS += odb/cbtree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
-LIB_OBJS += chunk-format.o
+LIB_OBJS += pack/chunk-format.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
-LIB_OBJS += commit-graph.o
+LIB_OBJS += pack/commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += odb/commit.o
 LIB_OBJS += common-exit.o
@@ -1145,9 +1145,9 @@ LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
-LIB_OBJS += delta-islands.o
+LIB_OBJS += pack/delta-islands.o
 LIB_OBJS += diagnose.o
-LIB_OBJS += diff-delta.o
+LIB_OBJS += pack/diff-delta.o
 LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
@@ -1211,8 +1211,8 @@ LIB_OBJS += merge-ll.o
 LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge.o
-LIB_OBJS += midx.o
-LIB_OBJS += midx-write.o
+LIB_OBJS += pack/midx.o
+LIB_OBJS += pack/midx-write.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
@@ -1241,22 +1241,22 @@ LIB_OBJS += organize/gitorganize-format.o
 LIB_OBJS += organize/labeler-protocol.o
 LIB_OBJS += organize/organize.o
 LIB_OBJS += organize/organizer-protocol.o
-LIB_OBJS += pack-bitmap-write.o
-LIB_OBJS += pack-bitmap.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-mtimes.o
-LIB_OBJS += pack-objects.o
+LIB_OBJS += pack/pack-bitmap-write.o
+LIB_OBJS += pack/pack-bitmap.o
+LIB_OBJS += pack/pack-check.o
+LIB_OBJS += pack/pack-mtimes.o
+LIB_OBJS += pack/pack-objects.o
 LIB_OBJS += refs/pack-refs.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += packfile.o
-LIB_OBJS += packfile-list.o
+LIB_OBJS += pack/pack-revindex.o
+LIB_OBJS += pack/pack-write.o
+LIB_OBJS += pack/packfile.o
+LIB_OBJS += pack/packfile-list.o
 LIB_OBJS += pager.o
 LIB_OBJS += parallel-checkout.o
 LIB_OBJS += parse.o
 LIB_OBJS += parse-options-cb.o
 LIB_OBJS += parse-options.o
-LIB_OBJS += patch-delta.o
+LIB_OBJS += pack/patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
 LIB_OBJS += path-walk.o
@@ -1270,11 +1270,11 @@ LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += protocol-caps.o
-LIB_OBJS += prune-packed.o
-LIB_OBJS += pseudo-merge.o
+LIB_OBJS += pack/prune-packed.o
+LIB_OBJS += pack/pseudo-merge.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
-LIB_OBJS += reachable.o
+LIB_OBJS += pack/reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase.o
@@ -1304,12 +1304,12 @@ LIB_OBJS += reftable/table.o
 LIB_OBJS += reftable/tree.o
 LIB_OBJS += reftable/writer.o
 LIB_OBJS += remote.o
-LIB_OBJS += repack.o
-LIB_OBJS += repack-cruft.o
-LIB_OBJS += repack-filtered.o
-LIB_OBJS += repack-geometry.o
-LIB_OBJS += repack-midx.o
-LIB_OBJS += repack-promisor.o
+LIB_OBJS += pack/repack.o
+LIB_OBJS += pack/repack-cruft.o
+LIB_OBJS += pack/repack-filtered.o
+LIB_OBJS += pack/repack-geometry.o
+LIB_OBJS += pack/repack-midx.o
+LIB_OBJS += pack/repack-promisor.o
 LIB_OBJS += odb/replace-object.o
 LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
@@ -1322,7 +1322,7 @@ LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
-LIB_OBJS += server-info.o
+LIB_OBJS += pack/server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
@@ -2992,7 +2992,7 @@ gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
-pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
+pack/pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
 
 ifdef NO_EXPAT
 http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
diff --git a/apply.c b/apply.c
index ba486ab51d..dbfb891b4c 100644
--- a/apply.c
+++ b/apply.c
@@ -15,7 +15,7 @@
 #include "base85.h"
 #include "config.h"
 #include "odb/odb.h"
-#include "delta.h"
+#include "pack/delta.h"
 #include "diff.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/blame.c b/blame.c
index a594dc5f0e..cd18c09a3c 100644
--- a/blame.c
+++ b/blame.c
@@ -21,8 +21,8 @@
 #include "blame.h"
 #include "odb/alloc.h"
 #include "odb/commit-slab.h"
-#include "bloom.h"
-#include "commit-graph.h"
+#include "pack/bloom.h"
+#include "pack/commit-graph.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 3685713205..c42226d3e8 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -22,7 +22,7 @@
 #include "revision.h"
 #include "trace2.h"
 #include "progress.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ccd6b33827..a59aa00cea 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -19,7 +19,7 @@
 #include "parse-options.h"
 #include "userdiff.h"
 #include "odb/oid-array.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 12170ae8f4..7b5274e884 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,7 +40,7 @@
 #include "run-command.h"
 #include "setup.h"
 #include "connected.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "pkt-line.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0758af3b64..2de897402e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "odb/odb.h"
 #include "progress.h"
 #include "odb/replace-object.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index e5a6c0b889..39271d720e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,7 @@
 #include "mailmap.h"
 #include "help.h"
 #include "commit-reach.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "pretty.h"
 #include "trailer.h"
 
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index e256779b1f..45a7a61cd3 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -12,7 +12,7 @@
 #include "path.h"
 #include "parse-options.h"
 #include "quote.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 
 static unsigned long garbage;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 43bc72f05f..3b7d650e24 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -12,8 +12,8 @@
 #include "odb/blob.h"
 #include "odb/tree.h"
 #include "odb/commit.h"
-#include "delta.h"
-#include "pack.h"
+#include "pack/delta.h"
+#include "pack/pack.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "refs/refs.h"
@@ -21,7 +21,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "run-command.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ce46a709a6..b14b96ce5c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,7 +36,7 @@
 #include "commit-reach.h"
 #include "branch.h"
 #include "promisor-remote.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "shallow.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 430cf28bd8..a00ca35703 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -7,12 +7,12 @@
 #include "odb/blob.h"
 #include "odb/tag.h"
 #include "refs/refs.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "cache-tree.h"
 #include "odb/fsck.h"
 #include "parse-options.h"
 #include "progress.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
@@ -24,8 +24,8 @@
 #include "run-command.h"
 #include "sparse-index.h"
 #include "refs/worktree.h"
-#include "pack-revindex.h"
-#include "pack-bitmap.h"
+#include "pack/pack-revindex.h"
+#include "pack/pack-bitmap.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
diff --git a/builtin/gc.c b/builtin/gc.c
index 1a71e6f908..bdf3d43108 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,8 +27,8 @@
 #include "sigchain.h"
 #include "strvec.h"
 #include "odb/commit.h"
-#include "commit-graph.h"
-#include "packfile.h"
+#include "pack/commit-graph.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "path.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index aa0e04eeee..23d7e68020 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -3,11 +3,11 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "delta.h"
+#include "pack/delta.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "csum-file.h"
 #include "odb/blob.h"
 #include "odb/commit.h"
@@ -17,8 +17,8 @@
 #include "odb/fsck.h"
 #include "strbuf.h"
 #include "thread-utils.h"
-#include "packfile.h"
-#include "pack-revindex.h"
+#include "pack/packfile.h"
+#include "pack/pack-revindex.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index e8827b5dc6..83c5d66f36 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "builtin.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "odb/commit-slab.h"
 #include "odb/commit.h"
 #include "config.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 2369c3b6f9..ad0c984d4b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -50,7 +50,7 @@
 #include "branch.h"
 #include "commit-reach.h"
 #include "wt-status.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 10af1beb5c..81401e37d5 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "odb/odb.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 4e0254d70e..f3f4714c1d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -14,7 +14,7 @@
 #include "parse-options.h"
 #include "odb/hash-lookup.h"
 #include "odb/commit-slab.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
 #include "pretty.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69f35a727b..37c379d3d8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -10,38 +10,38 @@
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "delta.h"
-#include "pack.h"
-#include "pack-revindex.h"
+#include "pack/delta.h"
+#include "pack/pack.h"
+#include "pack/pack-revindex.h"
 #include "csum-file.h"
 #include "odb/tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
-#include "pack-objects.h"
+#include "pack/pack-objects.h"
 #include "progress.h"
 #include "refs/refs.h"
 #include "thread-utils.h"
-#include "pack-bitmap.h"
-#include "delta-islands.h"
-#include "reachable.h"
+#include "pack/pack-bitmap.h"
+#include "pack/delta-islands.h"
+#include "pack/reachable.h"
 #include "odb/oid-array.h"
 #include "strvec.h"
 #include "strmap.h"
 #include "list.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/object-file-convert.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/replace-object.h"
 #include "dir.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "trace2.h"
 #include "shallow.h"
 #include "promisor-remote.h"
-#include "pack-mtimes.h"
+#include "pack/pack-mtimes.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "odb/blob.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 10e1ce6ab5..5396e2bc10 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -12,7 +12,7 @@
 #include "gettext.h"
 #include "hex.h"
 
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/odb.h"
 #include "strbuf.h"
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 4d63f26b0a..5d4a72abb4 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,7 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "prune-packed.h"
+#include "pack/prune-packed.h"
 
 static const char * const prune_packed_usage[] = {
 	"git prune-packed [-n | --dry-run] [-q | --quiet]",
diff --git a/builtin/prune.c b/builtin/prune.c
index 301f59e897..ae3505c5e5 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -8,11 +8,11 @@
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
-#include "reachable.h"
+#include "pack/reachable.h"
 #include "parse-options.h"
 #include "path.h"
 #include "progress.h"
-#include "prune-packed.h"
+#include "pack/prune-packed.h"
 #include "odb/replace-object.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 88cbaed133..f01cc1a188 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -22,15 +22,15 @@
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
-#include "pack.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/packfile.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "protocol.h"
 #include "refs/refs.h"
 #include "remote.h"
 #include "run-command.h"
-#include "server-info.h"
+#include "pack/server-info.h"
 #include "setup.h"
 #include "shallow.h"
 #include "sideband.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index fc0b74ed95..d227104063 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "odb/odb.h"
 #include "revision.h"
-#include "reachable.h"
+#include "pack/reachable.h"
 #include "wildmatch.h"
 #include "refs/worktree.h"
 #include "refs/reflog.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index db504d673f..5927a0dfdb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -6,13 +6,13 @@
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
-#include "server-info.h"
+#include "pack/server-info.h"
 #include "string-list.h"
-#include "midx.h"
-#include "packfile.h"
-#include "prune-packed.h"
+#include "pack/midx.h"
+#include "pack/packfile.h"
+#include "pack/prune-packed.h"
 #include "promisor-remote.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "shallow.h"
 
 #define ALL_INTO_ONE 1
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 466a0a515d..d6bddda9d4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -15,7 +15,7 @@
 #include "odb/object-name.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "pack-bitmap.h"
+#include "pack/pack-bitmap.h"
 #include "parse-options.h"
 #include "log-tree.h"
 #include "graph.h"
@@ -24,7 +24,7 @@
 #include "refs/reflog-walk.h"
 #include "odb/oidset.h"
 #include "odb/oidmap.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "commit-reach.h"
 #include "quote.h"
 #include "strbuf.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 55c3c409ae..86dacb1a1e 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "parse-options.h"
 
 static const char *const show_index_usage[] = {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e5891809dd..93caca20ef 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -12,15 +12,15 @@
 #include "odb/streaming.h"
 #include "odb/transaction.h"
 #include "odb/object.h"
-#include "delta.h"
-#include "pack.h"
+#include "pack/delta.h"
+#include "pack/pack.h"
 #include "odb/blob.h"
 #include "odb/replace-object.h"
 #include "strbuf.h"
 #include "progress.h"
 #include "decorate.h"
 #include "odb/fsck.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 4c12968a83..41bbd0114f 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -3,7 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "server-info.h"
+#include "pack/server-info.h"
 
 static const char * const update_server_info_usage[] = {
 	"git update-server-info [-f | --force]",
diff --git a/commit-reach.c b/commit-reach.c
index 9636b5b37f..0b59c9ba29 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "odb/commit.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
diff --git a/connected.c b/connected.c
index 1aafa86101..1884614b80 100644
--- a/connected.c
+++ b/connected.c
@@ -8,7 +8,7 @@
 #include "sigchain.h"
 #include "connected.h"
 #include "transport.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "promisor-remote.h"
 
 static int promised_object_cb(const struct object_id *oid UNUSED,
diff --git a/diagnose.c b/diagnose.c
index 6858f39f45..716dabf05c 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -8,7 +8,7 @@
 #include "hex.h"
 #include "strvec.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "write-or-die.h"
diff --git a/diff.c b/diff.c
index 22265895a7..91addcdab7 100644
--- a/diff.c
+++ b/diff.c
@@ -17,7 +17,7 @@
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "delta.h"
+#include "pack/delta.h"
 #include "hex.h"
 #include "xdiff-interface.h"
 #include "color.h"
@@ -34,7 +34,7 @@
 #include "odb/tmp-objdir.h"
 #include "graph.h"
 #include "odb/oid-array.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "pager.h"
 #include "parse-options.h"
 #include "help.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 434b57e5b0..b19cb3239e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,7 +13,7 @@
 #include "pkt-line.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
 #include "remote.h"
@@ -23,7 +23,7 @@
 #include "version.h"
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/odb.h"
 #include "odb/object-name.h"
 #include "path.h"
@@ -32,7 +32,7 @@
 #include "odb/fsck.h"
 #include "shallow.h"
 #include "commit-reach.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "sigchain.h"
 #include "mergesort.h"
 #include "prio-queue.h"
diff --git a/http-backend.c b/http-backend.c
index 90624c3348..57589cc127 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -18,7 +18,7 @@
 #include "url.h"
 #include "setup.h"
 #include "strvec.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/odb.h"
 #include "protocol.h"
 #include "date.h"
diff --git a/http-push.c b/http-push.c
index 858aa9db33..88a8417ea4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -18,7 +18,7 @@
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
 #include "url.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "commit-reach.h"
diff --git a/http-walker.c b/http-walker.c
index dba84c0ef5..e73c3677d1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -8,7 +8,7 @@
 #include "http.h"
 #include "list.h"
 #include "transport.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 
diff --git a/http.c b/http.c
index 81b58bd8d2..24a6b30ab3 100644
--- a/http.c
+++ b/http.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "http.h"
 #include "config.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "run-command.h"
 #include "url.h"
 #include "urlmatch.h"
@@ -17,7 +17,7 @@
 #include "gettext.h"
 #include "trace.h"
 #include "transport.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "string-list.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
diff --git a/line-log.c b/line-log.c
index 2c9c11e5d3..343159d90a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -16,7 +16,7 @@
 #include "line-log.h"
 #include "setup.h"
 #include "strvec.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "odb/tree-walk.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
diff --git a/list-objects.c b/list-objects.c
index b8a673ed69..1db5ba29b5 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -13,7 +13,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/odb.h"
 #include "trace.h"
 #include "environment.h"
diff --git a/meson.build b/meson.build
index 8dd613a8bb..238beb0dfd 100644
--- a/meson.build
+++ b/meson.build
@@ -322,7 +322,7 @@ libgit_sources = [
   'bisect.c',
   'blame.c',
   'odb/blob.c',
-  'bloom.c',
+  'pack/bloom.c',
   'branch.c',
   'bundle-uri.c',
   'bundle.c',
@@ -330,11 +330,11 @@ libgit_sources = [
   'odb/cbtree.c',
   'chdir-notify.c',
   'checkout.c',
-  'chunk-format.c',
+  'pack/chunk-format.c',
   'color.c',
   'column.c',
   'combine-diff.c',
-  'commit-graph.c',
+  'pack/commit-graph.c',
   'commit-reach.c',
   'odb/commit.c',
   'common-exit.c',
@@ -350,9 +350,9 @@ libgit_sources = [
   'ctype.c',
   'date.c',
   'decorate.c',
-  'delta-islands.c',
+  'pack/delta-islands.c',
   'diagnose.c',
-  'diff-delta.c',
+  'pack/diff-delta.c',
   'diff-merges.c',
   'diff-lib.c',
   'diff-no-index.c',
@@ -416,8 +416,8 @@ libgit_sources = [
   'merge-ort.c',
   'merge-ort-wrappers.c',
   'merge.c',
-  'midx.c',
-  'midx-write.c',
+  'pack/midx.c',
+  'pack/midx-write.c',
   'name-hash.c',
   'negotiator/default.c',
   'negotiator/noop.c',
@@ -446,22 +446,22 @@ libgit_sources = [
   'organize/labeler-protocol.c',
   'organize/organize.c',
   'organize/organizer-protocol.c',
-  'pack-bitmap-write.c',
-  'pack-bitmap.c',
-  'pack-check.c',
-  'pack-mtimes.c',
-  'pack-objects.c',
+  'pack/pack-bitmap-write.c',
+  'pack/pack-bitmap.c',
+  'pack/pack-check.c',
+  'pack/pack-mtimes.c',
+  'pack/pack-objects.c',
   'refs/pack-refs.c',
-  'pack-revindex.c',
-  'pack-write.c',
-  'packfile.c',
-  'packfile-list.c',
+  'pack/pack-revindex.c',
+  'pack/pack-write.c',
+  'pack/packfile.c',
+  'pack/packfile-list.c',
   'pager.c',
   'parallel-checkout.c',
   'parse.c',
   'parse-options-cb.c',
   'parse-options.c',
-  'patch-delta.c',
+  'pack/patch-delta.c',
   'patch-ids.c',
   'path.c',
   'path-walk.c',
@@ -475,11 +475,11 @@ libgit_sources = [
   'prompt.c',
   'protocol.c',
   'protocol-caps.c',
-  'prune-packed.c',
-  'pseudo-merge.c',
+  'pack/prune-packed.c',
+  'pack/pseudo-merge.c',
   'quote.c',
   'range-diff.c',
-  'reachable.c',
+  'pack/reachable.c',
   'read-cache.c',
   'rebase-interactive.c',
   'rebase.c',
@@ -509,12 +509,12 @@ libgit_sources = [
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
-  'repack.c',
-  'repack-cruft.c',
-  'repack-filtered.c',
-  'repack-geometry.c',
-  'repack-midx.c',
-  'repack-promisor.c',
+  'pack/repack.c',
+  'pack/repack-cruft.c',
+  'pack/repack-filtered.c',
+  'pack/repack-geometry.c',
+  'pack/repack-midx.c',
+  'pack/repack-promisor.c',
   'odb/replace-object.c',
   'replay.c',
   'repo-settings.c',
@@ -527,7 +527,7 @@ libgit_sources = [
   'send-pack.c',
   'sequencer.c',
   'serve.c',
-  'server-info.c',
+  'pack/server-info.c',
   'setup.c',
   'shallow.c',
   'sideband.c',
diff --git a/odb/commit.c b/odb/commit.c
index dc98000ab2..06daa8c6a0 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "odb/tag.h"
 #include "odb/commit.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/odb/fsck.c b/odb/fsck.c
index 75306dc8a3..8c953f61a4 100644
--- a/odb/fsck.c
+++ b/odb/fsck.c
@@ -18,7 +18,7 @@
 #include "url.h"
 #include "utf8.h"
 #include "odb/oidset.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "submodule-config.h"
 #include "config.h"
 #include "help.h"
diff --git a/odb/object-file.c b/odb/object-file.c
index c4841cc289..41ee67abb6 100644
--- a/odb/object-file.c
+++ b/odb/object-file.c
@@ -22,8 +22,8 @@
 #include "odb/odb.h"
 #include "odb/streaming.h"
 #include "odb/transaction.h"
-#include "pack.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "setup.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index 16b6cd8f12..ff61d55590 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -22,7 +22,7 @@
 #include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "commit-reach.h"
 #include "date.h"
 #include "odb/object-file-convert.h"
diff --git a/odb/object.c b/odb/object.c
index 8a34e52eca..7c2f920d3f 100644
--- a/odb/object.c
+++ b/odb/object.c
@@ -13,7 +13,7 @@
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "odb/alloc.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 
 unsigned int get_max_object_index(const struct repository *repo)
 {
diff --git a/odb/odb.c b/odb/odb.c
index ffa2881e9f..e942149d91 100644
--- a/odb/odb.c
+++ b/odb/odb.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
@@ -9,13 +9,13 @@
 #include "khash.h"
 #include "lockfile.h"
 #include "odb/loose.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "odb/object-file-convert.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/source-inmemory.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
diff --git a/odb/source-files.c b/odb/source-files.c
index 279a2ccab6..b526e5c219 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -10,11 +10,11 @@
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
-#include "pack-objects.h"
-#include "packfile.h"
+#include "pack/pack-objects.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..0e391f6fcf 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -5,11 +5,11 @@
 #include "git-zlib.h"
 #include "list-objects-filter-options.h"
 #include "mergesort.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
-#include "packfile.h"
-#include "pack-bitmap.h"
+#include "pack/packfile.h"
+#include "pack/pack-bitmap.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
diff --git a/odb/source-packed.h b/odb/source-packed.h
index a0f6b5096d..619e28179e 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -2,7 +2,7 @@
 #define ODB_SOURCE_PACKED_H
 
 #include "odb/source.h"
-#include "packfile-list.h"
+#include "pack/packfile-list.h"
 #include "strmap.h"
 
 /*
diff --git a/odb/source.c b/odb/source.c
index 2a2e1d0060..95f4362327 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -2,7 +2,7 @@
 #include "odb/object-file.h"
 #include "odb/source-files.h"
 #include "odb/source.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 
 static const char * const odb_source_names_by_type[] = {
 	[ODB_SOURCE_UNKNOWN] = "unknown",
diff --git a/odb/tag.c b/odb/tag.c
index 7be23b04c1..36cb7732a8 100644
--- a/odb/tag.c
+++ b/odb/tag.c
@@ -11,7 +11,7 @@
 #include "odb/alloc.h"
 #include "gpg-interface.h"
 #include "hex.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "repository.h"
 
 const char *tag_type = "tag";
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 59bbb849d1..e0ef2ef871 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "repository.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
index ef61ab577c..81dc1d556b 100644
--- a/oss-fuzz/fuzz-pack-headers.c
+++ b/oss-fuzz/fuzz-pack-headers.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index 5b033dbd93..599b12b9bf 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 
diff --git a/bloom.c b/pack/bloom.c
similarity index 99%
rename from bloom.c
rename to pack/bloom.c
index e61cb05246..874e011530 100644
--- a/bloom.c
+++ b/pack/bloom.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "hashmap.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "odb/commit.h"
 #include "odb/commit-slab.h"
 #include "odb/tree.h"
diff --git a/bloom.h b/pack/bloom.h
similarity index 100%
rename from bloom.h
rename to pack/bloom.h
diff --git a/chunk-format.c b/pack/chunk-format.c
similarity index 99%
rename from chunk-format.c
rename to pack/chunk-format.c
index 08b90762d4..31468dcc6e 100644
--- a/chunk-format.c
+++ b/pack/chunk-format.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "chunk-format.h"
+#include "pack/chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
 #include "odb/hash.h"
diff --git a/chunk-format.h b/pack/chunk-format.h
similarity index 100%
rename from chunk-format.h
rename to pack/chunk-format.h
diff --git a/commit-graph.c b/pack/commit-graph.c
similarity index 99%
rename from commit-graph.c
rename to pack/commit-graph.c
index 7c22588c46..afc04d74a5 100644
--- a/commit-graph.c
+++ b/pack/commit-graph.c
@@ -7,12 +7,12 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/commit.h"
 #include "odb/object.h"
 #include "refs/refs.h"
 #include "odb/hash-lookup.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "odb/odb.h"
 #include "odb/oid-array.h"
 #include "path.h"
@@ -20,13 +20,13 @@
 #include "hashmap.h"
 #include "odb/replace-object.h"
 #include "progress.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "odb/commit-slab.h"
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
 #include "odb/tree.h"
-#include "chunk-format.h"
+#include "pack/chunk-format.h"
 
 void git_test_write_commit_graph_or_die(struct odb_source *source)
 {
diff --git a/commit-graph.h b/pack/commit-graph.h
similarity index 100%
rename from commit-graph.h
rename to pack/commit-graph.h
diff --git a/delta-islands.c b/pack/delta-islands.c
similarity index 99%
rename from delta-islands.c
rename to pack/delta-islands.c
index 1c92cdf37c..3d015719a5 100644
--- a/delta-islands.c
+++ b/pack/delta-islands.c
@@ -7,15 +7,15 @@
 #include "hex.h"
 #include "odb/tag.h"
 #include "odb/tree.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "odb/tree-walk.h"
 #include "diff.h"
 #include "progress.h"
 #include "refs/refs.h"
 #include "khash.h"
-#include "pack-bitmap.h"
-#include "pack-objects.h"
-#include "delta-islands.h"
+#include "pack/pack-bitmap.h"
+#include "pack/pack-objects.h"
+#include "pack/delta-islands.h"
 #include "odb/oid-array.h"
 #include "config.h"
 
diff --git a/delta-islands.h b/pack/delta-islands.h
similarity index 100%
rename from delta-islands.h
rename to pack/delta-islands.h
diff --git a/delta.h b/pack/delta.h
similarity index 100%
rename from delta.h
rename to pack/delta.h
diff --git a/diff-delta.c b/pack/diff-delta.c
similarity index 99%
rename from diff-delta.c
rename to pack/diff-delta.c
index 43c339f010..0800ce4607 100644
--- a/diff-delta.c
+++ b/pack/diff-delta.c
@@ -14,7 +14,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "delta.h"
+#include "pack/delta.h"
 
 /* maximum hash entry list for the same hash bucket */
 #define HASH_LIMIT 64
diff --git a/midx-write.c b/pack/midx-write.c
similarity index 99%
rename from midx-write.c
rename to pack/midx-write.c
index af4410a0b8..1f8f24410a 100644
--- a/midx-write.c
+++ b/pack/midx-write.c
@@ -3,20 +3,20 @@
 #include "config.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/hash-lookup.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "progress.h"
 #include "trace2.h"
 #include "run-command.h"
-#include "chunk-format.h"
-#include "pack-bitmap.h"
+#include "pack/chunk-format.h"
+#include "pack/pack-bitmap.h"
 #include "refs/refs.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "path.h"
-#include "pack-revindex.h"
+#include "pack/pack-revindex.h"
 
 #define PACK_EXPIRED UINT_MAX
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
diff --git a/midx.c b/pack/midx.c
similarity index 99%
rename from midx.c
rename to pack/midx.c
index 47f67c4295..2608e99468 100644
--- a/midx.c
+++ b/pack/midx.c
@@ -4,14 +4,14 @@
 #include "config.h"
 #include "dir.h"
 #include "hex.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/hash-lookup.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "progress.h"
 #include "trace2.h"
-#include "chunk-format.h"
-#include "pack-bitmap.h"
-#include "pack-revindex.h"
+#include "pack/chunk-format.h"
+#include "pack/pack-bitmap.h"
+#include "pack/pack-revindex.h"
 #include "strvec.h"
 
 #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
diff --git a/midx.h b/pack/midx.h
similarity index 100%
rename from midx.h
rename to pack/midx.h
diff --git a/pack-bitmap-write.c b/pack/pack-bitmap-write.c
similarity index 99%
rename from pack-bitmap-write.c
rename to pack/pack-bitmap-write.c
index b5e14b196f..6ef5fb4629 100644
--- a/pack-bitmap-write.c
+++ b/pack/pack-bitmap-write.c
@@ -9,24 +9,24 @@
 #include "diff.h"
 #include "revision.h"
 #include "progress.h"
-#include "pack.h"
-#include "pack-bitmap.h"
+#include "pack/pack.h"
+#include "pack/pack-bitmap.h"
 #include "odb/hash-lookup.h"
-#include "pack-objects.h"
+#include "pack/pack-objects.h"
 #include "path.h"
 #include "commit-reach.h"
 #include "prio-queue.h"
 #include "trace2.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "pseudo-merge.h"
+#include "pack/pseudo-merge.h"
 #include "odb/oid-array.h"
 #include "config.h"
 #include "odb/alloc.h"
 #include "refs/refs.h"
 #include "strmap.h"
-#include "midx.h"
-#include "pack-revindex.h"
+#include "pack/midx.h"
+#include "pack/pack-revindex.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/pack-bitmap.c b/pack/pack-bitmap.c
similarity index 99%
rename from pack-bitmap.c
rename to pack/pack-bitmap.c
index 908a00ec0c..80f853f355 100644
--- a/pack-bitmap.c
+++ b/pack/pack-bitmap.c
@@ -10,18 +10,18 @@
 #include "revision.h"
 #include "progress.h"
 #include "list-objects.h"
-#include "pack.h"
-#include "pack-bitmap.h"
-#include "pack-revindex.h"
-#include "pack-objects.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/pack-bitmap.h"
+#include "pack/pack-revindex.h"
+#include "pack/pack-objects.h"
+#include "pack/packfile.h"
 #include "repository.h"
 #include "trace2.h"
 #include "odb/odb.h"
 #include "list-objects-filter-options.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "config.h"
-#include "pseudo-merge.h"
+#include "pack/pseudo-merge.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
diff --git a/pack-bitmap.h b/pack/pack-bitmap.h
similarity index 99%
rename from pack-bitmap.h
rename to pack/pack-bitmap.h
index b50ef0b4e4..6f6fc1cb50 100644
--- a/pack-bitmap.h
+++ b/pack/pack-bitmap.h
@@ -3,8 +3,8 @@
 
 #include "ewah/ewok.h"
 #include "khash.h"
-#include "pack.h"
-#include "pack-objects.h"
+#include "pack/pack.h"
+#include "pack/pack-objects.h"
 #include "refs/refs.h"
 #include "string-list.h"
 
diff --git a/pack-check.c b/pack/pack-check.c
similarity index 99%
rename from pack-check.c
rename to pack/pack-check.c
index 358c68ef11..e66ef8f1b7 100644
--- a/pack-check.c
+++ b/pack/pack-check.c
@@ -4,9 +4,9 @@
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "progress.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
diff --git a/pack-mtimes.c b/pack/pack-mtimes.c
similarity index 98%
rename from pack-mtimes.c
rename to pack/pack-mtimes.c
index 903c1039c8..1dbc072bb0 100644
--- a/pack-mtimes.c
+++ b/pack/pack-mtimes.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "pack-mtimes.h"
+#include "pack/pack-mtimes.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "strbuf.h"
 
 static char *pack_mtimes_filename(struct packed_git *p)
diff --git a/pack-mtimes.h b/pack/pack-mtimes.h
similarity index 100%
rename from pack-mtimes.h
rename to pack/pack-mtimes.h
diff --git a/pack-objects.c b/pack/pack-objects.c
similarity index 98%
rename from pack-objects.c
rename to pack/pack-objects.c
index 35ecc8831e..aa1d5bb1c9 100644
--- a/pack-objects.c
+++ b/pack/pack-objects.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
 #include "odb/object.h"
-#include "pack.h"
-#include "pack-objects.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/pack-objects.h"
+#include "pack/packfile.h"
 #include "parse.h"
 #include "repository.h"
 
diff --git a/pack-objects.h b/pack/pack-objects.h
similarity index 99%
rename from pack-objects.h
rename to pack/pack-objects.h
index 8b9fc2e36b..dbd07d3913 100644
--- a/pack-objects.h
+++ b/pack/pack-objects.h
@@ -3,8 +3,8 @@
 
 #include "odb/odb.h"
 #include "thread-utils.h"
-#include "pack.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/packfile.h"
 
 struct repository;
 
diff --git a/pack-revindex.c b/pack/pack-revindex.c
similarity index 99%
rename from pack-revindex.c
rename to pack/pack-revindex.c
index 613d1bb897..51cf1f82c6 100644
--- a/pack-revindex.c
+++ b/pack/pack-revindex.c
@@ -1,13 +1,13 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "pack-revindex.h"
+#include "pack/pack-revindex.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "parse.h"
 #include "repository.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "csum-file.h"
 
 struct revindex_entry {
diff --git a/pack-revindex.h b/pack/pack-revindex.h
similarity index 100%
rename from pack-revindex.h
rename to pack/pack-revindex.h
diff --git a/pack-write.c b/pack/pack-write.c
similarity index 99%
rename from pack-write.c
rename to pack/pack-write.c
index 86af0ac730..3ced89d932 100644
--- a/pack-write.c
+++ b/pack/pack-write.c
@@ -2,14 +2,14 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "csum-file.h"
 #include "remote.h"
-#include "chunk-format.h"
+#include "pack/chunk-format.h"
 #include "odb/object-file.h"
-#include "pack-mtimes.h"
-#include "pack-objects.h"
-#include "pack-revindex.h"
+#include "pack/pack-mtimes.h"
+#include "pack/pack-objects.h"
+#include "pack/pack-revindex.h"
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/pack.h b/pack/pack.h
similarity index 100%
rename from pack.h
rename to pack/pack.h
diff --git a/packfile-list.c b/pack/packfile-list.c
similarity index 96%
rename from packfile-list.c
rename to pack/packfile-list.c
index 01fb913abf..4e041d4fed 100644
--- a/packfile-list.c
+++ b/pack/packfile-list.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "packfile.h"
-#include "packfile-list.h"
+#include "pack/packfile.h"
+#include "pack/packfile-list.h"
 
 void packfile_list_clear(struct packfile_list *list)
 {
diff --git a/packfile-list.h b/pack/packfile-list.h
similarity index 100%
rename from packfile-list.h
rename to pack/packfile-list.h
diff --git a/packfile.c b/pack/packfile.c
similarity index 99%
rename from packfile.c
rename to pack/packfile.c
index 2936cbf3fa..0426bee827 100644
--- a/packfile.c
+++ b/pack/packfile.c
@@ -5,11 +5,11 @@
 #include "gettext.h"
 #include "hex.h"
 #include "list.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "repository.h"
 #include "dir.h"
-#include "packfile.h"
-#include "delta.h"
+#include "pack/packfile.h"
+#include "pack/delta.h"
 #include "odb/hash-lookup.h"
 #include "odb/commit.h"
 #include "odb/object.h"
@@ -20,11 +20,11 @@
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
-#include "midx.h"
-#include "commit-graph.h"
-#include "pack-revindex.h"
+#include "pack/midx.h"
+#include "pack/commit-graph.h"
+#include "pack/pack-revindex.h"
 #include "promisor-remote.h"
-#include "pack-mtimes.h"
+#include "pack/pack-mtimes.h"
 
 char *odb_pack_name(struct repository *r, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
diff --git a/packfile.h b/pack/packfile.h
similarity index 99%
rename from packfile.h
rename to pack/packfile.h
index 9859bfb5e0..55dc02539b 100644
--- a/packfile.h
+++ b/pack/packfile.h
@@ -7,7 +7,7 @@
 #include "odb/source-files.h"
 #include "odb/source-packed.h"
 #include "odb/oidset.h"
-#include "packfile-list.h"
+#include "pack/packfile-list.h"
 #include "repository.h"
 
 /* in odb.h */
diff --git a/patch-delta.c b/pack/patch-delta.c
similarity index 98%
rename from patch-delta.c
rename to pack/patch-delta.c
index 42199fa956..77c1e278b7 100644
--- a/patch-delta.c
+++ b/pack/patch-delta.c
@@ -10,7 +10,7 @@
  */
 
 #include "git-compat-util.h"
-#include "delta.h"
+#include "pack/delta.h"
 
 void *patch_delta(const void *src_buf, size_t src_size,
 		  const void *delta_buf, size_t delta_size,
diff --git a/prune-packed.c b/pack/prune-packed.c
similarity index 94%
rename from prune-packed.c
rename to pack/prune-packed.c
index f536ef1eaf..52473c6bf9 100644
--- a/prune-packed.c
+++ b/pack/prune-packed.c
@@ -3,9 +3,9 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "odb/object-file.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "progress.h"
-#include "prune-packed.h"
+#include "pack/prune-packed.h"
 #include "repository.h"
 
 static struct progress *progress;
diff --git a/prune-packed.h b/pack/prune-packed.h
similarity index 100%
rename from prune-packed.h
rename to pack/prune-packed.h
diff --git a/pseudo-merge.c b/pack/pseudo-merge.c
similarity index 99%
rename from pseudo-merge.c
rename to pack/pseudo-merge.c
index f87fd46b46..07c6ebea05 100644
--- a/pseudo-merge.c
+++ b/pack/pseudo-merge.c
@@ -2,14 +2,14 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "pseudo-merge.h"
+#include "pack/pseudo-merge.h"
 #include "date.h"
 #include "odb/oid-array.h"
 #include "strbuf.h"
 #include "config.h"
 #include "string-list.h"
 #include "refs/refs.h"
-#include "pack-bitmap.h"
+#include "pack/pack-bitmap.h"
 #include "odb/commit.h"
 #include "odb/alloc.h"
 #include "progress.h"
diff --git a/pseudo-merge.h b/pack/pseudo-merge.h
similarity index 100%
rename from pseudo-merge.h
rename to pack/pseudo-merge.h
diff --git a/reachable.c b/pack/reachable.c
similarity index 98%
rename from reachable.c
rename to pack/reachable.c
index a99699c6d8..51c13b552f 100644
--- a/reachable.c
+++ b/pack/reachable.c
@@ -8,15 +8,15 @@
 #include "odb/blob.h"
 #include "diff.h"
 #include "revision.h"
-#include "reachable.h"
+#include "pack/reachable.h"
 #include "cache-tree.h"
 #include "progress.h"
 #include "list-objects.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "refs/worktree.h"
 #include "odb/object-file.h"
-#include "pack-bitmap.h"
-#include "pack-mtimes.h"
+#include "pack/pack-bitmap.h"
+#include "pack/pack-mtimes.h"
 #include "config.h"
 #include "run-command.h"
 #include "sequencer.h"
diff --git a/reachable.h b/pack/reachable.h
similarity index 100%
rename from reachable.h
rename to pack/reachable.h
diff --git a/repack-cruft.c b/pack/repack-cruft.c
similarity index 98%
rename from repack-cruft.c
rename to pack/repack-cruft.c
index 0653e88792..0f49a59ca7 100644
--- a/repack-cruft.c
+++ b/pack/repack-cruft.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
-#include "repack.h"
-#include "packfile.h"
+#include "pack/repack.h"
+#include "pack/packfile.h"
 #include "repository.h"
 #include "run-command.h"
 
diff --git a/repack-filtered.c b/pack/repack-filtered.c
similarity index 98%
rename from repack-filtered.c
rename to pack/repack-filtered.c
index edcf7667c5..2a77018951 100644
--- a/repack-filtered.c
+++ b/pack/repack-filtered.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "repository.h"
 #include "run-command.h"
 #include "string-list.h"
diff --git a/repack-geometry.c b/pack/repack-geometry.c
similarity index 99%
rename from repack-geometry.c
rename to pack/repack-geometry.c
index 15b3412950..1ae2e8be9f 100644
--- a/repack-geometry.c
+++ b/pack/repack-geometry.c
@@ -1,11 +1,11 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "repository.h"
 #include "hex.h"
-#include "midx.h"
-#include "packfile.h"
+#include "pack/midx.h"
+#include "pack/packfile.h"
 
 static uint32_t pack_geometry_weight(struct packed_git *p)
 {
diff --git a/repack-midx.c b/pack/repack-midx.c
similarity index 99%
rename from repack-midx.c
rename to pack/repack-midx.c
index 342deb798c..d1b563e90c 100644
--- a/repack-midx.c
+++ b/pack/repack-midx.c
@@ -1,12 +1,12 @@
 #include "git-compat-util.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "odb/hash.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "odb/odb.h"
 #include "odb/oidset.h"
-#include "pack-bitmap.h"
+#include "pack/pack-bitmap.h"
 #include "path.h"
 #include "refs/refs.h"
 #include "run-command.h"
diff --git a/repack-promisor.c b/pack/repack-promisor.c
similarity index 98%
rename from repack-promisor.c
rename to pack/repack-promisor.c
index 90318ce150..628903244c 100644
--- a/repack-promisor.c
+++ b/pack/repack-promisor.c
@@ -1,8 +1,8 @@
 #include "git-compat-util.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "hex.h"
-#include "pack.h"
-#include "packfile.h"
+#include "pack/pack.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "repository.h"
 #include "run-command.h"
diff --git a/repack.c b/pack/repack.c
similarity index 99%
rename from repack.c
rename to pack/repack.c
index 16da2e35cb..91dde13b29 100644
--- a/repack.c
+++ b/pack/repack.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
 #include "dir.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "path.h"
-#include "repack.h"
+#include "pack/repack.h"
 #include "repository.h"
 #include "run-command.h"
 #include "tempfile.h"
diff --git a/repack.h b/pack/repack.h
similarity index 100%
rename from repack.h
rename to pack/repack.h
diff --git a/server-info.c b/pack/server-info.c
similarity index 99%
rename from server-info.c
rename to pack/server-info.c
index 3021ee8926..627d2e3c98 100644
--- a/server-info.c
+++ b/pack/server-info.c
@@ -8,11 +8,11 @@
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "path.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
-#include "server-info.h"
+#include "pack/server-info.h"
 #include "strbuf.h"
 #include "tempfile.h"
 
diff --git a/server-info.h b/pack/server-info.h
similarity index 100%
rename from server-info.h
rename to pack/server-info.h
diff --git a/path.c b/path.c
index 4afd1e3ffa..516abb3f82 100644
--- a/path.c
+++ b/path.c
@@ -13,7 +13,7 @@
 #include "setup.h"
 #include "submodule-config.h"
 #include "path.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "odb/odb.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index b2188d34c7..da6b1225dd 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -9,7 +9,7 @@
 #include "trace2.h"
 #include "transport.h"
 #include "strvec.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "environment.h"
 #include "url.h"
 #include "urlmatch.h"
diff --git a/repo-settings.c b/repo-settings.c
index f3be3b8c5a..f40d1436a9 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,8 +2,8 @@
 #include "config.h"
 #include "repo-settings.h"
 #include "repository.h"
-#include "midx.h"
-#include "pack-objects.h"
+#include "pack/midx.h"
+#include "pack/pack-objects.h"
 #include "setup.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
diff --git a/revision.c b/revision.c
index 35a1893436..f92a6482f1 100644
--- a/revision.c
+++ b/revision.c
@@ -31,7 +31,7 @@
 #include "odb/commit-slab.h"
 #include "cache-tree.h"
 #include "bisect.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "refs/worktree.h"
 #include "path.h"
 #include "read-cache.h"
@@ -40,11 +40,11 @@
 #include "strvec.h"
 #include "trace2.h"
 #include "commit-reach.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "prio-queue.h"
 #include "hashmap.h"
 #include "utf8.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "json-writer.h"
 #include "list-objects-filter-options.h"
 #include "resolve-undo.h"
diff --git a/run-command.c b/run-command.c
index ce84db8782..e0c4325900 100644
--- a/run-command.c
+++ b/run-command.c
@@ -15,7 +15,7 @@
 #include "trace2.h"
 #include "quote.h"
 #include "config.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "compat/nonblock.h"
 
 void child_process_init(struct child_process *child)
diff --git a/scalar.c b/scalar.c
index af3456b5d0..2cb09af1a5 100644
--- a/scalar.c
+++ b/scalar.c
@@ -15,7 +15,7 @@
 #include "fsmonitor-settings.h"
 #include "refs/refs.h"
 #include "dir.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "help.h"
 #include "setup.h"
 #include "trace2.h"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index f1f48e973d..59beba76d2 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -4,8 +4,8 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "odb/odb.h"
-#include "pack-bitmap.h"
-#include "pseudo-merge.h"
+#include "pack/pack-bitmap.h"
+#include "pack/pseudo-merge.h"
 #include "setup.h"
 
 static int bitmap_list_commits(void)
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 48ff2c6024..5c469af08d 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "hex.h"
 #include "odb/commit.h"
 #include "repository.h"
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 8223a60229..291c2eb291 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -10,7 +10,7 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
-#include "delta.h"
+#include "pack/delta.h"
 #include "strbuf.h"
 
 static const char usage_str[] =
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index c7475ed4d9..216e7abb9a 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 #include "parse-options.h"
 #include "setup.h"
 
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
index af1d52de10..13e8996b66 100644
--- a/t/helper/test-name-hash.c
+++ b/t/helper/test-name-hash.c
@@ -5,7 +5,7 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
-#include "pack-objects.h"
+#include "pack/pack-objects.h"
 #include "strbuf.h"
 
 int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 7e5791c7ab..a3117ca6fc 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -2,12 +2,12 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
-#include "delta.h"
+#include "pack/delta.h"
 #include "git-zlib.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "pack.h"
-#include "pack-objects.h"
+#include "pack/pack.h"
+#include "pack/pack-objects.h"
 #include "parse-options.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index b915059322..4750a33140 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -4,8 +4,8 @@
 #include "hex.h"
 #include "strbuf.h"
 #include "odb/odb.h"
-#include "packfile.h"
-#include "pack-mtimes.h"
+#include "pack/packfile.h"
+#include "pack/pack-mtimes.h"
 #include "setup.h"
 
 static void dump_mtimes(struct packed_git *p)
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 965700a698..c80df07586 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -1,10 +1,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "repository.h"
 #include "odb/odb.h"
-#include "bloom.h"
+#include "pack/bloom.h"
 #include "setup.h"
 
 static void dump_graph_info(struct commit_graph *graph)
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 9be143ee6c..1e3db8cd81 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -2,14 +2,14 @@
 
 #include "test-tool.h"
 #include "hex.h"
-#include "midx.h"
+#include "pack/midx.h"
 #include "repository.h"
 #include "odb/odb.h"
-#include "pack-bitmap.h"
-#include "packfile.h"
+#include "pack/pack-bitmap.h"
+#include "pack/packfile.h"
 #include "setup.h"
 #include "gettext.h"
-#include "pack-revindex.h"
+#include "pack/pack-revindex.h"
 
 static struct multi_pack_index *setup_midx(const char *object_dir)
 {
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 530e37b01d..58f486a471 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "odb/commit.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 57013566cc..1997141691 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/object.h"
-#include "pack.h"
+#include "pack/pack.h"
 #include "parse-options.h"
 #include "parse.h"
 #include "repository.h"
diff --git a/transport-helper.c b/transport-helper.c
index 55bd9291db..6721209d46 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -19,7 +19,7 @@
 #include "refs/refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
-#include "packfile.h"
+#include "pack/packfile.h"
 
 static int debug;
 
diff --git a/upload-pack.c b/upload-pack.c
index 80d2c95c9b..d145a89c7b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -26,7 +26,7 @@
 #include "trace2.h"
 #include "protocol.h"
 #include "upload-pack.h"
-#include "commit-graph.h"
+#include "pack/commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
 #include "trace.h"
-- 
2.54.0

