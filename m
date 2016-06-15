From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2013, #01; Sun, 3)
Date: Sun, 03 Mar 2013 02:00:51 -0800
Message-ID: <7vppzgby5o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 11:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5jd-0001F2-QY
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 11:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab3CCKA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 05:00:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746Ab3CCKA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 05:00:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 842A2BCF6;
	Sun,  3 Mar 2013 05:00:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	OXI59may/sFGU8zMqFBEbReWfY=; b=Wr1CQSwOjVHEnc1rUBvTPh+K8t5un4gEC
	nkfn3usiBkFqg8lmtfqivnvNjZPCvNXPV+0WRW4vyuVprWxGZ+J0LBRF0KLqVx6T
	DSgHbkSjsMDlHm678LIjwjwD9K9w1u815yhSrY3qnVMADvVnugaOa0MpMqy4oEGf
	xRz5wtpcTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OVy
	PT8/IKdS4aOEc+pK/Y8vdjqe2LpVPYfxNiyGO7DkIUHkFnUn6p9yE3kca8roI9ck
	rBchHuSxeoaNC24+7tn1FY0qiB6gMWUPZgkGvNx4stZMClBmoGAChOZaEsbzftGv
	9pcTwj9cF6hDVvLpr7Z9tk1SLai3VUV4C+ENAHek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78B52BCF5;
	Sun,  3 Mar 2013 05:00:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D30CBCF4; Sun,  3 Mar 2013
 05:00:53 -0500 (EST)
X-master-at: 4d0d0c3c59800e07d899e53121902833e3fd0cc7
X-next-at: c3bedd3ddcc0d007d41c3ed9d173b298b181e827
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C2A1F88-83E9-11E2-B9C5-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217348>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the 'master' is at 1.8.2-rc2.  Hopefully we can tag the
final in the middle of the month.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* mh/maint-ceil-absolute (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-26 at ba83c45)
 + Provide a mechanism to turn off symlink resolution in ceiling paths

 An earlier workaround designed to help people who list logical
 directories that will not match what getcwd(3) returns in the
 GIT_CEILING_DIRECTORIES had an adverse effect when it is slow to
 stat and readlink a directory component of an element listed on it.

--------------------------------------------------
[New Topics]

* kb/name-hash (2013-02-27) 1 commit
 - name-hash.c: fix endless loop with core.ignorecase=true

 The code to keep track of what directory names are known to Git on
 platforms with case insensitive filesystems can get confused upon
 a hash collision between these pathnames and looped forever.


* rs/zip-compresssed-size-with-export-subst (2013-02-27) 1 commit
  (merged to 'next' on 2013-03-03 at c1ac6d8)
 + archive-zip: fix compressed size for stored export-subst files

 When export-subst is used, "zip" output recorded incorrect
 size of the file.

 Will cook in 'next'.


* hv/config-from-strbuf (2013-02-28) 4 commits
 - teach config parsing to read from strbuf
 - config: make parsing stack struct independent from actual data source
 - config: drop file pointer validity check in get_next_char()
 - config: factor out config file stack management


* jc/describe (2013-02-28) 1 commit
 - describe: --match=<pattern> must limit the refs even when used with --all

 Comments?


* jk/mailsplit-maildir-muttsort (2013-03-02) 1 commit
  (merged to 'next' on 2013-03-03 at d5f7735)
 + mailsplit: sort maildir filenames more cleverly

 Will cook in 'next'.


* pc/subtree-add-before-fetch (2013-02-28) 1 commit
 - contrib/subtree: allow addition of remote branch with name not locally present

 Comments?


* tr/line-log (2013-02-28) 5 commits
 - log -L: :pattern:file syntax to find by funcname
 - Implement line-history search (git log -L)
 - Export rewrite_parents() for 'log -L'
 - blame: introduce $ as "end of file" in -L syntax
 - Refactor parse_loc

--------------------------------------------------
[Stalled]

* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 There seems to be some interest. Let's see if it results in a solid
 execution of a sensible transition plan towards Git 2.0.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* jc/perl-cat-blob (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at 7c0079a)
 + Git.pm: fix cat_blob crashes on large files

 perl/Git.pm::cat_blob slurped everything in core only to write it
 out to a file descriptor, which was not a very smart thing to do.

 Will cook in 'next'.


* nd/doc-index-format (2013-02-23) 3 commits
  (merged to 'next' on 2013-02-26 at 4d3caea)
 + update-index: list supported idx versions and their features
 + read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
 + index-format.txt: mention of v4 is missing in some places

 Update the index format documentation to mention the v4 format.

 Will cook in 'next'.


* ap/maint-diff-rename-avoid-overlap (2013-03-02) 3 commits
 - tests: make sure rename pretty print works
  (merged to 'next' on 2013-02-26 at 19d70bf)
 + diff: prevent pprint_rename from underrunning input
  (merged to 'next' on 2013-02-25 at c9bd6d3)
 + diff: Fix rename pretty-print when suffix and prefix overlap

 The logic used by "git diff -M --stat" to shorten the names of
 files before and after a rename did not work correctly when the
 common prefix and suffix between the two filenames overlapped.

 Will cook in 'next' (the tip may still be rerolled).


* ap/maint-update-index-h-is-for-help (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at f5f767c)
 + update-index: allow "-h" to also display options

 Will cook in 'next'.


* jc/color-diff-doc (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at c37541c)
 + diff-options: unconfuse description of --color

 Will cook in 'next'.


* nd/branch-error-cases (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 1d0289f)
 + branch: segfault fixes and validation

 "git branch" had more cases where it did not bother to check
 nonsense command line parameters.

 Will cook in 'next'.


* rt/commit-cleanup-config (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 8249b61)
 + t7502: perform commits using alternate editor in a subshell

 Fix tests that contaminated their environments and affected new
 tests introduced later in the sequence by containing their effects
 in their own subshells.

 Will cook in 'next'.


* wk/doc-pre-rebase (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-25 at a6ec310)
 + Documentation/githooks: Explain pre-rebase parameters

 Will cook in 'next'.


* da/downcase-u-in-usage (2013-02-24) 20 commits
  (merged to 'next' on 2013-02-26 at 977b67e)
 + contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" string
 + contrib/examples/git-remote.perl: use a lowercase "usage:" string
 + tests: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + Documentation/user-manual.txt: use a lowercase "usage:" string
 + templates/hooks--update.sample: use a lowercase "usage:" string
 + contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
 + contrib/examples: use a lowercase "usage:" string
 + contrib/fast-import/import-zips.py: use spaces instead of tabs
 + contrib/fast-import/import-zips.py: fix broken error message
 + contrib/fast-import: use a lowercase "usage:" string
 + contrib/credential: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsexportcommit: use a lowercase "usage:" string
 + git-archimport: use a lowercase "usage:" string
 + git-merge-one-file: use a lowercase "usage:" string
 + git-relink: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + git-sh-setup: use a lowercase "usage:" string

 Will cook in 'next'.


* dm/ni-maxhost-may-be-missing (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at 93ec2c9)
 + git-compat-util.h: Provide missing netdb.h definitions

 Will cook in 'next'.


* gp/avoid-explicit-mention-of-dot-git-refs (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at ec42d98)
 + Fix ".git/refs" stragglers

 Will cook in 'next'.


* gp/describe-match-uses-glob-pattern (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at c9cc789)
 + describe: Document --match pattern format
 (this branch is used by gp/forbid-describe-all-match.)

 Will cook in 'next'.


* gp/forbid-describe-all-match (2013-02-24) 1 commit
 - describe: make --all and --match=PATTERN mutually incompatible
 (this branch uses gp/describe-match-uses-glob-pattern.)

 "describe --match=<pattern> --all <commit>" ought to mean "use refs
 that match <pattern> to describe <commit>; you do not have to limit
 yourself to annotated tags."  But it doesn't.  Disable the
 combination.

 We may want to discard this if jc/describe topic turns out to be a
 better idea.


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
 - Makefile: make mandir, htmldir and infodir absolute

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.


* jk/suppress-clang-warning (2013-02-25) 1 commit
 - fix clang -Wtautological-compare with unsigned enum


* mg/qnx6 (2013-02-25) 1 commit
 - QNX: newer QNX 6.x.x is not so crippled

 Still under discussion.
 Not ready for inclusion.


* mg/unsigned-time-t (2013-02-25) 2 commits
 - Fix time offset calculation in case of unsigned time_t
 - date.c: fix unsigned time_t comparison

 A few workarounds for systems with unsigned time_t.


* rj/msvc-build (2013-02-25) 5 commits
  (merged to 'next' on 2013-02-26 at 7493068)
 + msvc: avoid collisions between "tags" and "TAGS"
 + msvc: test-svn-fe: Fix linker "unresolved external" error
 + msvc: Fix build by adding missing symbol defines
 + msvc: git-daemon: Fix linker "unresolved external" errors
 + msvc: Fix compilation errors caused by poll.h emulation

 Will cook in 'next'.


* wk/user-manual-literal-format (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at d59ce38)
 + user-manual: Standardize backtick quoting

 Will cook in 'next'.


* jk/utf-8-can-be-spelled-differently (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at c079525)
 + utf8: accept alternate spellings of UTF-8

 Will cook in 'next'.


* jk/pkt-line-cleanup (2013-02-24) 19 commits
  (merged to 'next' on 2013-02-25 at d83e970)
 + remote-curl: always parse incoming refs
 + remote-curl: move ref-parsing code up in file
 + remote-curl: pass buffer straight to get_remote_heads
 + teach get_remote_heads to read from a memory buffer
 + pkt-line: share buffer/descriptor reading implementation
 + pkt-line: provide a LARGE_PACKET_MAX static buffer
 + pkt-line: move LARGE_PACKET_MAX definition from sideband
 + pkt-line: teach packet_read_line to chomp newlines
 + pkt-line: provide a generic reading function with options
 + pkt-line: drop safe_write function
 + pkt-line: move a misplaced comment
 + write_or_die: raise SIGPIPE when we get EPIPE
 + upload-archive: use argv_array to store client arguments
 + upload-archive: do not copy repo name
 + send-pack: prefer prefixcmp over memcmp in receive_status
 + fetch-pack: fix out-of-bounds buffer offset in get_ack
 + upload-pack: remove packet debugging harness
 + upload-pack: do not add duplicate objects to shallow list
 + upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make
 them more robust.

 Will cook in 'next'.


* ob/imap-send-ssl-verify (2013-02-20) 1 commit
  (merged to 'next' on 2013-02-25 at e897609)
 + imap-send: support Server Name Indication (RFC4366)

 Correctly connect to SSL/TLS sites that serve multiple hostnames on
 a single IP by including Server Name Indication in the client-hello.

 Will cook in 'next'.


* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* tk/doc-filter-branch (2013-02-26) 2 commits
  (merged to 'next' on 2013-02-26 at bd4638b)
 + Documentation: filter-branch env-filter example
 + git-filter-branch.txt: clarify ident variables usage

 Will cook in 'next'.


* bc/commit-complete-lines-given-via-m-option (2013-02-19) 4 commits
  (merged to 'next' on 2013-02-19 at cf622b7)
 + Documentation/git-commit.txt: rework the --cleanup section
 + git-commit: only append a newline to -m mesg if necessary
 + t7502: demonstrate breakage with a commit message with trailing newlines
 + t/t7502: compare entire commit message with what was expected

 'git commit -m "$str"' when $str was already terminated with a LF
 now avoids adding an extra LF to the message.

 Will cook in 'next'.


* da/difftool-fixes (2013-02-21) 4 commits
  (merged to 'next' on 2013-02-25 at 687db1f)
 + t7800: "defaults" is no longer a builtin tool name
 + t7800: modernize tests
 + t7800: update copyright notice
 + difftool: silence uninitialized variable warning

 Minor maintenance updates to difftool, and updates to its tests.

 Will cook in 'next'.


* nd/read-directory-recursive-optim (2013-02-17) 1 commit
  (merged to 'next' on 2013-02-17 at 36ba9f4)
 + read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.

 Will cook in 'next'.


* mg/gpg-interface-using-status (2013-02-14) 5 commits
  (merged to 'next' on 2013-02-26 at 93f0e72)
 + pretty: make %GK output the signing key for signed commits
 + pretty: parse the gpg status lines rather than the output
 + gpg_interface: allow to request status return
 + log-tree: rely upon the check in the gpg_interface
 + gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.

 Will cook in 'next'.


* jn/shell-disable-interactive (2013-02-11) 2 commits
 - shell: pay attention to exit status from 'help' command
 - shell doc: emphasize purpose and security model

 Expecting a reroll.
 $gmane/216229


* jc/fetch-raw-sha1 (2013-02-07) 4 commits
  (merged to 'next' on 2013-02-14 at ffa3c65)
 + fetch: fetch objects by their exact SHA-1 object names
 + upload-pack: optionally allow fetching from the tips of hidden refs
 + fetch: use struct ref to represent refs to be fetched
 + parse_fetch_refspec(): clarify the codeflow a bit

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).

 Will cook in 'next'.


* mn/send-email-works-with-credential (2013-02-27) 6 commits
  (merged to 'next' on 2013-02-27 at ee7ae0e)
 + git-send-email: use git credential to obtain password
 + Git.pm: add interface for git credential command
 + Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 + Git.pm: refactor command_close_bidi_pipe to use _cmd_close
 + Git.pm: fix example in command_close_bidi_pipe documentation
 + Git.pm: allow command_close_bidi_pipe to be called as method

 Hooks the credential system to send-email.

 Will cook in 'next'.


* nd/branch-show-rebase-bisect-state (2013-02-08) 1 commit
 - branch: show rebase/bisect info when possible instead of "(no branch)"

 Expecting a reroll.
 $gmane/215771


* nd/count-garbage (2013-02-15) 4 commits
  (merged to 'next' on 2013-02-17 at b2af923)
 + count-objects: report how much disk space taken by garbage files
 + count-objects: report garbage files in pack directory too
 + sha1_file: reorder code in prepare_packed_git_one()
 + git-count-objects.txt: describe each line in -v output

 Will cook in 'next'.


* tz/credential-authinfo (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-27 at 7a261cb)
 + Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Will cook in 'next'.


* jl/submodule-deinit (2013-02-17) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Expecting a reroll.
 $gmane/216498


* jc/remove-export-from-config-mak-in (2013-02-12) 2 commits
  (merged to 'next' on 2013-02-12 at eb8af04)
 + Makefile: do not export mandir/htmldir/infodir
  (merged to 'next' on 2013-02-07 at 33f7d4f)
 + config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Will cook in 'next'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
  (merged to 'next' on 2013-01-30 at b639b47)
 + simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0.


* bc/append-signed-off-by (2013-02-23) 13 commits
  (merged to 'next' on 2013-02-25 at 32f7ac2)
 + git-commit: populate the edit buffer with 2 blank lines before s-o-b
 + Unify appending signoff in format-patch, commit and sequencer
 + format-patch: update append_signoff prototype
 + t4014: more tests about appending s-o-b lines
 + sequencer.c: teach append_signoff to avoid adding a duplicate newline
 + sequencer.c: teach append_signoff how to detect duplicate s-o-b
 + sequencer.c: always separate "(cherry picked from" from commit body
 + sequencer.c: require a conforming footer to be preceded by a blank line
 + sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 + t/t3511: add some tests of 'cherry-pick -s' functionality
 + t/test-lib-functions.sh: allow to specify the tag name to test_commit
 + commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 + sequencer.c: rework search for start of footer to improve clarity

 Will cook in 'next'.
