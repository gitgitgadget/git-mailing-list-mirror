Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F9356A3C
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990464; cv=none; b=PGd8mmu1lenfbYsc8nu06PojDc5lhZb6x8JQMx33P8DAcnanzFJDMhCmlTjLyOhajBM23o95KQ4b0ItqIRsX+7mjT/8SXTnBGmMWKLvNidbxe+OwZTdphjrfRXcBwMx8APMQ9mkG3IW9t9UzkPG1gsLM7qZ3tM62+RwrHCxmR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990464; c=relaxed/simple;
	bh=3GuU0Pfkdo/HeFjtjrWNRTzoMv5d8JNgx2axr20G62s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ThjDeYWyUw3s+k8FInxup3zc7UkpqzAPjt4qR+jjFFM675mci7vkgPMlp4+0GNCPaIfDHRh2/ys+vqdus8EtprFrlVgldgJ30P9nrAB6JyIhGloZexzwhMfgT7wvgUfO0k2CxLlZRO2qQREyQecFSBO0ccOeDhE7qiqEK7fXsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KlpTv7zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSnlCycF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KlpTv7zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSnlCycF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50BB7140026D;
	Fri, 20 Mar 2026 03:07:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 03:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990462;
	 x=1774076862; bh=6pe082Hcn2Qt5+L0T5FeUb1+ELDesR+a2N2cXtmxJ/0=; b=
	KlpTv7zl6uY2iH/8SguW+7wZg5H8lpWHA4iqdJqp5DJzLHn7ZppXojCMYbUxcYMy
	E0dh+uEQSAu26tFIKtiycXUggDz6MSAz+fGDeqv571txHmBn6bgx4e59K/H9ks1b
	B+EZi0qhB3a6fjvMCV134AlWCRThZiuy9BaaBKa5+IifyLVn6LI3bvpUETmm4KF1
	OVK54n+Wy3SqEN0rffwdSe9zbE0z1s0N71+cGmxjp+0BG3DhlBCHth+xACqnQjZy
	EtiGlD8bKHHMsoe0edLiuw2hn7+4NVG4soSga3Q06IiXYDFaJknsI+7kvtyq+kOq
	Lja8IS5WB/c8w5CMCmp44A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990462; x=
	1774076862; bh=6pe082Hcn2Qt5+L0T5FeUb1+ELDesR+a2N2cXtmxJ/0=; b=P
	SnlCycF80FswuOvlGiwSK34bhh+EXgFdl8BbpInl/cGCc2JD74GjUHt8NziDXT08
	xclYeEXJ9NIneEwMKVDExWrF4xg7qaS1RTuE0529PA9mbooCL3/ArTh0On5XBpqs
	xvNKrEUSDIbe9SOR4DyIpTzoRjdR/xxzsNRVWkhZQWs4qV3qWGtexk0AhDtW+nM+
	Tx3fKetkMDdRYwejMJOnEmnnDiAMWILA2UkXdpK0SX3MocNTay4/CkXqfR810SYg
	+/MtiHyAZdPwuPfG2J9Db6Ebs7RVwN8Zjr32wn4s2tJl/sPQj7JRNnpnnKBvdQgJ
	wj3GOlYr1vstCsWG55xpg==
X-ME-Sender: <xms:PvK8aUDjycQeoCsTFIuM4zHXrywiagNnyQmZpNCykM-AiPiURgIsgA>
    <xme:PvK8ad8589ykO4BC3QuugCgn8CpKXgT0HPPcXTUfRRy2cALJAaZ3Xn1EpmCrU481d
    2GjOuNznpcDcblhmzUcsSl6C1Q0yL3sgVq_p9b9Lqc5cPLL4p1_zM4>
X-ME-Received: <xmr:PvK8aU8GoIn4DYJNdEv53qiPkuFrzYXd1hBHWlbSxPRGmEZQhtIKr5vaZHG1Na26Lu6yPYfQzSyqM21wloXRJeUePPsXgvVsFBAA51Fka-7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetkeelkeeuueevkeeufeegvdfhueeilefgtdegteeifeehkedvhfduvdekvdehvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:PvK8aUctbJpNpGvflTv6j1UW6VS2d2OuUQ7gv7j7Zqd_aWiSBF46eA>
    <xmx:PvK8adGMkqqDwwcI_rqPCpHpt6tKxLZxtDu6Ln05d7SU1H5RJ7HMLw>
    <xmx:PvK8aSc8J2SnOt54haNd7xB66T2aNbc18qEOs0U_fF6nTxi2bFZgaQ>
    <xmx:PvK8aXGwhpg2_G6Nc5XUrT33LahmYeYNnhDIeM_BUew9wLvTjFxN7w>
    <xmx:PvK8ad9QeWbuVOcVM84ieCA7lE2KwJzTrRMNbyQX7Tt2gWYrlkl2l7i1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85ef5c93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/14] odb: generic object name handling
Date: Fri, 20 Mar 2026 08:07:26 +0100
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/yvGkC/3WNwQrCMBBEf6Xs2ZVk24r15H9ID9lktYtoSqJFK
 f13Y8GjxzfMvJkhS1LJcKhmSDJp1ngvQJsK/ODuF0ENhYEM7Uxta+QGx2vGGBhzfCYv6JjLEt2
 +8a0lIvYOynxMctbXqj71hQfNj5je69Nkv+lP2v2XThYNtiEIu0AdsTmW3lZv0C/L8gEoUxUIv
 QAAAA==
X-Change-ID: 20260313-b4-pks-odb-source-abbrev-a84c51222bca
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series refactors handling of object names to become pluggable
and thus generic. This includes:

  - Disambiguation of object names with a common prefix. This is
    required to list candidate objects in case the user has passed a
    non-unique prefix.

  - Abbreviating an object ID to the shortest prefix required while
    staying unique.

The logic to compute these operations is specific to the backend, but
not generic. This patch series fixes that by moving the functionality
into the respective backends.

This patch series may feel somewhat unexiting, but it's not. Especially
abbreviating object IDs is done in lots of places, so this functionality
is overall quite critical. So starting with this series, it is now
possible to do all kinds of local work with an alternative backend:
git-commit(1), git-log(1), git-rev-parse(1), git-merge(1) and many other
commands now work as expected. My MongoDB proof of concept [1] only
requires two commits (the object format extension) on top. And no, I
don't endorse MongoDB or propose it as a future potential backend. It
simply had a good C API that was easy to use.

Of course, other functionality, especially everything that involves
packfiles, doesn't yet work.

This patch series is built on top of ca1db8a0f7 (The 17th batch,
2026-03-16) with ps/object-counting at 6801ffd37d (odb: introduce
generic object counting, 2026-03-12) merged into it.

Changes in v2:
  - Document `cb_iter` callback.
  - Fix left-over conversion of `odb_source_loose_for_each_object()`.
  - commit message typo fixes.
  - Link to v1: https://lore.kernel.org/r/20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/454

---
Patrick Steinhardt (14):
      oidtree: modernize the code a bit
      oidtree: extend iteration to allow for arbitrary return codes
      odb: introduce `struct odb_for_each_object_options`
      object-name: move logic to iterate through loose prefixed objects
      object-name: move logic to iterate through packed prefixed objects
      object-name: extract function to parse object ID prefixes
      object-name: backend-generic `repo_collect_ambiguous()`
      object-name: backend-generic `get_short_oid()`
      object-name: merge `update_candidates()` and `match_prefix()`
      object-name: abbreviate loose object names without `disambiguate_state`
      object-name: simplify computing common prefixes
      object-name: move logic to compute loose abbreviation length
      object-file: move logic to compute packed abbreviation length
      odb: introduce generic `odb_find_abbrev_len()`

 builtin/cat-file.c       |   7 +-
 builtin/pack-objects.c   |  12 +-
 cbtree.c                 |  21 ++-
 cbtree.h                 |  17 +-
 commit-graph.c           |   5 +-
 hash.c                   |  18 ++
 hash.h                   |   3 +
 object-file.c            |  76 ++++++++-
 object-file.h            |  21 ++-
 object-name.c            | 437 ++++++++---------------------------------------
 odb.c                    |  99 ++++++++++-
 odb.h                    |  39 +++++
 odb/source-files.c       |  33 +++-
 odb/source.h             |  30 +++-
 oidtree.c                |  65 +++----
 oidtree.h                |  48 +++++-
 packfile.c               | 297 +++++++++++++++++++++++++++++++-
 packfile.h               |   7 +-
 t/unit-tests/u-oidtree.c |  18 +-
 19 files changed, 782 insertions(+), 471 deletions(-)

Range-diff versus v1:

 1:  5ce8cced1e =  1:  755acf126c oidtree: modernize the code a bit
 2:  26c4377ff1 !  2:  6ab9e5d41c oidtree: extend iteration to allow for arbitrary return codes
    @@ cbtree.h: static inline void cb_init(struct cb_tree *t)
      struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
      
     -typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
    ++/*
    ++ * Callback invoked by `cb_each()` for each node in the critbit tree. A return
    ++ * value of 0 will cause the iteration to continue, a non-zero return code will
    ++ * cause iteration to abort. The error code will be relayed back from
    ++ * `cb_each()` in that case.
    ++ */
     +typedef int (*cb_iter)(struct cb_node *, void *arg);
      
     -void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
 3:  da7b74b572 !  3:  9caf0288e4 odb: introduce `struct odb_for_each_object_options`
    @@ Commit message
         a subsequent commit we'll want to change object iteration to also
         support iterating over only those objects that have a specific prefix.
         While we could of course add the prefix to the function signature, or
    -    alternative introduce a new function, both of these options don't really
    -    seem to be that sensible.
    +    alternatively introduce a new function, both of these options don't
    +    really seem to be that sensible.
     
         Instead, introduce a new `struct odb_for_each_object_options` that can
         be passed to a new `odb_for_each_object_ext()` function. Splice through
    @@ object-file.c: int odb_source_loose_for_each_object(struct odb_source *source,
      		return 0;
      
      	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
    +@@ object-file.c: int odb_source_loose_count_objects(struct odb_source *source,
    + 		*out = count * 256;
    + 		ret = 0;
    + 	} else {
    ++		struct odb_for_each_object_options opts = { 0 };
    + 		*out = 0;
    + 		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
    +-						       out, 0);
    ++						       out, &opts);
    + 	}
    + 
    + out:
     
      ## object-file.h ##
     @@ object-file.h: int odb_source_loose_for_each_object(struct odb_source *source,
 4:  e4dedd4686 =  4:  232bcf662e object-name: move logic to iterate through loose prefixed objects
 5:  7f9bfca9fd =  5:  be9b546c67 object-name: move logic to iterate through packed prefixed objects
 6:  3eb88fa774 =  6:  60672e6cd1 object-name: extract function to parse object ID prefixes
 7:  8fa16eb02a !  7:  38032fee38 object-name: backend-generic `repo_collect_ambiguous()`
    @@ Commit message
         to do is to enumerate objects that have such a prefix and then append
         those objects to a `struct oid_array`. This can be trivially achieved
         in a generic way now that `odb_for_each_object()` has learned to yield
    -    only objects that much such a prefix.
    +    only objects that match such a prefix.
     
         Refactor the code to use the backend-generic infrastructure instead.
     
 8:  0b0ce71bdd =  8:  98af219ca1 object-name: backend-generic `get_short_oid()`
 9:  74733d34de =  9:  12866c582b object-name: merge `update_candidates()` and `match_prefix()`
10:  2ca53a01d4 = 10:  6b4eda123a object-name: abbreviate loose object names without `disambiguate_state`
11:  a391911854 = 11:  7aa921504b object-name: simplify computing common prefixes
12:  9ad66df1ca = 12:  d1bf2706f8 object-name: move logic to compute loose abbreviation length
13:  cf8a33ab67 = 13:  e59e7dffb4 object-file: move logic to compute packed abbreviation length
14:  acd07686db = 14:  726be6de40 odb: introduce generic `odb_find_abbrev_len()`

---
base-commit: b052aca69d64d2d8e28e7ce97dcb1beb3d94515a
change-id: 20260313-b4-pks-odb-source-abbrev-a84c51222bca

