Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C818CC1D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284319; cv=none; b=SD/aVdCidT0QLMp4/LT/b6zA3DRRGl5CoaNsox+B+27J3Bc6pyW0qnwptW2thRX5G1dSnqObSsB1gBy1OBMMIujV8cgX6SSVvixWSEvgX734P6sDf29P9JUPKDfD3wyE7i7oWa2ftfpFZ0Z0h+F4PIcPaQ/YNGyCBgymRxbHkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284319; c=relaxed/simple;
	bh=S91+9k2JA0acA6OwHsgv6gr9TzHi79A2l1JT36+xBQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bQ47MjA8oXTYrF4cEuSAX3//4yg+FmF2CPTOwdgJVWULJThwe50iXseALWJxysg6y3CohLQlXXx/O+vTSXlqy5GJaBWQ0DY/0MjHs55ycCxOc6YUt0o+0dj03inIUQxjzdAUkcE+h8wVF6y5Jf9gPMBY0NEfovFEjSrt0G3d3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2rQ7yyEN; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2rQ7yyEN"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2974743675so2444716276.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729284315; x=1729889115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIr2qYuj02r0hGlEkzIzJlHamH6KZb9647YgqBkUITA=;
        b=2rQ7yyENUojrBSDJ3IpY8N8tUllwxFwp63u5+VPDgDlomareG/dZ/95mE6wcY5FvwG
         LzYR3etTh/IvUAS8DoFwjYy7wRiQvzbC8x7kuqK9YgvPSQlttWU9nTQXKZcg7QxUWY/c
         jw/7Xgk80FtG12hdWiQxzM/zA2u+lvzezKA3txP2ZH7dt8qFRaDsL5nlD8Ph0XOQZePe
         agLdrejy+ZFjbGLQnEVwiyeG6zpf7LpgUZ/bedbZxaWipcZB9L82RD4TLigykvdrr8TG
         n9BSvw07OHfK32bSysBP/yi/sMWMu/hCZi0ujyPUtVchbm9cBaHtSWIxQTKvnBAl9T7a
         u3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729284315; x=1729889115;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIr2qYuj02r0hGlEkzIzJlHamH6KZb9647YgqBkUITA=;
        b=qZW5XLdwo03YN+0bU28eOXuhug5MOxwbJCaCwe+8Pnb9ZwrWjz7u+T0oRKwQCUbxoJ
         kuKNZP7dDFvwdFoC+Ox+N3c5jwzSNuea+zUOyAyVZSnj34KnAW1zrKcxO+6lBmAKtbu4
         RAGzrferxnzqrzp/3+WfsLvzmRreUenQS/jPHGyNcN2QSphaTDsR76tNYFQHJFckNxlI
         fWCt6vv4HN5v4RaiVAYkseJFGTxaHxCdpaLJLUlE8KiiwK2XvJUFgxqEOcjpJ9CoVH9Y
         W3fuoI+X6w/qUMxJiwS207a/dBrCPO9vf8V1YkMVkxBEtPml9i5ztOJZNfBFHG4J+UiZ
         +pNg==
X-Gm-Message-State: AOJu0Yyjnbpv3iZv/MYhA4hTa+HoTRYEMFTiq9c4GQhhx/nfBiu8uuEZ
	USp4VNn1ekZEHsbpbPbu8ZPyu1SakCpVWxSxY4KXxnKGF+XeFmhT6vTF7OXvdWXQoj57ZOA8EtT
	m
X-Google-Smtp-Source: AGHT+IEpNvXQwMwuaezu7bI29g/k11NqQX/9d3qrKcbY/VAFAXHVdHBZP19e+2NHIc1eHTdpcPTDOA==
X-Received: by 2002:a05:6902:218d:b0:e25:d900:a0f8 with SMTP id 3f1490d57ef6-e2bb16972femr3686726276.43.1729284314290;
        Fri, 18 Oct 2024 13:45:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb020a76asm450221276.18.2024.10.18.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:45:13 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:45:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2024, #09; Fri, 18)
Message-ID: <ZxLI06smvMuf/cT2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-master-at: 34b6ce9b30747131b6e781ff718a45328aa887d0
X-next-at: 1226f6d8faf60d03cbb3b021c68d48364bf67ac0

What's cooking in git.git (Oct 2024, #09; Fri, 18)
--------------------------------------------------

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

This is the second integration round from the interim maintainer. Some
more topics which were marked to graduate to 'master' have done so,
and 'next' has some new topics that have moved down. A large handful
of topics are awaiting review or discussion, so please take a look at
those marked as such below.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	https://github.com/git/git/

(Note that other usual spots are not updated while Junio is on
vacation, including the below):

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/ttaylorr/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* aa/t7300-modernize (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at e3a8d7f6c4)
 + t7300-clean.sh: use test_path_* helper functions for error logging

 Test modernization.

 source: <pull.1811.v4.git.1728498122419.gitgitgadget@gmail.com>


* jc/doc-refspec-syntax (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at 912ed5fae8)
 + doc: clarify <src> in refspec syntax

 Doc updates.

 source: <xmqqy137wtyz.fsf@gitster.g>


* kh/checkout-ignore-other-docfix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at ed66b60f52)
 + checkout: refer to other-worktree branch, not ref

 Doc updates.

 source: <fcfbcd3868bda75dd0463e04739047e74d239d32.1728585467.git.code@khaugsbakk.name>


* kh/merge-tree-doc (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at b22c213d6c)
 + doc: merge-tree: improve example script

 Docfix.
 cf. <CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
 source: <c7e0d76e71eef56c6279e0f7e82a2d194f78d2a4.1728492617.git.code@khaugsbakk.name>


* kn/loose-object-layer-wo-global-hash (2024-10-09) 1 commit
  (merged to 'next' on 2024-10-11 at 99252fb6cc)
 + loose: don't rely on repository global state

 Code clean-up.

 source: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>


* ng/rebase-merges-branch-name-as-label (2024-10-09) 3 commits
  (merged to 'next' on 2024-10-11 at a5785fd206)
 + rebase-merges: try and use branch names as labels
 + rebase-update-refs: extract load_branch_decorations
 + load_branch_decorations: fix memory leak with non-static filters

 "git rebase --rebase-merges" now uses branch names as labels when
 able.

 source: <pull.1784.v3.git.git.1728460700.gitgitgadget@gmail.com>


* ps/maintenance-start-crash-fix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at c54df41815)
 + builtin/gc: fix crash when running `git maintenance start`

 "git maintenance start" crashed due to an uninitialized variable
 reference, which has been corrected.

 source: <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>


* tc/bundle-uri-leakfix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at 07ac214952)
 + bundle-uri: plug leak in unbundle_from_file()

 Leakfix.

 source: <20241010091249.1895960-1-toon@iotcl.com>


* xx/protocol-v2-doc-markup-fix (2024-10-10) 1 commit
  (merged to 'next' on 2024-10-11 at 37932adca4)
 + Documentation/gitprotocol-v2.txt: fix a slight inconsistency in format

 Docfix.

 source: <pull.1807.git.git.1728566443089.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* ak/typofix (2024-10-17) 1 commit
 + t: fix typos

 More typofixes.

 source: <20241017112835.10100-1-algonell@gmail.com>


* jc/optional-path (2024-10-14) 3 commits
 - parseopt: values of pathname type can be prefixed with :(optional)
 - config: values of pathname type can be prefixed with :(optional)
 - t7500: make each piece more independent

 Teach configuration values of type "pathname" a new ':(optional)'
 suffix.

 source: <20241014204427.1712182-1-gitster@pobox.com>


* kh/update-ref (2024-10-16) 6 commits
 - doc: mutually link update-ref and symbolic-ref
 - doc: update-ref: discuss symbolic links
 - doc: update-ref: remove confusing paragraph
 - doc: update-ref: demote symlink to last section
 - doc: update-ref: remove safety paragraphs
 - doc: update-ref: drop “flag”

 Documentation updates to 'git-update-ref(1)'.

 source: <cover.1729017728.git.code@khaugsbakk.name>


* ps/ref-filter-sort (2024-10-17) 1 commit
 - ref-filter: format iteratively with lexicographic refname sorting

 Teaches the ref-filter machinery to recognize and avoid cases where
 sorting would be redundant.

 Will merge to 'next'?
 source: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>


* sk/msvc-warnings (2024-10-17) 1 commit
 + mingw.c: Fix complier warnings for a 64 bit msvc

 Fixes compile time warnings with 64-bit MSVC.

 source: <20241017171820.2679-2-soekkle@freenet.de>

--------------------------------------------------
[Cooking]

* am/git-blame-ignore-revs-by-default (2024-10-14) 2 commits
 - blame: introduce --override-ignore-revs to bypass ignore revisions list
 - blame: respect .git-blame-ignore-revs automatically

 Teaches 'git blame' to treat '.git-blame-ignore-revs' as if it were
 passed as '--ignore-revs-file' by default.

 source: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>


* kn/ci-clang-format-tidy (2024-10-14) 3 commits
 - clang-format: don't align expressions after linebreaks
 - clang-format: align consecutive macro definitions
 - clang-format: re-adjust line break penalties

 Updates the '.clang-format' to match project conventions.

 source: <cover.1728697428.git.karthik.188@gmail.com>


* la/trailer-info (2024-10-14) 1 commit
 - trailer: spread usage of "trailer_block" language

 Refactoring.

 source: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>


* ps/cmake-clar (2024-10-15) 3 commits
 - cmake: set up proper dependencies for generated clar headers
 - cmake: fix compilation of clar-based unit tests
 - Makefile: extract script to generate clar declarations

 Buildfix for unit tests when using CMake.

 source: <cover.1728985514.git.ps@pks.im>


* ps/platform-compat-fixes (2024-10-16) 10 commits
 - http: fix build error on FreeBSD
 - builtin/credential-cache: fix missing parameter for stub function
 - t7300: work around platform-specific behaviour with long paths on MinGW
 - t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 - t3404: work around platform-specific behaviour on macOS 10.15
 - t1401: make invocation of tar(1) work with Win32-provided one
 - t/lib-gpg: fix setup of GNUPGHOME in MinGW
 - t/lib-gitweb: test against the build version of gitweb
 - t/test-lib: wire up NO_ICONV prerequisite
 - t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE

 Various platform compatibility fixes split out of the larger effort
 to use Meson as the primary build tool.

 Will merge to 'next'?
 source: <cover.1729060405.git.ps@pks.im>


* ps/reftable-strbuf (2024-10-17) 10 commits
 - reftable: handle trivial `reftable_buf` errors
 - reftable/stack: adapt `stack_filename()` to handle allocation failures
 - reftable/record: adapt `reftable_record_key()` to handle allocation failures
 - reftable/stack: adapt `format_name()` to handle allocation failures
 - t/unit-tests: check for `reftable_buf` allocation errors
 - reftable/blocksource: adapt interface name
 - reftable: convert from `strbuf` to `reftable_buf`
 - reftable/basics: provide new `reftable_buf` interface
 - reftable: stop using `strbuf_addf()`
 - reftable: stop using `strbuf_addbuf()`

 Implements a new reftable-specific strbuf replacement to reduce
 reftable's dependency on Git-specific data structures.

 Will merge to 'next'?
 source: <cover.1729140565.git.ps@pks.im>


* ps/upgrade-clar (2024-10-14) 2 commits
 - Makefile: adjust sed command for generating "clar-decls.h"
 - t/unit-tests: update clar to 0810a36

 Buildfix and upgrade of Clar to a newer version.

 source: <cover.1728903464.git.ps@pks.im>


* wf/diff-highlight-install (2024-10-14) 1 commit
 - diff-highlight: make install link into DESTDIR

 Adds an 'install' recipe to diff-highlight's Makefile.

 source: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>


* wm/shortlog-hash (2024-10-17) 1 commit
 + builtin/shortlog: explicitly set hash algo when there is no repo

 Teaches 'shortlog' to explicitly use SHA-1 when operating outside of
 a repository.

 Will merge to 'next'.
 source: <20241017093528.18157-1-wolf@oriole.systems>


* bc/drop-ancient-libcurl-and-perl (2024-10-11) 13 commits
 - gitweb: make use of s///r
 - INSTALL: require Perl 5.26.0
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241010235621.738239-1-sandals@crustytoothpaste.net>


* co/t6050-pipefix (2024-10-15) 1 commit
 - t6050: avoid pipes with upstream Git commands

 Avoid losing exit status by having Git command being tested on the
 upstream side of a pipe.

 Needs review.
 There is at least one known broken conversion.
 cf. <CAPig+cRLdzAEA-G=L81yR9dmm8Y-5VEU7ybyohKmbq9=0bDUaQ@mail.gmail.com>
 source: <20241015112645.415955-1-chizobajames21@gmail.com>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728939687.git.steadmon@google.com>


* tb/cross-pack-delta-reuse (2024-10-11) 11 commits
 . pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap
 . pack-bitmap.c: record whether the result was filtered
 . pack-bitmap: enable cross-pack delta reuse
 . t5332: enable OFS_DELTAs via test_pack_objects_reused
 . write_reused_pack_one(): translate bit positions directly
 . pack-bitmap: drop `from_midx` field from `bitmapped_pack`
 . pack-bitmap.c: extract `find_base_bitmap_pos()`
 . pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
 . pack-bitmap.c: delay calling 'offset_to_pack_pos()'
 . pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
 . pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`

 Allow pack-objects to reuse an existing delta in a packfile, when
 it ends up sending the base object from a different packfile.

 It seems to break the tests when merged to 'seen'.
 source: <cover.1728505840.git.me@ttaylorr.com>


* bf/t-readme-mention-reftable (2024-10-11) 1 commit
 (merged to 'next' on 2024-10-18 at b246cb10d4)
 + t/README: add missing value for GIT_TEST_DEFAULT_REF_FORMAT

 Doc update.

 source: <20241011191150.825255-1-bence@ferdinandy.com>


* bf/set-head-symref (2024-10-15) 6 commits
 . fetch: set remote/HEAD if it does not exist
 . refs: add create_only option to refs_update_symref
 . refs: add TRANSACTION_CREATE_EXISTS error
 . remote set-head: better output for --auto
 . remote set-head: add new variable for readability
 . refs: atomically record overwritten ref in update_symref

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Needs to shed files backend dependency a bit more.
 cf. <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
 source: <20241014225431.1394565-1-bence@ferdinandy.com>


* db/submodule-fetch-with-remote-name-fix (2024-10-09) 1 commit
 (merged to 'next' on 2024-10-18 at a473d0df83)
 + submodule: correct remote name with fetch

 A "git fetch" from the superproject going down to a submodule used
 a wrong remote when the default remote names are set differently
 between them.

 source: <20241009033257.1316690-1-daniel@mariadb.org>


* ps/build (2024-10-09) 24 commits
 . Introduce support for the Meson build system
 . Documentation: add comparison of build systems
 . t: allow overriding build dir
 . t: better support for out-of-tree builds
 . Makefile: simplify building of templates
 . Makefile: allow "bin-wrappers/" directory to exist
 . Makefile: consistently use PERL_PATH
 . Makefile: consistently use @PLACEHOLDER@ to substitute
 . Makefile: use common template for GIT-BUILD-OPTIONS
 . Makefile: refactor generators to be PWD-independent
 . Makefile: refactor GIT-VERSION-GEN to be reusable
 . Makefile: extract script to massage Perl scripts
 . Makefile: extract script to generate clar declarations
 . http: fix build error on FreeBSD
 . builtin/credential-cache: fix missing parameter for stub function
 . t/unit-tests: update clar unit test framework
 . t7300: work around platform-specific behaviour with long paths on MinGW
 . t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 . t3404: work around platform-specific behaviour on macOS 10.15
 . t1401: make invocation of tar(1) work with Win32-provided one
 . t/lib-gpg: fix setup of GNUPGHOME in MinGW
 . t/lib-gitweb: test against the build version of gitweb
 . t/test-lib: wire up NO_ICONV prerequisite
 . t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE

 Build procedure update plus introduction of Mason based builds

 Needs review.
 Tentatively dropped from 'seen', for a circular dependency.
 cf. https://github.com/git/git/actions/runs/11299216196
 source: <cover.1728485139.git.ps@pks.im>


* ps/ci-gitlab-windows (2024-10-09) 5 commits
 (merged to 'next' on 2024-10-18 at 58a3be436a)
 + gitlab-ci: exercise Git on Windows
 + gitlab-ci: introduce stages and dependencies
 + ci: handle Windows-based CI jobs in GitLab CI
 + ci: create script to set up Git for Windows SDK
 + t7300: work around platform-specific behaviour with long paths on MinGW

 Enable Windows-based CI in GitLab.

 source: <cover.1728480039.git.ps@pks.im>


* ak/typofixes (2024-10-10) 6 commits
 (merged to 'next' on 2024-10-18 at c45095cae5)
 + t: fix typos
 + t/helper: fix a typo
 + t/perf: fix typos
 + t/unit-tests: fix typos
 + contrib: fix typos
 + compat: fix typos

 Typofixes.

 source: <20241010151223.311719-1-algonell@gmail.com>


* cw/worktree-relative (2024-10-08) 4 commits
 (merged to 'next' on 2024-10-18 at efc01c616e)
 + worktree: add test for path handling in linked worktrees
 + worktree: link worktrees with relative paths
 + worktree: refactor infer_backlink() to use *strbuf
 + Merge branch 'es/worktree-repair-copied' into cw/worktrees-relative
 (this branch uses es/worktree-repair-copied.)

 An extra worktree attached to a repository points at each other to
 allow finding the repository from the worktree and vice versa
 possible.  Turn this linkage to relative paths.

 source: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>


* ds/path-walk (2024-10-08) 17 commits
 - pack-objects: thread the path-based compression
 - pack-objects: refactor path-walk delta phase
 - scalar: enable path-walk during push via config
 - pack-objects: enable --path-walk via config
 - repack: update usage to match docs
 - repack: add --path-walk option
 - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 - p5313: add performance tests for --path-walk
 - pack-objects: update usage to match docs
 - pack-objects: add --path-walk option
 - pack-objects: extract should_attempt_deltas()
 - path-walk: add prune_all_uninteresting option
 - revision: create mark_trees_uninteresting_dense()
 - path-walk: allow visiting tags
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - path-walk: introduce an object walk by path

 A new algorithm for object graph traversal to favor visiting the
 objects at the same tree path in succession (as opposed to visiting
 objects that are different between trees as we walk commit
 histories) is introduced to optimize object packing.

 Needs review.
 source: <pull.1813.git.1728396723.gitgitgadget@gmail.com>


* hy/partial-repack-fix (2024-10-16) 3 commits
 . partial-clone: update doc
 . t0410: adapt tests to repack changes
 . repack: pack everything into packfile

 "git repack" avoids losing local objects that are reachable from
 objects in a packfile fetched from a promisor remote.

 Expecting a reroll.
 cf. <xmqqa5faec4x.fsf@gitster.g>
 source: <20241014032546.68427-1-hanyang.tony@bytedance.com>


* pb/clar-build-fix (2024-10-11) 1 commit
 (merged to 'next' on 2024-10-18 at ae6e80b047)
 + Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o

 Build fix.

 source: <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>


* ps/cache-tree-w-broken-index-entry (2024-10-07) 3 commits
 (merged to 'next' on 2024-10-18 at 0048cdba0b)
 + unpack-trees: detect mismatching number of cache-tree/index entries
 + cache-tree: detect mismatching number of index entries
 + cache-tree: refactor verification to return error codes

 Fail gracefully instead of crashing when attempting to write the
 contents of a corrupt in-core index as a tree object.

 source: <cover.1728275640.git.ps@pks.im>


* ua/t3404-cleanup (2024-10-14) 3 commits
 - parse: replace atoi() with strtoul_ui() and strtol_i()
 - t3404: replace test with test_line_count()
 - t3404: avoid losing exit status with focus on `git show` and `git cat-file`

 Test update.

 Will merge to 'next'?
 source: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>


* jc/a-commands-without-the-repo (2024-10-11) 3 commits
 (merged to 'next' on 2024-10-18 at b428982db3)
 + archive: remove the_repository global variable
 + annotate: remove usage of the_repository global
 + git: pass in repo to builtin based on setup_git_directory_gently

 Commands that can also work outside Git have learned to take the
 repository instance "repo" when we know we are in a repository, and
 NULL when we are not, in a parameter.  The uses of the_repository
 variable in a few of them have been removed using the new calling
 convention.

 source: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>


* ej/cat-file-remote-object-info (2024-09-27) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20240926013856.35527-1-eric.peijian@gmail.com>


* es/worktree-repair-copied (2024-09-23) 1 commit
 + worktree: repair copied repository and linked worktrees
 (this branch is used by cw/worktree-relative.)

 The heuristics in "git worktree repair" can be confused when a
 worktree and its repository are copied and break correctly
 configured worktree and repository that point at each other, which
 has been corrected.

 Needs review.
 source: <20240923075416.54289-1-ericsunshine@charter.net>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 - fetch-pack.c: do not declare local commits as "have" in partial repos
 - packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Needs review.
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>


* jc/breaking-changes-early-adopter-option (2024-10-11) 1 commit
 (merged to 'next' on 2024-10-18 at 899fb7e75f)
 + BreakingChanges: early adopter option

 Describe the policy to introduce breaking changes.

 source: <xmqq1q0mcnt8.fsf@gitster.g>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 On hold.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-09-30) 9 commits
 - ref: add symlink ref content check for files backend
 - t0602: add ref content checks for worktrees
 - ref: enhance escape situation for worktrees
 - ref: add escape check for the referent of symref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - builtin/refs: support multiple worktrees check for refs.
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <xmqqikud6kc0.fsf@gitster.g>
 source: <Zvj-DgHqtC30KjJe@ArchLinux>


* tb/incremental-midx-part-2 (2024-10-04) 17 commits
 - fixup! pack-bitmap.c: open and store incremental bitmap layers
 - fixup! midx: implement writing incremental MIDX bitmaps
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>
 source: <ZwBsbW5jsFw0mxKk@nand.local>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Waiting for review responses.
 source: <20240823224630.1180772-1-e@80x24.org>
