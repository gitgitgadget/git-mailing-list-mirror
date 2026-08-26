Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C736DA04
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787116; cv=none; b=dfcXUlzUs28/cB4bTOBnQ9fU4OcISYzWhxUJocscMWFYUA7RLhNB3S6c9aal2lzirjw0GpD+y4gTm1DNF3K2ust1bPz97n5b4T73Wzq4NZF0GcQdkZWqPwnYY2SnKrYOKA+0kIprAdA+D4aawqSO8edzVuE98eHGY/DlX/gXKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787116; c=relaxed/simple;
	bh=XAZYsHMEAMdxo1NDyVYF4QlovSscbF0kiZRcBOxg7tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q0FMGt86tI47jXTe/RAqJyUXEUV4Tn/kMgg98VtzrdTXDZAZs5NfdBMVGtu10rDoopD6hnDlqtO45RP53cHbrzKm5nKhF1AAsqIgoAz+h+pI1qOHzao2rsndOruzcIaapc7Y0db+n4QOUdb0a0168UME/0oeWRR1bvyGC69QjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kbzIO2qh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6GuWWhy; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kbzIO2qh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6GuWWhy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1F3A7A0085;
	Wed, 26 Aug 2026 19:31:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 19:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1787787114; x=1787873514; bh=mEJkLGhA1LvHOf62TOXwX
	LWnHyCP8DfRHpn8CJhk1zo=; b=kbzIO2qhMoHtXx5ppxR3FSLov2P5HUDl22XSE
	98s4w2G6Fvl6pJu2k7kT4wuXrQqo+y919ZqzpXHgQkBew6ADUWYO7UvCufFT3O7Q
	0vH+Lh8Epo+rg4AVPRG59KoXqoh/aBmFIct869bU7n1XQeV4Z5RKRLhTKP/55LaB
	3AnhW/PxLO45iC0R27TBKYNBQdg8H7XvJJ4fY9hUlWx1U6OXmW564JjMdZ4FvIVY
	BKV7VUpqVrIi+g6Gxj0LPzT80qnbxuxo2yEYhtsdkJA2TR88lYoHaeV9/RO3fvrM
	q70rxqPUcU5Z/NekdRCdLGg9oA+hGttn0azQe/R2KFjX8TvLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787787114; x=1787873514; bh=mEJkLGhA1LvHOf62TOXwXLWnHyCP8DfRHpn
	8CJhk1zo=; b=U6GuWWhybruxmWPhWiGIYLxKhna4v0f97eKchwWEXVoIyIVtk04
	5ixOlwVJytP6nWJ1suZ5ha6gazoMUvFTqy0aFPet5HpnF7SIbc7HNfeWeIcbB6OP
	GO2Eb/vn1y8ATMbrF54yc9Ob39vIlIQWBrwduJEQt2BbLB/x/hObVSeB2nkFt0G+
	5VrgKdZLjKrmX0vRk9IdIM+Ytoi2n68ro2H4oWpZVo7OS8feYoFyZa7Aum0DrVfI
	gxzWp9xiGnp3Q6i1lwwVxxRao0sNnjyi5uCjSnQ0DnxFfbgPChqmyKLrBhDG5S8A
	GRImhWx5ZUYaaTw95r4//v6J/mWO3RXsrLw==
X-ME-Sender: <xms:anePanIQpYA6xSrOLO4Aex2IP4I2008h0pl69GG1L2Jn2RPRRy6G9Q>
    <xme:anePahIMuvBOE7299SGrt6-sYpgzrxNPt_W6n77PYvIrtKPKvoyLEZ4VKJcf3mwbm
    gGUZJNgpTG1WIGIKuF4dk0s3V6UFOWx8TrwLCpHhVYQ9xC_sPipiXA>
X-ME-Received: <xmr:anePatVF8JavOfYK68Q2bgrQuFfFPEgyEAn8F7R9Qzok6Rlx2zKwkDjh2Awl9fyU9n3WUm06zNBxByej0-za14koQV1jrU69EA>
X-ME-Proxy-Cause: dmFkZTGAWdF675HqcITvaHojqaUbRhfXj0J/9OsCAKLgVkJeY9a2O7xqDu7kaFhknOSZZP
    NR70iNEwINkxuqBgybpwrgXFndsIh0ndJ9qSKJsl76OE6nLyIVAsofUtIiJ7KPR5JTzmT6
    Mfsksua52o/gKagTPZwNixJUpbsILVXFX1/Z6NMXoa4iWRw4qEhQZBXDwuuAmAPnDrd79k
    4ul1dr/sM2BEq/W/We43w0g7RRPE2F8r6sNo6VVGw3CDvuDnsXynPfrSPQ4XF0GRkNkKyP
    deicuYEBI5TNIbB1UshrjBv8DnJLuqr8JPB4SaNQCC8RMl/Z/jKVOhE6gnTcafCFyXvUXX
    m0CG8aFsaAATsIwah+EljwZa4qYyRh/myg1B/BnooODsNM/UgFSInqm+ju4GUvyywK4ITs
    ZXdinJl/bUtSwlxH9Mf3/0gcHaLkXEpYfcLyc84bjgXmWuB3rwDrNd0rwzL9dBHTcwRI6W
    04IFL0I0JEuukZ1wQZC/gCihysUOsT8+H24zNF+Qk1L/UpJtGjn0kZGSMGN7ugxVURThYP
    kyr5w5VJUa1pUbxTNERwhayHvh9FlbpXunwCAfW7uuO2OmlXLPRx8EoncJdSIJtnLuJfJS
    m+UoqSeq6dxBa004o84cCIqwtP739QUr1gsECeIDaiQ6Hm4wfYrt6myQtetw
X-ME-Proxy: <xmx:aneParhiQWHPSyE_w51hB7m12CUziFKbFoNxEmK7OjEinuybG6wong>
    <xmx:anePag_W7qKokdT-k7GeryXwdDOQ3yTLiaN7xwTXxfVVwIW-JIeG9A>
    <xmx:anePatCJbunm_jUpBVctstTxnhmDO9fCrIPmZe02l5E1tNNtSrPfdQ>
    <xmx:anePalJANvupPVfggd6VGHiZOthBey7Z21cEUTLp8bVUG7pGKEj78w>
    <xmx:anePaqg_VYzaLEtpGC_9h5riEGbQ_ioJgnf5HUeJXI300im5DtSiLVy7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 19:31:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] die_for_incompatible_opts(): unbounded number of options
Date: Wed, 26 Aug 2026 16:31:50 -0700
Message-ID: <20260826233152.1703497-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-862-g3c6f97f7b9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have die_for_incompatible_optN() (for 2 <= N <= 4) to check and
complain when two or more among N mutually incompatible options are
used.

What should a developer do if there are more than four options that
cannot be used at once?

Introduce die_for_incompatible_opts(), which can handle an arbitrary
number of mutually exclusive options.  This is done in two steps:

 - The API for existing functions takes N pairs (for 2 <= N <= 4) of
   'int set, const char *name' parameters that signal which options
   are set.  This parameter order is inconvenient for varargs, where
   a sentinel value marks the end of the argument list (and there is
   no clear sentinel value of type 'int').  The first patch rewrites
   all implementations and callers of die_for_incompatible_optN() to
   swap the parameter order to pairs of 'const char *name, int set'.

 - The second patch then introduces die_for_incompatible_opts(),
   which takes an arbitrary number of 'const char *name, int set'
   pairs terminated by a NULL sentinel.

We could do without the first step and use the 'const char *, int'
order only in die_for_incompatible_opts(), leaving the traditional
die_for_incompatible_opt[234]() functions using the
'int, const char *' order, but using a consistent ordering is
likely easier in the long run.

 1/2: die_for_incompatible_optN: swap the order of arguments
 2/2: die_for_incompatible_opts(): accept more than four options

 builtin/add.c          |  6 +++---
 builtin/clone.c        |  8 ++++----
 builtin/commit.c       | 24 ++++++++++++------------
 builtin/difftool.c     |  6 +++---
 builtin/gc.c           |  8 ++++----
 builtin/grep.c         |  6 +++---
 builtin/log.c          |  6 +++---
 builtin/merge-tree.c   |  8 ++++----
 builtin/pack-objects.c | 21 ++++++++++-----------
 builtin/push.c         |  8 ++++----
 builtin/repack.c       | 12 +++++++-----
 builtin/replay.c       | 18 +++++++++---------
 builtin/rev-list.c     |  6 +++---
 builtin/show-ref.c     |  7 ++++---
 parse-options.c        | 26 ++++++++++++++------------
 parse-options.h        | 40 +++++++++++++++++++++++-----------------
 revision.c             | 26 +++++++++++++-------------
 17 files changed, 123 insertions(+), 113 deletions(-)

-- 
2.55.0-862-g3c6f97f7b9

