From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 00/16] Add missing &&'s in the testsuite
Date: Fri, 24 Sep 2010 16:22:40 -0600
Message-ID: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGdy-0000U4-RX
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab0IXWVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:16 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60844 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:15 -0400
Received: by qwh6 with SMTP id 6so2090828qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=03ATuhbI0ARf4lNM41dJ7nOir92Gbgr6oaaYv3g+JJ0=;
        b=SsjjuIcJ7Gl/XG0yore6yx5lzvCnwzi5Lg2mmb8h2K4m8ZVBcAvJ6bhGgz5lijDvHw
         dXrBymoeH6vmc8sJhv9Q1qxdsaPknE7MVq8G9TPRyZSc4Z5woSPYDdI9k/860UXksA/D
         HBTUm2oWAETMnwwUDGJT2SLRQOZnQODZFKa6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rB45qMFnX5VDc+Gts8BRnsIrhuPJFlsvIXDJTfQ4v52WLV4LHTvT5i3TYrSkT4OHvI
         fDtWoaL+4An7wmuB53ttHb4ntrejKxulIfcfLM9cOFy6jtdSBqACBqOOnx4H2THJWsOQ
         HZMSUccjwZWeWUGl2G+0KsrBCJ8jEnzuuV7Dk=
Received: by 10.220.124.215 with SMTP id v23mr1375388vcr.170.1285366874490;
        Fri, 24 Sep 2010 15:21:14 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.12
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157072>

This patch series fixes many of the missing &&s in the testsuite.  I'm
certain there are still others I have missed.  While many of the
changes were simple and obvious (e.g. the 80 files changed in patch 16
of this series), some required other changes which I'd like some
feedback on.

Changes since v1:
  * Squashed all the trivial mechanical '&&' addition patches together
  * Re-ordered the other 15 patches by type of change

*** BLURB HERE ***

Elijah Newren (16):
  t3020 (ls-files-error-unmatch): remove stray '1' from end of file

I'm guessing this was a stray character typed in and unnoticed, but
perhaps it serves a real purpose that I just don't understand?


  t4017 (diff-retval): replace manual exit code check with test_expect_code

Several tests in t4017 just ran one command and tried to check it's
exit status, so they seemed like clear candidates for
test_expect_code.


  t1001 (read-tree-m-2way): add missing &&
  t1002 (read-tree-m-u-2way): add missing &&
  t4002 (diff-basic): use test_might_fail for commands that might fail
  t4202 (log): Replace '<git-command> || :' with test_might_fail

All four of these patches replace occurrences of things like
  command that should succeed || return 1
  command that will fail
with
  command that should succeed &&
  test_might_fail command that will fail &&


  t3600 (rm): add lots of missing &&
  t4019 (diff-wserror): add lots of missing &&
  t4026 (color): add missing &&
  t5602 (clone-remote-exec): add missing &&
  t6016 (rev-list-graph-simplify-history): add missing &&
  t6050 (replace): add missing &&
  t7001 (mv): add missing &&
  t7601 (merge-pull-config): add missing &&
  t7800 (difftool): add missing &&

These 9 tests needed modifications of various sorts to pass after
adding missing &&s.


  Add missing &&'s throughout the testsuite

One big patch for 80 files with simple addition of '&&' where it was
needed.


 t/t0001-init.sh                             |   20 +++++-----
 t/t0003-attributes.sh                       |   16 ++++----
 t/t0020-crlf.sh                             |    2 +-
 t/t0024-crlf-archive.sh                     |    4 +-
 t/t0026-eol-config.sh                       |    2 +-
 t/t0050-filesystem.sh                       |    6 ++--
 t/t1000-read-tree-m-3way.sh                 |    2 +-
 t/t1001-read-tree-m-2way.sh                 |   18 +++++-----
 t/t1002-read-tree-m-u-2way.sh               |   10 +++---
 t/t1302-repo-version.sh                     |    2 +-
 t/t1401-symbolic-ref.sh                     |    2 +-
 t/t1402-check-ref-format.sh                 |    4 +-
 t/t1410-reflog.sh                           |    8 ++--
 t/t1501-worktree.sh                         |    2 +-
 t/t1509-root-worktree.sh                    |    6 ++--
 t/t2007-checkout-symlink.sh                 |    2 +-
 t/t2016-checkout-patch.sh                   |    2 +-
 t/t2050-git-dir-relative.sh                 |    4 +-
 t/t2103-update-index-ignore-missing.sh      |    2 +-
 t/t2200-add-update.sh                       |    2 +-
 t/t3001-ls-files-others-exclude.sh          |    2 +-
 t/t3020-ls-files-error-unmatch.sh           |    1 -
 t/t3050-subprojects-fetch.sh                |    4 +-
 t/t3203-branch-output.sh                    |    6 ++--
 t/t3307-notes-man.sh                        |    2 +-
 t/t3406-rebase-message.sh                   |    6 ++--
 t/t3408-rebase-multi-line.sh                |    2 +-
 t/t3504-cherry-pick-rerere.sh               |    4 +-
 t/t3600-rm.sh                               |   38 +++++++++-----------
 t/t3903-stash.sh                            |    4 +-
 t/t3904-stash-patch.sh                      |    2 +-
 t/t4002-diff-basic.sh                       |   12 +++---
 t/t4017-diff-retval.sh                      |   30 +++++----------
 t/t4019-diff-wserror.sh                     |   52 +++++++++++++-------------
 t/t4021-format-patch-numbered.sh            |    2 +-
 t/t4026-color.sh                            |    2 +-
 t/t4027-diff-submodule.sh                   |    2 +-
 t/t4103-apply-binary.sh                     |    8 ++--
 t/t4104-apply-boundary.sh                   |    4 +-
 t/t4111-apply-subdir.sh                     |    4 +-
 t/t4119-apply-config.sh                     |    2 +-
 t/t4124-apply-ws-rule.sh                    |    4 +-
 t/t4127-apply-same-fn.sh                    |   18 +++++-----
 t/t4130-apply-criss-cross-rename.sh         |    2 +-
 t/t4133-apply-filenames.sh                  |    6 ++--
 t/t4150-am.sh                               |    2 +-
 t/t4202-log.sh                              |    2 +-
 t/t5300-pack-object.sh                      |    4 +-
 t/t5301-sliding-window.sh                   |    2 +-
 t/t5302-pack-index.sh                       |    2 +-
 t/t5500-fetch-pack.sh                       |    2 +-
 t/t5502-quickfetch.sh                       |    2 +-
 t/t5503-tagfollow.sh                        |    4 +-
 t/t5510-fetch.sh                            |    2 +-
 t/t5516-fetch-push.sh                       |   20 +++++-----
 t/t5517-push-mirror.sh                      |   10 +++---
 t/t5519-push-alternates.sh                  |    2 +-
 t/t5531-deep-submodule-push.sh              |    2 +-
 t/t5541-http-push.sh                        |    2 +-
 t/t5550-http-fetch.sh                       |    6 ++--
 t/t5601-clone.sh                            |    6 ++--
 t/t5602-clone-remote-exec.sh                |   14 ++++----
 t/t5701-clone-local.sh                      |    8 ++--
 t/t5705-clone-2gb.sh                        |    2 +-
 t/t6009-rev-list-parent.sh                  |    2 +-
 t/t6010-merge-base.sh                       |    2 +-
 t/t6016-rev-list-graph-simplify-history.sh  |   24 +++---------
 t/t6022-merge-rename.sh                     |    2 +-
 t/t6024-recursive-merge.sh                  |    2 +-
 t/t6030-bisect-porcelain.sh                 |    8 ++--
 t/t6040-tracking-info.sh                    |    2 +-
 t/t6050-replace.sh                          |    4 +-
 t/t7001-mv.sh                               |    2 +-
 t/t7004-tag.sh                              |   14 ++++----
 t/t7105-reset-patch.sh                      |    6 ++--
 t/t7300-clean.sh                            |    6 ++--
 t/t7501-commit.sh                           |    2 +-
 t/t7502-commit.sh                           |    2 +-
 t/t7506-status-submodule.sh                 |    2 +-
 t/t7600-merge.sh                            |    2 +-
 t/t7601-merge-pull-config.sh                |   12 +++---
 t/t7610-mergetool.sh                        |    2 +-
 t/t7700-repack.sh                           |    2 +-
 t/t7800-difftool.sh                         |   12 +++---
 t/t8003-blame.sh                            |    6 ++--
 t/t9122-git-svn-author.sh                   |    4 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9134-git-svn-ignore-paths.sh             |    6 ++--
 t/t9137-git-svn-dcommit-clobber-series.sh   |    2 +-
 t/t9138-git-svn-authors-prog.sh             |    6 ++--
 t/t9146-git-svn-empty-dirs.sh               |    6 ++--
 t/t9151-svn-mergeinfo.sh                    |   22 ++++++------
 t/t9200-git-cvsexportcommit.sh              |    4 +-
 t/t9401-git-cvsserver-crlf.sh               |    2 +-
 t/t9600-cvsimport.sh                        |    2 +-
 95 files changed, 287 insertions(+), 314 deletions(-)

-- 
1.7.3.95.g14291
