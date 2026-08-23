Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154E33EB06
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505579; cv=none; b=H9Fxb/J65Zz13quY+QTsCdxwu+2SZiPUaxQGlciUoejqdtAG05TECUfffCVhEieE4/ozgmu+GVAm07hqK1IiYk2xZuvgX6IhBAxm6JEIEekqlZBR+y0O+Ja3jCd8kwbDNrlAJTGhuAtLWkQjkQF91qjYO+Ad8r7XJroS2xn4uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505579; c=relaxed/simple;
	bh=o1jGVaXYVOeevEOHVyBAmNm4yG5RNOFW6iyLOaS3hkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYEpHgz3ziIj+PG7NHrLUciK/xYJl+osHJeyh0idzR64vSlHXr/ju1PcKrONgsPvNkvCc0fCo/7kq6XOFcPl63t4nEs1A9djPjTCPkWRXOVebKiQaCNi0x4LYzlg3pGIjhlmDL8qDSRpMbO8UpzkAT3ht9FyApgP06gXqJYW+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbp+mnYd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbp+mnYd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cedda2ce6fso15453425ad.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505571; x=1788110371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bgM59LnXKvn9HE5pUvQCixdeBgkgMv59XzDt1svkTfk=;
        b=bbp+mnYdpOpsoH5paa9ZlAr1yAPG9zsNylvIc5bxcbTSzpZcaRkkv2e3eWYhWH0TSe
         Wwi7UhCUoFtyLHJuUoE0lw4cnF6iIdwUDgUstQeCq5oq4JnCLeAEtZKZLvTs4XTMWtk7
         z2nwbXKd3JtrDYRVkK0t5UVKNX344QNK1DvQ0gcl+g5uF+bShUjkTSxarnTC6B3TaPEJ
         PWHZWkkq+bW2hC1qoOSV2fvv+rlb4+MlopEd++tmkBUxLWV6uyR+xakBobIO603f0ItM
         YSWa/lG0w3f5NJJDS522lYThkYzlqLrCOUmb1DxJr7BJbZehcaYDeeY+iMYjR+LHPgEJ
         z/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505571; x=1788110371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bgM59LnXKvn9HE5pUvQCixdeBgkgMv59XzDt1svkTfk=;
        b=Y7Nwa7mQQir/qxs+D6yrYOC1V2jHmyDLVFfX9ZkVtwcOhrxvsgDcpoYYOWGuLH4l5H
         DFx+Q+po6Luiv6aVHcWkyI3KyVdsxooG2bRLQ+hfXf7UJh86Jt3ZHavsrpQpVm8E6xhT
         lGCUyUq5Xk1BiJUD0PfR6FqPSXBmlZqWYaljVbKr0T2w02upeAWLoWxlVwFZhdIdi6Vk
         GxA74CK2y+Nj5brfIM7k6l2JM6v3pfXsV1I1G9TzcsJzwEM7FCGHNcAjK1wTioLWN/2u
         Q4U9NYWJAuwhBpcPkEepfrF5eBd+TF/iMGswGYpoBwtYtgtIpxB3wPRwsY9JH5cSTvMD
         L12Q==
X-Gm-Message-State: AFuF++lcZDSlAPT5oYMD5dcLYF0ugTYjgTXDWfPui/yvkL6NRkchYwGe
	8RZDQ56R3hAqeRGmTGJZB+sfYHD6mMP3KACPuitzrDXFYMb1H1EpHQcmgGc14g==
X-Gm-Gg: AR+sD13pDm9e0W389Hyubmyv+/ri+1f0WFrZpKfH6xgm5eMLvtQjDGKBVC+5wNHoV5o
	b54fcm9x5Z4cYd068CJeyeqhVAuem1YIq8Ira7xOUbSZGID0zGl3JmzT1tf4pFW/0tRLpkV++9d
	IMHOBjOAISLecR8V5w8kWCxvUwBPc6v88QJ55ek17cHVCyQOOFp1I0UJbsTpBhaxdFERu15p98n
	dYIqkHv7D2GE+pH68t48PWxu/BqxEdqpPxq1fDXyRsaF780v4YSwcxkzMKwIQGsIsDlxydboZxn
	7X0DaZ4Spu9uoJOyeLeQ0Tg2HeU9jRGzL0IdFHLPWLv5h4AuM8F+D46sRNO41UrIH5QhsZP7Jfa
	ilq7GGDbV6+IqdK6bkegPbVyJCKwa871RjYdtCRU/8+u+TWhX+VVJz4aIXqHBQb625piOSIRMXF
	3OVWTu2rsqiAX0J+kspalu0GiKlW51BGgtVLQ1aM+QbBpuNkBlIA/WHwcUvgRfA9GkM0CGvetXJ
	PiWIfscqkhUmVgiOptbjQRzGexh+O3aa5Z4H+1QG97P1LXUS227XUSx4oKRDwzqY/0+zphdyqjl
	r+eoDRmoWZJyhgXjeyos/bfZiNMlmDZBvkkvk9N7NDrIEw==
X-Received: by 2002:a17:902:ebc3:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2d64b0427fdmr406486335ad.12.1787505570576;
        Sun, 23 Aug 2026 10:19:30 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327ff728ca7sm15539234eec.3.2026.08.23.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:29 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 08/14] refs: gather the refs sources under refs/
Date: Sun, 23 Aug 2026 10:18:52 -0700
Message-ID: <20260823171915.2662373-9-mmontalbo@gmail.com>
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

Move the 8 refs C sources and 8 headers into refs/ as renames. Repoint
every reference to their old paths to the new ones: the #include lines
across the tree, the Makefile and meson.build build entries.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize                        | 32 ++++++++++++++---------------
 Makefile                            | 16 +++++++--------
 add-interactive.c                   |  2 +-
 archive.c                           |  2 +-
 attr.c                              |  2 +-
 bisect.c                            |  2 +-
 blame.c                             |  2 +-
 branch.c                            |  6 +++---
 builtin/am.c                        |  2 +-
 builtin/bisect.c                    |  2 +-
 builtin/blame.c                     |  2 +-
 builtin/branch.c                    |  6 +++---
 builtin/check-ref-format.c          |  2 +-
 builtin/checkout.c                  |  2 +-
 builtin/clone.c                     |  4 ++--
 builtin/config.c                    |  2 +-
 builtin/describe.c                  |  2 +-
 builtin/fast-export.c               |  4 ++--
 builtin/fast-import.c               |  2 +-
 builtin/fetch.c                     |  4 ++--
 builtin/for-each-ref.c              |  2 +-
 builtin/fsck.c                      |  4 ++--
 builtin/gc.c                        |  6 +++---
 builtin/history.c                   |  2 +-
 builtin/init-db.c                   |  2 +-
 builtin/log.c                       |  4 ++--
 builtin/ls-remote.c                 |  2 +-
 builtin/merge.c                     |  4 ++--
 builtin/name-rev.c                  |  2 +-
 builtin/notes.c                     |  4 ++--
 builtin/pack-objects.c              |  2 +-
 builtin/pack-refs.c                 |  2 +-
 builtin/pull.c                      |  4 ++--
 builtin/push.c                      |  2 +-
 builtin/rebase.c                    |  2 +-
 builtin/receive-pack.c              |  4 ++--
 builtin/reflog.c                    |  6 +++---
 builtin/refs.c                      |  6 +++---
 builtin/remote.c                    |  4 ++--
 builtin/replace.c                   |  2 +-
 builtin/replay.c                    |  2 +-
 builtin/repo.c                      |  4 ++--
 builtin/reset.c                     |  2 +-
 builtin/rev-list.c                  |  2 +-
 builtin/rev-parse.c                 |  2 +-
 builtin/show-branch.c               |  2 +-
 builtin/sparse-checkout.c           |  2 +-
 builtin/stash.c                     |  6 +++---
 builtin/submodule--helper.c         |  4 ++--
 builtin/symbolic-ref.c              |  2 +-
 builtin/tag.c                       |  4 ++--
 builtin/update-index.c              |  2 +-
 builtin/update-ref.c                |  2 +-
 builtin/var.c                       |  2 +-
 builtin/verify-tag.c                |  2 +-
 builtin/worktree.c                  |  4 ++--
 bundle-uri.c                        |  2 +-
 bundle.c                            |  2 +-
 checkout.c                          |  2 +-
 combine-diff.c                      |  2 +-
 commit-graph.c                      |  2 +-
 commit-reach.c                      |  2 +-
 config.c                            |  2 +-
 connect.c                           |  2 +-
 delta-islands.c                     |  2 +-
 diff-lib.c                          |  2 +-
 dir.c                               |  2 +-
 environment.c                       |  2 +-
 fetch-pack.c                        |  2 +-
 fmt-merge-msg.c                     |  2 +-
 help.c                              |  2 +-
 http-backend.c                      |  2 +-
 log-tree.c                          |  4 ++--
 merge-ort.c                         |  2 +-
 meson.build                         | 16 +++++++--------
 midx-write.c                        |  2 +-
 negotiator/default.c                |  2 +-
 negotiator/skipping.c               |  2 +-
 notes-cache.c                       |  2 +-
 notes-merge.c                       |  2 +-
 notes-utils.c                       |  2 +-
 notes.c                             |  2 +-
 odb/commit.c                        |  2 +-
 odb/fsck.c                          |  2 +-
 odb/object-name.c                   |  2 +-
 odb/replace-object.c                |  2 +-
 pack-bitmap-write.c                 |  2 +-
 pack-bitmap.h                       |  2 +-
 path.c                              |  2 +-
 pretty.c                            |  2 +-
 pseudo-merge.c                      |  2 +-
 reachable.c                         |  4 ++--
 read-cache.c                        |  2 +-
 refs/files-backend.c                |  4 ++--
 refs/iterator.c                     |  2 +-
 ls-refs.c => refs/ls-refs.c         |  4 ++--
 ls-refs.h => refs/ls-refs.h         |  0
 pack-refs.c => refs/pack-refs.c     |  4 ++--
 pack-refs.h => refs/pack-refs.h     |  0
 refs/packed-backend.c               |  4 ++--
 refs/ref-cache.c                    |  2 +-
 ref-filter.c => refs/ref-filter.c   |  6 +++---
 ref-filter.h => refs/ref-filter.h   |  0
 reflog-walk.c => refs/reflog-walk.c |  4 ++--
 reflog-walk.h => refs/reflog-walk.h |  0
 reflog.c => refs/reflog.c           |  4 ++--
 reflog.h => refs/reflog.h           |  2 +-
 refs/refs-internal.h                |  2 +-
 refs.c => refs/refs.c               |  4 ++--
 refs.h => refs/refs.h               |  0
 refspec.c => refs/refspec.c         |  4 ++--
 refspec.h => refs/refspec.h         |  0
 refs/reftable-backend.c             |  4 ++--
 worktree.c => refs/worktree.c       |  4 ++--
 worktree.h => refs/worktree.h       |  2 +-
 remote.c                            |  4 ++--
 remote.h                            |  2 +-
 repack-midx.c                       |  2 +-
 replay.c                            |  2 +-
 repository.c                        |  2 +-
 reset.c                             |  2 +-
 revision.c                          |  6 +++---
 scalar.c                            |  2 +-
 sequencer.c                         |  2 +-
 serve.c                             |  2 +-
 server-info.c                       |  2 +-
 setup.c                             |  4 ++--
 setup.h                             |  2 +-
 shallow.c                           |  2 +-
 submodule.c                         |  4 ++--
 t/helper/test-reach.c               |  2 +-
 t/helper/test-ref-store.c           |  4 ++--
 transport-helper.c                  |  4 ++--
 transport.c                         |  4 ++--
 unpack-trees.c                      |  2 +-
 upload-pack.c                       |  2 +-
 walker.c                            |  2 +-
 wt-status.c                         |  4 ++--
 138 files changed, 210 insertions(+), 210 deletions(-)
 rename ls-refs.c => refs/ls-refs.c (99%)
 rename ls-refs.h => refs/ls-refs.h (100%)
 rename pack-refs.c => refs/pack-refs.c (97%)
 rename pack-refs.h => refs/pack-refs.h (100%)
 rename ref-filter.c => refs/ref-filter.c (99%)
 rename ref-filter.h => refs/ref-filter.h (100%)
 rename reflog-walk.c => refs/reflog-walk.c (99%)
 rename reflog-walk.h => refs/reflog-walk.h (100%)
 rename reflog.c => refs/reflog.c (99%)
 rename reflog.h => refs/reflog.h (99%)
 rename refs.c => refs/refs.c (99%)
 rename refs.h => refs/refs.h (100%)
 rename refspec.c => refs/refspec.c (99%)
 rename refspec.h => refs/refspec.h (100%)
 rename worktree.c => refs/worktree.c (99%)
 rename worktree.h => refs/worktree.h (99%)

diff --git a/.gitorganize b/.gitorganize
index 5da6d0b2b1..e29497504a 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -201,8 +201,6 @@ lockfile.c component=? role=lib prefix=lockfile includes=setup:1 cochange=refs:1
 lockfile.h component=? role=public prefix=lockfile cochange=index:5,revision:4,diff:3,refs:3,odb:2
 log-tree.c component=revision role=lib prefix=format-patch includes=odb:8,revision:5,diff:3,setup:3,refs:2 cochange=revision:222,diff:112,odb:112,refs:31,transport:16
 log-tree.h component=revision role=header prefix=format-patch cochange=revision:64,diff:11,refs:3,odb:2,transport:2
-ls-refs.c component=refs role=lib prefix=ls-refs includes=setup:3,refs:2,odb:1,transport:1 cochange=refs:26,transport:17,pack:10,revision:5,odb:4
-ls-refs.h component=refs role=header prefix=ls-refs cochange=transport:11,refs:5,submodule:1
 mailinfo.c component=? role=lib prefix=mailinfo includes=setup:2 cochange=transport:5,index:3,notes:3,odb:3,revision:3
 mailinfo.h component=? role=public prefix=mailinfo
 mailmap.c component=? role=lib prefix=mailmap includes=setup:3,odb:2 cochange=setup:13,transport:11,refs:10,index:8,revision:5
@@ -290,8 +288,6 @@ pack-mtimes.c component=pack role=lib prefix=pack-mtimes includes=pack:2,odb:1 c
 pack-mtimes.h component=pack role=header prefix=pack-mtimes cochange=pack:4,odb:2,setup:1,transport:1
 pack-objects.c component=pack role=lib prefix=pack-objects includes=pack:3,odb:1,setup:1 cochange=pack:66,diff:17,odb:16,transport:9,index:5
 pack-objects.h component=pack role=header prefix=pack-objects includes=pack:2,odb:1 cochange=pack:44,setup:5,odb:1
-pack-refs.c component=refs role=lib prefix=pack-refs includes=refs:2,setup:2,revision:1 cochange=refs:12,transport:8,index:2,merge:2,odb:2
-pack-refs.h component=refs role=header prefix=pack-refs cochange=refs:5
 pack-revindex.c component=pack role=lib prefix=pack-revindex includes=pack:3,odb:1,setup:1 cochange=pack:94,odb:7,index:6,transport:5,setup:4
 pack-revindex.h component=pack role=header prefix=pack-revindex cochange=pack:32,odb:1
 pack-write.c component=pack role=lib prefix=pack-write includes=pack:5,setup:2,odb:1,transport:1 cochange=pack:88,odb:21,transport:21,setup:14,index:10
@@ -353,16 +349,22 @@ rebase-interactive.c component=? role=lib prefix=rebase-interactive includes=odb
 rebase-interactive.h component=? role=public prefix=rebase-interactive
 rebase.c component=? role=lib prefix=rebase cochange=index:3,pack:3,setup:2,convert:1,diff:1
 rebase.h component=? role=public prefix=pull
-ref-filter.c component=refs role=lib prefix=ref-filter includes=odb:6,setup:5,refs:3,revision:2,index:1 cochange=refs:112,revision:59,odb:41,transport:40,index:30
-ref-filter.h component=refs role=header prefix=ref-filter includes=odb:2,revision:1 cochange=refs:62,revision:7,transport:6,diff:5,index:4
-reflog-walk.c component=refs role=lib prefix=reflog-walk includes=refs:2,diff:1,odb:1,revision:1,setup:1 cochange=refs:34,revision:26,index:13,diff:9,transport:8
-reflog-walk.h component=refs role=header prefix=reflog-walk cochange=revision:23,refs:19,odb:6,archive:2,index:2
-reflog.c component=refs role=lib prefix=refs includes=odb:3,refs:2,setup:2,revision:1 cochange=refs:18,transport:13,odb:9,revision:7,diff:4
-reflog.h component=refs role=header prefix=reflog includes=refs:1 cochange=refs:8,odb:3,index:1,revision:1,transport:1
-refs.c component=refs role=lib prefix=refs includes=setup:6,odb:5,refs:2,submodule:1 cochange=refs:373,transport:133,setup:116,odb:82,revision:77
-refs.h component=refs role=header prefix=refs includes=odb:2,setup:2 cochange=refs:352,transport:55,revision:34,setup:25,odb:16
-refspec.c component=refs role=lib prefix=refspec includes=refs:2,odb:1,transport:1 cochange=refs:27,transport:26,index:2,submodule:2
-refspec.h component=refs role=header prefix=refspec cochange=transport:31,refs:29,submodule:3,index:2
+refs/ls-refs.c component=refs role=lib prefix=ls-refs includes=setup:3,refs:2,odb:1,transport:1 cochange=refs:26,transport:17,pack:10,revision:5,odb:4
+refs/ls-refs.h component=refs role=header prefix=ls-refs cochange=transport:11,refs:5,submodule:1
+refs/pack-refs.c component=refs role=lib prefix=pack-refs includes=refs:2,setup:2,revision:1 cochange=refs:12,transport:8,index:2,merge:2,odb:2
+refs/pack-refs.h component=refs role=header prefix=pack-refs cochange=refs:5
+refs/ref-filter.c component=refs role=lib prefix=ref-filter includes=odb:6,setup:5,refs:3,revision:2,index:1 cochange=refs:112,revision:59,odb:41,transport:40,index:30
+refs/ref-filter.h component=refs role=header prefix=ref-filter includes=odb:2,revision:1 cochange=refs:62,revision:7,transport:6,diff:5,index:4
+refs/reflog-walk.c component=refs role=lib prefix=reflog-walk includes=refs:2,diff:1,odb:1,revision:1,setup:1 cochange=refs:34,revision:26,index:13,diff:9,transport:8
+refs/reflog-walk.h component=refs role=header prefix=reflog-walk cochange=revision:23,refs:19,odb:6,archive:2,index:2
+refs/reflog.c component=refs role=lib prefix=refs includes=odb:3,refs:2,setup:2,revision:1 cochange=refs:18,transport:13,odb:9,revision:7,diff:4
+refs/reflog.h component=refs role=header prefix=reflog includes=refs:1 cochange=refs:8,odb:3,index:1,revision:1,transport:1
+refs/refs.c component=refs role=lib prefix=refs includes=setup:6,odb:5,refs:2,submodule:1 cochange=refs:373,transport:133,setup:116,odb:82,revision:77
+refs/refs.h component=refs role=header prefix=refs includes=odb:2,setup:2 cochange=refs:352,transport:55,revision:34,setup:25,odb:16
+refs/refspec.c component=refs role=lib prefix=refspec includes=refs:2,odb:1,transport:1 cochange=refs:27,transport:26,index:2,submodule:2
+refs/refspec.h component=refs role=header prefix=refspec cochange=transport:31,refs:29,submodule:3,index:2
+refs/worktree.c component=refs role=lib prefix=worktree includes=setup:4,index:2,refs:2 cochange=refs:73,setup:53,index:22,submodule:13,pack:11
+refs/worktree.h component=refs role=header prefix=worktree includes=refs:1 cochange=refs:61,revision:10,pack:5,setup:5,odb:4
 remote-curl.c component=transport role=lib prefix=remote-curl includes=transport:9,setup:3,odb:1 cochange=transport:226,diff:9,revision:6,setup:5,archive:4
 remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,transport:3,refs:2,revision:2 cochange=transport:272,refs:91,revision:56,index:51,odb:30
 remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
@@ -480,8 +482,6 @@ walker.c component=transport role=lib prefix=refs includes=odb:6,refs:1,setup:1,
 walker.h component=transport role=header prefix=walker includes=transport:1 cochange=transport:19
 wildmatch.c component=? role=lib prefix=hex cochange=index:4,refs:3,diff:1,odb:1,revision:1
 wildmatch.h component=? role=public prefix=? cochange=index:3,refs:2,diff:1,revision:1,setup:1
-worktree.c component=refs role=lib prefix=worktree includes=setup:4,index:2,refs:2 cochange=refs:73,setup:53,index:22,submodule:13,pack:11
-worktree.h component=refs role=header prefix=worktree includes=refs:1 cochange=refs:61,revision:10,pack:5,setup:5,odb:4
 wrapper.c component=? role=lib prefix=wrapper cochange=setup:21,index:16,pack:6,transport:5,convert:4
 wrapper.h component=? role=public prefix=wrapper cochange=index:2,revision:1,setup:1
 write-or-die.c component=? role=lib prefix=write-or-die cochange=pack:6,setup:6,index:4,transport:2,convert:1
diff --git a/Makefile b/Makefile
index a95b87d970..f733ccfee0 100644
--- a/Makefile
+++ b/Makefile
@@ -1201,7 +1201,7 @@ LIB_OBJS += list-objects.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += odb/loose.o
-LIB_OBJS += ls-refs.o
+LIB_OBJS += refs/ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += odb/match-trees.o
@@ -1246,7 +1246,7 @@ LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-mtimes.o
 LIB_OBJS += pack-objects.o
-LIB_OBJS += pack-refs.o
+LIB_OBJS += refs/pack-refs.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
 LIB_OBJS += packfile.o
@@ -1278,17 +1278,17 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase.o
-LIB_OBJS += ref-filter.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += reflog.o
-LIB_OBJS += refs.o
+LIB_OBJS += refs/ref-filter.o
+LIB_OBJS += refs/reflog-walk.o
+LIB_OBJS += refs/reflog.o
+LIB_OBJS += refs/refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
-LIB_OBJS += refspec.o
+LIB_OBJS += refs/refspec.o
 LIB_OBJS += reftable/basics.o
 LIB_OBJS += reftable/block.o
 LIB_OBJS += reftable/blocksource.o
@@ -1377,7 +1377,7 @@ LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
-LIB_OBJS += worktree.o
+LIB_OBJS += refs/worktree.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
diff --git a/add-interactive.c b/add-interactive.c
index 51ddcc4e87..67ee53f5cc 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -11,7 +11,7 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "revision.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "string-list.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/archive.c b/archive.c
index c0d2e0c44b..53820bd859 100644
--- a/archive.c
+++ b/archive.c
@@ -13,7 +13,7 @@
 #include "path.h"
 #include "pretty.h"
 #include "setup.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
 #include "odb/tree.h"
diff --git a/attr.c b/attr.c
index e829149cb4..e7c6562bee 100644
--- a/attr.c
+++ b/attr.c
@@ -20,7 +20,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "read-cache-ll.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "odb/odb.h"
 #include "setup.h"
diff --git a/bisect.c b/bisect.c
index 2dea7139ad..85c5a12ed2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -9,7 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "list-objects.h"
 #include "quote.h"
 #include "run-command.h"
diff --git a/blame.c b/blame.c
index d1cba8811f..a594dc5f0e 100644
--- a/blame.c
+++ b/blame.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/odb.h"
 #include "cache-tree.h"
 #include "mergesort.h"
diff --git a/branch.c b/branch.c
index 7593a499a9..d752e55b88 100644
--- a/branch.c
+++ b/branch.c
@@ -9,13 +9,13 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "path.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "remote.h"
 #include "repository.h"
 #include "sequencer.h"
 #include "odb/commit.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "submodule-config.h"
 #include "run-command.h"
 #include "strmap.h"
diff --git a/builtin/am.c b/builtin/am.c
index f138a8fe3d..d7e4e125d2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -22,7 +22,7 @@
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/commit.h"
 #include "diff.h"
 #include "unpack-trees.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index a1b7fc9407..51e2e949cc 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -9,7 +9,7 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "bisect.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "odb/oid-array.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index c88fc489f7..1662bd487d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -30,7 +30,7 @@
 #include "odb/odb.h"
 #include "pager.h"
 #include "blame.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
 #include "odb/tag.h"
 #include "write-or-die.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index c50c28c720..7909f250aa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -12,7 +12,7 @@
 #include "color.h"
 #include "editor.h"
 #include "environment.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/commit.h"
 #include "gettext.h"
 #include "odb/object-name.h"
@@ -24,8 +24,8 @@
 #include "strmap.h"
 #include "column.h"
 #include "utf8.h"
-#include "ref-filter.h"
-#include "worktree.h"
+#include "refs/ref-filter.h"
+#include "refs/worktree.h"
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd1c9c0e0c..5de8c0e6f5 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -5,7 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
 #include "strbuf.h"
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2dcebb2cb2..87c1f087b8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -24,7 +24,7 @@
 #include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 6d6a756a12..12170ae8f4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -22,8 +22,8 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/tree.h"
diff --git a/builtin/config.c b/builtin/config.c
index 0882899c3f..15782dfe64 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -15,7 +15,7 @@
 #include "quote.h"
 #include "setup.h"
 #include "strbuf.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 
 static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
diff --git a/builtin/describe.c b/builtin/describe.c
index 75961c5945..c16a1da092 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -9,7 +9,7 @@
 #include "lockfile.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 472877f0e5..4a98f14d39 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -12,8 +12,8 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/commit.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1d560d4e71..43bc72f05f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -16,7 +16,7 @@
 #include "pack.h"
 #include "path.h"
 #include "read-cache-ll.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "csum-file.h"
 #include "quote.h"
 #include "dir.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2089e7823e..ce46a709a6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -11,8 +11,8 @@
 #include "gettext.h"
 #include "environment.h"
 #include "hex.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/oidset.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index d3399455ef..9b3f277cb8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "odb/object.h"
 #include "parse-options.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "strbuf.h"
 #include "strvec.h"
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3176941c1d..430cf28bd8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -6,7 +6,7 @@
 #include "odb/tree.h"
 #include "odb/blob.h"
 #include "odb/tag.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "pack.h"
 #include "cache-tree.h"
 #include "odb/fsck.h"
@@ -23,7 +23,7 @@
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "sparse-index.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "pack-revindex.h"
 #include "pack-bitmap.h"
 
diff --git a/builtin/gc.c b/builtin/gc.c
index f2fdc2c69d..1a71e6f908 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,17 +32,17 @@
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "path.h"
-#include "reflog.h"
+#include "refs/reflog.h"
 #include "rerere.h"
 #include "revision.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "remote.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin/history.c b/builtin/history.c
index a2aa224bd1..56b5015bc0 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -15,7 +15,7 @@
 #include "parse-options.h"
 #include "path.h"
 #include "read-cache.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "replay.h"
 #include "reset.h"
 #include "revision.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e96b1283b7..f459635129 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -10,7 +10,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
 #include "strbuf.h"
 
diff --git a/builtin/log.c b/builtin/log.c
index ab381e529e..7099f5fcc5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -13,7 +13,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "odb/streaming.h"
@@ -28,7 +28,7 @@
 #include "odb/oid-array.h"
 #include "odb/oidset.h"
 #include "odb/tag.h"
-#include "reflog-walk.h"
+#include "refs/reflog-walk.h"
 #include "patch-ids.h"
 #include "path.h"
 #include "shortlog.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fe77829557..1b12d6e6ec 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "transport.h"
 #include "pkt-line.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "wildmatch.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 56f89b2944..2369c3b6f9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -26,8 +26,8 @@
 #include "hook.h"
 #include "diff.h"
 #include "diff-merges.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/commit.h"
 #include "diffcore.h"
 #include "path.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index d2870bd37c..4e0254d70e 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -8,7 +8,7 @@
 #include "config.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-name.h"
 #include "pager.h"
 #include "parse-options.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 2cf1437346..6ebb5db39c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,14 +20,14 @@
 #include "path.h"
 
 #include "pretty.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "exec-cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "notes-merge.h"
 #include "notes-utils.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "write-or-die.h"
 
 static const char *separator = "\n";
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3e4c5442dc..69f35a727b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -21,7 +21,7 @@
 #include "list-objects-filter-options.h"
 #include "pack-objects.h"
 #include "progress.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
 #include "delta-islands.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 3446b84cda..235ae2cc5a 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "gettext.h"
-#include "pack-refs.h"
+#include "refs/pack-refs.h"
 
 int cmd_pack_refs(int argc,
 		  const char **argv,
diff --git a/builtin/pull.c b/builtin/pull.c
index cb3d76cb16..bc8dcde318 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -24,8 +24,8 @@
 #include "path.h"
 #include "read-cache-ll.h"
 #include "rebase.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "wt-status.h"
diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..39b6ff4b8b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -12,7 +12,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refspec.h"
+#include "refs/refspec.h"
 #include "run-command.h"
 #include "remote.h"
 #include "transport.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7b8366e5cd..983dbb7ce5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -16,7 +16,7 @@
 #include "run-command.h"
 #include "strvec.h"
 #include "dir.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "config.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5ec79a4595..88cbaed133 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,7 +27,7 @@
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "protocol.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "remote.h"
 #include "run-command.h"
 #include "server-info.h"
@@ -40,7 +40,7 @@
 #include "trace.h"
 #include "trace2.h"
 #include "version.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b709cb0e3c..fc0b74ed95 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -8,9 +8,9 @@
 #include "revision.h"
 #include "reachable.h"
 #include "wildmatch.h"
-#include "worktree.h"
-#include "reflog.h"
-#include "refs.h"
+#include "refs/worktree.h"
+#include "refs/reflog.h"
+#include "refs/refs.h"
 #include "parse-options.h"
 
 #define BUILTIN_REFLOG_SHOW_USAGE \
diff --git a/builtin/refs.c b/builtin/refs.c
index 37936353be..abfc0acdd2 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,11 +1,11 @@
 #include "builtin.h"
 #include "config.h"
 #include "odb/fsck.h"
-#include "pack-refs.h"
+#include "refs/pack-refs.h"
 #include "parse-options.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strbuf.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "for-each-ref.h"
 #include "refs/refs-internal.h"
 
diff --git a/builtin/remote.c b/builtin/remote.c
index b5b54ded27..9a5df99c11 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,8 +14,8 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "rebase.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 793226006c..83497cd974 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,7 +14,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "parse-options.h"
 #include "path.h"
 #include "run-command.h"
diff --git a/builtin/replay.c b/builtin/replay.c
index 4ea7c42215..83b136a13e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "replay.h"
 #include "revision.h"
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 473072b44d..e052e6c0ba 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -11,8 +11,8 @@
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
-#include "ref-filter.h"
-#include "refs.h"
+#include "refs/ref-filter.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 55539f565c..c3bfbab7d5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,7 +20,7 @@
 #include "lockfile.h"
 #include "odb/object.h"
 #include "pretty.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "odb/tree.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0c55dc5b96..466a0a515d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -21,7 +21,7 @@
 #include "graph.h"
 #include "bisect.h"
 #include "progress.h"
-#include "reflog-walk.h"
+#include "refs/reflog-walk.h"
 #include "odb/oidset.h"
 #include "odb/oidmap.h"
 #include "packfile.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index f3bf7831b7..2fb682d5a2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -17,7 +17,7 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "quote.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c58abc872f..4da3330a26 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -8,7 +8,7 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "pretty.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "color.h"
 #include "strvec.h"
 #include "odb/object-name.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e2186fdd33..9b4cad87a5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -19,7 +19,7 @@
 #include "quote.h"
 #include "setup.h"
 #include "sparse-index.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 
 static const char *empty_base = "";
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 2af975aaff..62fec2f17f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
@@ -27,8 +27,8 @@
 #include "sparse-index.h"
 #include "log-tree.h"
 #include "diffcore.h"
-#include "reflog.h"
-#include "reflog-walk.h"
+#include "refs/reflog.h"
+#include "refs/reflog-walk.h"
 #include "add-interactive.h"
 #include "odb/oid-array.h"
 #include "odb/commit.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 96c83476df..bf8b20247f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -21,8 +21,8 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "remote.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 231e41e715..9ea9ca6500 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -3,7 +3,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "parse-options.h"
 #include "strbuf.h"
 
diff --git a/builtin/tag.c b/builtin/tag.c
index e3eee35e88..d554ae8f81 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -16,7 +16,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
@@ -28,7 +28,7 @@
 #include "gpg-interface.h"
 #include "odb/oid-array.h"
 #include "column.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "date.h"
 #include "write-or-die.h"
 #include "odb/object-file-convert.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 992f496efd..54741c3241 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -20,7 +20,7 @@
 #include "odb/object-file.h"
 #include "odb/odb.h"
 #include "odb/transaction.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
 #include "pathspec.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e7ac68f495..5bcd100e52 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "odb/hash.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..d01c87dfa2 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -14,7 +14,7 @@
 #include "environment.h"
 #include "ident.h"
 #include "pager.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "path.h"
 #include "strbuf.h"
 #include "run-command.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 791679a4d8..460244f25b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -13,7 +13,7 @@
 #include "odb/object-name.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 
 static const char * const verify_tag_usage[] = {
 		N_("git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>..."),
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c2ed274f9..90af2193c1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -18,14 +18,14 @@
 #include "strvec.h"
 #include "branch.h"
 #include "read-cache-ll.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "remote.h"
 #include "run-command.h"
 #include "hook.h"
 #include "sigchain.h"
 #include "submodule.h"
 #include "utf8.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
diff --git a/bundle-uri.c b/bundle-uri.c
index 948265330b..96ddf92347 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -6,7 +6,7 @@
 #include "bundle.h"
 #include "copy.h"
 #include "gettext.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "run-command.h"
 #include "hashmap.h"
 #include "pkt-line.h"
diff --git a/bundle.c b/bundle.c
index 81d241e6d0..c64b14a05a 100644
--- a/bundle.c
+++ b/bundle.c
@@ -15,7 +15,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strvec.h"
 #include "list-objects-filter-options.h"
 #include "connected.h"
diff --git a/checkout.c b/checkout.c
index 966a70c267..e3b4d341da 100644
--- a/checkout.c
+++ b/checkout.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "odb/object-name.h"
 #include "remote.h"
-#include "refspec.h"
+#include "refs/refspec.h"
 #include "repository.h"
 #include "checkout.h"
 #include "config.h"
diff --git a/combine-diff.c b/combine-diff.c
index 1c33937f21..6f16e9ea38 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -14,7 +14,7 @@
 #include "xdiff-interface.h"
 #include "xdiff/xmacros.h"
 #include "log-tree.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/tree.h"
 #include "userdiff.h"
 #include "odb/oid-array.h"
diff --git a/commit-graph.c b/commit-graph.c
index abf7c404b3..7c22588c46 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -10,7 +10,7 @@
 #include "packfile.h"
 #include "odb/commit.h"
 #include "odb/object.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/hash-lookup.h"
 #include "commit-graph.h"
 #include "odb/odb.h"
diff --git a/commit-reach.c b/commit-reach.c
index 9b4715fd65..9636b5b37f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -6,7 +6,7 @@
 #include "decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "revision.h"
 #include "odb/tag.h"
 #include "commit-reach.h"
diff --git a/config.c b/config.c
index eacc6847a2..3f335dbec1 100644
--- a/config.c
+++ b/config.c
@@ -30,7 +30,7 @@
 #include "path.h"
 #include "utf8.h"
 #include "color.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
 #include "strvec.h"
 #include "trace2.h"
diff --git a/connect.c b/connect.c
index e54c88f5e2..a24b019b2c 100644
--- a/connect.c
+++ b/connect.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "pkt-line.h"
 #include "quote.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "run-command.h"
 #include "remote.h"
 #include "connect.h"
diff --git a/delta-islands.c b/delta-islands.c
index 0c0d222ab3..1c92cdf37c 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -11,7 +11,7 @@
 #include "odb/tree-walk.h"
 #include "diff.h"
 #include "progress.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "khash.h"
 #include "pack-bitmap.h"
 #include "pack-objects.h"
diff --git a/diff-lib.c b/diff-lib.c
index 313b6136b1..a5072c5f6d 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -17,7 +17,7 @@
 #include "revision.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "repository.h"
 #include "submodule.h"
 #include "symlinks.h"
diff --git a/dir.c b/dir.c
index c9005a0ac1..d230ecdec1 100644
--- a/dir.c
+++ b/dir.c
@@ -19,7 +19,7 @@
 #include "name-hash.h"
 #include "odb/object-file.h"
 #include "path.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "repository.h"
 #include "wildmatch.h"
 #include "pathspec.h"
diff --git a/environment.c b/environment.c
index 40b993ec90..6066417b62 100644
--- a/environment.c
+++ b/environment.c
@@ -26,7 +26,7 @@
 #include "odb/object-name.h"
 #include "repository.h"
 #include "config.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "fmt-merge-msg.h"
 #include "odb/commit.h"
 #include "strvec.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index b172114879..434b57e5b0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -9,7 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "pkt-line.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 6e11ad0fa9..7fa8c4cd79 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -4,7 +4,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "diff.h"
diff --git a/help.c b/help.c
index ccc42f09e0..96f98ec621 100644
--- a/help.c
+++ b/help.c
@@ -15,7 +15,7 @@
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "parse-options.h"
 #include "prompt.h"
 #include "fsmonitor-ipc.h"
diff --git a/http-backend.c b/http-backend.c
index 9b7ae96579..90624c3348 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -8,7 +8,7 @@
 #include "hex.h"
 #include "path.h"
 #include "repository.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "pkt-line.h"
 #include "odb/object.h"
 #include "odb/tag.h"
diff --git a/log-tree.c b/log-tree.c
index c9fde242a1..116bb7ea68 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -18,8 +18,8 @@
 #include "graph.h"
 #include "log-tree.h"
 #include "merge-ort.h"
-#include "reflog-walk.h"
-#include "refs.h"
+#include "refs/reflog-walk.h"
+#include "refs/refs.h"
 #include "odb/replace-object.h"
 #include "revision.h"
 #include "string-list.h"
diff --git a/merge-ort.c b/merge-ort.c
index 35d30dcf06..a12bf62a3d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -44,7 +44,7 @@
 #include "path.h"
 #include "promisor-remote.h"
 #include "read-cache-ll.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
diff --git a/meson.build b/meson.build
index 6586f8ae9f..8dd613a8bb 100644
--- a/meson.build
+++ b/meson.build
@@ -406,7 +406,7 @@ libgit_sources = [
   'lockfile.c',
   'log-tree.c',
   'odb/loose.c',
-  'ls-refs.c',
+  'refs/ls-refs.c',
   'mailinfo.c',
   'mailmap.c',
   'odb/match-trees.c',
@@ -451,7 +451,7 @@ libgit_sources = [
   'pack-check.c',
   'pack-mtimes.c',
   'pack-objects.c',
-  'pack-refs.c',
+  'refs/pack-refs.c',
   'pack-revindex.c',
   'pack-write.c',
   'packfile.c',
@@ -483,17 +483,17 @@ libgit_sources = [
   'read-cache.c',
   'rebase-interactive.c',
   'rebase.c',
-  'ref-filter.c',
-  'reflog-walk.c',
-  'reflog.c',
-  'refs.c',
+  'refs/ref-filter.c',
+  'refs/reflog-walk.c',
+  'refs/reflog.c',
+  'refs/refs.c',
   'refs/debug.c',
   'refs/files-backend.c',
   'refs/reftable-backend.c',
   'refs/iterator.c',
   'refs/packed-backend.c',
   'refs/ref-cache.c',
-  'refspec.c',
+  'refs/refspec.c',
   'reftable/basics.c',
   'reftable/error.c',
   'reftable/block.c',
@@ -579,7 +579,7 @@ libgit_sources = [
   'versioncmp.c',
   'walker.c',
   'wildmatch.c',
-  'worktree.c',
+  'refs/worktree.c',
   'wrapper.c',
   'write-or-die.c',
   'ws.c',
diff --git a/midx-write.c b/midx-write.c
index bb4ceaede7..af4410a0b8 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -12,7 +12,7 @@
 #include "run-command.h"
 #include "chunk-format.h"
 #include "pack-bitmap.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "path.h"
diff --git a/negotiator/default.c b/negotiator/default.c
index 404db17785..7d67933e06 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -5,7 +5,7 @@
 #include "odb/commit.h"
 #include "../fetch-negotiator.h"
 #include "../prio-queue.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "../repository.h"
 #include "odb/tag.h"
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index e1218d2a93..9e685f54a1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -6,7 +6,7 @@
 #include "../fetch-negotiator.h"
 #include "../hex.h"
 #include "../prio-queue.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "../repository.h"
 #include "odb/tag.h"
 
diff --git a/notes-cache.c b/notes-cache.c
index abe0964bba..02fb418c6f 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -7,7 +7,7 @@
 #include "pretty.h"
 #include "repository.h"
 #include "odb/commit.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strbuf.h"
 
 static int notes_cache_match_validity(struct repository *r,
diff --git a/notes-merge.c b/notes-merge.c
index 2b025b6d3d..72a3b9479c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -5,7 +5,7 @@
 #include "advice.h"
 #include "odb/commit.h"
 #include "gettext.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
diff --git a/notes-utils.c b/notes-utils.c
index b6275dfa26..491de7a7ce 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -5,7 +5,7 @@
 #include "odb/commit.h"
 #include "environment.h"
 #include "gettext.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "notes-utils.h"
 #include "strbuf.h"
 
diff --git a/notes.c b/notes.c
index ef44dae00d..5842226c68 100644
--- a/notes.c
+++ b/notes.c
@@ -13,7 +13,7 @@
 #include "strbuf.h"
 #include "odb/tree-walk.h"
 #include "string-list.h"
-#include "refs.h"
+#include "refs/refs.h"
 
 /*
  * Use a non-balancing simple 16-tree structure with struct int_node as
diff --git a/odb/commit.c b/odb/commit.c
index d0e036876c..dc98000ab2 100644
--- a/odb/commit.c
+++ b/odb/commit.c
@@ -22,7 +22,7 @@
 #include "odb/hash-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "commit-reach.h"
 #include "setup.h"
 #include "shallow.h"
diff --git a/odb/fsck.c b/odb/fsck.c
index e76779109a..75306dc8a3 100644
--- a/odb/fsck.c
+++ b/odb/fsck.c
@@ -14,7 +14,7 @@
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "odb/fsck.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "url.h"
 #include "utf8.h"
 #include "odb/oidset.h"
diff --git a/odb/object-name.c b/odb/object-name.c
index 98c88e7337..16b6cd8f12 100644
--- a/odb/object-name.c
+++ b/odb/object-name.c
@@ -12,7 +12,7 @@
 #include "odb/commit.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "remote.h"
 #include "dir.h"
 #include "odb/odb.h"
diff --git a/odb/replace-object.c b/odb/replace-object.c
index 32d778f55e..c69c5aa200 100644
--- a/odb/replace-object.c
+++ b/odb/replace-object.c
@@ -4,7 +4,7 @@
 #include "odb/oidmap.h"
 #include "odb/odb.h"
 #include "odb/replace-object.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "repository.h"
 #include "odb/commit.h"
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 64233d6cd0..b5e14b196f 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -23,7 +23,7 @@
 #include "odb/oid-array.h"
 #include "config.h"
 #include "odb/alloc.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strmap.h"
 #include "midx.h"
 #include "pack-revindex.h"
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1385027c1f..b50ef0b4e4 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,7 +5,7 @@
 #include "khash.h"
 #include "pack.h"
 #include "pack-objects.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "string-list.h"
 
 struct commit;
diff --git a/path.c b/path.c
index 3a3a66155a..4afd1e3ffa 100644
--- a/path.c
+++ b/path.c
@@ -9,7 +9,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "setup.h"
 #include "submodule-config.h"
 #include "path.h"
diff --git a/pretty.c b/pretty.c
index 461e8cd527..4575f3fde6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -17,7 +17,7 @@
 #include "log-tree.h"
 #include "notes.h"
 #include "color.h"
-#include "reflog-walk.h"
+#include "refs/reflog-walk.h"
 #include "gpg-interface.h"
 #include "trailer.h"
 #include "run-command.h"
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 0809a2bcb3..f87fd46b46 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 #include "config.h"
 #include "string-list.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "pack-bitmap.h"
 #include "odb/commit.h"
 #include "odb/alloc.h"
diff --git a/reachable.c b/reachable.c
index 2a62adf7f5..a99699c6d8 100644
--- a/reachable.c
+++ b/reachable.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/commit.h"
 #include "odb/blob.h"
 #include "diff.h"
@@ -13,7 +13,7 @@
 #include "progress.h"
 #include "list-objects.h"
 #include "packfile.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "odb/object-file.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
diff --git a/read-cache.c b/read-cache.c
index 8f6b812b5f..148a93f10e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,7 +16,7 @@
 #include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "dir.h"
 #include "odb/object-file.h"
 #include "odb/odb.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef7532e727..35acc13ccc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -9,7 +9,7 @@
 #include "odb/hash.h"
 #include "../hex.h"
 #include "odb/fsck.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "../repo-settings.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -22,7 +22,7 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
-#include "../worktree.h"
+#include "refs/worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../revision.h"
diff --git a/refs/iterator.c b/refs/iterator.c
index d5cacde51b..08c80ee818 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -6,7 +6,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "refs/refs-internal.h"
 #include "iterator.h"
 
diff --git a/ls-refs.c b/refs/ls-refs.c
similarity index 99%
rename from ls-refs.c
rename to refs/ls-refs.c
index e29ef0947f..75b9b5e620 100644
--- a/ls-refs.c
+++ b/refs/ls-refs.c
@@ -6,9 +6,9 @@
 #include "odb/hash.h"
 #include "hex.h"
 #include "repository.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "strvec.h"
-#include "ls-refs.h"
+#include "refs/ls-refs.h"
 #include "pkt-line.h"
 #include "config.h"
 #include "string-list.h"
diff --git a/ls-refs.h b/refs/ls-refs.h
similarity index 100%
rename from ls-refs.h
rename to refs/ls-refs.h
diff --git a/pack-refs.c b/refs/pack-refs.c
similarity index 97%
rename from pack-refs.c
rename to refs/pack-refs.c
index eb6b2ba2c2..c9f36872cc 100644
--- a/pack-refs.c
+++ b/refs/pack-refs.c
@@ -1,9 +1,9 @@
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
-#include "pack-refs.h"
+#include "refs/pack-refs.h"
 #include "parse-options.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "revision.h"
 
 int pack_refs_core(int argc,
diff --git a/pack-refs.h b/refs/pack-refs.h
similarity index 100%
rename from pack-refs.h
rename to refs/pack-refs.h
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c7005a9ecc..afcb800a5f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -7,14 +7,14 @@
 #include "../gettext.h"
 #include "odb/hash.h"
 #include "../hex.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "refs-internal.h"
 #include "packed-backend.h"
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
 #include "../statinfo.h"
-#include "../worktree.h"
+#include "refs/worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../trace2.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index a4182ea57f..3599199b8e 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,6 +1,6 @@
 #include "../git-compat-util.h"
 #include "odb/hash.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "../repository.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
diff --git a/ref-filter.c b/refs/ref-filter.c
similarity index 99%
rename from ref-filter.c
rename to refs/ref-filter.c
index 8a3d056577..e3de16b7a7 100644
--- a/ref-filter.c
+++ b/refs/ref-filter.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "run-command.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "wildmatch.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
@@ -23,7 +23,7 @@
 #include "color.h"
 #include "odb/tag.h"
 #include "quote.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "revision.h"
 #include "utf8.h"
 #include "versioncmp.h"
@@ -31,7 +31,7 @@
 #include "wt-status.h"
 #include "odb/commit-slab.h"
 #include "commit-reach.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "hashmap.h"
 
 static struct ref_msg {
diff --git a/ref-filter.h b/refs/ref-filter.h
similarity index 100%
rename from ref-filter.h
rename to refs/ref-filter.h
diff --git a/reflog-walk.c b/refs/reflog-walk.c
similarity index 99%
rename from reflog-walk.c
rename to refs/reflog-walk.c
index 4058cfa6df..711b71be66 100644
--- a/reflog-walk.c
+++ b/refs/reflog-walk.c
@@ -2,12 +2,12 @@
 
 #include "git-compat-util.h"
 #include "odb/commit.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "diff.h"
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
-#include "reflog-walk.h"
+#include "refs/reflog-walk.h"
 
 struct complete_reflogs {
 	char *ref;
diff --git a/reflog-walk.h b/refs/reflog-walk.h
similarity index 100%
rename from reflog-walk.h
rename to refs/reflog-walk.h
diff --git a/reflog.c b/refs/reflog.c
similarity index 99%
rename from reflog.c
rename to refs/reflog.c
index 178ef7fe44..751485f885 100644
--- a/reflog.c
+++ b/refs/reflog.c
@@ -7,8 +7,8 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "odb/odb.h"
-#include "reflog.h"
-#include "refs.h"
+#include "refs/reflog.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "odb/tree.h"
 #include "odb/tree-walk.h"
diff --git a/reflog.h b/refs/reflog.h
similarity index 99%
rename from reflog.h
rename to refs/reflog.h
index b996712c00..ef39b0fcc5 100644
--- a/reflog.h
+++ b/refs/reflog.h
@@ -1,6 +1,6 @@
 #ifndef REFLOG_H
 #define REFLOG_H
-#include "refs.h"
+#include "refs/refs.h"
 
 #define REFLOG_EXPIRE_TOTAL   (1 << 0)
 #define REFLOG_EXPIRE_UNREACH (1 << 1)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c3ac7b556f..51be5be0fb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REFS_INTERNAL_H
 #define REFS_REFS_INTERNAL_H
 
-#include "refs.h"
+#include "refs/refs.h"
 #include "iterator.h"
 #include "string-list.h"
 
diff --git a/refs.c b/refs/refs.c
similarity index 99%
rename from refs.c
rename to refs/refs.c
index e01163be2a..2bc9c3cecd 100644
--- a/refs.c
+++ b/refs/refs.c
@@ -12,7 +12,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "iterator.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "refs/refs-internal.h"
 #include "hook.h"
 #include "odb/object-name.h"
@@ -20,7 +20,7 @@
 #include "odb/object.h"
 #include "path.h"
 #include "submodule.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "strvec.h"
 #include "repo-settings.h"
 #include "setup.h"
diff --git a/refs.h b/refs/refs.h
similarity index 100%
rename from refs.h
rename to refs/refs.h
diff --git a/refspec.c b/refs/refspec.c
similarity index 99%
rename from refspec.c
rename to refs/refspec.c
index f3cb1b0748..324c274bff 100644
--- a/refspec.c
+++ b/refs/refspec.c
@@ -6,8 +6,8 @@
 #include "hex.h"
 #include "string-list.h"
 #include "strvec.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "remote.h"
 #include "strbuf.h"
 
diff --git a/refspec.h b/refs/refspec.h
similarity index 100%
rename from refspec.h
rename to refs/refspec.h
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9d6194c4e6..120f9c947f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -12,7 +12,7 @@
 #include "../iterator.h"
 #include "../parse.h"
 #include "../path.h"
-#include "../refs.h"
+#include "refs/refs.h"
 #include "../reftable/reftable-basics.h"
 #include "../reftable/reftable-error.h"
 #include "../reftable/reftable-fsck.h"
@@ -23,7 +23,7 @@
 #include "../setup.h"
 #include "../strmap.h"
 #include "../trace2.h"
-#include "../worktree.h"
+#include "refs/worktree.h"
 #include "../write-or-die.h"
 #include "refs-internal.h"
 
diff --git a/worktree.c b/refs/worktree.c
similarity index 99%
rename from worktree.c
rename to refs/worktree.c
index cbf95328a3..3578229534 100644
--- a/worktree.c
+++ b/refs/worktree.c
@@ -6,10 +6,10 @@
 #include "gettext.h"
 #include "path.h"
 #include "repository.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
 #include "strbuf.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
diff --git a/worktree.h b/refs/worktree.h
similarity index 99%
rename from worktree.h
rename to refs/worktree.h
index fbb2757f5b..11cdc5f7fc 100644
--- a/worktree.h
+++ b/refs/worktree.h
@@ -1,7 +1,7 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
 
-#include "refs.h"
+#include "refs/refs.h"
 
 struct strbuf;
 
diff --git a/remote.c b/remote.c
index 89dc91429a..39e9f58cba 100644
--- a/remote.c
+++ b/remote.c
@@ -10,8 +10,8 @@
 #include "remote.h"
 #include "url.h"
 #include "urlmatch.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "odb/object-name.h"
 #include "odb/odb.h"
 #include "path.h"
diff --git a/remote.h b/remote.h
index fbf552cc2f..e094082e03 100644
--- a/remote.h
+++ b/remote.h
@@ -3,7 +3,7 @@
 
 #include "odb/hash.h"
 #include "hashmap.h"
-#include "refspec.h"
+#include "refs/refspec.h"
 #include "string-list.h"
 #include "strvec.h"
 
diff --git a/repack-midx.c b/repack-midx.c
index a9df431952..342deb798c 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -8,7 +8,7 @@
 #include "odb/oidset.h"
 #include "pack-bitmap.h"
 #include "path.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "run-command.h"
 #include "tempfile.h"
 #include "trace2.h"
diff --git a/replay.c b/replay.c
index 9e29f29ff6..8dd7b99502 100644
--- a/replay.c
+++ b/replay.c
@@ -5,7 +5,7 @@
 #include "hex.h"
 #include "merge-ort.h"
 #include "odb/object-name.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "replay.h"
 #include "revision.h"
 #include "sequencer.h"
diff --git a/repository.c b/repository.c
index 72434e3a50..b5e442f9f3 100644
--- a/repository.c
+++ b/repository.c
@@ -17,7 +17,7 @@
 #include "sparse-index.h"
 #include "trace2.h"
 #include "promisor-remote.h"
-#include "refs.h"
+#include "refs/refs.h"
 
 /*
  * We do not define `USE_THE_REPOSITORY_VARIABLE` in this file because we do
diff --git a/reset.c b/reset.c
index 950d45d07d..29bbeaa9d4 100644
--- a/reset.c
+++ b/reset.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "odb/object-name.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "reset.h"
 #include "odb/tree-walk.h"
 #include "odb/tree.h"
diff --git a/revision.c b/revision.c
index 9e90f909da..35a1893436 100644
--- a/revision.c
+++ b/revision.c
@@ -16,12 +16,12 @@
 #include "odb/commit.h"
 #include "diff.h"
 #include "diff-merges.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "revision.h"
 #include "repository.h"
 #include "graph.h"
 #include "grep.h"
-#include "reflog-walk.h"
+#include "refs/reflog-walk.h"
 #include "patch-ids.h"
 #include "decorate.h"
 #include "string-list.h"
@@ -32,7 +32,7 @@
 #include "cache-tree.h"
 #include "bisect.h"
 #include "packfile.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "path.h"
 #include "read-cache.h"
 #include "setup.h"
diff --git a/scalar.c b/scalar.c
index a80d8ee3ff..af3456b5d0 100644
--- a/scalar.c
+++ b/scalar.c
@@ -13,7 +13,7 @@
 #include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-settings.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "dir.h"
 #include "packfile.h"
 #include "help.h"
diff --git a/sequencer.c b/sequencer.c
index 67ab3cdf0d..d13721ab1f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -29,7 +29,7 @@
 #include "merge.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "sparse-index.h"
 #include "strvec.h"
 #include "quote.h"
diff --git a/serve.c b/serve.c
index 95cf3d8ea4..df3086fb3a 100644
--- a/serve.c
+++ b/serve.c
@@ -4,7 +4,7 @@
 #include "odb/hash.h"
 #include "pkt-line.h"
 #include "version.h"
-#include "ls-refs.h"
+#include "refs/ls-refs.h"
 #include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
diff --git a/server-info.c b/server-info.c
index 75ead482e1..3021ee8926 100644
--- a/server-info.c
+++ b/server-info.c
@@ -4,7 +4,7 @@
 #include "dir.h"
 #include "hex.h"
 #include "repository.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/object.h"
 #include "odb/commit.h"
 #include "odb/tag.h"
diff --git a/setup.c b/setup.c
index fe8e9ffdc5..925a600dba 100644
--- a/setup.c
+++ b/setup.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -22,7 +22,7 @@
 #include "quote.h"
 #include "trace.h"
 #include "trace2.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
diff --git a/setup.h b/setup.h
index 763fd384e8..7bfc5ce068 100644
--- a/setup.h
+++ b/setup.h
@@ -1,7 +1,7 @@
 #ifndef SETUP_H
 #define SETUP_H
 
-#include "refs.h"
+#include "refs/refs.h"
 #include "string-list.h"
 
 int is_inside_git_dir(struct repository *repo);
diff --git a/shallow.c b/shallow.c
index 25116d7a6e..daa6db8e0d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -9,7 +9,7 @@
 #include "odb/commit.h"
 #include "odb/tag.h"
 #include "pkt-line.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "odb/oid-array.h"
 #include "path.h"
 #include "diff.h"
diff --git a/submodule.c b/submodule.c
index d091b484a4..32af65e6b8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,14 +16,14 @@
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "string-list.h"
 #include "odb/oid-array.h"
 #include "strvec.h"
 #include "thread-utils.h"
 #include "path.h"
 #include "remote.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "parse-options.h"
 #include "odb/object-file.h"
 #include "odb/object-name.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 4151cfbe25..df1c677b9f 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "odb/object-name.h"
-#include "ref-filter.h"
+#include "refs/ref-filter.h"
 #include "setup.h"
 #include "string-list.h"
 #include "odb/tag.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 1fbdc52fc5..8c2fb0aad7 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -2,9 +2,9 @@
 
 #include "test-tool.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "setup.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "odb/odb.h"
 #include "path.h"
 #include "repository.h"
diff --git a/transport-helper.c b/transport-helper.c
index 59f61f23c6..55bd9291db 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -15,8 +15,8 @@
 #include "thread-utils.h"
 #include "sigchain.h"
 #include "strvec.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
 #include "packfile.h"
diff --git a/transport.c b/transport.c
index 5b83cf9e73..38915e5466 100644
--- a/transport.c
+++ b/transport.c
@@ -15,8 +15,8 @@
 #include "send-pack.h"
 #include "bundle.h"
 #include "gettext.h"
-#include "refs.h"
-#include "refspec.h"
+#include "refs/refs.h"
+#include "refs/refspec.h"
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index d6e05207a8..b911700d74 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,7 +16,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "progress.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "attr.h"
 #include "read-cache.h"
 #include "split-index.h"
diff --git a/upload-pack.c b/upload-pack.c
index 5c12af2219..80d2c95c9b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -6,7 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
diff --git a/walker.c b/walker.c
index 876865d20a..83f980c1f3 100644
--- a/walker.c
+++ b/walker.c
@@ -12,7 +12,7 @@
 #include "odb/tree-walk.h"
 #include "odb/tag.h"
 #include "odb/blob.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "progress.h"
 #include "prio-queue.h"
 
diff --git a/wt-status.c b/wt-status.c
index 950ebc3418..708366b973 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -21,7 +21,7 @@
 #include "run-command.h"
 #include "strvec.h"
 #include "remote.h"
-#include "refs.h"
+#include "refs/refs.h"
 #include "submodule.h"
 #include "column.h"
 #include "read-cache.h"
@@ -31,7 +31,7 @@
 #include "trace2.h"
 #include "odb/tree.h"
 #include "utf8.h"
-#include "worktree.h"
+#include "refs/worktree.h"
 #include "lockfile.h"
 #include "sequencer.h"
 #include "fsmonitor-settings.h"
-- 
2.54.0

