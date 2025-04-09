Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7A1B6CE4
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240209; cv=none; b=NlS1g9ZMAjxhuSJTbdMixhF2914oRyLodNotJDtq/002dZdwhg9nABhBveu/vUm3NaNMNoGhkwnnsTbnHlG7aniDLgiHI4TOC7Hrx4y01mQpgG/krRI5MLFG42KT6cpELuZZxuxYJWA9xE2qoThm9kqKCshn5BDqF3FT0w/fhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240209; c=relaxed/simple;
	bh=c9JzMSA0OSOWKvB9f5dbKEVF7v2GCady/5VwsOACd5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIFf/euIOZoABtLn8TF9TsrgRIjNUDM+dQkzBePZwj7mCLPPlsw6e/bCs3X/oT8vBF1xtSdgF/RB3kv1ZqQzPeyFHYMqkBLUTerGIDljKdfSjWhprNDnhY9u/Hw7/SLIuvFIjgf+Xcn+QekzzXuTKX2jA7oHXGYjRO8QclrziY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HJ2cVWBy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7qYm9GG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HJ2cVWBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7qYm9GG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2748D11400F7;
	Wed,  9 Apr 2025 19:10:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 09 Apr 2025 19:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1744240205; x=1744326605; bh=G/6U3t/1jvnsfdkExWahR4Rh7vohj+8n
	Bp6B56ChJeM=; b=HJ2cVWBysmdzaQessgLdGyU/7/0KrJDmpMRc+QSpOJVzGCzV
	cbF3speq04TQmtozrFJTJ4rorHKtkLCEOKKxyQNDUNJpXzGALD6eHwMSrXWRhq2W
	tYGrTsEB2l1qCU6JXVMOBQrGtAxmXv80FCvYciLiqZGqmqh0+0QeY7a4hZ2lLVUY
	pc2qL3CPovXEZzl/r3wrjXzjaPAx4jFLqtHmkwBoXZ9jt/SyY9fsYNS1QXGg1FIr
	Ms6UXVu6L2UDS7iMZKNcczbNdZlykSxw8+gS76DZa2tRIDf5lDudfhuMsoTTkVBY
	ReT9KupVGODXRIyb9GwPmvgt8ZrmoCeKXG96cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744240205; x=
	1744326605; bh=G/6U3t/1jvnsfdkExWahR4Rh7vohj+8nBp6B56ChJeM=; b=d
	7qYm9GG8ilelK4bRXrwipsTBuk0jm7j8QnZSo914nRq47J4llXJtelTBBDCXwOJZ
	wO7t7/kM7+y+/JgM3LiYp8b4jX1B5d1TuNtLH1ZzyOf1eIX0+4UCMevwc+luRfpt
	K0dXGTJUQOJ+T2QylIINZF4VGZyPbtW/MhPUNszy7jMUm4YFeDikUHbKPhCtaw+G
	UaWBrnlLuN8eg9PGStNxSDSLTkn0Ek+xEplRpH2HBKCdFu6s7gMIUMBKNfpqzRTM
	l84W5hxBg81ZBzUbfk5+zvZSvQKZGdxm4bnCEzUkvDlSq54dgsYs++tsBCX8PGfy
	O51uLicWhUY5kcnsVo71Q==
X-ME-Sender: <xms:S_72Z2OhV2jWlk4p5tzEp14gDxCQw02zqNy8WzJDLTAfiYmX78HlHw>
    <xme:S_72Z0_FiBEeWmE4I4G2i84ewb_Yu7-88gou3Mv-nl_hT3rUFau89-rrsPzfX6Upi
    PWelFQ8u7oFThpuBQ>
X-ME-Received: <xmr:S_72Z9RUtbY7X90a3niWGQgY4MKsfDFCdCDgu4CyDgjGpJ0ZoqKt6CX6BSmtkHt8SE_5ZkjZ79S3utzNugYqHI9N0w3wKc4mt4Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepjefhgfefvdekfedthfejgeffieevieeifeeg
    ueeihfejleeufeffjeetkeffffejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhrghtvggrrhhnrghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhesjhhohhhnshgvnhdrnhhopdhrtg
    hpthhtoheptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:S_72Z2sCvwUQyf1r3GZd8i5i1D5WHpBycPcsO7tv4F-iFBfmi3M8HQ>
    <xmx:S_72Z-ftZ09zooyWQ6MppgotvSyvC3MWRoiYJeHaOmvcSz-Os9DpfQ>
    <xmx:S_72Z61x2FITkYB-e5Qf_EsmPxI5SBXC-L45Jli0BbEVAnz9-k-usg>
    <xmx:S_72Zy9mYwBMzmQ8sL_fY0WN1QIWeJUh-MRhgvjvoEfQ438UrOjXZQ>
    <xmx:TP72ZwSt8HwZvK8PO4aplU36GPA0dGgu4bTh7Us70aJuOqWodJov8CXF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 19:10:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Arnav Bhate <bhatearnav@gmail.com>,
    Christian Fredrik Johnsen <christian@johnsen.no>,
    =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Karthik Nayak <karthik.188@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: "What's cooking" interim report
Date: Wed, 09 Apr 2025 16:10:00 -0700
Message-ID: <xmqqy0w9orsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since the issue #02 of this month, a handful of topics have been
picked up, a few topics have been replaced by their newer
iterations, a topic that is already in 'next' gained an additional
commit on top, and a topic got its description extended.

--------------------------------------------------
Born topics

[New Topics]

 * kn/bundle-dedup-optim (2025-04-08) 2 commits
  - bundle: fix non-linear performance scaling with refs
  - t6020: test for duplicate refnames in bundle creation

  Optimize the code to dedup references recorded in a bundle file.

  Will merge to 'next'?
  source: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>

 * kn/meson-hdr-check (2025-04-08) 4 commits
  - meson: add support for 'headers-check'
  - meson: move headers definition from 'contrib/coccinelle'
  - coccinelle: meson: rename variables to be more specific
  - Merge branch 'es/meson-build-skip-coccinelle' into kn/meson-hdr-check

  Add an equivalent to "make hdr-check" target to meson based builds.

  Getting there.
  cf. <xmqqsemiuwhx.fsf@gitster.g>
  source: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>

 * ps/object-file-cleanup (2025-04-08) 10 commits
  - object-store: merge "object-store-ll.h" and "object-store.h"
  - object-store: remove global array of cached objects
  - object: split out functions relating to object store subsystem
  - object-file: split out functions relating to index subsystem
  - object-file: split up concerns of `HASH_*` flags
  - object-file: split out functions relating to object store subsystem
  - object-file: move `xmmap()` into "wrapper.c"
  - object-file: move `git_open_cloexec()` to "compat/open.c"
  - object-file: move `safe_create_leading_directories()` into "dir.c"
  - Merge branch 'ps/object-wo-the-repository' into ps/object-file-cleanup
  (this branch uses ps/object-wo-the-repository.)

  Code clean-up.

  Will merge to 'next'?
  cf. <xmqqsemiteot.fsf@gitster.g>
  cf. <CABPp-BFv_WGVUexyQBHkCcyO0N+UQCcJ3eM9Oh6bP_ZCUkaxLw@mail.gmail.com>
  source: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>

 * ab/environment-clean-header (2025-04-09) 1 commit
  - environment.h: remove unused variables

  Code clean-up.

  Will merge to 'next'.
  source: <2c547567-2b72-476c-9fc5-71cac050fa15@gmail.com>

 * cj/refname-avail-check-optim-typofix (2025-04-09) 1 commit
  - refs: fix duplicated word in comment

  Comment fix.

  Will merge to 'next'.
  source: <pull.1940.v2.git.git.1743857867327.gitgitgadget@gmail.com>

 * dd/sparse-glibc-workaround (2025-04-09) 1 commit
  - sparse: ignore warning from new glibc headers

  Squelch false-positive from sparse.

  Will merge to 'next'.
  source: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>

 * js/ci-github-update-ubuntu (2025-04-09) 1 commit
  - ci: upgrade `sparse` to supported build agents

  Adjust to the deprecation of use of Ubuntu 20.04 GitHub Actions CI.

  Will merge to 'next'.
  source: <77f82414-261c-d2bc-f911-ed3d4b06c86e@gmx.de>

 * ps/refname-avail-check-optim (2025-04-09) 1 commit
  - refs/packed: fix BUG when seeking refs with UTF-8 characters

  Incorrect sorting of refs with bytes with high-bit set on platforms
  with signed char led to a BUG, which has been corrected.

  Will merge to 'next'.
  cf. <20250404205740.GA780449@coredump.intra.peff.net>
  source: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>

 * rj/build-tweaks (2025-04-09) 13 commits
  - config.mak.uname: set CSPRNG_METHOD to getrandom on Linux
  - config.mak.uname: add arc4random to the cygwin build
  - config.mak.uname: add sysinfo() configuration for cygwin
  - builtin/gc.c: correct RAM calculation when using sysinfo
  - config.mak.uname: add clock_gettime() to the cygwin build
  - config.mak.uname: add HAVE_GETDELIM to the cygwin section
  - config.mak.uname: only set NO_REGEX on cygwin for v1.7
  - config.mak.uname: add a note about NO_STRLCPY for Linux
  - Makefile: remove NEEDS_LIBRT build variable
  - meson.build: set default help format to html on windows
  - meson.build: only set build variables for non-default values
  - Makefile: only set some BASIC_CFLAGS when RUNTIME_PREFIX is set
  - meson.build: remove -DCURL_DISABLE_TYPECHECK

  Various build tweaks, including CSPRNG selection on some platforms.

  Comments?
  source: <cover.1743859985.git.ramsay@ramsayjones.plus.com>

--------------------------------------------------
Other topics that had seen changes.

[Cooking]

 * pb/status-rebase-fixes (2025-03-28) 4 commits
  - wt-status: suggest 'git rebase --continue' to conclude 'merge' instruction
  - wt-status: also abbreviate 'merge' and 'fixup -C' lines during rebase
  - SQUASH??? - <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
  - rebase -r: do create merge commit after empty resolution
 
- A few fixes around "git status" while "git rebase" is running.
+ A few fixes around "git status" while "git rebase" is running,
+ plus a corner case bug fix for "git rebase -r".
 
- Comments?  It probably deserves a clarifying reroll.
+ Expecting a (small and hopefully final) clarifying reroll.
  cf. <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
+ cf. <e9700234-324d-dc63-d91e-9b8f36fabc79@gmail.com>
  source: <pull.1897.git.1743181401.gitgitgadget@gmail.com>

-* ua/update-update-server-info (2025-03-29) 1 commit
+* ua/update-update-server-info (2025-04-08) 1 commit
  - builtin/update-server-info: remove unnecessary if statement
 
- Expecting a (hopefully minor and final) reroll.
- cf. <xmqqa58snf9c.fsf@gitster.g>
- source: <20250329120327.105925-2-usmanakinyemi202@gmail.com>
+ Code simplification.
+
+ Will merge to 'next'.
+ source: <20250407195850.299348-2-usmanakinyemi202@gmail.com>

-* en/merge-recursive-debug (2025-04-07) 8 commits
+* en/merge-recursive-debug (2025-04-08) 8 commits
  - builtin/{merge,rebase,revert}: remove GIT_TEST_MERGE_ALGORITHM
  - tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
  - merge-recursive.[ch]: thoroughly debug these
  - merge, sequencer: switch recursive merges over to ort
  - sequencer: switch non-recursive merges over to ort
  - merge-ort: enable diff-algorithms other than histogram
  - builtin/merge-recursive: switch to using merge_ort_generic()
  - checkout: replace merge_trees() with merge_ort_nonrecursive()
 
- Expecting a reroll.
- cf. <CABPp-BGN2JCt9BJ0wQqtgNLhD6Qf19PMzYWpjgpJ6O2OcyRCXg@mail.gmail.com>
- source: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
+ Remove remnants of the recursive merge strategy backend, which was
+ superseded by the ort merge strategy.
+
+ Will merge to 'next'.
+ source: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>

-* jk/fetch-follow-remote-head-fix (2025-03-18) 3 commits
+* jk/fetch-follow-remote-head-fix (2025-04-09) 4 commits
+ - fetch: make set_head() call easier to read
   (merged to 'next' on 2025-04-07 at ba5ac342a5)
  + fetch: don't ask for remote HEAD if followRemoteHEAD is "never"
  + fetch: only respect followRemoteHEAD with configured refspecs
  + Merge branch 'jk/fetch-ref-prefix-cleanup' into jk/fetch-follow-remote-head-fix
 
  "git fetch [<remote>]" with only the configured fetch refspec
  should be the only thing to update refs/remotes/<remote>/HEAD,
  but the code was overly eager to do so in other cases.
 
- Will merge to 'master'.
+ Will merge to 'next' and then to 'master'.
  cf. <Z9n7myvpnDOWFWqt@nand.local>
  source: <20250318053905.GA2051217@coredump.intra.peff.net>
