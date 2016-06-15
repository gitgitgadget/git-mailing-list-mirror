From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #09; Sun, 26)
Date: Sun, 26 Feb 2012 23:49:40 -0800
Message-ID: <7vd390btrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vLB-00048y-AD
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2B0Hto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:49:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab2B0Htn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 02:49:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE1812874;
	Mon, 27 Feb 2012 02:49:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ddM9R5C8sTBTzxEkddRZ+OoQy
	vo=; b=jMBVNkoRwJVzpAL6tiLiMNhjYLrJoCDJ7HOK1WNW8l3TCuQqaYbJoMPka
	01x5evf3LQt/w6Ri6yRJQD6W7V66w9CAG+dFrs72hcGYZeTdrqP6ZFW7eFM75qJu
	Z19iOmif/4223SRhxhzw5wP0PMUTSgKHDvYggSAN3ze0Ohh0Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=a3msEuNfzq9V/c/2L3x
	opf/Hs98XTD9pIRXmFlPnQeYqBlxef0mSt/cle7Defzu8JUfupIx7S4rGys4IrSX
	myAY/44FMSaVLcKew3SgIwmOfbzFT/LxeVn9qgnxfPVMKEWva24p8aPWrXqet4sY
	NI6MW4TSBG/khcMgbmEGML7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B683D2873;
	Mon, 27 Feb 2012 02:49:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE4DF2871; Mon, 27 Feb 2012
 02:49:41 -0500 (EST)
X-master-at: 3724cc7c58df709cffbf6cc0701d1ca6fa5a5ba2
X-next-at: 62a6ddf54b0fda0c3cc0e609af05c6ce3503f51c
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B7BC00E-6117-11E1-97EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191604>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/am-3-nonstandard-popt (2012-02-26) 2 commits
  (merged to 'next' on 2012-02-26 at 62a6ddf)
 + test: "am -3" can accept non-standard -p<num>
  (merged to 'next' on 2012-02-26 at 1363bd6)
 + am -3: allow nonstandard -p<num> option

The code to synthesize the fake ancestor tree used by 3-way merge
fallback in "git am" was not prepared to read a patch created with
a non-standard -p<num> value.

* cb/fsck-squelch-dangling (2012-02-26) 1 commit
 - fsck: do not print dangling objects by default

Introduces "fsck --dangling" and removes the output for dangling object=
s
from the default output.

I personally do not think it is worth risking backward compatibility in
the way this patch implements the squelching of the output.  An approac=
h
to add --no-dangling option without changing the default would be OK,
though.

* rf/no-no-no-parseopt (2012-02-26) 3 commits
 - parse-options: remove PARSE_OPT_NEGHELP
 - parse-options: allow positivation of options starting, with no-
 - test-parse-options: convert to OPT_BOOL()

Options that use PARSE_OPT_NEGHELP needed to word their help text in
a strange way.

--------------------------------------------------
[Graduated to "master"]

* fc/push-prune (2012-02-22) 4 commits
  (merged to 'next' on 2012-02-23 at 8044055)
 + push: add '--prune' option
 + remote: refactor code into alloc_delete_ref()
 + remote: reorganize check_pattern_match()
 + remote: use a local variable in match_push_refs()

"git push" learned the "--prune" option, similar to "git fetch".

* jb/filter-ignore-sigpipe (2012-02-21) 1 commit
  (merged to 'next' on 2012-02-23 at 605dd39)
 + Ignore SIGPIPE when running a filter driver

When the filter driver exits before reading the content before the main
git process writes the contents to be filtered to the pipe to it, the
latter could be killed with SIGPIPE instead of ignoring such an event a=
s
an error.

* jc/add-refresh-unmerged (2012-02-17) 1 commit
  (merged to 'next' on 2012-02-21 at 09f8721)
 + refresh_index: do not show unmerged path that is outside pathspec

"git add --refresh <pathspec>" warned about unmerged paths outside the
given pathspec.

* jc/doc-merge-options (2012-02-22) 1 commit
  (merged to 'next' on 2012-02-23 at dcf1d13)
 + Documentation/merge-options.txt: group "ff" related options together

Documentation for "git merge" had "--ff-only" far away from other optio=
ns
related to the handling of fast-forward merges.

* jk/config-include (2012-02-17) 10 commits
  (merged to 'next' on 2012-02-20 at 7b150b7)
 + config: add include directive
 + config: eliminate config_exclusive_filename
 + config: stop using config_exclusive_filename
 + config: provide a version of git_config with more options
 + config: teach git_config_rename_section a file argument
 + config: teach git_config_set_multivar_in_file a default path
 + config: copy the return value of prefix_filename
 + t1300: add missing &&-chaining
 + docs/api-config: minor clarifications
 + docs: add a basic description of the config API

An assignment to the include.path pseudo-variable causes the named file
to be included in-place when Git looks up configuration variables.

* jk/maint-avoid-streaming-filtered-contents (2012-02-24) 3 commits
  (merged to 'next' on 2012-02-26 at 25e014c)
 + do not stream large files to pack when filters are in use
 + teach dry-run convert_to_git not to require a src buffer
 + teach convert_to_git a "dry run" mode

The bulk check-in codepath streamed contents that needs smudge/clean
filters without running them, instead of punting and delegating to the
codepath to run filters after slurping everything to core.

* jn/gitweb-search-optim (2012-02-23) 3 commits
  (merged to 'next' on 2012-02-23 at 9f9125f)
 + gitweb: Faster project search
 + gitweb: Option for filling only specified info in fill_project_list_=
info
 + gitweb: Refactor checking if part of project info need filling
 (this branch is used by jn/gitweb-hilite-regions.)

"gitweb" learns to read various pieces of information for the repositor=
ies
lazily, instead of reading everything that could be needed (including t=
he
ones that are not necessary for a specific task).

* js/configure-libintl (2012-02-20) 1 commit
  (merged to 'next' on 2012-02-21 at 79d7ccc)
 + configure: don't use -lintl when there is no gettext support

Build fix for autoconf, meant for 'maint' track.

* ld/git-p4-expanded-keywords (2012-02-14) 1 commit
  (merged to 'next' on 2012-02-16 at a9004c5)
 + git-p4: add initial support for RCS keywords

Teach git-p4 to unexpand $RCS$-like keywords that are embedded in
tracked contents in order to reduce unnecessary merge conflicts.

Replaced with the rerolled patch.

* pj/remote-set-branches-usage-fix (2012-02-19) 1 commit
  (merged to 'next' on 2012-02-21 at cb71d0e)
 + remote: fix set-branches usage and documentation

Documentation fix.

* sp/smart-http-failure-to-push (2012-02-23) 1 commit
  (merged to 'next' on 2012-02-23 at fe0b2aa)
 + disconnect from remote helpers more gently

When a remote helper exits before reading the blank line from the main =
git
process to signal the end of commands, the latter could be killed with
SIGPIPE. Instead we should ignore such event as a non-error.

* tr/maint-bundle-long-subject (2012-02-23) 4 commits
  (merged to 'next' on 2012-02-23 at b2c1605)
 + t5704: match tests to modern style
 + strbuf: improve strbuf_get*line documentation
 + bundle: use a strbuf to scan the log for boundary commits
 + bundle: put strbuf_readline_fd in strbuf.c with adjustments

"git bundle create" produced a corrupt bundle file upon seeing commits
with excessively long subject line.

* tr/perftest (2012-02-17) 3 commits
  (merged to 'next' on 2012-02-20 at 4c75ba9)
 + Add a performance test for git-grep
 + Introduce a performance testing framework
 + Move the user-facing test library to test-lib-functions.sh

The beginning of a new performance benchmark framework.

--------------------------------------------------
[Stalled]

* jc/diff-ignore-case (2012-02-19) 6 commits
 - diff -i
 - diff: --ignore-case
 - xdiff: introduce XDF_IGNORE_CASE
 - xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

"git diff" learns "--ignore-case" option.

Commits near the tip need to be better titled.

* jc/pickaxe-ignore-case (2012-02-21) 1 commit
 - pickaxe: allow -i to search in patch case-insensitively

The original "-S" pickaxe probably needs to be taught about the option.

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

The second one looked iffy.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

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

* jc/split-blob (2012-02-23) 7 commits
 - fixup?
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

* zj/diff-stat-dyncol (2012-02-24) 10 commits
 - diff --stat: add config option to limit graph width
 - diff --stat: enable limiting of the graph part
 - diff --stat: add a test for output with COLUMNS=3D40
 - diff --stat: use a maximum of 5/8 for the filename part
 - merge --stat: use the full terminal width
 - log --stat: use the full terminal width
 - show --stat: use the full terminal width
 - diff --stat: use the full terminal width
 - diff --stat: tests for long filenames and big change counts
 - Merge branches zj/decimal-width, zj/term-columns and jc/diff-stat-sc=
aler

Rerolled.

* nd/columns (2012-02-26) 11 commits
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

Rerolled.

* ph/cherry-pick-advice-refinement (2012-02-22) 1 commit
  (merged to 'next' on 2012-02-26 at 1c930c3)
 + cherry-pick: No advice to commit if --no-commit

The advice given by a conflicted "cherry-pick --no-commit" told the use=
r
to make a commit after resolving conflicts.

Will merge to "master".

* pj/completion-remote-set-url-branches (2012-02-22) 2 commits
  (merged to 'next' on 2012-02-26 at 0062008)
 + completion: normalize increment/decrement style
 + completion: remote set-* <name> and <branch>

Will merge to "master".

* th/git-diffall (2012-02-24) 1 commit
 - contrib: added git-diffall

* jn/gitweb-hilite-regions (2012-02-26) 4 commits
 - gitweb: Highlight matched part of shortened project description
 - gitweb: Highlight matched part of project description when searching=
 projects
 - gitweb: Highlight matched part of project name when searching projec=
ts
 - gitweb: Introduce esc_html_match_hl and esc_html_hl_regions

Project search in "gitweb" shows the substring that matched in the proj=
ect
name and description highlighted. The highlighting logic is meant to be
reused later for other kinds of searches e.g. grep and commit log searc=
h.

* jb/required-filter (2012-02-17) 1 commit
  (merged to 'next' on 2012-02-26 at e9ba88a)
 + Add a setting to require a filter to be successful

A content filter used to be a way to make the recorded contents "more
useful", but this defines a way to optionally mark a filter "required".

Will merge to "master".
