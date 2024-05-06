Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9815CD7D
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039541; cv=none; b=rl5DixyiwRt8525zFOvKiKSafF/Os2VQAqP9vWHR0lP/TyKAngg72z75BoCKoJm9ODmm0VoBuoPb8aTFnHco0VfKyG1P6fnySmM74LyhqWLij1NZ5p95GZdOxhXv2fvDdcqAsmdfwpFzQqjsXmy894Nenj8mkmVHbwY1kbwExGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039541; c=relaxed/simple;
	bh=7Bxc6G1vrYfRSPDfz3bBVeAzMLltKP7HQ7CQSwsfEvU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZ3/g8oJNJ1DATK9ahs0NU7ckRmgqE0yoGguR3Cdq3wXndXXU7rE+DrBNXZPbNntKRdXFsQAM999zG7h4JAN27MZw+ZzeWLDRJGPWz7L/3WMt0jcFEaJ5YiUV+nr4bu0Q/MMBuDcOa4ArB6zyqF4AZqZsTAinIcz42SQ9XildlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTOrosYE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTOrosYE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 324EF2FB12;
	Mon,  6 May 2024 19:52:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	Bxc6G1vrYfRSPDfz3bBVeAzMLltKP7HQ7CQSwsfEvU=; b=bTOrosYElH7tCEdEL
	n4zzz/mzYFjB/zASkO0exWN1+DZaT7m4Cr/lpwcn2sZbUDsaI3EgrmXZjhvkOCLF
	8kAqlxYzdYbXYhg8fpStTbJTKAqrEmjynJofFCQfpQl9spoJBIDguFMJYoiynPEQ
	cfWrZRiSBXuaQSjtwWKZhAmHug=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 28CA62FB11;
	Mon,  6 May 2024 19:52:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A8582FB10;
	Mon,  6 May 2024 19:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (May 2024, #03; Mon, 6)
X-master-at: d4cc1ec35f3bcce816b69986ca41943f6ce21377
X-next-at: b98150cc7190226eafa47b017c34392aadf638ea
Date: Mon, 06 May 2024 16:52:11 -0700
Message-ID: <xmqqo79iwlas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A941246E-0C03-11EF-B3B4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

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
[New Topics]

* it/refs-name-conflict (2024-05-06) 1 commit
 - refs: return conflict error when checking packed refs

 Comments?
 cf. <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
 source: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>


* jc/format-patch-more-aggressive-range-diff (2024-05-06) 1 commit
 - format-patch: run range-diff with larger creation-factor

 The default "creation-factor" used by "git format-patch" has been
 raised to make it more aggressively find matching commits.

 Comments?
 source: <xmqqbk5i3ncw.fsf_-_@gitster.g>


* jp/tag-trailer (2024-05-06) 3 commits
 - builtin/tag: add --trailer option
 - builtin/commit: refactor --trailer logic
 - builtin/commit: use ARGV macro to collect trailers

 "git tag" learned the "--trailer" option to futz with the trailers
 in the same way as "git commit" does.

 Will merge to 'next'.
 source: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>


* ow/refspec-glossary-update (2024-05-06) 1 commit
 - Documentation: Mention that refspecs are explained elsewhere

 Doc update.

 Will merge to 'next'.
 source: <20240506182317.13477-1-oystwa@gmail.com>


* ps/ci-enable-minimal-fuzzers-at-gitlab (2024-05-06) 1 commit
 - gitlab-ci: add smoke test for fuzzers

 CI update.

 Will merge to 'next'.
 source: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>


* ps/ci-python-2-deprecation (2024-05-06) 1 commit
 - ci: fix Python dependency on Ubuntu 24.04

 Unbreak CI jobs so that we do not attempt to use Python 2 that has
 been removed from the platform.

 Will merge to 'next'.
 source: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>


* rs/external-diff-with-exit-code (2024-05-06) 2 commits
 - diff: fix --exit-code with external diff
 - diff: report unmerged paths as changes in run_diff_cmd()

 The "--exit-code" option of "git diff" command learned to work with
 the "--ext-diff" option.

 Will merge to 'next'?
 source: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>

--------------------------------------------------
[Cooking]

* jc/test-workaround-broken-mv (2024-05-02) 1 commit
  (merged to 'next' on 2024-05-06 at 7e009c6827)
 + t/lib-chunk: work around broken "mv" on some vintage of macOS

 Tests that try to corrupt in-repository files in chunked format did
 not work well on macOS due to its broken "mv", which has been
 worked around.

 Will merge to 'master'.
 source: <xmqqsez0c6ma.fsf@gitster.g>


* jt/port-ci-whitespace-check-to-gitlab (2024-05-03) 5 commits
 - gitlab-ci: add whitespace error check
 - ci: make the whitespace report optional
 - ci: separate whitespace check script
 - github-ci: fix link to whitespace error
 - ci: pre-collapse GitLab CI sections

 The "whitespace check" task that was enabled for GitHub Actions CI
 has been ported to GitLab CI.

 Will merge to 'next'?
 source: <20240503172110.181326-1-jltobler@gmail.com>


* jc/no-default-attr-tree-in-bare (2024-05-03) 1 commit
 - stop using HEAD for attributes in bare repository by default

 Git 2.43 started using the tree of HEAD as the source of attributes
 in a bare repository, which has severe performance implications.
 For now, revert the change, without ripping out a more explicit
 support for the attr.tree configuration variable.

 Will merge to 'next'?
 source: <xmqqzft6aozg.fsf_-_@gitster.g>


* jl/git-no-advice (2024-05-03) 3 commits
  (merged to 'next' on 2024-05-06 at 95cc03ef96)
 + advice: add --no-advice global option
 + doc: add spacing around paginate options
 + doc: clean up usage documentation for --no-* opts

 A new global "--no-advice" option can be used to disable all advice
 messages, which is meant to be used only in scripts.

 Will merge to 'master'.
 source: <20240503071706.78109-1-james@jamesliu.io>


* kn/ref-transaction-symref (2024-05-03) 7 commits
 - refs: remove `create_symref` and associated dead code
 - refs: rename `refs_create_symref()` to `refs_update_symref()`
 - refs: use transaction in `refs_create_symref()`
 - refs: add support for transactional symref updates
 - refs: support symrefs in 'reference-transaction' hook
 - files-backend: extract out `create_symref_lock()`
 - refs: accept symref values in `ref_transaction_update()`

 Updates to symbolic refs can now be made as a part of ref
 transaction.

 Will merge to 'next'?
 source: <20240503124115.252413-1-knayak@gitlab.com>


* ma/win32-unix-domain-socket (2024-05-03) 1 commit
  (merged to 'next' on 2024-05-06 at 799a546c96)
 + win32: fix building with NO_UNIX_SOCKETS

 Build fix.

 Will merge to 'master'.
 source: <20240503091427.2808390-1-mh@glandium.org>


* ps/config-subcommands (2024-05-06) 14 commits
 - builtin/config: display subcommand help
 - builtin/config: introduce "edit" subcommand
 - builtin/config: introduce "remove-section" subcommand
 - builtin/config: introduce "rename-section" subcommand
 - builtin/config: introduce "unset" subcommand
 - builtin/config: introduce "set" subcommand
 - builtin/config: introduce "get" subcommand
 - builtin/config: introduce "list" subcommand
 - builtin/config: pull out function to handle `--null`
 - builtin/config: pull out function to handle config location
 - builtin/config: use `OPT_CMDMODE()` to specify modes
 - builtin/config: move "fixed-value" option to correct group
 - builtin/config: move option array around
 - config: clarify memory ownership when preparing comment strings

 The operation mode options (like "--get") the "git config" command
 uses have been deprecated and replaced with subcommands (like "git
 config get").

 Will merge to 'next'.
 source: <cover.1714982328.git.ps@pks.im>


* ps/refs-without-the-repository (2024-05-03) 5 commits
 - refs: remove functions without ref store
 - cocci: apply rules to rewrite callers of "refs" interfaces
 - cocci: introduce rules to transform "refs" to pass ref store
 - refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
 - refs: introduce missing functions that accept a `struct ref_store`

 The refs API lost functions that implicitly assumes to work on the
 primary ref_store by forcing the callers to pass a ref_store as an
 argument.

 Will merge to 'next'?
 source: <cover.1714717057.git.ps@pks.im>


* ps/reftable-write-options (2024-05-03) 11 commits
 - refs/reftable: allow configuring geometric factor
 - reftable: make the compaction factor configurable
 - refs/reftable: allow disabling writing the object index
 - refs/reftable: allow configuring restart interval
 - reftable: use `uint16_t` to track restart interval
 - refs/reftable: allow configuring block size
 - reftable/dump: support dumping a table's block structure
 - reftable/writer: improve error when passed an invalid block size
 - reftable/writer: drop static variable used to initialize strbuf
 - reftable: consistently pass write opts as value
 - reftable: consistently refer to `reftable_write_options` as `opts`

 The knobs to tweak how reftable files are written have been made
 available as configuration variables.

 Needs review.
 source: <cover.1714630191.git.ps@pks.im>


* tb/attr-limits (2024-05-03) 1 commit
  (merged to 'next' on 2024-05-06 at b98150cc71)
 + attr.c: move ATTR_MAX_FILE_SIZE check into read_attr_from_buf()

 The maximum size of attribute files is enforced more consistently.

 Will merge to 'master'.
 source: <28f6267709db78ba526d7ed9fc4a734674697c70.1714763555.git.me@ttaylorr.com>


* bb/rgb-12-bit-colors (2024-05-02) 3 commits
  (merged to 'next' on 2024-05-02 at 7fe29c98d7)
 + color: add support for 12-bit RGB colors
 + t/t4026-color: add test coverage for invalid RGB colors
 + t/t4026-color: remove an extra double quote character

 The color parsing code learned to handle 12-bit RGB colors, spelled
 as "#RGB" (in addition to "#RRGGBB" that is already supported).

 Will merge to 'master'.
 source: <20240502110331.6347-1-dev+git@drbeat.li>


* ds/scalar-reconfigure-all-fix (2024-05-06) 1 commit
 - scalar: avoid segfault in reconfigure --all

 Scalar fix.

 Expecting a final (and hopefully small) reroll.
 cf. <Zjhufiq2DmBlVpIx@tanuki>
 source: <pull.1724.v2.git.1714874298859.gitgitgadget@gmail.com>


* ps/pseudo-ref-terminology (2024-05-02) 10 commits
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

 Comments?
 source: <cover.1714637671.git.ps@pks.im>


* dk/zsh-git-repo-path-fix (2024-04-30) 1 commit
  (merged to 'next' on 2024-05-02 at 0446d8e63a)
 + completion: zsh: stop leaking local cache variable

 Command line completion support for zsh (in contrib/) has been
 updated to stop exposing internal state to end-user shell
 interaction.

 Will merge to 'master'.
 source: <pull.1725.git.1714513995564.gitgitgadget@gmail.com>


* rs/diff-parseopts-cleanup (2024-05-01) 1 commit
  (merged to 'next' on 2024-05-02 at cd9779c175)
 + diff-lib: stop calling diff_setup_done() in do_diff_cache()

 Code clean-up to remove code that is now a noop.

 Will merge to 'master'.
 source: <0e96c5a3-7b4d-4c6b-875e-d80e3eb07a00@web.de>


* rh/complete-symbolic-ref (2024-04-25) 3 commits
  (merged to 'next' on 2024-05-01 at 7020ecebe7)
 + completion: add docs on how to add subcommand completions
 + completion: improve docs for using __git_complete
 + completion: add 'symbolic-ref'

 Command line completion script (in contrib/) learned to complete
 "git symbolic-ref" a bit better (you need to enable plumbing
 commands to be completed with GIT_COMPLETION_SHOW_ALL_COMMANDS).

 Will merge to 'master'.
 source: <20240425101845.708554-3-rhi@pengutronix.de>


* jt/doc-submitting-rerolled-series (2024-04-25) 1 commit
  (merged to 'next' on 2024-05-01 at 1c5865f11c)
 + doc: clarify practices for submitting updated patch versions

 Developer doc update.

 Will merge to 'master'.
 source: <20240425213404.133660-1-jltobler@gmail.com>


* bc/zsh-compatibility (2024-04-26) 2 commits
  (merged to 'next' on 2024-05-02 at 10222b2472)
 + vimdiff: make script and tests work with zsh
 + t4046: avoid continue in &&-chain for zsh

 zsh can pretend to be a normal shell pretty well except for some
 glitches that we tickle in some of our scripts. Work them around
 so that "vimdiff" and our test suite works well enough with it.

 Will merge to 'master'.
 source: <20240426221154.2194139-1-sandals@crustytoothpaste.net>


* jc/rev-parse-fatal-doc (2024-05-01) 1 commit
 - rev-parse: document how --is-* options work outside a repository

 Doc update.

 Comments?
 source: <xmqqplu54fbg.fsf@gitster.g>


* ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
 . repository: stop setting SHA1 as the default object hash
 . oss-fuzz/commit-graph: set up hash algorithm
 . builtin/shortlog: don't set up revisions without repo
 . builtin/diff: explicitly set hash algo when there is no repo
 . builtin/bundle: abort "verify" early when there is no repository
 . builtin/blame: don't access potentially unitialized `the_hash_algo`
 . builtin/rev-parse: allow shortening to more than 40 hex characters
 . remote-curl: fix parsing of detached SHA256 heads
 . attr: fix BUG() when parsing attrs outside of repo
 . attr: don't recompute default attribute source
 . parse-options-cb: only abbreviate hashes when hash algo is known
 . path: move `validate_headref()` to its only user
 . path: harden validation of HEAD with non-standard hashes

 Before discovering the repository details, We used to assume SHA-1
 as the "default" hash function, which has been corrected. Hopefully
 this will smoke out codepaths that rely on such an unwarranted
 assumptions.

 Seems to break t0003 with a NULL the_repository.

 Ejected out of 'seen' for now.
 source: <cover.1714371422.git.ps@pks.im>


* rj/add-p-typo-reaction (2024-04-30) 2 commits
  (merged to 'next' on 2024-05-01 at 3016062ebf)
 + add-patch: response to unknown command
 + add-patch: do not show UI messages on stderr

 When the user responds to a prompt given by "git add -p" with an
 unsupported command, list of available commands were given, which
 was too much if the user knew what they wanted to type but merely
 made a typo.  Now the user gets a much shorter error message.

 Will merge to 'master'.
 source: <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>


* ps/the-index-is-no-more (2024-04-18) 6 commits
  (merged to 'next' on 2024-05-01 at 7b9a0ab760)
 + repository: drop `initialize_the_repository()`
 + repository: drop `the_index` variable
 + builtin/clone: stop using `the_index`
 + repository: initialize index in `repo_init()`
 + builtin: stop using `the_index`
 + t/helper: stop using `the_index`

 The singleton index_state instance "the_index" has been eliminated
 by always instantiating "the_repository" and replacing references
 to "the_index"  with references to its .index member.

 Will merge to 'master'.
 source: <cover.1713442061.git.ps@pks.im>


* ps/ci-test-with-jgit (2024-04-12) 13 commits
  (merged to 'next' on 2024-05-01 at 35e293e618)
 + t0612: add tests to exercise Git/JGit reftable compatibility
 + t0610: fix non-portable variable assignment
 + t06xx: always execute backend-specific tests
 + ci: install JGit dependency
 + ci: make Perforce binaries executable for all users
 + ci: merge scripts which install dependencies
 + ci: fix setup of custom path for GitLab CI
 + ci: merge custom PATH directories
 + ci: convert "install-dependencies.sh" to use "/bin/sh"
 + ci: drop duplicate package installation for "linux-gcc-default"
 + ci: skip sudo when we are already root
 + ci: expose distro name in dockerized GitHub jobs
 + ci: rename "runs_on_pool" to "distro"

 Tests to ensure interoperability between reftable written by jgit
 and our code have been added and enabled in CI.

 Will merge to 'master'.
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
  (merged to 'next' on 2024-05-01 at 789ec5bd35)
 + credential: add method for querying capabilities
 + credential-cache: implement authtype capability
 + t: add credential tests for authtype
 + credential: add support for multistage credential rounds
 + t5563: refactor for multi-stage authentication
 + docs: set a limit on credential line length
 + credential: enable state capability
 + credential: add an argument to keep state
 + http: add support for authtype and credential
 + docs: indicate new credential protocol fields
 + credential: add a field called "ephemeral"
 + credential: gate new fields on capability
 + credential: add a field for pre-encoded credentials
 + http: use new headers for each object request
 + remote-curl: reset headers on new request
 + credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.

 Will merge to 'master'.
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


* la/hide-trailer-info (2024-05-02) 11 commits
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

 Will merge to 'next'?
 source: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>


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


* js/unit-test-suite-runner (2024-05-06) 9 commits
 - cmake: let `test-tool` run the unit tests, too
 - ci: use test-tool as unit test runner on Windows
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Will merge to 'next'.
 source: <cover.1715024899.git.steadmon@google.com>
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


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

--------------------------------------------------
[Discarded]

* js/cmake-with-test-tool (2024-04-30) 2 commits
 . cmake: let `test-tool` run the unit tests, too
 . Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 Rolled into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>
