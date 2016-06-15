From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2013, #09; Thu, 21)
Date: Thu, 21 Feb 2013 15:20:54 -0800
Message-ID: <7vd2vttfs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 00:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fS9-0002sK-Og
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab3BUXVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3BUXU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:20:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE91BBBEA;
	Thu, 21 Feb 2013 18:20:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=i
	7fFjk4HlsOFVY0k8Ju6OLQW5VU=; b=MjOkB+/+OD5UXSn8iP8SmSsDGYZUXbgqz
	nZQJfhdgeWjlyUBBe5aKm82NWe+IMkb4dabfc3OHfdf1Za7ferXUiijIpYaa7a9w
	84lzdfCC1waYeaJRWiB2GiohPfyHlvvQLTYcGcrbovWRMRvib16Teg0IQTLaR+HC
	ivnUBeyzdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vlO
	nWNjXoB2EoAyu/NUG7CB8+u6i5A0aVwTBBif7Ia8feuUQhA1Kn8i1dXc8zXM9uq8
	NpsdjpFuhs2GoLVfqj2xyFb2o/w/ddB5osjHTkmAdR0MfIJgPHXMuqaOFvaQW9Z7
	UkBo+aOrl7quBdqf1T+aRTDqiUJJJymlW2Jaw0js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 921C5BBE3;
	Thu, 21 Feb 2013 18:20:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 976A9BBC2; Thu, 21 Feb 2013
 18:20:56 -0500 (EST)
X-master-at: b3600c36286517cda38df976946557ce3e87bd82
X-next-at: 811e0c07090d01cfcae9d07e8c207363d2d9194f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 582A5FFE-7C7D-11E2-A6F6-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216805>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

On the 'maint' front, a maintenance release 1.8.1.4 is out.  The
same fixes are also included in the 'master' and upwards.

The tip of the 'master' is a bit past 1.8.2-rc0; new topics that are
not listed in this report are likely to be too late for the upcoming
release.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/pkt-line-cleanup (2013-02-20) 19 commits
 - remote-curl: always parse incoming refs
 - remote-curl: move ref-parsing code up in file
 - remote-curl: pass buffer straight to get_remote_heads
 - teach get_remote_heads to read from a memory buffer
 - pkt-line: share buffer/descriptor reading implementation
 - pkt-line: provide a LARGE_PACKET_MAX static buffer
 - pkt-line: move LARGE_PACKET_MAX definition from sideband
 - pkt-line: teach packet_read_line to chomp newlines
 - pkt-line: provide a generic reading function with options
 - pkt-line: drop safe_write function
 - pkt-line: move a misplaced comment
 - write_or_die: raise SIGPIPE when we get EPIPE
 - upload-archive: use argv_array to store client arguments
 - upload-archive: do not copy repo name
 - send-pack: prefer prefixcmp over memcmp in receive_status
 - fetch-pack: fix out-of-bounds buffer offset in get_ack
 - upload-pack: remove packet debugging harness
 - upload-pack: do not add duplicate objects to shallow list
 - upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make
 them more robust.

 Will merge to and cook in 'next'.


* ob/imap-send-ssl-verify (2013-02-20) 1 commit
 - imap-send: support Server Name Indication (RFC4366)

 Correctly connect to SSL/TLS sites that serve multiple hostnames on
 a single IP by including Server Name Indication in the client-hello.

 Will merge to and cook in 'next'.


* jn/less-reconfigure (2013-02-20) 1 commit
  (merged to 'next' on 2013-02-21 at 811e0c0)
 + Makefile: avoid infinite loop on configure.ac change

 A change made on v1.8.1.x maintenance track had a nasty regression
 to break the build when autoconf is used.

 Will fast-track to 'master' and 'maint' (regression fix).


* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.


* mh/maint-ceil-absolute (2013-02-21) 1 commit
 - Provide a mechanism to turn off symlink resolution in ceiling paths

 An earlier workaround designed to help people who list logical
 directories that will not match what getcwd(3) returns in the
 GIT_CEILING_DIRECTORIES had an adverse effect when it is slow to
 stat and readlink a directory component of an element listed on it.

 Waiting for review.  Needs sign-off.


* tk/doc-filter-branch (2013-02-21) 3 commits
 - [SQUASH???] reword desc on filter-branch's use of env
 - Documentation: filter-branch env-filter example
 - git-filter-branch.txt: clarify ident variables usage

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

* as/check-ignore (2013-02-19) 2 commits
  (merged to 'next' on 2013-02-21 at 27927a2)
 + name-hash: allow hashing an empty string
 + t0008: document test_expect_success_multi

 "git check-ignore ." segfaulted, as a function it calls deep in its
 callchain took a string in the <ptr, length> form but did not stop
 when given an empty string.

 Will fast-track to 'master' (this is a new feature in the upcoming release).


* bc/commit-complete-lines-given-via-m-option (2013-02-19) 4 commits
  (merged to 'next' on 2013-02-19 at cf622b7)
 + Documentation/git-commit.txt: rework the --cleanup section
 + git-commit: only append a newline to -m mesg if necessary
 + t7502: demonstrate breakage with a commit message with trailing newlines
 + t/t7502: compare entire commit message with what was expected

 'git commit -m "$str"' when $str was already terminated with a LF
 now avoids adding an extra LF to the message.

 Will cook in 'next'.


* ct/autoconf-htmldir (2013-02-19) 1 commit
  (merged to 'next' on 2013-02-21 at 44f127d)
 + Bugfix: undefined htmldir in config.mak.autogen

 An earlier change to config.mak.autogen broke a build driven by the
 ./configure script when --htmldir is not specified on the command
 line of ./configure.

 Will fast-track to 'master' (regression fix).


* wk/user-manual (2013-02-19) 3 commits
  (merged to 'next' on 2013-02-19 at dbc0eb2)
 + user-manual: Flesh out uncommitted changes and submodule updates
 + user-manual: Use request-pull to generate "please pull" text
 + user-manual: Reorganize the reroll sections, adding 'git rebase -i'

 Further updates to the user manual.

 Will merge to 'master'.


* wk/man-deny-current-branch-is-default-these-days (2013-02-18) 1 commit
  (merged to 'next' on 2013-02-21 at e67b15b)
 + user-manual: typofix (ofthe->of the)

 Will fast-track to 'master'.


* da/difftool-fixes (2013-02-20) 3 commits
 - t7800: modernize tests
 - t7800: update copyright notice
 - difftool: silence uninitialized variable warning

 Minor maintenance updates to difftool, and updates to its tests.


* nd/read-directory-recursive-optim (2013-02-17) 1 commit
  (merged to 'next' on 2013-02-17 at 36ba9f4)
 + read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.

 Will cook in 'next'.


* mg/gpg-interface-using-status (2013-02-14) 5 commits
 - pretty: make %GK output the signing key for signed commits
 - pretty: parse the gpg status lines rather than the output
 - gpg_interface: allow to request status return
 - log-tree: rely upon the check in the gpg_interface
 - gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.


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


* mn/send-email-works-with-credential (2013-02-12) 6 commits
 - git-send-email: use git credential to obtain password
 - Git.pm: add interface for git credential command
 - Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 - Git.pm: refactor command_close_bidi_pipe to use _cmd_close
 - Git.pm: fix example in command_close_bidi_pipe documentation
 - Git.pm: allow command_close_bidi_pipe to be called as method

 Hooks the credential system to send-email.
 Rerolled.
 Waiting for a review.


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


* tz/credential-authinfo (2013-02-05) 1 commit
 - Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Expecting a reroll.
 $gmane/215556


* jl/submodule-deinit (2013-02-17) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.


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


* bc/append-signed-off-by (2013-02-12) 12 commits
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: require a conforming footer to be preceded by a blank line
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Waiting for further reviews.
 $gmane/216327 may need to be addressed.

--------------------------------------------------
[Discarded]

* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jk/smart-http-robustify (2013-02-17) 3 commits
 . remote-curl: sanity check ref advertisement from server
 . remote-curl: verify smart-http metadata lines
 . pkt-line: teach packet_get_line a no-op mode

 Parse the HTTP exchange that implements the native Git protocol as
 a series of stateless RPC more carefully to diagnose protocol
 breakage better.

 Superseded by jk/pkt-line-cleanup


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).
