From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2011, #06; Thu, 31)
Date: Thu, 31 Mar 2011 15:26:31 -0700
Message-ID: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 00:26:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5QKF-0004C8-FC
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759416Ab1CaW0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 18:26:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab1CaW0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 18:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C05765401;
	Thu, 31 Mar 2011 18:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	PaPogVbYsrhkV21shFGjGkQoYQ=; b=NsGOPubc9rCtQgjUZz9ZDbc8drgQ6HNIp
	s8ljMgqvNz68HyaEzRsvL2NW0pm7p/iY3fuWTlzyQJ7wtG5RRG3jSqBblGgSO7IW
	q/OuuDX+ZAoCDRcdZkOYtjNMuS5APGaptLPgWy8da9xvonEWLor6FSIzoWxrrJiX
	PyjWbRblY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=AAz
	aHmsl/3ZcKwcXxl8SoF6aLHL7IPum6jcMPqc3ZxFYy9jazgwbRQGP1lk2e93vIwo
	1b/K9IwLA5VEb/Hdu3RwlnOPxxjxdvA+NedFZLCdFPI5DZy03yS6VSjkttS4Dyb3
	JFlmVUpCgcYEATIVjhM1zsp/mSze8DoWAPqBdqBM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD4995400;
	Thu, 31 Mar 2011 18:28:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62EAB53FD; Thu, 31 Mar 2011
 18:28:22 -0400 (EDT)
X-master-at: 6acef043581d69597860f3343ec2691c72b0803c
X-next-at: ae5b80d74263fcfbdcca7004dee1552cb35a2a9d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3123191E-5BE6-11E0-9557-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170537>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

It's been two months since v1.7.4 and -rc0 was way overdue.  I'll do a -rc1
sometime next week, hoping that we can finish this cycle by mid April.

Which means that from now on, we wouldn't be interested in topics that are
mostly internal clean-ups, new features that is not already in 'master',
nor fixes for nontrivial bugs that are not regressions.  A bug that
existed since v1.7.0 is something we have lived with long enough that it
is not worth the risk of introducing other new bugs by trying to fix it
before 1.7.5 final).

What we would want to see are regression fixes.  There are quite a few new
topics that have already graduated in 'master', or have been cooking and
should be in 'master' shortly.  If they introduce new bugs that didn't
exist in v1.7.4, they need to be squashed before anything else.

The criteria is a bit looser for documentation updates.  Simple grammar
and spelling fixes are usually safe; changes in the structure and markups
are riskier.

In any case, please use your best judgement and help polishing v1.7.5
release.

--------------------------------------------------
[New Topics]

* jh/notes-add-ui (2011-03-30) 1 commit
 - Make "git notes add" more user-friendly when there are existing notes

* jk/maint-remote-mirror-safer (2011-03-30) 3 commits
 - remote: deprecate --mirror
 - remote: separate the concept of push and fetch mirrors
 - remote: disallow some nonsensical option combinations

* jk/notes-ui-updates (2011-03-30) 7 commits
 - log/pretty-options: Document --[no-]notes and deprecate old notes options
 - revision.c: make --no-notes reset --notes list
 - revision.c: support --notes command-line option
 - notes: refactor display notes default handling
 - notes: refactor display notes extra refs field
 - revision.c: refactor notes ref expansion
 - notes: make expand_notes_ref globally accessible

* jr/grep-en-config (2011-03-30) 1 commit
  (merged to 'next' on 2011-03-31 at 2a73028)
 + grep: allow -E and -n to be turned on by default via configuration

This is low impact, isolated, and has no risk of breaking the system as a
whole. May merge by rc1.

* nd/maint-setup (2011-03-26) 2 commits
  (merged to 'next' on 2011-03-31 at 2c36f6a)
 + Kill off get_relative_cwd()
 + setup: return correct prefix if worktree is '/'

This benefits only the minority who use /.git at the root level of the
filesystem, but the changed code is used from many codepaths; will not
merge before 1.7.5.

--------------------------------------------------
[Stalled]

* jc/diff-irreversible-delete (2011-02-28) 1 commit
 - git diff -D: omit the preimage of deletes

"diff -B -D" should omit the deleting half of a broken pair from the
output.  This is low impact, isolated, and has no risk of breaking the
system as a whole, but the topic needs documentation and tests.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

It seems that we need separate parsers for these two formats in order not
to regress the users of the original cvs.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP, and will not be ready for 1.7.5. Need to put histogram output
into index-pack --verify to really kill verify-pack.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jk/edit-notes-in-commit-log (2011-03-07) 2 commits
 - [wip] commit: allow editing notes in commit message editor
 - notes: make expand_notes_ref globally accessible

* mg/grep-full-tree (2011-03-01) 2 commits
 - grep: make --full-tree work with pathspecs
 - grep: --full-tree

Do not merge; it would be preferable to use ":/" or whatever magic
pathspec that is relative to the root of the working tree.

--------------------------------------------------
[Cooking]

* mz/rebase (2011-02-28) 34 commits
  (merged to 'next' on 2011-03-31 at 3b1343c)
 + rebase: define options in OPTIONS_SPEC
  (merged to 'next' on 2011-02-25 at 52caa7a)
 + Makefile: do not install sourced rebase scripts
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

I wanted to wait for an independent Ack or two for the tip one, which was
a response to regression concerns raised by J6t, but ended up merging it
after giving another look.  Will not merge before 1.7.5, as there is no
user visible improvements up to this point.

* jc/merge-sans-branch (2011-03-23) 2 commits
  (merged to 'next' on 2011-03-31 at 754a6af)
 + merge: merge with the default upstream branch without argument
 + merge: match the help text with the documentation

Allow running "git merge" without telling it what to merge.  It will merge
with the "upstream" of the current branch if configured.  This is low
impact, isolated, and has no risk of major regression.  May merge before
rc1, but it is Ok to wait.

* jh/gitweb-localtime (2011-03-23) 1 commit
 - gitweb: javascript ability to adjust time based on timezone

* jk/maint-merge-rename-create (2011-03-25) 3 commits
  (merged to 'next' on 2011-03-31 at b9bc9f1)
 + merge: turn on rewrite detection
 + merge: handle renames with replacement content
 + t3030: fix accidental success in symlink rename

May merge before rc1, but it is Ok to wait.

* jk/pull-into-empty (2011-03-25) 2 commits
  (merged to 'next' on 2011-03-31 at d4dd598)
 + pull: do not clobber untracked files on initial pull
 + merge: merge unborn index before setting ref

This is low impact, isolated, and has no risk of major regression. Will
merge before rc1.

* mz/maint-rename-unmerged (2011-03-23) 1 commit
  (merged to 'next' on 2011-03-31 at c7b3d9a)
 + diffcore-rename: don't consider unmerged path as source

Will cook until 1.7.5 final.

* nd/struct-pathspec (2011-03-25) 4 commits
  (merged to 'next' on 2011-03-31 at 66cbb7d)
 + Improve tree_entry_interesting() handling code
 + Convert read_tree{,_recursive} to support struct pathspec
 + Reimplement read_tree_recursive() using tree_entry_interesting()
 + Merge branch 'en/object-list-with-pathspec' into 'nd/struct-pathspec'

Will cook until 1.7.5 final.

* jc/add-u-migration (2011-03-22) 3 commits
 - add: make "add -u/-A" update full tree without pathspec (step 3)
 - add: make "add -u/-A" update full tree without pathspec (step 2)
  (merged to 'next' on 2011-03-31 at 962e058)
 + add: make "add -u/-A" update full tree without pathspec

The bottom one is a necessary first step toward the UI clean-up planned
for 1.8.0 which we discussed in length in the earlier part of the cycle;
the change is low impact, isolated, and has no risk of breaking the system
as a whole, but I would wait until the ":/" magic pathspec materializes,
as the advice message would have to become different, and the way to get
more stable semantics will become more direct.

* jk/progress-with-pager (2011-03-24) 4 commits
 - diff: turn on rename detection progress reporting
 - show: turn on rename detection progress reporting
 - progress: use pager's original_stderr if available
 - pager: save the original stderr when redirecting to pager

Will cook until 1.7.5 final.

* sb/sparse-more (2011-03-21) 1 commit
  (merged to 'next' on 2011-03-23 at 4bec1d1)
 + Makefile: Cover more files with make check

Will merge.

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
  (merged to 'next' on 2011-03-31 at 8d685d7)
 + diffcore-rename: fall back to -C when -C -C busts the rename limit
 + diffcore-rename: record filepair for rename src
 + diffcore-rename: refactor "too many candidates" logic
 + builtin/diff.c: remove duplicated call to diff_result_code()

Will hold.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-03-18 at a32016b)
 + merge-recursive: tweak magic band-aid
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

I am not happy with these magic band aids.  Will hold.

* nd/init-gitdir (2011-03-19) 2 commits
  (merged to 'next' on 2011-03-31 at 3b8fb40)
 + init, clone: support --separate-git-dir for .git file
 + git-init.txt: move description section up

Will merge.

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
  (merged to 'next' on 2011-03-20 at a5e452d)
 + fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 + submodule update: Don't fetch when the submodule commit is already present
 + fetch/pull: Don't recurse into a submodule when commits are already present
 + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 + config: teach the fetch.recurseSubmodules option the 'on-demand' value
 + fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 + fetch/pull: recurse into submodules when necessary

Will merge.

* ab/i18n-st (2011-02-22) 69 commits
  (merged to 'next' on 2011-03-23 at e2732e2)
 + i18n: git-shortlog basic messages
 + i18n: git-revert split up "could not revert/apply" message
 + i18n: git-revert literal "me" messages
 + i18n: git-revert "Your local changes" message
 + i18n: git-revert basic messages
 + i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 + i18n: git-notes basic commands
 + i18n: git-gc "Auto packing the repository" message
 + i18n: git-gc basic messages
 + i18n: git-describe basic messages
 + i18n: git-clean clean.requireForce messages
 + i18n: git-clean basic messages
 + i18n: git-bundle basic messages
 + i18n: git-archive basic messages
 + i18n: git-status "renamed: " message
 + i18n: git-status "Initial commit" message
 + i18n: git-status "Changes to be committed" message
 + i18n: git-status shortstatus messages
 + i18n: git-status "nothing to commit" messages
 + i18n: git-status basic messages
 + i18n: git-push "prevent you from losing" message
 + i18n: git-push basic messages
 + i18n: git-tag tag_template message
 + i18n: git-tag basic messages
 + i18n: git-reset "Unstaged changes after reset" message
 + i18n: git-reset reset_type_names messages
 + i18n: git-reset basic messages
 + i18n: git-rm basic messages
 + i18n: git-mv "bad" messages
 + i18n: git-mv basic messages
 + i18n: git-merge "Wonderful" message
 + i18n: git-merge "You have not concluded your merge" messages
 + i18n: git-merge "Updating %s..%s" message
 + i18n: git-merge basic messages
 + i18n: git-log "--OPT does not make sense" messages
 + i18n: git-log basic messages
 + i18n: git-grep "--open-files-in-pager" message
 + i18n: git-grep basic messages
 + i18n: git-fetch split up "(non-fast-forward)" message
 + i18n: git-fetch update_local_ref messages
 + i18n: git-fetch formatting messages
 + i18n: git-fetch basic messages
 + i18n: git-diff basic messages
 + i18n: git-commit advice messages
 + i18n: git-commit "enter the commit message" message
 + i18n: git-commit print_summary messages
 + i18n: git-commit formatting messages
 + i18n: git-commit "middle of a merge" message
 + i18n: git-commit basic messages
 + i18n: git-checkout "Switched to a .. branch" message
 + i18n: git-checkout "HEAD is now at" message
 + i18n: git-checkout describe_detached_head messages
 + i18n: git-checkout: our/their version message
 + i18n: git-checkout basic messages
 + i18n: git-branch "(no branch)" message
 + i18n: git-branch "git branch -v" messages
 + i18n: git-branch "Deleted branch [...]" message
 + i18n: git-branch "remote branch '%s' not found" message
 + i18n: git-branch basic messages
 + i18n: git-add "Unstaged changes" message
 + i18n: git-add "remove '%s'" message
 + i18n: git-add "did not match any files" message
 + i18n: git-add "The following paths are ignored" message
 + i18n: git-add basic messages
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone basic messages
 + i18n: git-init "Initialized [...] repository" message
 + i18n: git-init basic messages

Will merge.

--------------------------------------------------
[Discarded]

* jc/diff-dotdot (2011-03-23) 2 commits
 . warn use of "git diff A..B"
 . diff: remove dead code that flips arguments order

This was 1/4 tongue-in-cheek. Now we seem to have a handful of volunteer
cluebat bearers, and I wouldn't have to worry about this topic very much.

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 . merge: introduce per-branch-configuration helper function
 . merge: introduce setup_merge_commit helper function
 . merge: update the usage information to be more modern

I've been wanting to move this forward for quite some time but 
ended up redoing it myself (see jc/merge-sans-branch)
