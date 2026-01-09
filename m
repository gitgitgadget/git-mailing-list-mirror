Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21242500942
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994226; cv=none; b=fxW8WkRcRkB6DUgBJCUCpND5rpsVB2jXD4lvZNcrUSIDlW856i9j0Ph2GF5dCh9IHnG9ZXJ0tLpI52Zj0v+wAeBACAVokJmIjx4pecP4S80WSUuBTbPlth+pQbPCJSRT6Sjka5NYnY7JyXNq4ajDdaJ6whLTbmRcet8hrCh8U7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994226; c=relaxed/simple;
	bh=fuRtD9FWO/MMonJO5YTrlfEuQbAPT1xyQkIdNPEqXb4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxZdH7x5dVAVgyogjfQOm24N2sr3RWT8f0w2QXeVq2XRzMIIGlLOh8SX/jggn4Ox+I6BhctLUS+cM/T8+iDn8AyJYydD+3npA7p6jEGpsUVWYIgaK3HM4pArZc0nRzB3U5waDSc+kvpPN0CdFS2S7xjNSYW3Kmhz2uEdtH52F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GWD+05KD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GWD+05KD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=Ar6UA09Zt+2GTtC4jWg3cbM+B7S6aNzHYiHF267dnMI=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GWD+05KD4KmqOCz29XjrmGMCYrbmqvqwK94i6vvdR82Rd83x1w9xI7ftsAMml3sL
	 gFxeaalDw8FPlYQ5TdCsUv58BKcktcqiiUPnfeuR4TknQznEu6/YK/wp8ptxP5vLY
	 WfbkGbTT5sqAcuLeOooN+ncw8zKJPCMF6GJZFxRbq3X+UN1sT9+kHBJcMdWl1OJbj
	 z3irVfbGY8zKABBrIL+/CfZv9wqP4StDgTgoUhMyojMdm6LO8E/tIslTpU3xZpIcF
	 JCgaf1p9hSWTpJHHcByMGcLgXynrAXV3qRDnuHrPepq7vsLvO5NjeY5+9YUG6lkub
	 Zspvyk9w/aLe8qJk4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N5lj7-1vu1G1073b-00ym7n for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 00/10] tree: stop using the_repository
Date: Fri,  9 Jan 2026 22:30:11 +0100
Message-ID: <20260109213021.2546-1-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/+OC87hcASife7B4IiqX9tD89ivwbZ8+ZsnyEwINbpDsJyZjn8
 3JOp11o/Xq5yE36hiKwyc8wBf1TyxQ/Xd0AkwG83Cxf+0J5TeHE6Xj9fM92+5vPFa+RMh1b
 mJLP9Y25L1Z1JwSI4q63PDiJGSLGHrQN7wFtYO/cBDKiP5H92lNjAhO1TOROJo1r+Lf/WmK
 LDQbTJl57AQNVoyJabkUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+LdhS6Yejhs=;EyXVLTGk8lQVQyVEbCsL8pPI3ar
 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
 OL2RA==

The tree parsing functions use the_repository internally.  Add variants
that allow using arbitrary repositories.  Fix callers one by one for
which had USE_THE_REPOSITORY_VARIABLE removed despite this implicit
usage and convert the rest mechanically.

  environment: move access to core.maxTreeDepth into repo settings
  tree: add repo_parse_tree*()
  add-interactive: use repo_parse_tree_indirect()
  bloom: use repo_parse_tree()
  delta-islands: use repo_parse_tree()
  pack-bitmap-write: use repo_parse_tree()
  path-walk: use repo_parse_tree_gently()
  tree: use repo_parse_tree()
  tree: stop using the_repository
  cocci: convert parse_tree functions to repo_ variants

 add-interactive.c                       |  2 +-
 archive.c                               |  2 +-
 bloom.c                                 |  2 +-
 builtin/am.c                            | 10 ++++-----
 builtin/checkout.c                      | 12 +++++-----
 builtin/clone.c                         |  4 ++--
 builtin/commit.c                        |  5 +++--
 builtin/diff-tree.c                     |  2 +-
 builtin/ls-tree.c                       |  2 +-
 builtin/merge-tree.c                    |  9 +++++---
 builtin/merge.c                         |  8 +++----
 builtin/read-tree.c                     |  4 ++--
 builtin/reset.c                         |  4 ++--
 builtin/stash.c                         |  8 +++----
 cache-tree.c                            |  2 +-
 contrib/coccinelle/the_repository.cocci | 10 +++++++++
 delta-islands.c                         |  2 +-
 diff-lib.c                              |  2 +-
 environment.c                           | 29 -------------------------
 environment.h                           |  1 -
 fsck.c                                  |  2 +-
 git-compat-util.h                       | 24 ++++++++++++++++++++
 http-push.c                             |  2 +-
 list-objects.c                          |  4 ++--
 merge-ort.c                             | 13 ++++++-----
 merge.c                                 |  6 ++---
 pack-bitmap-write.c                     |  2 +-
 path-walk.c                             |  2 +-
 read-cache.c                            |  2 +-
 repo-settings.c                         |  3 +++
 repo-settings.h                         |  3 +++
 reset.c                                 |  2 +-
 revision.c                              |  4 ++--
 sequencer.c                             |  4 ++--
 t/helper/test-cache-tree.c              |  2 +-
 t/helper/test-match-trees.c             |  4 ++--
 tree-diff.c                             |  2 +-
 tree-walk.c                             |  4 +++-
 tree.c                                  | 16 ++++++--------
 tree.h                                  | 13 +++++++----
 walker.c                                |  2 +-
 41 files changed, 129 insertions(+), 107 deletions(-)

=2D-=20
2.52.0

