Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9A7AE71
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591807; cv=none; b=qT223C0KD5EQnXb3/W/BAECAYacz0xKrqjVK0nRKertfNc8a2oPZP1yyoJJ5p2+v2GlptvF/WMZ27BQAxkDObBPWv0NzMp56wvmZ6SnQGQQ/BydontOB4ZQLWMk3MYLN/79OmMuChe0l40UNlo3vUNFWz+A5KW4MkWSxPYKJM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591807; c=relaxed/simple;
	bh=F0CAQDRKM9B7fmQa55tEwo0jlc/9efuCxInqjvh2MoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hckhEIGlmIegkn0pcNI+77eeCCaccdq9Apc0vqT/Do5w/m7BB7uvl1y1dLfiycGg0p+7WA7KnR9KAc/3RtWdogisZWlUsLeTb6w4I7ttL8TODi2k/QQeRRewBrA4k7PFFa2fBjXtEI1IZqeAyv8k4/igS6LmX1RE1gbtmTWcCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UF9CCFOg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UF9CCFOg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B3E7F37A3B;
	Mon,  4 Mar 2024 17:36:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=F0CAQDRKM9B7fmQa55tEwo0jl
	c/9efuCxInqjvh2MoA=; b=UF9CCFOgR7dD4fC/5hKmMlLnJhct334flk/Fci+RS
	NEslSWQ7AH1EMIZvFNJ1HGZOwcj0rGSitBTpf37QNLCxXH8UMFCxAt3M/f8GSyKt
	TFB0JUsJkRLG+M3ZPv/IlscosyZaJpNh0m3mGxP9ZGVaJUjv+H9nUFFDHe47gRA6
	iQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ABE3837A39;
	Mon,  4 Mar 2024 17:36:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3991E37A38;
	Mon,  4 Mar 2024 17:36:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2024, #01; Mon, 4)
X-master-at: b387623c12f3f4a376e4d35a610fd3e55d7ea907
X-next-at: de5f6a74cb92fb2d418f67c29f18e8f21f7e420c
Date: Mon, 04 Mar 2024 14:36:33 -0800
Message-ID: <xmqq4jdloc9a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A82C6420-DA77-11EE-8181-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

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

* cp/t9146-use-test-path-helpers (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-21 at 0b8356ef33)
 + t9146: replace test -d/-e/-f with appropriate test_path_is_* function

 Test script clean-up.
 source: <pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com>


* ds/doc-send-email-capitalization (2024-02-20) 1 commit
  (merged to 'next' on 2024-02-21 at c4aac4b993)
 + documentation: send-email: use camel case consistently

 Doc update.
 source: <88f1fe08c3047e14090957093ee8d98b0f60cb6c.1708467601.git.dsimic@=
manjaro.org>


* hs/rebase-not-in-progress (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at ce53f5243f)
 + rebase: make warning less passive aggressive

 Error message update.
 source: <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>


* ja/doc-placeholders-markup-rules (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at b6761ceeac)
 + doc: clarify the format of placeholders

 The way placeholders are to be marked-up in documentation have been
 specified; use "_<placeholder>_" to typeset the word inside a pair
 of <angle-brakets> emphasized.
 source: <pull.1671.git.1708550340094.gitgitgadget@gmail.com>


* ja/docfixes (2024-02-20) 3 commits
  (merged to 'next' on 2024-02-21 at 6d778ca672)
 + doc: end sentences with full-stop
 + doc: close unclosed angle-bracket of a placeholder in git-clone doc
 + doc: git-rev-parse: enforce command-line description syntax

 Doc update.
 source: <pull.1670.git.1708468374.gitgitgadget@gmail.com>


* jc/doc-add-placeholder-fix (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at 6950ff216b)
 + doc: apply the new placeholder rules to git-add documentation

 Practice the new mark-up rule for <placeholders> with "git add"
 documentation page.
 source: <xmqqbk89molz.fsf@gitster.g>


* jw/remote-doc-typofix (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at fe95873cfa)
 + git-remote.txt: fix typo

 Docfix.
 source: <20240221083554.5255-1-jwilk@jwilk.net>


* ps/difftool-dir-diff-exit-code (2024-02-20) 1 commit
  (merged to 'next' on 2024-02-21 at a7bbef5a5f)
 + git-difftool--helper: honor `--trust-exit-code` with `--dir-diff`

 "git difftool --dir-diff" learned to honor the "--trust-exit-code"
 option; it used to always exit with 0 and signalled success.
 Acked-by: David Aguilar <davvid@gmail.com>
 cf. <CAJDDKr5+3jszG=3Dpsh=3DkUGDjNCeTDGPSS-qDuN=3DJAq-3ua=3DbNDg@mail.gm=
ail.com>
 source: <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.=
im>


* ps/reflog-list (2024-02-21) 9 commits
  (merged to 'next' on 2024-02-23 at 7413632239)
 + builtin/reflog: introduce subcommand to list reflogs
 + refs: stop resolving ref corresponding to reflogs
 + refs: drop unused params from the reflog iterator callback
 + refs: always treat iterators as ordered
 + refs/files: sort merged worktree and common reflogs
 + refs/files: sort reflogs returned by the reflog iterator
 + dir-iterator: support iteration in sorted order
 + dir-iterator: pass name to `prepare_next_entry_data()` directly
 + Merge branch 'ps/reftable-backend' into ps/reflog-list

 "git reflog" learned a "list" subcommand that enumerates known reflogs.
 source: <cover.1708518982.git.ps@pks.im>


* tb/multi-pack-verbatim-reuse (2024-02-23) 1 commit
  (merged to 'next' on 2024-02-23 at 8ee07f1da4)
 + Documentation/config/pack.txt: fix broken AsciiDoc mark-up

 Docfix.
 source: <72bb58e5f3b8a5a622394c5ff40426156e122580.1708720255.git.me@ttay=
lorr.com>

--------------------------------------------------
[New Topics]

* jk/upload-pack-bounded-resources (2024-02-28) 9 commits
  (merged to 'next' on 2024-03-01 at b70b6f0913)
 + upload-pack: free tree buffers after parsing
 + upload-pack: use PARSE_OBJECT_SKIP_HASH_CHECK in more places
 + upload-pack: always turn off save_commit_buffer
 + upload-pack: disallow object-info capability by default
 + upload-pack: accept only a single packfile-uri line
 + upload-pack: use a strmap for want-ref lines
 + upload-pack: use oidset for deepen_not list
 + upload-pack: switch deepen-not list to an oid_array
 + upload-pack: drop separate v2 "haves" array

 Originally merged to 'next' on 2024-02-29

 Various parts of upload-pack has been updated to bound the resource
 consumption relative to the size of the repository to protect from
 abusive clients.

 Will merge to 'master'.
 source: <20240228223700.GA1157826@coredump.intra.peff.net>


* jk/upload-pack-v2-capability-cleanup (2024-02-29) 4 commits
  (merged to 'next' on 2024-03-01 at 2750893db7)
 + upload-pack: only accept packfile-uris if we advertised it
 + upload-pack: use existing config mechanism for advertisement
 + upload-pack: centralize setup of sideband-all config
 + upload-pack: use repository struct to get config

 Originally merged to 'next' on 2024-02-29

 The upload-pack program, when talking over v2, accepted the
 packfile-uris protocol extension from the client, even if it did
 not advertise the capability, which has been corrected.

 Will merge to 'master'.
 source: <20240228224625.GA1158651@coredump.intra.peff.net>


* es/config-doc-sort-sections (2024-02-29) 1 commit
  (merged to 'next' on 2024-03-04 at 0752144ed7)
 + docs: sort configuration variable groupings alphabetically

 Doc updates.

 Will merge to 'master'.
 source: <20240229190229.20222-1-ericsunshine@charter.net>


* kh/doc-dashed-commands-have-not-worked-for-a-long-time (2024-03-01) 1 c=
ommit
  (merged to 'next' on 2024-03-04 at 7e070c67f9)
 + gitcli: drop mention of =E2=80=9Cnon-dashed form=E2=80=9D

 Doc update.

 Will merge to 'master'.
 source: <5b34bc4e22816f7f19bd26c15a08fe4c749b72f8.1709316230.git.code@kh=
augsbakk.name>


* jc/xwrite-cleanup (2024-03-02) 3 commits
 - repack: check error writing to pack-objects subprocess
 - sideband: avoid short write(2)
 - unpack: replace xwrite() loop with write_in_full()

 Uses of xwrite() helper have been audited and updated for better
 error checking and simpler code.
 source: <20240302190348.3946569-1-gitster@pobox.com>


* jc/test-i18ngrep (2024-03-02) 1 commit
 - test_i18ngrep: hard deprecate and forbid its use

 With release 2.44 we got rid of all uses of test_i18ngrep and there
 is no in-flight topic that adds a new use of it.  Make a call to
 test_i18ngrep a hard failure, so that we can remove it at the end
 of this release cycle.

 Comments?
 source: <xmqq5xy4zhdc.fsf@gitster.g>


* gt/core-bare-in-templates (2024-03-04) 1 commit
 - setup: remove unnecessary variable

 Code simplification.

 Will merge to 'next'?
 source: <20240304151811.511780-1-shyamthakkar001@gmail.com>


* so/clean-dry-run-without-force (2024-03-04) 2 commits
 - clean: further clean-up of implementation around "--force"
 - clean: improve -n and -f implementation and documentation

 The implementation in "git clean" that makes "-n" and "-i" ignore
 clean.requireForce has been simplified, together with the
 documentation.

 Will merge to 'next'.
 source: <87le6ziqzb.fsf_-_@osv.gnss.ru>
 source: <20240303220600.2491792-1-gitster@pobox.com>


* jh/trace2-missing-def-param-fix (2024-03-04) 4 commits
 - trace2: remove unneeded calls to generate 'def_param' set
 - trace2: emit 'def_param' set with 'cmd_name' event
 - trace2: avoid emitting 'def_param' set more than once
 - t0211: demonstrate missing 'def_param' events for certain commands

 Some trace2 events that lacked def_param have learned to show it,
 enriching the output.

 Needs review.
 source: <pull.1679.git.1709566808.gitgitgadget@gmail.com>


* ps/reftable-stack-tempfile (2024-03-04) 4 commits
 - reftable/stack: register compacted tables as tempfiles
 - reftable/stack: register lockfiles during compaction
 - reftable/stack: register new tables as tempfiles
 - lockfile: report when rollback fails

 The code in reftable backend that creates new table files works
 better with the tempfile framework to avoid leaving cruft after a
 failure.

 Needs review.
 source: <cover.1709549619.git.ps@pks.im>


* rs/opt-parse-long-fixups (2024-03-03) 6 commits
 - parse-options: rearrange long_name matching code
 - parse-options: normalize arg and long_name before comparison
 - parse-options: detect ambiguous self-negation
 - parse-options: factor out register_abbrev() and struct parsed_option
 - parse-options: set arg of abbreviated option lazily
 - parse-options: recognize abbreviated negated option with arg

 The parse-options code that deals with abbreviated long option
 names have been cleaned up.

 Needs review.
 source: <20240303121944.20627-1-l.s.r@web.de>


* sj/t9117-path-is-file (2024-03-04) 1 commit
  (merged to 'next' on 2024-03-04 at de5f6a74cb)
 + t9117: prefer test_path_* helper functions

 GSoC practice to replace "test -f" with "test_path_is_file".

 Will merge to 'master'.
 source: <20240304095436.56399-2-shejialuo@gmail.com>


* vm/t7301-use-test-path-helpers (2024-03-04) 1 commit
 - t7301: use test_path_is_(missing|file)

 GSoC practice to replace "test -f" with "test_path_is_file".

 Will merge to 'next'?
 source: <20240304171732.64457-2-vincenzo.mezzela@gmail.com>

--------------------------------------------------
[Cooking]

* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Needs review.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/merge-base-with-missing-commit (2024-02-29) 11 commits
  (merged to 'next' on 2024-03-01 at 3e3eabaee9)
 + commit-reach(repo_get_merge_bases_many_dirty): pass on errors
 + commit-reach(repo_get_merge_bases_many): pass on "missing commits" err=
ors
 + commit-reach(get_octopus_merge_bases): pass on "missing commits" error=
s
 + commit-reach(repo_get_merge_bases): pass on "missing commits" errors
 + commit-reach(get_merge_bases_many_0): pass on "missing commits" errors
 + commit-reach(merge_bases_many): pass on "missing commits" errors
 + commit-reach(paint_down_to_common): start reporting errors
 + commit-reach(paint_down_to_common): prepare for handling shallow commi=
ts
 + commit-reach(repo_in_merge_bases_many): report missing commits
 + commit-reach(repo_in_merge_bases_many): optionally expect missing comm=
its
 + commit-reach(paint_down_to_common): plug two memory leaks

 Originally merged to 'next' on 2024-02-29

 Make sure failure return from merge_bases_many() is properly caught.

 Needs an incremental fix-up.
 cf.<20240301065805.GB2680308@coredump.intra.peff.net>
 source: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>


* eg/add-uflags (2024-02-29) 1 commit
  (merged to 'next' on 2024-03-01 at 5dbc997561)
 + add: use unsigned type for collection of bits

 Originally merged to 'next' on 2024-02-29

 Code clean-up practice.

 Will merge to 'master'.
 source: <20240229194444.8499-2-giganteeugenio2@gmail.com>


* jc/doc-compat-util (2024-02-27) 1 commit
  (merged to 'next' on 2024-03-01 at 89b76c65d7)
 + doc: clarify the wording on <git-compat-util.h> requirement

 Originally merged to 'next' on 2024-02-27

 Clarify wording in the CodingGuidelines that requires <git-compat-util.h=
>
 to be the first header file.

 Will merge to 'master'.
 source: <xmqqle76kdpr.fsf_-_@gitster.g>


* jc/no-include-of-compat-util-from-headers (2024-02-24) 1 commit
  (merged to 'next' on 2024-03-01 at ebb921087e)
 + compat: drop inclusion of <git-compat-util.h>

 Originally merged to 'next' on 2024-02-26

 Header file clean-up.

 Will merge to 'master'.
 source: <xmqqwmqtli18.fsf@gitster.g>


* jk/reflog-special-cases-fix (2024-02-26) 3 commits
  (merged to 'next' on 2024-03-01 at 2b67f6e668)
 + read_ref_at(): special-case ref@{0} for an empty reflog
 + get_oid_basic(): special-case ref@{n} for oldest reflog entry
 + Revert "refs: allow @{n} to work with n-sized reflog"

 Originally merged to 'next' on 2024-02-27

 The logic to access reflog entries by date and number had ugly
 corner cases at the boundaries, which have been cleaned up.

 Will merge to 'master'.
 source: <20240226100010.GA1214708@coredump.intra.peff.net>


* jk/textconv-cache-outside-repo-fix (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at 8508b83758)
 + userdiff: skip textconv caching when not in a repository

 Originally merged to 'next' on 2024-02-26

 The code incorrectly attempted to use textconv cache when asked,
 even when we are not running in a repository, which has been
 corrected.

 Will merge to 'master'.
 source: <20240226102729.GB2685773@coredump.intra.peff.net>


* js/remove-cruft-files (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at 63100a274b)
 + neue: remove a bogus empty file

 Originally merged to 'next' on 2024-02-26

 Remove an empty file that shouldn't have been added in the first
 place.

 Will merge to 'master'.
 source: <pull.1674.git.1708958183225.gitgitgadget@gmail.com>


* jt/commit-redundant-scissors-fix (2024-02-27) 2 commits
  (merged to 'next' on 2024-03-01 at e5983498f1)
 + commit: unify logic to avoid multiple scissors lines when merging
 + commit: avoid redundant scissor line with --cleanup=3Dscissors -v

 Originally merged to 'next' on 2024-02-29

 "git commit -v --cleanup=3Dscissors" used to add the scissors line
 twice in the log message buffer, which has been corrected.

 Will merge to 'master'.
 source: <Zd2eLxPelxvP8FDk@localhost>


* pb/ort-make-submodule-conflict-message-an-advice (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at df880cde2e)
 + merge-ort: turn submodule conflict suggestions into an advice

 Originally merged to 'next' on 2024-02-27

 When a merge conflicted at a submodule, merge-ort backend used to
 unconditionally give a lengthy message to suggest how to resolve
 it.  Now the message can be squelched as an advice message.

 Will merge to 'master'.
 source: <pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>


* rj/complete-worktree-paths-fix (2024-02-27) 1 commit
 - completion: fix __git_complete_worktree_paths

 The logic to complete the command line arguments to "git worktree"
 subcommand (in contrib/) has been updated to correctly honor things
 like "git -C dir" etc.

 Comments?
 source: <b8f09e20-d0d3-4e0b-afe2-31affeb61052@gmail.com>


* rs/fetch-simplify-with-starts-with (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at 000e015fff)
 + fetch: convert strncmp() with strlen() to starts_with()

 Originally merged to 'next' on 2024-02-27

 Code simplification.

 Will merge to 'master'.
 source: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>


* rs/name-rev-with-mempool (2024-02-26) 2 commits
  (merged to 'next' on 2024-03-01 at d53eac1836)
 + name-rev: use mem_pool_strfmt()
 + mem-pool: add mem_pool_strfmt()

 Originally merged to 'next' on 2024-02-27

 Many small allocations "git name-rev" makes have been updated to
 allocate from a mem-pool.

 Will merge to 'master'.
 source: <20240225113947.89357-1-l.s.r@web.de>


* rs/submodule-prefix-simplify (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at 05d4d90201)
 + submodule: use strvec_pushf() for --submodule-prefix

 Originally merged to 'next' on 2024-02-27

 Code simplification.

 Will merge to 'master'.
 source: <8cd983fb-32b9-41c6-a9e7-a485b190488c@web.de>


* rs/t-ctype-simplify (2024-03-03) 4 commits
  (merged to 'next' on 2024-03-04 at 9bd84a8877)
 + t-ctype: avoid duplicating class names
 + t-ctype: align output of i
 + t-ctype: simplify EOF check
 + t-ctype: allow NUL anywhere in the specification string

 Code simplification to one unit-test program.

 Will merge to 'master'.
 source: <20240303101330.20187-1-l.s.r@web.de>


* sg/upload-pack-error-message-fix (2024-02-26) 1 commit
  (merged to 'next' on 2024-03-01 at b94664a7a0)
 + upload-pack: don't send null character in abort message to the client

 Originally merged to 'next' on 2024-02-27

 An error message from "git upload-pack", which responds to "git
 fetch" requests, had a trialing NUL in it, which has been
 corrected.

 Will merge to 'master'.
 source: <20240225183452.1939334-1-szeder.dev@gmail.com>


* ak/rebase-autosquash (2024-02-27) 1 commit
  (merged to 'next' on 2024-03-01 at 57a34830b7)
 + rebase: fix typo in autosquash documentation

 Originally merged to 'next' on 2024-02-27

 Typofix.

 Will merge to 'master'.
 source: <pull.1676.git.1709015578890.gitgitgadget@gmail.com>


* ps/reftable-repo-init-fix (2024-02-27) 2 commits
  (merged to 'next' on 2024-03-01 at abbf85051b)
 + refs/reftable: don't fail empty transactions in repo without HEAD
 + Merge branch 'ps/remote-helper-repo-initialization-fix' into ps/reftab=
le-repo-init-fix
 (this branch uses ps/remote-helper-repo-initialization-fix.)

 Originally merged to 'next' on 2024-02-29

 Clear the fallout from a fix for 2.44 regression.

 Will merge to 'master'.
 source: <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.=
im>


* ps/remote-helper-repo-initialization-fix (2024-02-27) 1 commit
  (merged to 'next' on 2024-03-01 at 7b79ffbd8f)
 + builtin/clone: allow remote helpers to detect repo
 (this branch is used by ps/reftable-repo-init-fix.)

 Originally merged to 'next' on 2024-02-29

 A custom remote helper no longer cannot access the newly created
 repository during "git clone", which is a regression in Git 2.44.
 This has been corrected.

 Will merge to 'master'.
 source: <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.=
im>


* pw/rebase-i-ignore-cherry-pick-help-environment (2024-02-27) 1 commit
 - rebase -i: stop setting GIT_CHERRY_PICK_HELP

 Code simplification by getting rid of code that sets an environment
 variable that is no longer used.

 Comments?
 source: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>


* as/option-names-in-messages (2024-02-16) 5 commits
 - revision.c: trivial fix to message
 - builtin/clone.c: trivial fix of message
 - builtin/remote.c: trivial fix of error message
 - transport-helper.c: trivial fix of error message
 - rebase: trivial fix of error message

 Error message updates.

 Expecting a reroll.
 source: <20240216101647.28837-1-ash@kambanaria.org>


* jh/fsmonitor-icase-corner-case-fix (2024-02-26) 14 commits
 - fsmonitor: support case-insensitive events
 - fsmonitor: refactor bit invalidation in refresh callback
 - fsmonitor: trace the new invalidated cache-entry count
 - fsmonitor: return invalided cache-entry count on non-directory event
 - fsmonitor: remove custom loop from non-directory path handler
 - fsmonitor: return invalidated cache-entry count on directory event
 - fsmonitor: move untracked-cache invalidation into helper functions
 - fsmonitor: refactor untracked-cache invalidation
 - dir: create untracked_cache_invalidate_trimmed_path()
 - fsmonitor: refactor refresh callback for non-directory events
 - fsmonitor: clarify handling of directory events in callback helper
 - fsmonitor: refactor refresh callback on directory events
 - t7527: add case-insensitve test for FSMonitor
 - name-hash: add index_dir_find()

 FSMonitor client code was confused when FSEvents were given in a
 different case on a case-insensitive filesystem, which has been
 corrected.

 Comments?
 source: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>


* ps/reftable-iteration-perf-part2 (2024-03-04) 13 commits
 - refs/reftable: precompute prefix length
 - reftable: allow inlining of a few functions
 - reftable/record: decode keys in place
 - reftable/record: reuse refname when copying
 - reftable/record: reuse refname when decoding
 - reftable/merged: avoid duplicate pqueue emptiness check
 - reftable/merged: circumvent pqueue with single subiter
 - reftable/merged: handle subiter cleanup on close only
 - reftable/merged: remove unnecessary null check for subiters
 - reftable/merged: make subiters own their records
 - reftable/merged: advance subiter on subsequent iteration
 - reftable/merged: make `merged_iter` structure private
 - reftable/pq: use `size_t` to track iterator index

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Will merge to 'next'?
 source: <cover.1709548907.git.ps@pks.im>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* kn/for-all-refs (2024-02-23) 6 commits
  (merged to 'next' on 2024-03-01 at 76a1297ace)
 + for-each-ref: add new option to include root refs
 + ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
 + refs: introduce `refs_for_each_include_root_refs()`
 + refs: extract out `loose_fill_ref_dir_regular_file()`
 + refs: introduce `is_pseudoref()` and `is_headref()`
 + Merge branch 'ps/reftable-backend' into kn/for-all-refs

 Originally merged to 'next' on 2024-02-27

 "git for-each-ref" learned "--include-root-refs" option to show
 even the stuff outside the 'refs/' hierarchy.

 Will merge to 'master'.
 source: <20240223100112.44127-1-karthik.188@gmail.com>


* jc/no-lazy-fetch (2024-02-27) 3 commits
  (merged to 'next' on 2024-03-01 at 14303cdbfe)
 + git: extend --no-lazy-fetch to work across subprocesses
 + git: document GIT_NO_REPLACE_OBJECTS environment variable
 + git: --no-lazy-fetch option

 Originally merged to 'next' on 2024-02-29

 "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
 fetching of objects from the promisor remote, which may be handy
 for debugging.

 Will merge to 'master'.
 source: <xmqq1q8xx38i.fsf@gitster.g>
 source: <xmqq1q9cl3xv.fsf@gitster.g>
 source: <xmqq1q9mmtpw.fsf@gitster.g>


* js/unit-test-suite-runner (2024-02-23) 8 commits
 - ci: use test-tool as unit test runner on Windows
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner
 (this branch is used by js/cmake-with-test-tool.)

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Needs review.
 source: <cover.1708728717.git.steadmon@google.com>


* cc/rev-list-allow-missing-tips (2024-02-28) 5 commits
  (merged to 'next' on 2024-03-01 at fd7b109d04)
 + revision: fix --missing=3D[print|allow*] for annotated tags
  (merged to 'next' on 2024-03-01 at ac0fc94378)
 + rev-list: allow missing tips with --missing=3D[print|allow*]
 + t6022: fix 'test' style and 'even though' typo
 + oidset: refactor oidset_insert_from_set()
 + revision: clarify a 'return NULL' in get_reference()

 Originally merged to 'next' on 2024-02-28

 "git rev-list --missing=3Dprint" has learned to optionally take
 "--allow-missing-tips", which allows the objects at the starting
 points to be missing.

 Will merge to 'master'.
 source: <20240214142513.4002639-1-christian.couder@gmail.com>


* js/merge-tree-3-trees (2024-02-23) 7 commits
  (merged to 'next' on 2024-03-01 at a75dc95f04)
 + fill_tree_descriptor(): mark error message for translation
 + cache-tree: avoid an unnecessary check
 + Always check `parse_tree*()`'s return value
 + t4301: verify that merge-tree fails on missing blob objects
 + merge-ort: do check `parse_tree()`'s return value
 + merge-tree: fail with a non-zero exit code on missing tree objects
 + merge-tree: accept 3 trees as arguments

 Originally merged to 'next' on 2024-02-28

 "git merge-tree" has learned that the three trees involved in the
 3-way merge only need to be trees, not necessarily commits.

 Will merge to 'master'.
 source: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
 source: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>


* rj/complete-reflog (2024-03-03) 5 commits
 - completion: reflog subcommands and options
 - completion: factor out __git_resolve_builtins
 - completion: introduce __git_find_subcommand
 - completion: reflog show <log-options>
 - completion: reflog with implicit "show"

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.

 Will merge to 'next'?
 source: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>


* ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-28) 2 com=
mits
  (merged to 'next' on 2024-03-01 at 339111ec08)
 + revision: implement `git log --merge` also for rebase/cherry-pick/reve=
rt
 + revision: ensure MERGE_HEAD is a ref in prepare_show_merge

 Originally merged to 'next' on 2024-02-29

 "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
 other kinds of *_HEAD pseudorefs.

 Will merge to 'master'.
 source: <20240228-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v=
6-0-8ec34c052b39@gmail.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* la/trailer-api (2024-03-01) 9 commits
 - format_trailers_from_commit(): indirectly call trailer_info_get()
 - format_trailer_info(): move "fast path" to caller
 - format_trailers(): use strbuf instead of FILE
 - trailer_info_get(): reorder parameters
 - trailer: move interpret_trailers() to interpret-trailers.c
 - trailer: reorder format_trailers_from_commit() parameters
 - trailer: rename functions to use 'trailer'
 - shortlog: add test for de-duplicating folded trailers
 - trailer: free trailer_info _after_ all related usage

 source: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* eb/hash-transition (2023-10-02) 30 commits
 - t1016-compatObjectFormat: add tests to verify the conversion between o=
bjects
 - t1006: test oid compatibility with cat-file
 - t1006: rename sha1 to oid
 - test-lib: compute the compatibility hash so tests may use it
 - builtin/ls-tree: let the oid determine the output algorithm
 - object-file: handle compat objects in check_object_signature
 - tree-walk: init_tree_desc take an oid to get the hash algorithm
 - builtin/cat-file: let the oid determine the output algorithm
 - rev-parse: add an --output-object-format parameter
 - repository: implement extensions.compatObjectFormat
 - object-file: update object_info_extended to reencode objects
 - object-file-convert: convert commits that embed signed tags
 - object-file-convert: convert commit objects when writing
 - object-file-convert: don't leak when converting tag objects
 - object-file-convert: convert tag objects when writing
 - object-file-convert: add a function to convert trees between algorithm=
s
 - object: factor out parse_mode out of fast-import and tree-walk into in=
 object.h
 - cache: add a function to read an OID of a specific algorithm
 - tag: sign both hashes
 - commit: export add_header_signature to support handling signatures on =
tags
 - commit: convert mergetag before computing the signature of a commit
 - commit: write commits for both hashes
 - object-file: add a compat_oid_in parameter to write_object_file_flags
 - object-file: update the loose object map when writing loose objects
 - loose: compatibilty short name support
 - loose: add a mapping between SHA-1 and SHA-256 for loose objects
 - repository: add a compatibility hash algorithm
 - object-names: support input of oids in any supported hash
 - oid-array: teach oid-array to handle multiple kinds of oids
 - object-file-convert: stubs for converting from one object format to an=
other

 Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.

 Will merge to and cook in 'next'?
 cf. <xmqqv86z5359.fsf@gitster.g>
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
