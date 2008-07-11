From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/5] Extend make remove-dashes
Date: Fri, 11 Jul 2008 02:12:02 +0200
Message-ID: <cover.1215734604.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH6Fp-00088A-CM
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 02:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYGKALy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 20:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYGKALx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 20:11:53 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35015 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbYGKALx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 20:11:53 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id AD4821DDC5B;
	Fri, 11 Jul 2008 02:11:50 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 395371A9833; Fri, 11 Jul 2008 02:12:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88063>

Hi,

This series extends what make remove-dashes did so far, now it uses not
only builtins but other programs (git-daemon, etc.) and the shell/perl
scripts as well.

The first two patch does minor changes to avoid unwanted renames.

The third patch changes the output of git bisect log to use a dash-less
form.

The 4th patch updates Linus' fixup-builtins script. It was used to
generate the last 'huge' patch.

The idea behind this series is to avoid commands in the source code and
tests which is not available in PATH; in other words I *think* is not a
'necessary' but a 'sooner or later we will have to do this' series.

The last patch is more a demonstration than a patch for inclusion at the
moment, since problem this is not the right time to do such a big
rename.

Miklos Vajna (5):
  t0001-init.sh: change confusing directory name
  t1007-hash-object.sh: use quotes for the test description
  git-bisect: use dash-less form on git bisect log
  make remove-dashes: apply to scripts and programs as well, not just
    to builtins
  Rewrite "git-frotz" to "git frotz" for scripts and programs as well

 Makefile                             |    2 +-
 contrib/examples/git-checkout.sh     |    2 +-
 contrib/examples/git-clean.sh        |    2 +-
 contrib/examples/git-clone.sh        |   24 ++--
 contrib/examples/git-commit.sh       |    6 +-
 contrib/examples/git-fetch.sh        |    6 +-
 contrib/examples/git-gc.sh           |    2 +-
 contrib/examples/git-ls-remote.sh    |    2 +-
 contrib/examples/git-resolve.sh      |    4 +-
 contrib/examples/git-revert.sh       |   22 ++--
 contrib/examples/git-tag.sh          |    6 +-
 fixup-builtins                       |   18 +-
 git-am.sh                            |   22 ++--
 git-bisect.sh                        |   10 +-
 git-instaweb.sh                      |    4 +-
 git-merge-octopus.sh                 |    2 +-
 git-merge-one-file.sh                |    8 +-
 git-merge-resolve.sh                 |    2 +-
 git-merge.sh                         |   10 +-
 git-parse-remote.sh                  |    6 +-
 git-pull.sh                          |   10 +-
 git-quiltimport.sh                   |    2 +-
 git-rebase.sh                        |   14 +-
 git-repack.sh                        |   12 +-
 git-sh-setup.sh                      |    2 +-
 git-stash.sh                         |   10 +-
 git-submodule.sh                     |   12 +-
 git-web--browse.sh                   |    2 +-
 t/t0001-init.sh                      |    6 +-
 t/t0050-filesystem.sh                |    2 +-
 t/t1007-hash-object.sh               |    2 +-
 t/t1200-tutorial.sh                  |    2 +-
 t/t1303-wacky-config.sh              |    2 +-
 t/t1400-update-ref.sh                |   10 +-
 t/t1503-rev-parse-verify.sh          |    2 +-
 t/t2005-checkout-index-symlinks.sh   |    4 +-
 t/t2050-git-dir-relative.sh          |    4 +-
 t/t2101-update-index-reupdate.sh     |    2 +-
 t/t2102-update-index-symlinks.sh     |    2 +-
 t/t2200-add-update.sh                |   12 +-
 t/t3001-ls-files-others-exclude.sh   |    2 +-
 t/t3020-ls-files-error-unmatch.sh    |    2 +-
 t/t3030-merge-recursive.sh           |   14 +-
 t/t3200-branch.sh                    |   58 +++---
 t/t3210-pack-refs.sh                 |    4 +-
 t/t3400-rebase.sh                    |    6 +-
 t/t3401-rebase-partial.sh            |   22 ++--
 t/t3403-rebase-skip.sh               |    2 +-
 t/t3404-rebase-interactive.sh        |    2 +-
 t/t3407-rebase-abort.sh              |    2 +-
 t/t3500-cherry.sh                    |   12 +-
 t/t3600-rm.sh                        |    4 +-
 t/t3800-mktag.sh                     |   12 +-
 t/t3900-i18n-commit.sh               |    6 +-
 t/t3901-i18n-patch.sh                |   16 +-
 t/t3903-stash.sh                     |    2 +-
 t/t4012-diff-binary.sh               |    4 +-
 t/t4103-apply-binary.sh              |   26 ++--
 t/t4124-apply-ws-rule.sh             |    2 +-
 t/t4127-apply-same-fn.sh             |    4 +-
 t/t4150-am.sh                        |    2 +-
 t/t5300-pack-object.sh               |   14 +-
 t/t5301-sliding-window.sh            |    4 +-
 t/t5302-pack-index.sh                |   12 +-
 t/t5400-send-pack.sh                 |   30 ++--
 t/t5401-update-hooks.sh              |    4 +-
 t/t5402-post-merge-hook.sh           |    4 +-
 t/t5403-post-checkout-hook.sh        |    4 +-
 t/t5500-fetch-pack.sh                |    4 +-
 t/t5510-fetch.sh                     |    2 +-
 t/t5530-upload-pack-error.sh         |    4 +-
 t/t5600-clone-fail-cleanup.sh        |   12 +-
 t/t6006-rev-list-format.sh           |    6 +-
 t/t6025-merge-symlinks.sh            |   32 ++--
 t/t6026-merge-attr.sh                |   12 +-
 t/t6030-bisect-porcelain.sh          |    4 +-
 t/t6120-describe.sh                  |   30 ++--
 t/t6300-for-each-ref.sh              |   28 ++--
 t/t7001-mv.sh                        |   12 +-
 t/t7003-filter-branch.sh             |   20 +-
 t/t7004-tag.sh                       |  318 +++++++++++++++++-----------------
 t/t7101-reset.sh                     |    8 +-
 t/t7102-reset.sh                     |    4 +-
 t/t7103-reset-bare.sh                |    2 +-
 t/t7201-co.sh                        |    2 +-
 t/t7300-clean.sh                     |   76 ++++----
 t/t7400-submodule-basic.sh           |   48 +++---
 t/t7401-submodule-summary.sh         |    2 +-
 t/t7500-commit.sh                    |    2 +-
 t/t7501-commit.sh                    |   48 +++---
 t/t7502-status.sh                    |    2 +-
 t/t7505-prepare-commit-msg-hook.sh   |    2 +-
 t/t7506-status-submodule.sh          |    2 +-
 t/t7600-merge.sh                     |    2 +-
 t/t7610-mergetool.sh                 |    2 +-
 t/t7701-repack-unpack-unreachable.sh |    2 +-
 t/t9001-send-email.sh                |    2 +-
 t/t9101-git-svn-props.sh             |   28 ++--
 t/t9119-git-svn-info.sh              |   44 +++---
 t/t9200-git-cvsexportcommit.sh       |   14 +-
 t/t9300-fast-import.sh               |   66 ++++----
 t/t9301-fast-export.sh               |    2 +-
 t/t9400-git-cvsserver-server.sh      |   40 ++--
 t/t9401-git-cvsserver-crlf.sh        |   10 +-
 t/t9600-cvsimport.sh                 |    2 +-
 t/t9700-perl-git.sh                  |   16 +-
 106 files changed, 731 insertions(+), 731 deletions(-)
