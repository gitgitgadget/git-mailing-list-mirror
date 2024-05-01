Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD180D52F
	for <git@vger.kernel.org>; Wed,  1 May 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714598801; cv=none; b=XoJk2sOLT7fQtRj1xSHE2icyJir2wptWfMD0Xxaej+Jg5oViaKbiZgH8r46mE+Ss0nwNxDthGuG7SQ2UqOG6a8E9pOcWD5nwv1wbayu0SO682y9zh4LjEklX/n+3I/AScIgfzXP7wd441OKaNPGnmoG8WnsemtmA0Unr/GMy3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714598801; c=relaxed/simple;
	bh=WK77z7kgkdzrTzpflBv+LMIG4KNICuS3Hcd+vyRg264=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=atL+ZlY5MeFaey5FqGWZSNqVEOoRdIbFTq+kHEFcuOeINl2W5xUJz3mpBBCVGotdcoNIPOhfm04s4fiWWiL7VX+11+VXpXEoly7UBU+lm/HnS2u+hBy4HplWIFwvQRuoGx2ar3THpsCzfjnMEDLlU25lK+HIAPZN8ywVXxWHARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UExKZZzo; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UExKZZzo"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DBF71AF67;
	Wed,  1 May 2024 17:26:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:message-id:date:mime-version:content-type; s=sasl; bh=W
	K77z7kgkdzrTzpflBv+LMIG4KNICuS3Hcd+vyRg264=; b=UExKZZzoUBrF0K7Bl
	nWzlPkkmduIEtiqBNjx1A9B/Dmdkrb+yEpppfDBiIlaJdhMdHd+fQsphjuutdHh6
	W0OHpNXd4QBvY+STF+KJsG7LcgOlSkoaAQSbBaJCJdszc2/Q0yF1SQzmjs3NYkq/
	9p8Rp248xt5hDlR+Ix+X4ZSgxM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 165071AF66;
	Wed,  1 May 2024 17:26:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 582CE1AF61;
	Wed,  1 May 2024 17:26:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (May 2024, #01; Wed, 1)
Message-ID: <xmqqr0el2pow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-master-at: d4cc1ec35f3bcce816b69986ca41943f6ce21377
X-next-at: 0667e3c05b4d9d32988313da24324a4cf9ecb0bf
Date: Wed, 01 May 2024 14:26:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79D53932-0801-11EF-9CC3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

The first batch of topics for the new cycle have graduated to the
'master' branch, and the tip of 'next' has been rewound.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

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

* aj/stash-staged-fix (2024-04-22) 1 commit
  (merged to 'next' on 2024-04-23 at d49e9dade0)
 + stash: fix "--staged" with binary files

 "git stash -S" did not handle binary files correctly, which has
 been corrected.
 source: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>


* ds/format-patch-rfc-and-k (2024-04-19) 1 commit
  (merged to 'next' on 2024-04-23 at b3b0c5507a)
 + format-patch: ensure that --rfc and -k are mutually exclusive

 The "-k" and "--rfc" options of "format-patch" will now error out
 when used together, as one tells us not to add anything to the
 title of the commit, and the other one tells us to add "RFC" in
 addition to "PATCH".
 source: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>


* jc/format-patch-rfc-more (2024-04-23) 2 commits
  (merged to 'next' on 2024-04-23 at 9f51487974)
 + format-patch: "--rfc=-(WIP)" appends to produce [PATCH (WIP)]
 + format-patch: allow --rfc to optionally take a value, like --rfc=WIP

 The "--rfc" option of "git format-patch" learned to take an
 optional string value to be used in place of "RFC" to tweak the
 "[PATCH]" on the subject header.
 source: <20240423175234.170434-1-gitster@pobox.com>


* js/build-fuzz-more-often (2024-04-24) 1 commit
  (merged to 'next' on 2024-04-25 at 28f65d1be2)
 + fuzz: link fuzz programs with `make all` on Linux

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.
 source: <ba9d24c6445de309226bf7c165499f1969807fef.1713982389.git.steadmon@google.com>


* js/for-each-repo-keep-going (2024-04-24) 2 commits
  (merged to 'next' on 2024-04-25 at d33253d919)
 + maintenance: running maintenance should not stop on errors
 + for-each-repo: optionally keep going on an error

 A scheduled "git maintenance" job is expected to work on all
 repositories it knows about, but it stopped at the first one that
 errored out.  Now it keeps going.
 source: <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>


* la/doc-use-of-contacts-when-contributing (2024-04-18) 8 commits
  (merged to 'next' on 2024-04-25 at 5102a45f63)
 + SubmittingPatches: demonstrate using git-contacts with git-send-email
 + SubmittingPatches: add heading for format-patch and send-email
 + SubmittingPatches: dedupe discussion of security patches
 + SubmittingPatches: discuss reviewers first
 + SubmittingPatches: quote commands
 + SubmittingPatches: mention GitGitGadget
 + SubmittingPatches: clarify 'git-contacts' location
 + MyFirstContribution: mention contrib/contacts/git-contacts

 Advertise "git contacts", a tool for newcomers to find people to
 ask review for their patches, a bit more in our developer
 documentation.
 source: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>


* pw/rebase-m-signoff-fix (2024-04-18) 6 commits
  (merged to 'next' on 2024-04-23 at 66374c00e2)
 + rebase -m: fix --signoff with conflicts
 + sequencer: store commit message in private context
 + sequencer: move current fixups to private context
 + sequencer: start removing private fields from public API
 + sequencer: always free "struct replay_opts"
 + Merge branch 'pw/t3428-cleanup' into pw/rebase-m-signoff-fix

 "git rebase --signoff" used to forget that it needs to add a
 sign-off to the resulting commit when told to continue after a
 conflict stops its operation.
 source: <cover.1713445918.git.phillip.wood@dunelm.org.uk>


* xx/disable-replace-when-building-midx (2024-04-17) 1 commit
  (merged to 'next' on 2024-04-23 at 6c8f41740e)
 + midx: disable replace objects

 The procedure to build multi-pack-index got confused by the
 replace-refs mechanism, which has been corrected by disabling the
 latter.
 source: <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* bb/rgb-12-bit-colors (2024-04-30) 4 commits
 - fixup! t/t4026-color: add test coverage for invalid RGB colors
 - color: add support for 12-bit RGB colors
 - t/t4026-color: add test coverage for invalid RGB colors
 - t/t4026-color: remove an extra double quote character

 Colors can now be specified with 12-bit format "#RGB" (in addition
 to "#RRGGBB" that is already supported).

 Will merge to 'next' after squashing the fix-up in???
 source: <20240429164849.78509-1-dev+git@drbeat.li>


* ds/scalar-reconfigure-all-fix (2024-04-30) 1 commit
 - scalar: avoid segfault in reconfigure --all

 Scalar fix.

 Comments?
 source: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>


* ps/pseudo-ref-terminology (2024-04-30) 10 commits
 - refs: refuse to write pseudorefs
 - ref-filter: properly distinuish pseudo and root refs
 - refs: pseudorefs are no refs
 - refs: root refs can be symbolic refs
 - refs: classify HEAD as a root ref
 - refs: refname `is_special_ref()` to `is_pseudo_ref()`
 - refs: rename `is_pseudoref()` to `is_root_ref()`
 - Documentation/glossary: define root refs as refs
 - Documentation/glossary: clarify limitations of pseudorefs
 - Documentation/glossary: redefine pseudorefs as special refs

 Terminology to call various ref-like things are getting
 straightened out.

 Under discussion.
 source: <cover.1714479928.git.ps@pks.im>


* dk/zsh-git-repo-path-fix (2024-04-30) 1 commit
 - completion: zsh: stop leaking local cache variable

 Command line completion support for zsh (in contrib/) has been
 updated to stop exposing internal state to end-user shell
 interaction.

 Will merge to 'next'.
 source: <pull.1725.git.1714513995564.gitgitgadget@gmail.com>


* rs/diff-parseopts-cleanup (2024-05-01) 1 commit
 - diff-lib: stop calling diff_setup_done() in do_diff_cache()

 Code clean-up to remove code that is now a noop.

 Will merge to 'next'.
 source: <0e96c5a3-7b4d-4c6b-875e-d80e3eb07a00@web.de>

--------------------------------------------------
[Cooking]

* rh/complete-symbolic-ref (2024-04-25) 3 commits
 - completion: add docs on how to add subcommand completions
 - completion: improve docs for using __git_complete
 - completion: add 'symbolic-ref'

 Command line completion script (in contrib/) learned to complete
 "git symbolic-ref" a bit better (you need to enable plumbing
 commands to be completed with GIT_COMPLETION_SHOW_ALL_COMMANDS).

 Will merge to 'next'.
 source: <20240425101845.708554-3-rhi@pengutronix.de>


* jt/doc-submitting-rerolled-series (2024-04-25) 1 commit
 - doc: clarify practices for submitting updated patch versions

 Developer doc update.

 Will merge to 'next'.
 source: <20240425213404.133660-1-jltobler@gmail.com>


* bc/zsh-compatibility (2024-04-26) 2 commits
 - vimdiff: make script and tests work with zsh
 - t4046: avoid continue in &&-chain for zsh

 zsh can pretend to be a normal shell pretty well except for some
 glitches that we tickle in some of our scripts. Work them around
 so that "vimdiff" and our test suite works well enough with it.

 Will merge to 'next'.
 source: <20240426221154.2194139-1-sandals@crustytoothpaste.net>


* jc/rev-parse-fatal-doc (2024-05-01) 1 commit
 - rev-parse: document how --is-* options work outside a repository

 Doc update.

 Comments?
 source: <xmqqplu54fbg.fsf@gitster.g>


* ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
 - repository: stop setting SHA1 as the default object hash
 - oss-fuzz/commit-graph: set up hash algorithm
 - builtin/shortlog: don't set up revisions without repo
 - builtin/diff: explicitly set hash algo when there is no repo
 - builtin/bundle: abort "verify" early when there is no repository
 - builtin/blame: don't access potentially unitialized `the_hash_algo`
 - builtin/rev-parse: allow shortening to more than 40 hex characters
 - remote-curl: fix parsing of detached SHA256 heads
 - attr: fix BUG() when parsing attrs outside of repo
 - attr: don't recompute default attribute source
 - parse-options-cb: only abbreviate hashes when hash algo is known
 - path: move `validate_headref()` to its only user
 - path: harden validation of HEAD with non-standard hashes

 Before discovering the repository details, We used to assume SHA-1
 as the "default" hash function, which has been corrected. Hopefully
 this will smoke out codepaths that rely on such an unwarranted
 assumptions.

 Comments?
 source: <cover.1714371422.git.ps@pks.im>


* rj/add-p-typo-reaction (2024-04-30) 2 commits
 - add-patch: response to unknown command
 - add-patch: do not show UI messages on stderr

 When the user responds to a prompt given by "git add -p" with an
 unsupported command, list of available commands were given, which
 was too much if the user knew what they wanted to type but merely
 made a typo.  Now the user gets a much shorter error message.

 Will merge to 'next'.
 source: <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>


* ps/the-index-is-no-more (2024-04-18) 6 commits
 - repository: drop `initialize_the_repository()`
 - repository: drop `the_index` variable
 - builtin/clone: stop using `the_index`
 - repository: initialize index in `repo_init()`
 - builtin: stop using `the_index`
 - t/helper: stop using `the_index`

 The singleton index_state instance "the_index" has been eliminated
 by always instantiating "the_repository" and replacing references
 to "the_index"  with references to its .index member.

 Will merge to 'next'.
 source: <cover.1713442061.git.ps@pks.im>


* kn/update-ref-symrefs (2024-04-26) 7 commits
 - ref: support symrefs in 'reference-transaction' hook
 - update-ref: add support for 'symref-update' command
 - update-ref: add support for 'symref-create' command
 - update-ref: add support for 'symref-delete' command
 - update-ref: add support for 'symref-verify' command
 - files-backend: extract out `create_symref_lock`
 - refs: accept symref values in `ref_transaction[_add]_update`

 "update-ref" learns to also handle symbolic refs.

 Expecting a reroll.
 cf. <CAOLa=ZT4yVEuZXmiTVB2tf0qaTPCPn=0TcJRc89knZQWZBbFTg@mail.gmail.com>
 source: <20240426152449.228860-1-knayak@gitlab.com>


* ps/ci-test-with-jgit (2024-04-12) 13 commits
 - t0612: add tests to exercise Git/JGit reftable compatibility
 - t0610: fix non-portable variable assignment
 - t06xx: always execute backend-specific tests
 - ci: install JGit dependency
 - ci: make Perforce binaries executable for all users
 - ci: merge scripts which install dependencies
 - ci: fix setup of custom path for GitLab CI
 - ci: merge custom PATH directories
 - ci: convert "install-dependencies.sh" to use "/bin/sh"
 - ci: drop duplicate package installation for "linux-gcc-default"
 - ci: skip sudo when we are already root
 - ci: expose distro name in dockerized GitHub jobs
 - ci: rename "runs_on_pool" to "distro"

 Tests to ensure interoperability between reftable written by jgit
 and our code have been added and enabled in CI.

 Will merge to 'next'.
 source: <cover.1712896868.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Expecting a reroll.
 cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* ps/reftable-write-optim (2024-04-08) 11 commits
  (merged to 'next' on 2024-04-30 at 0667e3c05b)
 + reftable/block: reuse compressed array
 + reftable/block: reuse zstream when writing log blocks
 + reftable/writer: reset `last_key` instead of releasing it
 + reftable/writer: unify releasing memory
 + reftable/writer: refactorings for `writer_flush_nonempty_block()`
 + reftable/writer: refactorings for `writer_add_record()`
 + refs/reftable: don't recompute committer ident
 + reftable: remove name checks
 + refs/reftable: skip duplicate name checks
 + refs/reftable: perform explicit D/F check when writing symrefs
 + refs/reftable: fix D/F conflict error message on ref copy

 Code to write out reftable has seen some optimization and
 simplification.

 Will merge to 'master'.
 source: <cover.1712578837.git.ps@pks.im>


* ds/send-email-per-message-block (2024-04-10) 2 commits
 - send-email: make it easy to discern the messages for each patch
 - send-email: move newline characters out of a few translatable strings

 "git send-email" learned to separate its reports on each message it
 sends out with an extra blank line in between.

 Comments?
 source: <cover.1712732383.git.dsimic@manjaro.org>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 cf. <xmqqy1a4ao3t.fsf@gitster.g>
 source: <20240328101356.300374-1-e@80x24.org>


* bc/credential-scheme-enhancement (2024-04-16) 16 commits
 - credential: add method for querying capabilities
 - credential-cache: implement authtype capability
 - t: add credential tests for authtype
 - credential: add support for multistage credential rounds
 - t5563: refactor for multi-stage authentication
 - docs: set a limit on credential line length
 - credential: enable state capability
 - credential: add an argument to keep state
 - http: add support for authtype and credential
 - docs: indicate new credential protocol fields
 - credential: add a field called "ephemeral"
 - credential: gate new fields on capability
 - credential: add a field for pre-encoded credentials
 - http: use new headers for each object request
 - remote-curl: reset headers on new request
 - credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.

 Will merge to 'next'.
 source: <20240417000240.3611948-1-sandals@crustytoothpaste.net>


* tb/pseudo-merge-reachability-bitmap (2024-04-30) 23 commits
 - t/perf: implement performace tests for pseudo-merge bitmaps
 - pseudo-merge: implement support for finding existing merges
 - ewah: `bitmap_equals_ewah()`
 - pack-bitmap: extra trace2 information
 - pack-bitmap.c: use pseudo-merges during traversal
 - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 - pack-bitmap: implement test helpers for pseudo-merge
 - ewah: implement `ewah_bitmap_popcount()`
 - pseudo-merge: implement support for reading pseudo-merge commits
 - pack-bitmap.c: read pseudo-merge extension
 - pseudo-merge: scaffolding for reads
 - pack-bitmap: extract `read_bitmap()` function
 - pack-bitmap-write.c: write pseudo-merge table
 - pack-bitmap-write.c: select pseudo-merge commits
 - pseudo-merge: implement support for selecting pseudo-merge commits
 - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 - pack-bitmap-write: support storing pseudo-merge commits
 - pseudo-merge.ch: initial commit
 - pack-bitmap: move some initialization to `bitmap_writer_init()`
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - ewah: implement `ewah_bitmap_is_subset()`
 - Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Needs review.
 source: <cover.1714422410.git.me@ttaylorr.com>


* la/hide-trailer-info (2024-04-26) 11 commits
 - trailer unit tests: inspect iterator contents
 - trailer: document parse_trailers() usage
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - trailer: make parse_trailers() return trailer_info pointer
 - interpret-trailers: access trailer_info with new helpers
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - trailer: add unit tests for trailer iterator
 - Makefile: sort UNIT_TEST_PROGRAMS
 - Merge branch 'la/format-trailer-info' into la/hide-trailer-info

 The trailer API has been reshuffled a bit.

 Expecting a hopefully final reroll.
 cf. <CAMo6p=GRcmy6NDGRskuNrauMYTkAgk_p_0TJJTPC2=axVrWuvQ@mail.gmail.com>
 source: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/cmake-with-test-tool (2024-04-30) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.

 Will merge to 'next' together with the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* js/unit-test-suite-runner (2024-04-30) 8 commits
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

 Will merge to 'next'?
 source: <cover.1714506612.git.steadmon@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


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


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
