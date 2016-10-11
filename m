Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A341F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbcJKVGO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:06:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752266AbcJKVGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:06:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 643F045FDF;
        Tue, 11 Oct 2016 17:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=0
        TcMbgalGaGRz3IMIRsJLR8Flww=; b=jGtJLN/cyMutRTFzE28ieHpKp7cYcAuwK
        0rWCWMeql1haq1jOMTTuwIOw++pdTsQkfWJk7tBTs0XH1FtAL2x8n82kE0zsS50s
        wf5Ve8DZKMQLSQSx66Dr9hrgGV4IJrJVx+u/GRiHz6rtdmcNMHNLSSPxaxCJeXkn
        Dm/ljB/c8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=iVl
        MdeK93wDv338OYJGShMQ2W9xOte0qTSOHETzxP+60Ku56uGX1fVhJGkQJCX9mipM
        UA+sKuKen7A+9Ch7na+LNqotDNs0Y+jWkf8Bm3sVFDNRz7jlnBeqvOPzQ++cOrNJ
        9Y1mGRSo5sPa3yjsm6ckZnMjGkt7WOQ/vGYwK62U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CAFE45FDE;
        Tue, 11 Oct 2016 17:06:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9601C45FDA;
        Tue, 11 Oct 2016 17:06:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2016, #03; Tue, 11)
X-master-at: 8a36cd87b7c85a651ab388d403629865ffa3ba0d
X-next-at: 28fc3e53f99219d01faa8a76452eac5ca9d631c2
Date:   Tue, 11 Oct 2016 14:06:08 -0700
Message-ID: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8919A328-8FF6-11E6-8F87-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A handful of topics have been merged to 'master' and the upcoming
release started to take shape.  Quite a few topics that no longer
merge cleanly to 'pu' and have been excluded from 'pu' for some time
have finally been moved to the Discarded section (many of them are
expected to be updated and return).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/curl-imap-send-explicit-scheme (2016-08-17) 1 commit
  (merged to 'next' on 2016-09-22 at 4449584c26)
 + imap-send: Tell cURL to use imap:// or imaps://

 When we started cURL to talk to imap server when a new enough
 version of cURL library is available, we forgot to explicitly add
 imap(s):// before the destination.  To some folks, that didn't work
 and the library tried to make HTTP(s) requests instead.


* cp/completion-negative-refs (2016-08-24) 1 commit
  (merged to 'next' on 2016-09-22 at abd1585aa6)
 + completion: support excluding refs

 The command-line completion script (in contrib/) learned to
 complete "git cmd ^mas<HT>" to complete the negative end of
 reference to "git cmd ^master".


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
  (merged to 'next' on 2016-09-22 at 9c5aeeced9)
 + ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.


* jc/blame-reverse (2016-06-14) 2 commits
  (merged to 'next' on 2016-09-22 at d1a8e9ce99)
 + blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 + blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.


* jk/pack-objects-optim-mru (2016-08-11) 4 commits
  (merged to 'next' on 2016-09-21 at 97b919bdbd)
 + pack-objects: use mru list when iterating over packs
 + pack-objects: break delta cycles before delta-search phase
 + sha1_file: make packed_object_info public
 + provide an initializer for "struct object_info"

 Originally merged to 'next' on 2016-08-11

 "git pack-objects" in a repository with many packfiles used to
 spend a lot of time looking for/at objects in them; the accesses to
 the packfiles are now optimized by checking the most-recently-used
 packfile first.


* nd/shallow-deepen (2016-06-13) 27 commits
  (merged to 'next' on 2016-09-22 at f0cf3e3385)
 + fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 + upload-pack: add get_reachable_list()
 + upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 + t5500, t5539: tests for shallow depth excluding a ref
 + clone: define shallow clone boundary with --shallow-exclude
 + fetch: define shallow boundary with --shallow-exclude
 + upload-pack: support define shallow boundary by excluding revisions
 + refs: add expand_ref()
 + t5500, t5539: tests for shallow depth since a specific date
 + clone: define shallow clone boundary based on time with --shallow-since
 + fetch: define shallow boundary with --shallow-since
 + upload-pack: add deepen-since to cut shallow repos based on time
 + shallow.c: implement a generic shallow boundary finder based on rev-list
 + fetch-pack: use a separate flag for fetch in deepening mode
 + fetch-pack.c: mark strings for translating
 + fetch-pack: use a common function for verbose printing
 + fetch-pack: use skip_prefix() instead of starts_with()
 + upload-pack: move rev-list code out of check_non_tip()
 + upload-pack: make check_non_tip() clean things up on error
 + upload-pack: tighten number parsing at "deepen" lines
 + upload-pack: use skip_prefix() instead of starts_with()
 + upload-pack: move "unshallow" sending code out of deepen()
 + upload-pack: remove unused variable "backup"
 + upload-pack: move "shallow" sending code out of deepen()
 + upload-pack: move shallow deepen code out of receive_needs()
 + transport-helper.c: refactor set_helper_option()
 + remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".


* rs/qsort (2016-10-03) 6 commits
  (merged to 'next' on 2016-10-06 at 32a5bd3c88)
 + show-branch: use QSORT
 + use QSORT, part 2
 + coccicheck: use --all-includes by default
 + remove unnecessary check before QSORT
 + use QSORT
 + add QSORT

 We call "qsort(array, nelem, sizeof(array[0]), fn)", and most of
 the time third parameter is redundant.  A new QSORT() macro lets us
 omit it.

--------------------------------------------------
[New Topics]

* ab/gitweb-abbrev-links (2016-10-06) 3 commits
 - gitweb: link to "git describe"'d commits in log messages
 - gitweb: link to 7-char+ SHA-1s, not only 8-char+
 - gitweb: fix a typo in a comment

 In addition to purely abbreviated commit object names, "gitweb"
 learned to turn "git describe" output (e.g. v2.9.3-599-g2376d31787)
 into clickable links in its output.

 Waiting for review.


* da/mergetool-diff-order (2016-10-11) 4 commits
  (merged to 'next' on 2016-10-11 at 3d1b98c16d)
 + mergetool: honor -O<orderfile>
 + mergetool: honor diff.orderFile
 + mergetool: move main program flow into a main() function
 + mergetool: add copyright

 "git mergetool" learned to honor "-O<orderfile>" to control the
 order of paths to present to the end user.

 Will merge to 'master'.


* jk/ref-symlink-loop (2016-10-10) 2 commits
  (merged to 'next' on 2016-10-11 at ac5c35f87f)
 + files_read_raw_ref: prevent infinite retry loops in general
 + files_read_raw_ref: avoid infinite loop on broken symlinks

 A stray symbolic link in $GIT_DIR/refs/ directory could make name
 resolution loop forever, which has been corrected.

 Will merge to 'master'.


* js/prepare-sequencer (2016-10-10) 26 commits
 - SQUASH: nobody uses this function yet
 - sequencer: mark all error messages for translation
 - sequencer: start error messages consistently with lower case
 - sequencer: quote filenames in error messages
 - sequencer: mark action_name() for translation
 - sequencer: remove overzealous assumption in rebase -i mode
 - sequencer: refactor write_message()
 - sequencer: left-trim lines read from the script
 - sequencer: do not try to commit when there were merge conflicts
 - sequencer: support cleaning up commit messages
 - sequencer: support amending commits
 - sequencer: allow editing the commit message on a case-by-case basis
 - sequencer: introduce a helper to read files written by scripts
 - sequencer: prepare for rebase -i's commit functionality
 - sequencer: remember the onelines when parsing the todo file
 - sequencer: refactor the code to obtain a short commit name
 - sequencer: get rid of the subcommand field
 - sequencer: avoid completely different messages for different actions
 - sequencer: strip CR from the todo script
 - sequencer: completely revamp the "todo" script parsing
 - sequencer: future-proof read_populate_todo()
 - sequencer: eventually release memory allocated for the option values
 - sequencer: future-proof remove_sequencer_state()
 - sequencer: avoid unnecessary indirection
 - sequencer: use memoized sequencer directory path
 - sequencer: use static initializers for replay_opts

 Update of the sequencer codebase to make it reusable to reimplement
 "rebase -i" continues.

 Waiting for review.


* js/regexec-buf (2016-10-10) 1 commit
  (merged to 'next' on 2016-10-11 at 466a26548c)
 + configure.ac: improve description of NO_REGEX test

 Will merge to 'master'.


* rs/cocci (2016-10-10) 2 commits
  (merged to 'next' on 2016-10-11 at bbd6a88402)
 + use strbuf_add_unique_abbrev() for adding short hashes, part 3
 + remove unnecessary NULL check before free(3)

 Code cleanup.

 Will merge to 'master'.


* sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
  (merged to 'next' on 2016-10-11 at e37425ed17)
 + submodule: ignore trailing slash in relative url
 + submodule: ignore trailing slash on superproject URL

 A minor regression fix for "git submodule".

 Will merge to 'master'.


* st/verify-tag (2016-10-10) 7 commits
 - t/t7004-tag: Add --format specifier tests
 - t/t7030-verify-tag: Add --format specifier tests
 - builtin/tag: add --format argument for tag -v
 - builtin/verify-tag: add --format to verify-tag
 - tag: add format specifier to gpg_verify_tag
 - ref-filter: add function to print single ref_array_item
 - gpg-interface, tag: add GPG_VERIFY_QUIET flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Is this ready for 'next'?


* js/reset-usage (2016-10-11) 1 commit
  (merged to 'next' on 2016-10-11 at 61ad4a7c0e)
 + reset: fix usage

 Will merge to 'master'.


* mm/credential-libsecret (2016-10-11) 1 commit
 - contrib: add credential helper for libsecret

 Will merge to 'next'.


* rs/pretty-format-color-doc-fix (2016-10-11) 1 commit
  (merged to 'next' on 2016-10-11 at f0ae64bcbd)
 + pretty: fix document link for color specification

 Will merge to 'master'.


* sb/attr (2016-10-11) 28 commits
 - attr: convert to new threadsafe API
 - attr: make git_check_attr_counted static
 - attr: make git_attr_counted static
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.


* sb/submodule-config-doc-drop-path (2016-10-11) 1 commit
  (merged to 'next' on 2016-10-11 at 28fc3e53f9)
 + documentation: improve submodule.<name>.{url, path} description

 The "submodule.<name>.path" stored in .gitmodules is never copied
 to .git/config and such a key in .git/config has no meaning, but
 the documentation described it and submodule.<name>.url next to
 each other as if both belong to .git/config.  This has been fixed.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.

 Will discard.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been two months without any support.  We may want to discard
 this.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.

 Will discard.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

 Will discard.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.

 Will discard.

--------------------------------------------------
[Cooking]

* jc/ws-error-highlight (2016-10-04) 4 commits
 - diff: introduce diff.wsErrorHighlight option
 - diff.c: move ws-error-highlight parsing helpers up
 - diff.c: refactor parse_ws_error_highlight()
 - t4015: split out the "setup" part of ws-error-highlight test

 "git diff/log --ws-error-highlight=<kind>" lacked the corresponding
 configuration variable to set it by default.

 Will merge to 'next'.


* jk/abbrev-auto (2016-10-03) 1 commit
 - find_unique_abbrev: move logic out of get_short_sha1()
 (this branch uses lt/abbrev-auto.)

 Updates the way approximate count of total objects is computed
 while attempting to come up with a unique abbreviated object name,
 which in turn needs to estimate how many hexdigits are necessary to
 ensure uniqueness.

 Undecided.


* jk/clone-copy-alternates-fix (2016-10-05) 1 commit
  (merged to 'next' on 2016-10-10 at 8154134c8c)
 + clone: detect errors in normalize_path_copy

 "git clone" of a local repository can be done at the filesystem
 level, but the codepath did not check errors while copying and
 adjusting the file that lists alternate object stores.

 Will merge to 'master'.


* nd/commit-p-doc (2016-10-05) 1 commit
  (merged to 'next' on 2016-10-10 at 5a9996dd7b)
 + git-commit.txt: clarify --patch mode with pathspec

 Documentation for "git commit" was updated to clarify that "commit
 -p <paths>" adds to the current contents of the index to come up
 with what to commit.

 Will merge to 'master'.


* nd/ita-empty-commit (2016-09-28) 3 commits
 - commit: don't be fooled by ita entries when creating initial commit
 - diff-lib.c: enable --shift-ita in index_differs_from()
 - Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"

 When new paths were added by "git add -N" to the index, it was
 enough to circumvent the check by "git commit" to refrain from
 making an empty commit without "--allow-empty".  The same logic
 prevented "git status" to show such a path as "new file" in the
 "Changes not staged for commit" section.

 Expecting a reroll.
 cf. <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
 cf. <xmqq8tubkgg5.fsf@gitster.mtv.corp.google.com>


* lt/abbrev-auto (2016-10-03) 3 commits
  (merged to 'next' on 2016-10-03 at bb188d00f7)
 + abbrev: auto size the default abbreviation
 + abbrev: prepare for new world order
 + abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
 (this branch is used by jk/abbrev-auto.)

 Allow the default abbreviation length, which has historically been
 7, to scale as the repository grows.  The logic suggests to use 12
 hexdigits for the Linux kernel, and 9 to 10 for Git itself.

 Will hold to see if people scream.


* dt/http-empty-auth (2016-10-04) 1 commit
  (merged to 'next' on 2016-10-10 at 10b7b0a6a5)
 + http: http.emptyauth should allow empty (not just NULL) usernames

 http.emptyauth configuration is a way to allow an empty username to
 pass when attempting to authenticate using mechanisms like
 Kerberos.  We took an unspecified (NULL) username and sent ":"
 (i.e. no username, no password) to CURLOPT_USERPWD, but did not do
 the same when the username is explicitly set to an empty string.

 Will merge to 'master'.


* jc/diff-unique-abbrev-comments (2016-09-30) 1 commit
 - diff_unique_abbrev(): document its assumption and limitation

 A bit more comments in a tricky code.

 Will merge to 'next'.


* jk/quarantine-received-objects (2016-10-10) 5 commits
  (merged to 'next' on 2016-10-10 at 0fd3e3b2ef)
 + tmp-objdir: do not migrate files starting with '.'
 + tmp-objdir: put quarantine information in the environment
 + receive-pack: quarantine objects until pre-receive accepts
 + tmp-objdir: introduce API for temporary object directories
 + check_connected: accept an env argument
 (this branch uses jk/alt-odb-cleanup.)

 In order for the receiving end of "git push" to inspect the
 received history and decide to reject the push, the objects sent
 from the sending end need to be made available to the hook and
 the mechanism for the connectivity check, and this was done
 traditionally by storing the objects in the receiving repository
 and letting "git gc" to expire it.  Instead, store the newly
 received objects in a temporary area, and make them available by
 reusing the alternate object store mechanism to them only while we
 decide if we accept the check, and once we decide, either migrate
 them to the repository or purge them immediately.

 Will merge to 'master'.


* jk/alt-odb-cleanup (2016-10-10) 18 commits
  (merged to 'next' on 2016-10-10 at d2ed6b6d21)
 + alternates: use fspathcmp to detect duplicates
 + sha1_file: always allow relative paths to alternates
 + count-objects: report alternates via verbose mode
 + fill_sha1_file: write into a strbuf
 + alternates: store scratch buffer as strbuf
 + fill_sha1_file: write "boring" characters
 + alternates: use a separate scratch space
 + alternates: encapsulate alt->base munging
 + alternates: provide helper for allocating alternate
 + alternates: provide helper for adding to alternates list
 + link_alt_odb_entry: refactor string handling
 + link_alt_odb_entry: handle normalize_path errors
 + t5613: clarify "too deep" recursion tests
 + t5613: do not chdir in main process
 + t5613: whitespace/style cleanups
 + t5613: use test_must_fail
 + t5613: drop test_valid_repo function
 + t5613: drop reachable_via function
 (this branch is used by jk/quarantine-received-objects.)

 Codepaths involved in interacting alternate object store have
 been cleaned up.

 Will merge to 'master'.


* va/i18n-perl-scripts (2016-10-10) 14 commits
 - i18n: difftool: mark warnings for translation
 - i18n: send-email: mark string with interpolation for translation
 - i18n: send-email: mark warnings and errors for translation
 - i18n: send-email: mark strings for translation
 - i18n: add--interactive: mark status words for translation
 - i18n: add--interactive: remove %patch_modes entries
 - i18n: add--interactive: mark edit_hunk_manually message for translation
 - i18n: add--interactive: i18n of help_patch_cmd
 - i18n: add--interactive: mark patch prompt for translation
 - i18n: add--interactive: mark plural strings
 - i18n: clean.c: match string with git-add--interactive.perl
 - i18n: add--interactive: mark strings with interpolation for translation
 - i18n: add--interactive: mark simple here-documents for translation
 - i18n: add--interactive: mark strings for translation

 Porcelain scripts written in Perl are getting internationalized.

 Waiting for review.
 cf. <20161010125449.7929-1-vascomalmeida@sapo.pt>


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-28 at c8673e03c2)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will hold to see if people scream.


* mg/gpg-richer-status (2016-10-06) 2 commits
 - SQUASH: gpg-interface: use more status letters
 - gpg-interface: use more status letters

 The GPG verification status shown in "%G?" pretty format specifier
 was not rich enough to differentiate a signature made by an expired
 key, a signature made by a revoked key, etc.  New output letters
 have been assigned to express them.

 Waiting for a response to ping/squash.


* js/libify-require-clean-work-tree (2016-10-07) 6 commits
 - wt-status: begin error messages with lower-case
 - wt-status: teach has_{unstaged,uncommitted}_changes() about submodules
 - wt-status: export also the has_un{staged,committed}_changes() functions
 - wt-status: make the require_clean_work_tree() function reusable
 - pull: make code more similar to the shell script again
 - pull: drop confusing prefix parameter of die_on_unclean_work_tree()

 The require_clean_work_tree() helper was recreated in C when "git
 pull" was rewritten from shell; the helper is now made available to
 other callers in preparation for upcoming "rebase -i" work.

 Will merge to 'next'.


* bw/ls-files-recurse-submodules (2016-10-10) 4 commits
 - ls-files: add pathspec matching for submodules
 - ls-files: pass through safe options for --recurse-submodules
 - ls-files: optionally recurse into submodules
 - git: make super-prefix option

 "git ls-files" learned "--recurse-submodules" option that can be
 used to get a listing of tracked files across submodules (i.e. this
 only works with "--cached" option, not for listing untracked or
 ignored files).  This would be a useful tool to sit on the upstream
 side of a pipe that is read with xargs to work on all working tree
 files from the top-level superproject.

 Will merge to 'next'.


* ls/filter-process (2016-10-10) 14 commits
 - contrib/long-running-filter: add long running filter example
 - convert: add filter.<driver>.process option
 - convert: prepare filter.<driver>.process option
 - convert: make apply_filter() adhere to standard Git error handling
 - pkt-line: add functions to read/write flush terminated packet streams
 - pkt-line: add packet_write_gently()
 - pkt-line: add packet_flush_gently()
 - pkt-line: add packet_write_fmt_gently()
 - pkt-line: extract set_packet_header()
 - pkt-line: rename packet_write() to packet_write_fmt()
 - run-command: add clean_on_exit_handler
 - run-command: move check_pipe() from write_or_die to run_command
 - convert: modernize tests
 - convert: quote filter names in error messages

 The smudge/clean filter API expect an external process is spawned
 to filter the contents for each path that has a filter defined.  A
 new type of "process" filter API has been added to allow the first
 request to run the filter for a path to spawn a single process, and
 all filtering need is served by this single process for multiple
 paths, reducing the process creation overhead.


* hv/submodule-not-yet-pushed-fix (2016-10-10) 3 commits
 - batch check whether submodule needs pushing into one call
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 Waiting for review.
 cf. <cover.1475851621.git.hvoigt@hvoigt.net>


* sg/fix-versioncmp-with-common-suffix (2016-09-08) 5 commits
 - versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
 - versioncmp: pass full tagnames to swap_prereleases()
 - t7004-tag: add version sort tests to show prerelease reordering issues
 - t7004-tag: use test_config helper
 - t7004-tag: delete unnecessary tags with test_when_finished

 The prereleaseSuffix feature of version comparison that is used in
 "git tag -l" did not correctly when two or more prereleases for the
 same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
 are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 Waiting for a reroll.
 cf. <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>


* sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
 - push: change submodule default to check when submodules exist
 - submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will hold to wait for hv/submodule-not-yet-pushed-fix


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-09-21 at e19148ea63)
 + pathspec: warn on empty strings as pathspec

 Originally merged to 'next' on 2016-07-13

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will hold to see if people scream.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-10-11 at 8928c8b9b3)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* jc/attr (2016-05-25) 18 commits
 . attr: support quoting pathname patterns in C style
 . attr: expose validity check for attribute names
 . attr: add counted string version of git_attr()
 . attr: add counted string version of git_check_attr()
 . attr: retire git_check_attrs() API
 . attr: convert git_check_attrs() callers to use the new API
 . attr: convert git_all_attrs() to use "struct git_attr_check"
 . attr: (re)introduce git_check_attr() and struct git_attr_check
 . attr: rename function and struct related to checking attributes
 . attr.c: plug small leak in parse_attr_line()
 . attr.c: tighten constness around "git_attr" structure
 . attr.c: simplify macroexpand_one()
 . attr.c: mark where #if DEBUG ends more clearly
 . attr.c: complete a sentence in a comment
 . attr.c: explain the lack of attr-name syntax check in parse_attr()
 . attr.c: update a stale comment on "struct match_attr"
 . attr.c: use strchrnul() to scan for one line
 . commit.c: use strchrnul() to scan for one line
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready.

 As the authors of topics that depend on this seem not in a hurry,
 let's discard this and dependent topics and restart them some other
 day.


* jc/attr-more (2016-06-09) 8 commits
 . attr.c: outline the future plans by heavily commenting
 . attr.c: always pass check[] to collect_some_attrs()
 . attr.c: introduce empty_attr_check_elems()
 . attr.c: correct ugly hack for git_all_attrs()
 . attr.c: rename a local variable check
 . fixup! d5ad6c13
 . attr.c: pass struct git_attr_check down the callchain
 . attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.


* sb/submodule-default-paths (2016-06-20) 5 commits
 . completion: clone can recurse into submodules
 . clone: add --init-submodule=<pathspec> switch
 . submodule update: add `--init-default-path` switch
 . Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 . Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.


* sb/pathspec-label (2016-06-03) 6 commits
 . pathspec: disable preload-index when attribute pathspec magic is in use
 . pathspec: allow escaped query values
 . pathspec: allow querying for attributes
 . pathspec: move prefix check out of the inner loop
 . pathspec: move long magic parsing out of prefix_pathspec
 . Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.


* sb/bisect (2016-04-15) 22 commits
 . SQUASH???
 . bisect: get back halfway shortcut
 . bisect: compute best bisection in compute_relevant_weights()
 . bisect: use a bottom-up traversal to find relevant weights
 . bisect: prepare for different algorithms based on find_all
 . bisect: rename count_distance() to compute_weight()
 . bisect: make total number of commits global
 . bisect: introduce distance_direction()
 . bisect: extract get_distance() function from code duplication
 . bisect: use commit instead of commit list as arguments when appropriate
 . bisect: replace clear_distance() by unique markers
 . bisect: use struct node_data array instead of int array
 . bisect: get rid of recursion in count_distance()
 . bisect: make algorithm behavior independent of DEBUG_BISECT
 . bisect: make bisect compile if DEBUG_BISECT is set
 . bisect: plug the biggest memory leak
 . bisect: add test for the bisect algorithm
 . t6030: generalize test to not rely on current implementation
 . t: use test_cmp_rev() where appropriate
 . t/test-lib-functions.sh: generalize test_cmp_rev
 . bisect: allow 'bisect run' if no good commit is known
 . bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Was expecting a reroll, but now pb/bisect topic starts removinging
 more and more parts from git-bisect.sh, this needs to see a fresh
 reroll.

 cf. <1460294354-7031-1-git-send-email-s-beyer@gmx.net>


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Has been waiting for a reroll for too long.
 cf. <1456754714-25237-1-git-send-email-szeder@ira.uka.de>


* pb/bisect (2016-08-23) 27 commits
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--check-and-set-terms` subcommand
 . bisect--helper: retire `--bisect-write` subcommand
 . bisect--helper: `bisect_replay` shell function in C
 . bisect--helper: `bisect_log` shell function in C
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: `bisect_state` & `bisect_head` shell function in C
 . bisect--helper: `bisect_autostart` shell function in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 GSoC "bisect" topic.

 I'd prefer to see early part solidified so that reviews can focus
 on the later part that is still in flux.  We are almost there but
 not quite yet.
