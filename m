From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #03; Thu, 9)
Date: Thu, 09 Feb 2012 16:15:07 -0800
Message-ID: <7vr4y3tugk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rve96-00082A-VM
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757818Ab2BJAPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:15:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42457 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab2BJAPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:15:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851117A23;
	Thu,  9 Feb 2012 19:15:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=It7Yuz8mR3sJvjETPzcVPk/39
	YY=; b=UyjiMKhwZ6rVWjeCC3S6X6Qz1EExK2NSdtHfhBa2goU2Mx1VFH7UvjO9K
	683/3xWXfBFXdEjay9cc5bPeCEK+4mLJx90qaFUCZ3kl4InUqK8gqAxe+8m1R7Jx
	vw55FRZWrv219L5q086+02WHsYaSlBRlrDyX3aT2aj+mz5M2+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=cBKng9hU4Rwj9Bm4+/t
	NOwScGhGbzbx2QR0b++RPkBEtAgjDEpxPAedOW7szF+ZmWqGZTNRp2uxpQSUwUdJ
	6cWoUTby9GMjO3GUDcYY5bNmv4HV5u+qMJ3NdmZjwIzn4nLPrHHyBZdz9yf3CY1H
	WayBaF6HUnwxm2Jrpb4axPWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9F697A0B;
	Thu,  9 Feb 2012 19:15:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A45779E1; Thu,  9 Feb 2012
 19:15:09 -0500 (EST)
X-master-at: 12766861cdf10fbbfda1023fd65aaf864eb8136a
X-next-at: 35cc89d1e2c66d6b01c986f1d2eb3248ee5667f1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ACABA8C-537C-11E1-AC34-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190347>

What's cooking in git.git (Feb 2012, #03; Thu, 9)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

Compared to the recent activity level on discussions of new features on
the list, some people may be wondering if the rate of advancement of th=
e
'master' and 'next' branches is getting throttled.

That is because it is.

Now the obviously good bits that have been cooking during the feature
freeze are pushed out to 'master', I'd want to make sure we can have a
timely release of v1.7.9.1 so that people can start benefiting from the
features and fixes introduced in v1.7.9 more smoothly and sooner, and t=
hat
is where my focus lies at this moment. I've been picking up new topics =
and
adding them to 'pu' only "as time and attention permit" basis, and this
mode of operation probably will continue throughout the second week of =
the
post v1.7.9 cycle (cf. http://tinyurl.com/gitcal).

I would like to see more people test the tip of 'pu' as soon as possibl=
e
to make sure the fixes to 'git merge' give more pleasant user experienc=
e
than stock 1.7.9 release. Things to expect are:

 * "git merge --ff-only v3.2" that should fast-forward to the commit th=
at
   is tagged should fast-forward, without creating the merge commit tha=
t
   records the contents taken from v3.2 tag (the topic
   jc/merge-ff-only-stronger-than-signed-merge in 'next' should take ca=
re
   of this issue);

 * "git merge --no-edit v3.2" does not spawn an editor, but does create
   the merge commit to record the contents taken from v3.2 tag (the top=
ic
   jn/merge-no-edit-fix in 'pu' should take care of this issue).

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bl/gitweb-project-filter (2012-02-01) 8 commits
  (merged to 'next' on 2012-02-01 at 2c96ce7)
 + gitweb: Make project search respect project_filter
 + gitweb: improve usability of projects search form
 + gitweb: place links to parent directories in page header
 + gitweb: show active project_filter in project_list page header
 + gitweb: limit links to alternate forms of project_list to active pro=
ject_filter
 + gitweb: add project_filter to limit project list to a subdirectory
 + gitweb: prepare git_get_projects_list for use outside 'forks'.
 + gitweb: move hard coded .git suffix out of git_get_projects_list

"gitweb" allows intermediate entries in the directory hierarchy that le=
ads
to a projects to be clicked, which in turn shows the list of projects
inside that directory.

* jc/maint-request-pull-for-tag (2012-01-31) 1 commit
  (merged to 'next' on 2012-02-01 at 7649f18)
 + request-pull: explicitly ask tags/$name to be pulled

When asking for a tag to be pulled, "request-pull" shows the name of th=
e
tag prefixed with "tags/"

* jn/svn-fe (2012-02-02) 47 commits
  (merged to 'next' on 2012-02-05 at e9d3917)
 + vcs-svn: suppress a -Wtype-limits warning
 + vcs-svn: allow import of > 4GiB files
 + vcs-svn: rename check_overflow arguments for clarity
  (merged to 'next' on 2012-02-01 at 9288c95)
 + vcs-svn/svndiff.c: squelch false "unused" warning from gcc
 + Merge branch 'svn-fe' of git://repo.or.cz/git/jrn into jn/svn-fe
 + vcs-svn: reset first_commit_done in fast_export_init
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: do not initialize report_buffer twice
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: avoid hangs from corrupt deltas
 + vcs-svn: guard against overflow when computing preimage length
 + Merge branch 'db/delta-applier' into db/text-delta
 + vcs-svn: implement text-delta handling
 + Merge branch 'db/delta-applier' into db/text-delta
 + Merge branch 'db/delta-applier' into svn-fe
 + vcs-svn: cap number of bytes read from sliding view
 + test-svn-fe: split off "test-svn-fe -d" into a separate function
 + vcs-svn: let deltas use data from preimage
 + vcs-svn: let deltas use data from postimage
 + vcs-svn: verify that deltas consume all inline data
 + vcs-svn: implement copyfrom_data delta instruction
 + vcs-svn: read instructions from deltas
 + vcs-svn: read inline data from deltas
 + vcs-svn: read the preimage when applying deltas
 + vcs-svn: parse svndiff0 window header
 + vcs-svn: skeleton of an svn delta parser
 + vcs-svn: make buffer_read_binary API more convenient
 + vcs-svn: learn to maintain a sliding view of a file
 + Makefile: list one vcs-svn/xdiff object or header per line
 + Merge branch 'db/svn-fe-code-purge' into svn-fe
 + vcs-svn: drop obj_pool
 + vcs-svn: drop treap
 + vcs-svn: drop string_pool
 + vcs-svn: pass paths through to fast-import
 + Merge branch 'db/strbufs-for-metadata' into db/svn-fe-code-purge
 + Merge branch 'db/length-as-hash' (early part) into db/svn-fe-code-pu=
rge
 + Merge branch 'db/vcs-svn-incremental' into svn-fe
 + vcs-svn: avoid using ls command twice
 + vcs-svn: use mark from previous import for parent commit
 + vcs-svn: handle filenames with dq correctly
 + vcs-svn: quote paths correctly for ls command
 + vcs-svn: eliminate repo_tree structure
 + vcs-svn: add a comment before each commit
 + vcs-svn: save marks for imported commits
 + vcs-svn: use higher mark numbers for blobs
 + vcs-svn: set up channel to read fast-import cat-blob response
 + Merge commit 'v1.7.5' into svn-fe

Originally merged to 'next' on 2012-01-29.

"vcs-svn"/"svn-fe" learned to read dumps with svn-deltas and support
incremental imports.

* jx/i18n-more-marking (2012-02-01) 2 commits
  (merged to 'next' on 2012-02-05 at 44e8cf6)
 + i18n: format_tracking_info "Your branch is behind" message
 + i18n: git-commit whence_s "merge/cherry-pick" message

Marks a few more messages we forgot to mark for i18n.

* rt/completion-branch-edit-desc (2012-01-29) 1 commit
  (merged to 'next' on 2012-02-01 at 0627ebf)
 + completion: --edit-description option for git-branch

Originally merged to 'next' on 2012-01-31.

--------------------------------------------------
[New Topics]

* jk/config-include (2012-02-06) 2 commits
 - config: add include directive
 - docs: add a basic description of the config API

An assignment to the include.path pseudo-variable causes the named file
to be included in-place when Git looks up configuration variables.

* jk/maint-tag-show-fixes (2012-02-08) 3 commits
  (merged to 'next' on 2012-02-08 at 18459c4)
 + tag: do not show non-tag contents with "-n"
 + tag: die when listing missing or corrupt objects
 + tag: fix output of "tag -n" when errors occur

Bugfixes to "git tag -n" that lacked much error checking.

* mm/empty-loose-error-message (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-07 at f119cac)
 + fsck: give accurate error message on empty loose object files

Updates the error message emitted when we see an empty loose object.

* nd/columns (2012-02-08) 15 commits
 - column: Fix some compiler and sparse warnings
 - column: add a corner-case test to t3200
 - columns: minimum coding style fixes
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add column.ui for default column output settings
 - column: support columns with different widths
 - column: add columnar layout
 - Stop starting pager recursively
 - Add git-column and column mode parsing
 - column: add API to print items in columns
 - Save terminal width before setting up pager

The "show list of ..." mode of a handful of commands learn to produce
column-oriented output.

Expecting a reroll.

* jc/maint-commit-ignore-i-t-a (2012-02-07) 1 commit
 - commit: ignore intent-to-add entries instead of refusing

Replaces the nd/commit-ignore-i-t-a series that was made unnecessary
complicated by bad suggestions I made earlier.

* jk/userdiff-config-simplify (2012-02-07) 1 commit
 - drop odd return value semantics from userdiff_config

Code cleanup.

* js/add-e-submodule-fix (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-08 at c8e2d28)
 + add -e: do not show difference in a submodule that is merely dirty

"add -e" learned not to show a diff for an otherwise unmodified submodu=
le
that only has uncommitted local changes in the patch prepared by for th=
e
user to edit.

* nd/cache-tree-api-refactor (2012-02-07) 1 commit
  (merged to 'next' on 2012-02-08 at a9abbca)
 + cache-tree: update API to take abitrary flags

Code cleanup.

* tg/tag-points-at (2012-02-08) 1 commit
 - tag: add --points-at list option

Will merge to 'next'.

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

* jn/merge-no-edit-fix (2012-02-09) 1 commit
 - merge: do not launch an editor on "--no-edit $tag"
 (this branch uses jc/merge-ff-only-stronger-than-signed-merge.)

* ld/git-p4-expanded-keywords (2012-02-09) 2 commits
 - git-p4: initial demonstration of possible RCS keyword fixup
 - git-p4: add test case for RCS keywords

* mp/make-cleanse-x-for-exe (2012-02-09) 1 commit
  (merged to 'next' on 2012-02-09 at 35cc89d)
 + Explicitly set X to avoid potential build breakage

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

* jc/split-blob (2012-01-24) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in 127b177
(bulk-checkin: support chunked-object encoding, 2011-11-30), these are
still early steps of a long and painful journey. At least pack-objects =
and
fsck need to learn the new encoding for the series to be usable locally=
,
and then index-pack/unpack-objects needs to learn it to be used remotel=
y.

Given that I heard a lot of noise that people want large files, and tha=
t I
was asked by somebody at GitTogether'11 privately for an advice on how =
to
pay developers (not me) to help adding necessary support, I am somewhat
dissapointed that the original patch series that was sent almost two
months ago still remains here without much comments and updates from th=
e
developer community. I even made the interface to the logic that decide=
s
where to split chunks easily replaceable, and I deliberately made the
logic in the original patch extremely stupid to entice others, especial=
ly
the "bup" fanboys, to come up with a better logic, thinking that giving
people an easy target to shoot for, they may be encouraged to help
out. The plan is not working :-(.

--------------------------------------------------
[Cooking]

* bw/inet-pton-ntop-compat (2012-02-05) 1 commit
  (merged to 'next' on 2012-02-06 at 61303e6)
 + Drop system includes from inet_pton/inet_ntop compatibility wrappers

The inclusion order of header files bites Solaris again and this fixes =
it.

* jc/branch-desc-typoavoidance (2012-02-05) 2 commits
  (merged to 'next' on 2012-02-06 at 9fb0568)
 + branch --edit-description: protect against mistyped branch name
 + tests: add write_script helper function
 (this branch is tangled with jk/tests-write-script.)

Typo in "git branch --edit-description my-tpoic" was not diagnosed.

* jc/checkout-out-of-unborn (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-07 at 60eb328)
 + git checkout -b: allow switching out of an unborn branch

I was fairly negative on this one, but Michael Haggerty and Peff convin=
ced
me that selling this as "'checkout -b' that lack the <start point> is
about creating a new branch from my current state" is perfectly fine.

* jc/maint-mailmap-output (2012-02-06) 1 commit
  (merged to 'next' on 2012-02-06 at 0a21425)
 + mailmap: always return a plain mail address from map_user()

map_user() was not rewriting its output correctly, which resulted in th=
e
user visible symptom that "git blame -e" sometimes showed excess '>' at
the end of email addresses.

* jc/merge-ff-only-stronger-than-signed-merge (2012-02-05) 1 commit
  (merged to 'next' on 2012-02-06 at 0fabf12)
 + merge: do not create a signed tag merge under --ff-only option
 (this branch is used by jn/merge-no-edit-fix.)

"git merge --ff-only $tag" failed because it cannot record the required
mergetag without creating a merge, but this is so common operation for
branch that is used _only_ to follow the upstream, so it is allowed to
fast-forward without recording the mergetag.

* tt/profile-build-fix (2012-02-09) 2 commits
  (merged to 'next' on 2012-02-09 at 1c183af)
 + Makefile: fix syntax for older make
  (merged to 'next' on 2012-02-07 at c8c5f3f)
 + Fix build problems related to profile-directed optimization

* nd/diffstat-gramnum (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 7335ecc)
 + Use correct grammar in diffstat summary line

The commands in the "git diff" family and "git apply --stat" that count
the number of files changed and the number of lines inserted/deleted ha=
ve
been updated to match the output from "diffstat".  This also opens the
door to i18n this line.

* jk/grep-binary-attribute (2012-02-02) 9 commits
  (merged to 'next' on 2012-02-05 at 9dffa7e)
 + grep: pre-load userdiff drivers when threaded
 + grep: load file data after checking binary-ness
 + grep: respect diff attributes for binary-ness
 + grep: cache userdiff_driver in grep_source
 + grep: drop grep_buffer's "name" parameter
 + convert git-grep to use grep_source interface
 + grep: refactor the concept of "grep source" into an object
 + grep: move sha1-reading mutex into low-level code
 + grep: make locking flag global

=46ixes a longstanding bug that there was no way to tell "git grep" tha=
t a
path may look like text but it is not, which "git diff" can do using th=
e
attributes system. Now "git grep" honors the same "binary" (or "-diff")
attribute.

* jc/parse-date-raw (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-07 at 486ae6e)
 + parse_date(): '@' prefix forces git-timestamp
 + parse_date(): allow ancient git-timestamp

"rebase" and "commit --amend" failed to work on commits with ancient
timestamps near year 1970.

* jk/git-dir-lookup (2012-02-02) 1 commit
  (merged to 'next' on 2012-02-05 at 1856d74)
 + standardize and improve lookup rules for external local repos

When you have both .../foo and .../foo.git, "git clone .../foo" did not
favor the former but the latter.

* jk/prompt-fallback-to-tty (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-06 at c0c995a)
 + prompt: fall back to terminal if askpass fails
 + prompt: clean up strbuf usage

The code to ask for password did not fall back to the terminal input wh=
en
GIT_ASKPASS is set but does not work (e.g. lack of X with GUI askpass
helper).

* jk/tests-write-script (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-05 at 4264ffa)
 + t0300: use write_script helper
 + tests: add write_script helper function
 (this branch is tangled with jc/branch-desc-typoavoidance.)

* jn/gitweb-search-utf-8 (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 055e446)
 + gitweb: Allow UTF-8 encoded CGI query parameters and path_info

Search box in "gitweb" did not accept non-ASCII characters correctly.

* jn/rpm-spec (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at dba940b)
 + git.spec: Workaround localized messages not put in any RPM

=46ix breakage in v1.7.9 Makefile; rpmbuild notices an unpackaged but
installed *.mo file and fails.

* fc/zsh-completion (2012-02-06) 3 commits
  (merged to 'next' on 2012-02-06 at c94dd12)
 + completion: simplify __gitcomp and __gitcomp_nl implementations
 + completion: use ls -1 instead of rolling a loop to do that ourselves
 + completion: work around zsh option propagation bug

=46ix git subcommand completion for zsh (in contrib/completion).

* nd/find-pack-entry-recent-cache-invalidation (2012-02-01) 2 commits
  (merged to 'next' on 2012-02-01 at e26aed0)
 + find_pack_entry(): do not keep packed_git pointer locally
 + sha1_file.c: move the core logic of find_pack_entry() into fill_pack=
_entry()

* nd/pack-objects-parseopt (2012-02-01) 3 commits
  (merged to 'next' on 2012-02-05 at d0dc25d)
 + pack-objects: convert to use parse_options()
 + pack-objects: remove bogus comment
 + pack-objects: do not accept "--index-version=3Dversion,"

"pack-objects" learned use parse-options, losing custom command line
parsing code.

--------------------------------------------------
[Discarded]

* nd/commit-ignore-i-t-a (2012-02-06) 4 commits
 . commit: remove commit.ignoreIntentToAdd, assume it's always true
 . commit: turn commit.ignoreIntentToAdd to true by default
 . commit: introduce a config key to allow as-is commit with i-t-a entr=
ies
 . cache-tree: update API to take abitrary flags

Instead of using configuration to selectively delay bugfixes like this
series does, let's sell it as a pure bugfix.
