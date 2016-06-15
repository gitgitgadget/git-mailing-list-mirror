From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2009, #01; Fri, 12)
Date: Fri, 12 Jun 2009 02:11:54 -0700
Message-ID: <7v1vppbyud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 11:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF2oE-0001t5-7f
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 11:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761455AbZFLJL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 05:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933137AbZFLJL4
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 05:11:56 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43523 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758794AbZFLJLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 05:11:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612091155.FHFA17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 12 Jun 2009 05:11:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2xBv1c0024aMwMQ04xBvJT; Fri, 12 Jun 2009 05:11:55 -0400
X-VR-Score: -30.00
X-Authority-Analysis: v=1.0 c=1 a=4DgtUoBNZXoA:10 a=RXFa_ix5es8A:10
 a=cPTGN6Gk-vNFAqd6hi0A:9 a=eAV-pdRI3Z32DPAO_1QA:7
 a=aeKcJ6LACVON7-AL40MJc466ChQA:4
X-CM-Score: 0.00
X-master-at: b8364903c3e4cde713102e4a36d3926b020b0f70
X-next-at: f0de74fb063e75167a6c218a93cfeae5b8bdaaba
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121398>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Unfortunately I am unusually short of time these days, and some of the
topics unfortunately got less "final review before deciding to merge up"
than I would have liked to give them.  This message itself has more
"please comment/review" requests than usual.

----------------------------------------------------------------
[New Topics]

* tr/die_errno (Mon Jun 8 23:02:20 2009 +0200) 4 commits
 - Use die_errno() instead of die() when checking syscalls
 - Convert existing die(..., strerror(errno)) to die_errno()
 - die_errno(): double % in strerror() output just in case
 - Introduce die_errno() that appends strerror(errno) to die()

I didn't check the individual conversion from die() to die_errno()
in this latest round; comments?

* cb/maint-no-double-merge (Mon Jun 1 11:20:56 2009 +0200) 1 commit
 + refuse to merge during a merge

Will merge to 'master' soonish.

* sp/msysgit (Thu Jun 11 22:56:12 2009 +0200) 13 commits
 + compat/ has subdirectories: do not omit them in 'make clean'
 + Fix typo in nedmalloc warning fix
 + MinGW: Teach Makefile to detect msysgit and apply specific
   settings
 + Fix warnings in nedmalloc when compiling with GCC 4.4.0
 + Add custom memory allocator to MinGW and MacOS builds
 + MinGW readdir reimplementation to support d_type
 + connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows
 + git: browsing paths with spaces when using the start command
 + MinGW: fix warning about implicit declaration of _getch()
 + test-chmtime: work around Windows limitation
 + Work around a regression in Windows 7, causing erase_in_line() to
   crash sometimes
 + Quiet make: do not leave Windows behind
 + MinGW: GCC >= 4 does not need SNPRINTF_SIZE_CORR anymore

A silly typo I failed to spot was fixed by J6t; should be ready for
'master' now.

* mh/master-send-email (Sun Jun 7 23:40:52 2009 +0200) 8 commits
 - send-email: fix a typo in a comment
 - Merge branch 'mh/maint-send-email' into mh/master-send-email
 - Merge branch 'mh/master-send-email-threaded-fix' into mh/master-
   send-email
 - add a test for git-send-email for threaded mails without chain-
   reply-to
 - send-email: fix threaded mails without chain-reply-to
 - doc/send-email: clarify the behavior of --in-reply-to with --no-
   thread
 - send-email: fix non-threaded mails
 - add a test for git-send-email for non-threaded mails

The author seems to have a better organization than the way I queued this
topic, so I am holding off merging it to 'next' yet.  My goal was to have
two topics, one eventually mergeable to 'maint', the other to 'master'.

* mn/maint-iconv-autoconf (Mon Jun 8 20:46:38 2009 -0700) 1 commit
 - fix handling of iconv configuration options

Will merge to 'next' soon.

* rc/maint-http-local-slot-fix (Sat Jun 6 16:43:26 2009 +0800) 1 commit
 + http*: cleanup slot->local after fclose

* sb/parse-options-integer (Thu Jun 4 16:43:57 2009 -0700) 2 commits
 + parse-options: simplify usage argh handling
 + parse-options: make OPT_INTEGER's argh explicit

* sb/pull-rebase (Fri Jun 12 00:39:21 2009 +0200) 3 commits
 - parse-remote: remove unused functions
 - parse-remote: support default reflist in get_remote_merge_branch
 - parse-remote: function to get the tracking branch to be merge

Will merge to 'next' soon, but it would be nice if we can fix the
"currently works only for the default mapping" before it goes to
'master'.

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 - Shift object enumeration out of upload-pack

* ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
 - http.c: add http.sslCertNoPass option
 - http.c: prompt for SSL client certificate password

I think "sslCertNoPass" is a mistake.  We should aim for the ideal (i.e.
detect when we do not need passphrase), and live with a configuration
kludge until the code achives the ideal (i.e. "needPass" to trigger the
new codepath to ask for passphrase), _if_ that ideal is achievable.  And
in this particular case, I think the ideal is not rocket science.

* mg/pushurl (Tue Jun 9 18:01:38 2009 +0200) 5 commits
 - builtin-remote: Make "remote -v" display push urls
 - builtin-remote: Show push urls as well
 - technical/api-remote: Describe new struct remote member pushurl
 - t5516: Check pushurl config setting
 - Allow push and fetch urls to be different

Will merge to 'next' soon.

----------------------------------------------------------------
[Graduated to "master"]

* tr/maint-doc-stash-pop (Thu May 28 11:40:15 2009 +0200) 1 commit
 + Documentation: teach stash/pop workflow instead of stash/apply

* da/pretty-tempname (Sun May 31 01:35:52 2009 -0700) 3 commits
 + diff: generate pretty filenames in prep_temp_blob()
 + compat: add a basename() compatibility function
 + compat: add a mkstemps() compatibility function

* cb/maint-1.6.0-xdl-merge-fix (Mon May 25 01:21:14 2009 +0100) 2 commits
 + Change xdl_merge to generate output even for null merges
 + t6023: merge-file fails to output anything for a degenerate merge

----------------------------------------------------------------
[Will merge to "master" soon]

* bc/solaris (Sun Jun 7 07:40:29 2009 +0200) 10 commits
 - configure: test whether -lresolv is needed
 + Makefile: insert SANE_TOOL_PATH to PATH before /bin or /usr/bin
 + git-compat-util.h: avoid using c99 flex array feature with Sun
   compiler 5.8
 + Makefile: add section for SunOS 5.7
 + Makefile: introduce SANE_TOOL_PATH for prepending required
   elements to PATH
 + Makefile: define __sun__ on SunOS
 + git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
 + On Solaris choose the OLD_ICONV iconv() declaration based on the
   UNIX spec
 + Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
   arguments
 + Makefile: use /usr/ucb/install on SunOS platforms rather than
   ginstall

We saw some success report with Sun's c99 compiler, which would allow us
to include the last remaining patch from Brandon with updates.  I lost
track of the status of the tip patch for autoconf.  Is it ready to go?
Comments from Solaris folks are appreciated.

* cb/match_refs_internal_tail (Sun May 31 16:26:48 2009 +0200) 1 commit
 + match_refs: search ref list tail internally

* nw/maint-cvsexportcommit (Fri May 29 00:23:33 2009 +0100) 1 commit
 + git-cvsexportcommit can't commit files which have been removed
   from CVS

* ak/maint-for-each-ref-no-lookup (Wed May 27 15:23:12 2009 -0400) 1 commit
 + for-each-ref: Do not lookup objects when they will not be used

I think this makes sense, except that I have this nagging feeling that its
use of for_each_rawref() where the original used for_each_ref() may have
some unintended side effects in corner cases.

* ph/submodule-rebase (Wed Jun 3 00:59:12 2009 +0200) 3 commits
 - git-submodule: add support for --merge.
 + Rename submodule.<name>.rebase to submodule.<name>.update
 + git-submodule: add support for --rebase.

I think people do not have issues with the first two, even though some
might still argue that "update --merge" is not a good mode of
operation.

* da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
 + mergetool--lib: add support for araxis merge

* cc/bisect (Sat Jun 6 06:41:35 2009 +0200) 5 commits
 + t6030: test skipping away from an already skipped commit
 + bisect: when skipping, choose a commit away from a skipped commit
 + bisect: add parameters to "filter_skipped"
 + bisect: display first bad commit without forking a new process
 + bisect: drop unparse_commit() and use clear_commit_marks()

Regardless of metrics, this is an improvement from the current one.  Will
merge to 'master', and let the finer details taken care of later.

* rc/http-push (Sat Jun 6 16:44:02 2009 +0800) 24 commits
 + http*: add helper methods for fetching objects (loose)
 + http*: add helper methods for fetching packs
 + http: use new http API in fetch_index()
 + http*: add http_get_info_packs
 + http-push.c::fetch_symref(): use the new http API
 + http-push.c::remote_exists(): use the new http API
 + http.c::http_fetch_ref(): use the new http API
 + transport.c::get_refs_via_curl(): use the new http API
 + http.c: new functions for the http API
 + http: create function end_url_with_slash
 + http*: move common variables and macros to http.[ch]
 + transport.c::get_refs_via_curl(): do not leak refs_url
 + Don't expect verify_pack() callers to set pack_size
 + http-push: do not SEGV after fetching a bad pack idx file
 + http*: copy string returned by sha1_to_hex
 + http-walker: verify remote packs
 + http-push, http-walker: style fixes
 + t5550-http-fetch: test fetching of packed objects
 + http-push: fix missing "#ifdef USE_CURL_MULTI" around
   "is_running_queue"
 + http-push: send out fetch requests on queue
 + t5540-http-push: test fetching of packed objects
 + t5540-http-push: test fetching of loose objects
 + Merge branch 'rc/maint-http-local-slot-fix' into rc/http-push
 + http*: cleanup slot->local after fclose

I do not use http-push myself, and as I said, I have shortage of git time
in recent weeks, so these are not as carefully reviewed as usual; but
RCTay is proving to be a very reliable HTTP guy I can trust, so unless
there are regression reports from people who actually use http-push, this
will be in 'master' soon.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Dscho asked about the performance implications of this; I do not think I
saw any progress on that yet...

* lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
 - Add initial support for pathname conversion to UTF-8
 - read_directory(): infrastructure for pathname character set
   conversion
 - Add 'fill_directory()' helper function for directory traversal

Before adding the real "conversion", this needs a few real fixups, I
think.  For example there is one hardcoded array that is used without
bounds check.

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 - Fix for a merge where a branch has an F->D transition
 - Add a reminder test case for a merge with F/D transition

Although the reported breakage is covered with the patch, Alex feels the
solution unsatisfactory. Cleaning up D/F conflict handling in merge-recursive
may be long overdue but seems to be a hard problem.

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

----------------------------------------------------------------
[Actively cooking]

* gb/am-foreign (Wed May 27 11:25:19 2009 +0200) 4 commits
 - git-am: refactor 'cleaning up and aborting'
 - git-am foreign patch support: StGIT support
 - git-am foreign patch support: autodetect some patch formats
 - git-am foreign patch support: introduce patch_format

Should re-review and merge to 'next' but I am short of time these days.

* jc/cache-tree (Fri May 22 23:14:25 2009 -0700) 5 commits
 + Avoid "diff-index --cached" optimization under --find-copies-
   harder
 + Optimize "diff-index --cached" using cache-tree
 + t4007: modernize the style
 + cache-tree.c::cache_tree_find(): simplify internal API
 + write-tree --ignore-cache-tree

I believe the code is right, but this touches a very low-level code with
high chance of subtle breakages unless you are really careful.  I'll let
it simmer a bit longer in 'next'.

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 - diff: Rename QUIET internal option to QUICK
 - diff: change semantics of "ignore whitespace" options

I am not sure if it should wait for a major version bump but this is a
good semantics change.  Perhaps merge to 'next' soonish, but I am
undecided.  Comments?

* cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
 - t6050: check pushing something based on a replaced commit
 - Documentation: add documentation for "git replace"
 - Add git-replace to .gitignore
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
