Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E653363
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590809; cv=none; b=aYMl2VFLgVr+PaKQdhtfwkpQ450Y4FuwMe/ZbP3DKFwPcDKDUlGvbp1aMfBSYz6U7YsrWRfYaLr39dkPfKffwIvm7XucVczb+SjcWjdO5zWePzSEQNkFZp5Xd4zJo3EQ3myYZqUOE1AfzbGJkn8J20YkvgE0MUBOyIXbm3MniZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590809; c=relaxed/simple;
	bh=WoxzIpUC6R1djduUf8jqhoW85EMVwT2mNUy4r0P6Uv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=YIpWYw8YEnbSVVPG3tGgZ3gDt01JzdYoBt44oOae+fb4yNg2MZOnyAxQD/l3FIxn0b4q14QWdSbY02SNPSHo1Yi65uBkhnRP1XUl6+P07lT/gOdNC9w3XD7+M5VYiWJ3I0FbjqJ6EPSzy6Apzht4CnUvWSsLxvXiaUwaZkLhlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mgGmSO0p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dl1LGwVQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mgGmSO0p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dl1LGwVQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B38712540135;
	Mon, 10 Mar 2025 03:13:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 03:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590806;
	 x=1741677206; bh=4HocIBe0T/GShWnR4/nL/oGCJFmOAnKvvgIXBsCspO4=; b=
	mgGmSO0pNhCqfCiTto9nUphAvZCcev4DITyfpItvXhoT0lRQ5q+g0kZQa+zKOX5N
	xbDil+sW4d0f8mRExN8SKxnB0l0ldrha/UOc5n++2dd2LfIHCg4M3t5ZsM50mR+6
	CiZUqVqhfr8m8Fn/ZMIGgtfwEwPFsc0o/0cn8YaiZVoGUzj+SpiQZEosc/qjbpef
	klGh6vCbOPy218y0WbtKG6WrBjIR7neTQP44prGo4D8ZOlAbQjhJzQxU5nWDhtmb
	xQvjojgrMOORdqwxfqMze7q+dJ8HxUqrh63XDYLvHgmlm9ogBq21eopxY8Ua6ID8
	i4f0upe1xmVcn30u0dpl+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590806; x=
	1741677206; bh=4HocIBe0T/GShWnR4/nL/oGCJFmOAnKvvgIXBsCspO4=; b=d
	l1LGwVQjtBs4f9iLr2XV/zGKnKdR3EkC3XqV5zcUjKu6z4SI8tj61tiQ8ArRpTnm
	8CgBqQikhvDiu6M7lVNVn6plEmIOZTpR7dSwoK8DeoznF+nY6rM/bUj2860iEAa3
	GTbvhYypiGpfNM/mSboXWIMmoh1408cBZ/BWp/zodyPLFLONn4hbYX9hNSS5cYxo
	RJLgPd3Ju1mGKTmJlylBowjSYw7lVCMlBsu/26UM8/27rTCPiqNeMlzPZTnI1Zjs
	/V/Pn599xV8oVwfwOPm69s591v2qCB6SKaOzgAHlMamNqxquQRhECXEbqQXZ2FIr
	CDF4q4M/ZSSIdleici6zA==
X-ME-Sender: <xms:FpHOZ8NFyUWF6DRMhPb3Rla0s0-is6PfWUOHyx_6dDXDmvgCj4XQGQ>
    <xme:FpHOZy8CGj3jOTzY2D999sXuuOz4N-rWyZcOGL3Ol8g2KaL1ee2U7MrQm1Q0xU-94
    XoFnRw81Lvi-q5Y6w>
X-ME-Received: <xmr:FpHOZzSAvR7MsWo9oA5iu9NvuNvXMx3MPoYM7ZXnfmrg0pY84XdCvHVav5U9-M4wf3omhoNX1T6UPoNLpzVN94LYkVNPHWI0Fw5uFooOKOTg5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FpHOZ0u6seQgSTVuJRCTs-4iPKFnqo3Gni0yRniuak8SvXXiDOKBWQ>
    <xmx:FpHOZ0d4cxCp9qr7b_wX91NiQ2Gf6r3dO28nwKVwGIZ4troQljI9IQ>
    <xmx:FpHOZ42clLMw1xHYUfvSt6AYHuSVzLmBfQ3HA1th2MVDcIybGFDNCA>
    <xmx:FpHOZ4_nhgWj0F5SlV2CY-75MKjaJmmP83zSq847F6RqRx9bFbEkQA>
    <xmx:FpHOZz450h2jEhgGshrVKXA-zF03NGp2-yZjjzL53sQxEcMxJS5yhLlq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8cbdc14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/12] Stop depending on `the_repository` in
 object-related subsystems
Date: Mon, 10 Mar 2025 08:13:19 +0100
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+RzmcC/43OwW7CMAwG4FdBOeMpjdOk7LT3QBxI6lBvglRJK
 JtQ330pOwxuPf6W/f2+i0yJKYv3zV0kmjhzvNSgtxvhh+PlRMB9zUJJ1UrVSHAaxq8M0X2SLxl
 uXIZ4LVAGgkRjzFxi+gHjjh3uumC9l6JaY6LA34+e/aHmgfOy96idmmX614ASVzZMDUjwbd9rD
 EpbQx/16I3PYuEn9UyataSqZEBtWlTWkdm9kPhM2rUkVtI674OWncXm/8t5nn8Bcwx8oH0BAAA
 =
X-Change-ID: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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

Changes in v2:
  - Point out why t1050 had to be adapted.
  - Drop the rename of `get_max_object_index()` and
    `get_indexed_object()`.
  - Fix a couple of commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im

Changes in v3:
  - Fix a semantic conflict with an in-flight patch series.
  - Link to v2: https://lore.kernel.org/r/20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im

Changes in v4:
  - Fix indentation in one of the commit messages.
  - Link to v3: https://lore.kernel.org/r/20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im

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
 builtin/ls-files.c                           |   3 +-
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
 87 files changed, 677 insertions(+), 613 deletions(-)

Range-diff versus v3:

 1:  01b5b16c3a4 =  1:  9d65ce9a2f2 csum-file: stop depending on `the_repository`
 2:  14e0349be2f =  2:  038c6e54308 object: stop depending on `the_repository`
 3:  9c7b8a031cc =  3:  9abd1306d6a pack-write: stop depending on `the_repository` and `the_hash_algo`
 4:  e0168b431e7 =  4:  605fb2a7176 environment: move access to "core.bigFileThreshold" into repo settings
 5:  529f296a935 =  5:  dc88e5ca6b2 pack-check: stop depending on `the_repository`
 6:  d4a2e9a7861 =  6:  fee92049913 pack-revindex: stop depending on `the_repository`
 7:  15e4d4de519 =  7:  f8ff74c83cf pack-bitmap-write: stop depending on `the_repository`
 8:  576d846495f =  8:  47547d3f566 object-file-convert: stop depending on `the_repository`
 9:  faf0f90a005 =  9:  39da917072f delta-islands: stop depending on `the_repository`
10:  b37879d101c = 10:  a509d63ee74 object-file: split out logic regarding hash algorithms
11:  4a1a5c67792 = 11:  421f1e96595 hash: fix "-Wsign-compare" warnings
12:  f45a7866d03 ! 12:  1b0b8f71125 hash: stop depending on `the_repository` in `null_oid()`
    @@ Commit message
             object in the superproject, and consequently we need to use its hash
             algorithm.
     
    -    This means that we could in theory just not bother about this edge case
    -    at all and just use `the_repository` in "diff-no-index.c". But doing so
    -    would feel misdesigned.
    +        This means that we could in theory just not bother about this edge
    +        case at all and just use `the_repository` in "diff-no-index.c". But
    +        doing so would feel misdesigned.
     
         Remove the `USE_THE_REPOSITORY_VARIABLE` preprocessor define in
         "hash.c".

---
base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0

