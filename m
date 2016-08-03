Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC951F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbcHCXGh (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:06:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933063AbcHCXGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 19:06:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C538333578;
	Wed,  3 Aug 2016 19:06:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	siacphYjfM9YnwlSyK/0mKMDXQ=; b=cypmz9YF7hOYZxG7s0PvwpU6hsyBDnus+
	OlWwCzjAcocV7pQP1AYROz+Ytn2WoLckwZdlMYNf1oo7P1t6o6OtYUJqqCU/S/3j
	jzYrn8MXEpSrbggpYKjfBK0t7Y5lNE6hfhkFoqd0dgNN1G6A71PRHnuIPE/z3HE7
	2BBnUZufmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VO0
	thQ0DXzndLUraQNthI8py1UOwacvCPDCffzLfDn9L+7S2EcIqtAKU6L+vdHTQ99U
	mhR+gdO9XMcjZHPzjYGbZkui3w+3pI30Ea+SJJnCcI12khlGF14qPkLEBTXwviP9
	gwQWhfSFhMz8pSSVfx2NT5pQlbnASyByDeeyFi8Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE01633577;
	Wed,  3 Aug 2016 19:06:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3026033576;
	Wed,  3 Aug 2016 19:06:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking (interim report)
Date:	Wed, 03 Aug 2016 16:06:20 -0700
Message-ID: <xmqqd1lp78r7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5091AAA-59CE-11E6-88F8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Quite a many topics have been merged to 'master' and 'next'.

As I just did a full "What's cooking" yesterday, I'd only list the
new topics and "highlights", the latter of which are what would
benefit from the last round of eyeballs from reviewers.

Many topics have been in 'Cooking' section even though they do not
show any progress; I'll start moving them to 'Stalled' and then
'Discarded' soonish.  Note that "Discarded" does not mean "Rejected,
don't talk about this ever again"; it merely means "With remaining
issue left unaddressed, I do not see a point in keeping it in my
tree right now".

--------------------------------------------------
[New Topics]

* jh/clean-smudge-f-doc (2016-08-03) 1 commit
 - clarify %f documentation

 Split out from a stalled jh/clean-smudge-annex topic before
 discarding it.

 Will merge to 'next'.


* jh/status-v2-porcelain (2016-08-03) 8 commits
 - status: tests for --porcelain=v2
 - git-status.txt: describe --porcelain=v2 format
 - status: print branch info with --porcelain=v2 --branch
 - status: print per-file porcelain v2 status data
 - status: per-file data collection for --porcelain=v2
 - status: support --porcelain[=<version>]
 - status: cleanup API to wt_status_print
 - status: rename long-format print routines

 Enhance "git status --porcelain" output by collecting more data on
 the state of the index and the working tree files, which may
 further be used to teach git-prompt (in contrib/) to make fewer
 calls to git.


* jk/parseopt-string-list (2016-08-03) 1 commit
 - blame: drop strdup of string literal

 A recent API change to parse_opt_string_list() introduced a small
 unintended memory leak in the command line parsing of "git blame",
 which has been plugged.

 Will merge to 'next'.


* js/import-tars-hardlinks (2016-08-03) 1 commit
 - import-tars: support hard links

 "import-tars" fast-import script (in contrib/) used to ignore a
 hardlink target and replaced it with an empty file, which has been
 corrected to record the same blob as the other file the hardlink is
 shared with.


* js/t4130-rename-without-ino (2016-08-03) 1 commit
 - t4130: work around Windows limitation

 Windows port was failing some tests in t4130, due to the lack of
 inum in the returned values by its lstat(2) emulation.

 Will merge to 'next' and then to 'master' and then to 'maint'.


* nd/fbsd-lazy-mtime (2016-08-03) 2 commits
 - SQUASH???
 - t7063: work around FreeBSD's lazy mtime update feature

 FreeBSD can lie when asked mtime of a directory, which made the
 untracked cache code to fall back to a slow-path, which in turn
 caused tests in t7063 to fail because it wanted to verify the
 behaviour of the fast-path.

 Waiting for a response to SQUASH???


* sb/submodule-recommend-shallowness (2016-08-03) 1 commit
 - gitmodules: document shallow recommendation

 Doc update.

 Will merge to 'next'.

--------------------------------------------------
[Cooking]

* ew/build-time-pager-tweaks (2016-08-03) 2 commits
 - SQUASH???
 - pager: move pager-specific setup into the build

 The build procedure learned PAGER_ENV knob that lists what default
 environment variable settings to export for popular pagers.  This
 mechanism is used to tweak the default settings to MORE on FreeBSD.

 Expecting a reroll.


* ib/t3700-add-chmod-x-updates (2016-08-01) 3 commits
  (merged to 'next' on 2016-08-03 at 1753346)
 + t3700: add a test_mode_in_index helper function
 + t3700: merge two tests into one
 + t3700: remove unwanted leftover files before running new tests

 The t3700 test about "add --chmod=-x" have been made a bit more
 robust and generally cleaned up.

 Will merge to 'master'.

This may want to go to 'maint'.


* sb/submodule-update-dot-branch (2016-08-01) 7 commits
 - submodule update: allow '.' for branch value
 - submodule--helper: add remote-branch helper
 - submodule-config: keep configured branch around
 - submodule--helper: fix usage string for relative-path
 - submodule update: narrow scope of local variable
 - submodule update: respect depth in subsequent fetches
 - t7406: future proof tests with hard coded depth

 A few updates to "git submodule update".

 Will merge to 'next'.


* jc/hashmap-doc-init (2016-08-02) 1 commit
 - hashmap: clarify that hashmap_entry can safely be discarded

 The API documentation for hashmap was unclear if hashmap_entry
 can be safely discarded without any other consideration.  State
 that it is safe to do so.


* jk/pack-objects-optim-mru (2016-07-29) 1 commit
 - pack-objects: use mru list when iterating over packs
 (this branch uses jk/pack-objects-optim.)

 This is still questionable in that it can attempt to create a cycle
 in delta-chain, only to be stopped by the last-ditch recovery logic
 in there.


* kw/patch-ids-optim (2016-07-29) 4 commits
 - rebase: avoid computing unnecessary patch IDs
 - patch-ids: add flag to create the diff patch id using header only data
 - patch-ids: replace the seen indicator with a commit pointer
 - patch-ids: stop using a hand-rolled hashmap implementation

 When "git rebase" tries to compare set of changes on the updated
 upstream and our own branch, it computes patch-id for all of these
 changes and attempts to find matches. This has been optimized by
 lazily computing the full patch-id (which is expensive) to be
 compared only for changes that touch the same set of paths.

 Will merge to 'next'.


* jk/reset-ident-time-per-commit (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-03 at 76d569c)
 + am: reset cached ident date for each patch

 Not-so-recent rewrite of "git am" that started making internal
 calls into the commit machinery had an unintended regression, in
 that no matter how many seconds it took to apply many patches, the
 resulting committer timestamp for the resulting commits were all
 the same.

 Will merge to 'master'.


* js/am-3-merge-recursive-direct (2016-08-01) 16 commits
 - merge-recursive: flush output buffer even when erroring out
 - merge_trees(): ensure that the callers release output buffer
 - merge-recursive: offer an option to retain the output in 'obuf'
 - merge-recursive: write the commit title in one go
 - merge-recursive: flush output buffer before printing error messages
 - am -3: use merge_recursive() directly again
 - merge-recursive: switch to returning errors instead of dying
 - merge-recursive: handle return values indicating errors
 - merge-recursive: allow write_tree_from_memory() to error out
 - merge-recursive: avoid returning a wholesale struct
 - merge_recursive: abort properly upon errors
 - prepare the builtins for a libified merge_recursive()
 - merge-recursive: clarify code in was_tracked()
 - die(_("BUG")): avoid translating bug messages
 - die("bug"): report bugs consistently
 - t5520: verify that `pull --rebase` shows the helpful advice when failing

 "git am -3" calls "git merge-recursive" when it needs to fall back
 to a three-way merge; this call has been turned into an internal
 subroutine call instead of spawning a separate subprocess.

 Eyes from other people are highly appreciated, as my eyes (and the
 original author's, too) have rotten by staring many rerolls of the
 same topic and are not effective in spotting errors.


* nd/log-decorate-color-head-arrow (2016-07-12) 1 commit
 - log: decorate HEAD -> branch with the same color for arrow and HEAD

 An entry "git log --decorate" for the tip of the current branch is
 shown as "HEAD -> name" (where "name" is the name of the branch);
 paint the arrow in the same color as "HEAD", not in the color for
 commits.

 Comments?  Personally I find it more-or-less "Meh".


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* po/range-doc (2016-07-20) 8 commits
 - doc: revisions - clarify reachability examples
 - doc: revisions - define `reachable`
 - doc: gitrevisions - clarify 'latter case' is revision walk
 - doc: gitrevisions - use 'reachable' in page description
 - doc: give headings for the two and three dot notations
 - doc: show the actual left, right, and boundary marks
 - doc: revisions - name the left and right sides
 - doc: use 'symmetric difference' consistently

 Clarify various ways to specify the "revision ranges" in the
 documentation.

 Updates in 4/8 ("give headings") is reported to break formatting?
 cf. <57913C97.1030001@xiplink.com>


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-07-13 at d9ca7fb)
 + pathspec: warn on empty strings as pathspec

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


* pb/bisect (2016-08-02) 13 commits
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` shell function in C
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
