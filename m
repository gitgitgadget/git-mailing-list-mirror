From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
	pickier
Date: Sat, 9 Feb 2008 14:05:33 -0500
Message-ID: <20080209190533.GD25533@fieldses.org>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 20:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNv1j-0001fm-7a
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 20:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbYBITFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbYBITFh
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 14:05:37 -0500
Received: from mail.fieldses.org ([66.93.2.214]:53256 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502AbYBITFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 14:05:36 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JNv13-0001LL-4P; Sat, 09 Feb 2008 14:05:33 -0500
Content-Disposition: inline
In-Reply-To: <20080209185038.GB25533@fieldses.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73254>

On Sat, Feb 09, 2008 at 01:50:38PM -0500, bfields wrote:
> On Sat, Feb 09, 2008 at 12:56:16PM -0500, Daniel Barkalow wrote:
> > On Sat, 9 Feb 2008, J. Bruce Fields wrote:
> > 
> > > From: J. Bruce Fields <bfields@citi.umich.edu>
> > > 
> > > This will change the notion of "bad" whitespace for the git project to
> > > include initial whitespace that uses spaces where tabs could have been
> > > used.
> > > 
> > > This only changes which whitespace is considered "bad".  It doesn't
> > > change the behavior when bad whitespace is found.  By default, commands
> > > like git-apply, git-am, and git-rebase will print a warning but
> > > otherwise do nothing.
> > 
> > I think there are files under t/ with different whitespace rules. For 
> > example, expected format-patch output will have lines that are: "-- "
> 
> Well, this change doesn't actually affect that case.
> 
> > While you're putting in attributes in general, it'd be nice to take care 
> > of all of the cases already in the tree.
> 
> Yeah, fair enough.  Hard to know where to start, though.  OK, just to
> get an idea, I committed a completely empty tree, made a diff (with
> --binary), then applied with --whitespace=fix and compared to the
> original.  In some cases these seem to be accidental, in some cases
> (git-p4) I assume they're intended to use the different style.

Or the below is just the difference between a tree with the default
whitespace style and one with the initial spaces also changed to tabs
where possible.  (Ignore the spurious change in .gitattributes.)

I'd be inclined to take the lazy approach, defaulting to the more
aggressive checks and then letting people send in the exceptions when
they get annoyed, but perhaps that's unhelpful.

--b.

 .gitattributes                                      |    1 
 COPYING                                             |    2 
 Documentation/SubmittingPatches                     |   30 
 Documentation/callouts.xsl                          |    2 
 Documentation/config.txt                            |    2 
 Documentation/core-tutorial.txt                     |   56 
 Documentation/diff-format.txt                       |    8 
 Documentation/everyday.txt                          |   20 
 Documentation/git-add.txt                           |   14 
 Documentation/git-am.txt                            |    6 
 Documentation/git-archimport.txt                    |    2 
 Documentation/git-bisect.txt                        |    6 
 Documentation/git-blame.txt                         |    4 
 Documentation/git-cherry.txt                        |   12 
 Documentation/git-cvsimport.txt                     |    4 
 Documentation/git-cvsserver.txt                     |   10 
 Documentation/git-daemon.txt                        |   10 
 Documentation/git-diff-tree.txt                     |    2 
 Documentation/git-for-each-ref.txt                  |    4 
 Documentation/git-format-patch.txt                  |   22 
 Documentation/git-http-fetch.txt                    |    8 
 Documentation/git-index-pack.txt                    |    2 
 Documentation/git-instaweb.txt                      |    2 
 Documentation/git-ls-files.txt                      |    2 
 Documentation/git-ls-tree.txt                       |    4 
 Documentation/git-mv.txt                            |    6 
 Documentation/git-pack-objects.txt                  |    4 
 Documentation/git-prune-packed.txt                  |    4 
 Documentation/git-push.txt                          |    2 
 Documentation/git-read-tree.txt                     |   14 
 Documentation/git-rebase.txt                        |   56 
 Documentation/git-repack.txt                        |   10 
 Documentation/git-rerere.txt                        |   20 
 Documentation/git-rev-parse.txt                     |   12 
 Documentation/git-rm.txt                            |    8 
 Documentation/git-send-email.txt                    |   14 
 Documentation/git-show-branch.txt                   |    8 
 Documentation/git-stash.txt                         |    4 
 Documentation/git-unpack-objects.txt                |    2 
 Documentation/git-update-index.txt                  |   18 
 Documentation/git.txt                               |    4 
 Documentation/howto/maintain-git.txt                |   14 
 Documentation/howto/rebase-from-internal-branch.txt |   20 
 Documentation/howto/rebuild-from-update-hook.txt    |    4 
 Documentation/howto/revert-branch-rebase.txt        |    2 
 Documentation/howto/separating-topic-branches.txt   |   86 
 Documentation/howto/update-hook-example.txt         |   56 
 Documentation/rev-list-options.txt                  |   10 
 Documentation/technical/pack-format.txt             |   16 
 Documentation/technical/pack-heuristics.txt         |  340 +-
 Documentation/technical/send-pack-pipeline.txt      |    8 
 Documentation/user-manual.txt                       |  122 
 INSTALL                                             |    4 
 Makefile                                            |    6 
 archive-tar.c                                       |   18 
 archive-zip.c                                       |   12 
 archive.c                                           |   16 
 blob.c                                              |   24 
 builtin-add.c                                       |    4 
 builtin-apply.c                                     |    6 
 builtin-fetch-pack.c                                |    2 
 builtin-fetch.c                                     |    4 
 builtin-for-each-ref.c                              |   10 
 builtin-fsck.c                                      |    4 
 builtin-init-db.c                                   |    2 
 builtin-log.c                                       |    2 
 builtin-ls-tree.c                                   |    6 
 builtin-pack-objects.c                              |    8 
 builtin-rev-parse.c                                 |    4 
 cache-tree.c                                        |    2 
 commit.h                                            |    8 
 compat/inet_pton.c                                  |  242 -
 compat/memmem.c                                     |    2 
 compat/pread.c                                      |   18 
 compat/unsetenv.c                                   |    2 
 configure.ac                                        |    4 
 contrib/completion/git-completion.bash              |    4 
 contrib/emacs/git-blame.el                          |  194 -
 contrib/emacs/git.el                                |  678 ++--
 contrib/emacs/vc-git.el                             |   58 
 contrib/examples/git-commit.sh                      |    2 
 contrib/examples/git-fetch.sh                       |    2 
 contrib/examples/git-svnimport.txt                  |    6 
 contrib/examples/git-tag.sh                         |   16 
 contrib/fast-import/git-p4                          | 2718 ++++++++++----------
 contrib/gitview/gitview                             |    6 
 contrib/hg-to-git/hg-to-git.py                      |  110 
 contrib/hg-to-git/hg-to-git.txt                     |    4 
 contrib/p4import/git-p4import.py                    |  358 +-
 contrib/p4import/git-p4import.txt                   |   12 
 contrib/stats/packinfo.pl                           |   58 
 convert.c                                           |   10 
 diff.h                                              |    2 
 fast-import.c                                       |   18 
 generate-cmdlist.sh                                 |    4 
 git-add--interactive.perl                           |    4 
 git-am.sh                                           |    8 
 git-archimport.perl                                 |  702 ++---
 git-bisect.sh                                       |   36 
 git-compat-util.h                                   |    2 
 git-cvsexportcommit.perl                            |   14 
 git-cvsimport.perl                                  |   24 
 git-cvsserver.perl                                  | 2346 ++++++++---------
 git-filter-branch.sh                                |    2 
 git-help--browse.sh                                 |    2 
 git-merge.sh                                        |   18 
 git-mergetool.sh                                    |   36 
 git-parse-remote.sh                                 |    2 
 git-rebase.sh                                       |    2 
 git-remote.perl                                     |    4 
 git-send-email.perl                                 |   26 
 git-svn.perl                                        |  336 +-
 gitk-git/gitk                                       |   44 
 gitweb/gitweb.perl                                  |  566 ++--
 index-pack.c                                        |   30 
 object.c                                            |    8 
 parse-options.c                                     |   12 
 parse-options.h                                     |    6 
 patch-ids.c                                         |    2 
 perl/Git.pm                                         |   10 
 perl/private-Error.pm                               |   40 
 ppc/sha1ppc.S                                       |    2 
 pretty.c                                            |   24 
 quote.c                                             |    4 
 quote.h                                             |    2 
 refs.c                                              |    2 
 remote.c                                            |    4 
 revision.c                                          |    4 
 sha1_file.c                                         |   10 
 strbuf.c                                            |    2 
 strbuf.h                                            |    2 
 t/lib-read-tree-m-3way.sh                           |    4 
 t/t0040-parse-options.sh                            |    2 
 t/t1000-read-tree-m-3way.sh                         |   12 
 t/t1001-read-tree-m-2way.sh                         |   10 
 t/t1300-repo-config.sh                              |    2 
 t/t3040-subprojects-basic.sh                        |    2 
 t/t3200-branch.sh                                   |   30 
 t/t3600-rm.sh                                       |    4 
 t/t4010-diff-pathspec.sh                            |    4 
 t/t4100/t-apply-1.patch                             |   10 
 t/t4101-apply-nonl.sh                               |    2 
 t/t4201-shortlog.sh                                 |    8 
 t/t5300-pack-object.sh                              |    6 
 t/t5301-sliding-window.sh                           |    6 
 t/t5302-pack-index.sh                               |    6 
 t/t5400-send-pack.sh                                |    6 
 t/t5402-post-merge-hook.sh                          |   12 
 t/t5403-post-checkout-hook.sh                       |   52 
 t/t6000lib.sh                                       |   16 
 t/t6002-rev-list-bisect.sh                          |    2 
 t/t6005-rev-list-count.sh                           |    6 
 t/t6030-bisect-porcelain.sh                         |   10 
 t/t6120-describe.sh                                 |    8 
 t/t7002-grep.sh                                     |    2 
 t/t7003-filter-branch.sh                            |    2 
 t/t7500-commit.sh                                   |    2 
 t/t9100-git-svn-basic.sh                            |   26 
 t/t9104-git-svn-follow-parent.sh                    |  108 
 t/t9107-git-svn-migrate.sh                          |   16 
 t/t9108-git-svn-glob.sh                             |   10 
 t/t9113-git-svn-dcommit-new-file.sh                 |    6 
 t/t9116-git-svn-log.sh                              |    2 
 t/t9118-git-svn-funky-branch-names.sh               |    4 
 t/t9400-git-cvsserver-server.sh                     |    6 
 t/t9500-gitweb-standalone-no-errors.sh              |    4 
 tag.c                                               |   18 
 test-chmtime.c                                      |    4 
 transport.c                                         |    4 
 utf8.c                                              |    4 
 wt-status.c                                         |    4 
 xdiff/xemit.c                                       |    2 
 172 files changed, 5276 insertions(+), 5275 deletions(-)
