From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 13:49:01 +0100
Message-ID: <49CCCB3D.8010706@drmicha.warpmail.net>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 13:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnBWO-000078-Am
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 13:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbZC0MtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 08:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZC0MtM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 08:49:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34435 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705AbZC0MtK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 08:49:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3D5DC301228;
	Fri, 27 Mar 2009 08:49:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 27 Mar 2009 08:49:08 -0400
X-Sasl-enc: eNq2EBVf77jodshElLoqdYNTThNfGD9IunMqQo1mPHTi 1238158147
Received: from localhost.localdomain (p4FC63422.dip0.t-ipconnect.de [79.198.52.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07CC9328B5;
	Fri, 27 Mar 2009 08:49:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114885>

Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
> Hello everybody,
> 
> [About my experience on version control systems: I started out with SCCS in
> the eighties, and I thought it must be cool as the UNIX guys used it to
> maintain their sources. Some times later I was using Emacs' numbered backup
> files as a poor substiutute for nothing else. Then I came across RCS, and I
> liked it soon ,because it was fully documented and well-written. I even ported
> it to MS-DOS (whew!). I was attaching tags to individual files to mark
> "releases" at those times. Then I heard about CVS. It seemed to help with the
> tagging, so I used it for the mopre complex projects. I even did branches and
> merging with it for the Linux sources. I spontaneously diskliked Bitkeeper,
> because it would not work off-line. I heard about Git some time ago, but using
> it seems very non-obvious. After having read the tutorial, and playing some
> simple scenarios, I must admit that I really like the fully distributed nature
> of it. However some commands seem to be a bit strange (e.g. "git add" is
> almost, but quite a "commit" (if you come from CVS)), and sources are quite
> complex. Also some seemingly dangerous commands that cannot easily be undone
> should ask safety questions ("cvs merge (-j)" would also fall into that
> category.]
> 
> What I'd like to see in git (My apologies if some were already discussed to 
> death):
> 
> 1) The ability to use the file's time at the time of add/commit instead of the
> current time, and the ability tho check outfiles with the times stored in the
> repository.
> 
> 2) Keyword substitution. I know it's controverse (dealing with binary files),
> but I'd like to have some automatic version numbering keyword at least:
> Initial idea is that every commit with a change increments the number by one,
> and when merging numbers a and b, the resulting number is max(a, b) + 1.

Keyword substitution and cvs/svn style version numbers are independent
issues. The sha1 describes a commit uniquely, one could use that as a
keyword.

Increasing version numbers are meaningless in a true DVCS world. What is
your 100th commit may not be someone else's, even if both your master's
heads are the same! This is why hg version numbers are a local thing.
They are merely a local shortcut for specifying a revision and serve the
same purpose as git's "backward" counts like HEAD~3 etc. Neither of them
work permanently, not even in a local repo, if you allow rebasing.

git rev-list HEAD|wc may produce something like it, but be sure to read
up on --sparse and --full-history.

> 3) "git undo": If possible undo the effects of the last command.
> 
> Following are some random remarks from a first-time git user, regarding the 
> buld/install:
> 
> Notes on building git-1.6.1.3 on openSUSE 11.0:
> There is no "asciidoc"; the INSTALL should be more verbose on special
> requirements (i.e. additional packages needed, and where to get them).
> LANG= make configure
> /bin/sh: curl-config: command not found
> make: `configure' is up to date.
> 
> make[2]: Entering directory `/git/git-1.6.1.3'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/git/git-1.6.1.3'
> rm -f git-add.html+ git-add.html
> asciidoc -b xhtml11 -d manpage -f asciidoc.conf \
>                  -agit_version=1.6.1.3 -o git-add.html+ git-add.txt
> make[1]: asciidoc: Command not found
> make[1]: *** [git-add.html] Error 127
> make[1]: Leaving directory `/git/git-1.6.1.3/Documentation'
> make: *** [doc] Error 2
> 
> Some parts of the make process may look like an error if they pass by quickly:
> 
> [...]
>     GEN git-request-pull
>     GEN git-sh-setup
>     GEN git-stash
>     GEN git-submodule
>     GEN git-web--browse
>     SUBDIR perl
> /usr/bin/perl Makefile.PL PREFIX='/home/windl/Projects/git/inst'
> Writing perl.mak for Git
>     GEN git-add--interactive
>     GEN git-archimport
>     GEN git-cvsexportcommit
>     GEN git-cvsimport
> [...]
> 
> Same is true for the install process:
> make[1]: Leaving directory `/home/windl/Projects/git/git-1.6.1.3/git-gui'
> bindir=$(cd '/home/windl/Projects/git/inst/bin' && pwd) && \
>         execdir=$(cd '/home/windl/Projects/git/inst/libexec/git-core/' && pwd) && 
> \
>         { rm -f "$execdir/git-add" && \
>                 ln git-add "$execdir/git-add" 2>/dev/null || \
>                 cp git-add "$execdir/git-add"; } && \
>         {  rm -f "$execdir/git-annotate" && ln "$execdir/git-add" "$execdir/git-
> annotate" 2>/dev/null || ln -s "git-add" "$execdir/git-annotate" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-annotate" || exit;  rm -f "$execdir/git-apply" && 
> ln "$execdir/git-add" "$execdir/git-apply" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-apply" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-apply" || 
> exit;  rm -f "$execdir/git-archive" && ln "$execdir/git-add" "$execdir/git-
> archive" 2>/dev/null || ln -s "git-add" "$execdir/git-archive" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-archive" || exit;  rm -f "$execdir/git-blame" && 
> ln "$execdir/git-add" "$execdir/git-blame" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-blame" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-blame" || 
> exit;  rm -f "$execdir/git-branch" && ln "$execdir/git-add" "$execdir/git-branch" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-branch" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-branch" || exit;  rm -f "$execdir/git-bundle" && 
> ln "$execdir/git-add" "$execdir/git-bundle" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-bundle" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-bundle" 
> || exit;  rm -f "$execdir/git-cat-file" && ln "$execdir/git-add" "$execdir/git-
> cat-file" 2>/dev/null || ln -s "git-add" "$execdir/git-cat-file" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-cat-file" || exit;  rm -f "$execdir/git-check-
> attr" && ln "$execdir/git-add" "$execdir/git-check-attr" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-check-attr" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-check-attr" || exit;  rm -f "$execdir/git-check-ref-format" && ln 
> "$execdir/git-add" "$execdir/git-check-ref-format" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-check-ref-format" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-check-ref-format" || exit;  rm -f "$execdir/git-checkout-index" && 
> ln "$execdir/git-add" "$execdir/git-checkout-index" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-checkout-index" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> checkout-index" || exit;  rm -f "$execdir/git-checkout" && ln "$execdir/git-add" 
> "$execdir/git-checkout" 2>/dev/null || ln -s "git-add" "$execdir/git-checkout" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-checkout" || exit;  rm -f 
> "$execdir/git-clean" && ln "$execdir/git-add" "$execdir/git-clean" 2>/dev/null || 
> ln -s "git-add" "$execdir/git-clean" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-clean" || exit;  rm -f "$execdir/git-clone" && ln "$execdir/git-add" 
> "$execdir/git-clone" 2>/dev/null || ln -s "git-add" "$execdir/git-clone" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-clone" || exit;  rm -f 
> "$execdir/git-commit-tree" && ln "$execdir/git-add" "$execdir/git-commit-tree" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-commit-tree" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-commit-tree" || exit;  rm -f "$execdir/git-
> commit" && ln "$execdir/git-add" "$execdir/git-commit" 2>/dev/null || ln -s "git-
> add" "$execdir/git-commit" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> commit" || exit;  rm -f "$execdir/git-config" && ln "$execdir/git-add" 
> "$execdir/git-config" 2>/dev/null || ln -s "git-add" "$execdir/git-config" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-config" || exit;  rm -f 
> "$execdir/git-count-objects" && ln "$execdir/git-add" "$execdir/git-count-objects" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-count-objects" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-count-objects" || exit;  rm -f "$execdir/git-
> describe" && ln "$execdir/git-add" "$execdir/git-describe" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-describe" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-describe" || exit;  rm -f "$execdir/git-diff-files" && ln 
> "$execdir/git-add" "$execdir/git-diff-files" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-diff-files" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-diff-
> files" || exit;  rm -f "$execdir/git-diff-index" && ln "$execdir/git-add" 
> "$execdir/git-diff-index" 2>/dev/null || ln -s "git-add" "$execdir/git-diff-index" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-diff-index" || exit;  rm -f 
> "$execdir/git-diff-tree" && ln "$execdir/git-add" "$execdir/git-diff-tree" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-diff-tree" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-diff-tree" || exit;  rm -f "$execdir/git-diff" && 
> ln "$execdir/git-add" "$execdir/git-diff" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-diff" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-diff" || 
> exit;  rm -f "$execdir/git-fast-export" && ln "$execdir/git-add" "$execdir/git-
> fast-export" 2>/dev/null || ln -s "git-add" "$execdir/git-fast-export" 2>/dev/null 
> || cp "$execdir/git-add" "$execdir/git-fast-export" || exit;  rm -f "$execdir/git-
> fetch--tool" && ln "$execdir/git-add" "$execdir/git-fetch--tool" 2>/dev/null || ln 
> -s "git-add" "$execdir/git-fetch--tool" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-fetch--tool" || exit;  rm -f "$execdir/git-fetch-pack" && ln 
> "$execdir/git-add" "$execdir/git-fetch-pack" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-fetch-pack" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> fetch-pack" || exit;  rm -f "$execdir/git-fetch" && ln "$execdir/git-add" 
> "$execdir/git-fetch" 2>/dev/null || ln -s "git-add" "$execdir/git-fetch" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-fetch" || exit;  rm -f 
> "$execdir/git-fmt-merge-msg" && ln "$execdir/git-add" "$execdir/git-fmt-merge-msg" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-fmt-merge-msg" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-fmt-merge-msg" || exit;  rm -f "$execdir/git-for-
> each-ref" && ln "$execdir/git-add" "$execdir/git-for-each-ref" 2>/dev/null || ln -
> s "git-add" "$execdir/git-for-each-ref" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-for-each-ref" || exit;  rm -f "$execdir/git-fsck" && ln 
> "$execdir/git-add" "$execdir/git-fsck" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-fsck" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-fsck" || 
> exit;  rm -f "$execdir/git-gc" && ln "$execdir/git-add" "$execdir/git-gc" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-gc" 2>/dev/null || cp "$execdir/git-
> add" "$execdir/git-gc" || exit;  rm -f "$execdir/git-grep" && ln "$execdir/git-
> add" "$execdir/git-grep" 2>/dev/null || ln -s "git-add" "$execdir/git-grep" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-grep" || exit;  rm -f 
> "$execdir/git-help" && ln "$execdir/git-add" "$execdir/git-help" 2>/dev/null || ln 
> -s "git-add" "$execdir/git-help" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-help" || exit;  rm -f "$execdir/git-init-db" && ln "$execdir/git-
> add" "$execdir/git-init-db" 2>/dev/null || ln -s "git-add" "$execdir/git-init-db" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-init-db" || exit;  rm -f 
> "$execdir/git-log" && ln "$execdir/git-add" "$execdir/git-log" 2>/dev/null || ln -
> s "git-add" "$execdir/git-log" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> log" || exit;  rm -f "$execdir/git-ls-files" && ln "$execdir/git-add" 
> "$execdir/git-ls-files" 2>/dev/null || ln -s "git-add" "$execdir/git-ls-files" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-ls-files" || exit;  rm -f 
> "$execdir/git-ls-remote" && ln "$execdir/git-add" "$execdir/git-ls-remote" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-ls-remote" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-ls-remote" || exit;  rm -f "$execdir/git-ls-tree" 
> && ln "$execdir/git-add" "$execdir/git-ls-tree" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-ls-tree" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-ls-tree" 
> || exit;  rm -f "$execdir/git-mailinfo" && ln "$execdir/git-add" "$execdir/git-
> mailinfo" 2>/dev/null || ln -s "git-add" "$execdir/git-mailinfo" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-mailinfo" || exit;  rm -f "$execdir/git-
> mailsplit" && ln "$execdir/git-add" "$execdir/git-mailsplit" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-mailsplit" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-mailsplit" || exit;  rm -f "$execdir/git-merge" && ln "$execdir/git-
> add" "$execdir/git-merge" 2>/dev/null || ln -s "git-add" "$execdir/git-merge" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-merge" || exit;  rm -f 
> "$execdir/git-merge-base" && ln "$execdir/git-add" "$execdir/git-merge-base" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-merge-base" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-merge-base" || exit;  rm -f "$execdir/git-merge-
> file" && ln "$execdir/git-add" "$execdir/git-merge-file" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-merge-file" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-merge-file" || exit;  rm -f "$execdir/git-merge-ours" && ln 
> "$execdir/git-add" "$execdir/git-merge-ours" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-merge-ours" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> merge-ours" || exit;  rm -f "$execdir/git-merge-recursive" && ln "$execdir/git-
> add" "$execdir/git-merge-recursive" 2>/dev/null || ln -s "git-add" "$execdir/git-
> merge-recursive" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-merge-
> recursive" || exit;  rm -f "$execdir/git-mv" && ln "$execdir/git-add" 
> "$execdir/git-mv" 2>/dev/null || ln -s "git-add" "$execdir/git-mv" 2>/dev/null || 
> cp "$execdir/git-add" "$execdir/git-mv" || exit;  rm -f "$execdir/git-name-rev" && 
> ln "$execdir/git-add" "$execdir/git-name-rev" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-name-rev" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-name-
> rev" || exit;  rm -f "$execdir/git-pack-objects" && ln "$execdir/git-add" 
> "$execdir/git-pack-objects" 2>/dev/null || ln -s "git-add" "$execdir/git-pack-
> objects" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-pack-objects" || exit;  
> rm -f "$execdir/git-pack-refs" && ln "$execdir/git-add" "$execdir/git-pack-refs" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-pack-refs" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-pack-refs" || exit;  rm -f "$execdir/git-prune-
> packed" && ln "$execdir/git-add" "$execdir/git-prune-packed" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-prune-packed" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-prune-packed" || exit;  rm -f "$execdir/git-prune" && ln 
> "$execdir/git-add" "$execdir/git-prune" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-prune" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-prune" || 
> exit;  rm -f "$execdir/git-push" && ln "$execdir/git-add" "$execdir/git-push" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-push" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-push" || exit;  rm -f "$execdir/git-read-tree" && 
> ln "$execdir/git-add" "$execdir/git-read-tree" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-read-tree" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-read-
> tree" || exit;  rm -f "$execdir/git-receive-pack" && ln "$execdir/git-add" 
> "$execdir/git-receive-pack" 2>/dev/null || ln -s "git-add" "$execdir/git-receive-
> pack" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-receive-pack" || exit;  
> rm -f "$execdir/git-reflog" && ln "$execdir/git-add" "$execdir/git-reflog" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-reflog" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-reflog" || exit;  rm -f "$execdir/git-remote" && 
> ln "$execdir/git-add" "$execdir/git-remote" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-remote" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-remote" 
> || exit;  rm -f "$execdir/git-rerere" && ln "$execdir/git-add" "$execdir/git-
> rerere" 2>/dev/null || ln -s "git-add" "$execdir/git-rerere" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-rerere" || exit;  rm -f "$execdir/git-reset" && 
> ln "$execdir/git-add" "$execdir/git-reset" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-reset" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-reset" || 
> exit;  rm -f "$execdir/git-rev-list" && ln "$execdir/git-add" "$execdir/git-rev-
> list" 2>/dev/null || ln -s "git-add" "$execdir/git-rev-list" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-rev-list" || exit;  rm -f "$execdir/git-rev-
> parse" && ln "$execdir/git-add" "$execdir/git-rev-parse" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-rev-parse" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-rev-parse" || exit;  rm -f "$execdir/git-revert" && ln 
> "$execdir/git-add" "$execdir/git-revert" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-revert" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-revert" 
> || exit;  rm -f "$execdir/git-rm" && ln "$execdir/git-add" "$execdir/git-rm" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-rm" 2>/dev/null || cp "$execdir/git-
> add" "$execdir/git-rm" || exit;  rm -f "$execdir/git-send-pack" && ln 
> "$execdir/git-add" "$execdir/git-send-pack" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-send-pack" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-send-
> pack" || exit;  rm -f "$execdir/git-shortlog" && ln "$execdir/git-add" 
> "$execdir/git-shortlog" 2>/dev/null || ln -s "git-add" "$execdir/git-shortlog" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-shortlog" || exit;  rm -f 
> "$execdir/git-show-branch" && ln "$execdir/git-add" "$execdir/git-show-branch" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-show-branch" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-show-branch" || exit;  rm -f "$execdir/git-show-
> ref" && ln "$execdir/git-add" "$execdir/git-show-ref" 2>/dev/null || ln -s "git-
> add" "$execdir/git-show-ref" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> show-ref" || exit;  rm -f "$execdir/git-stripspace" && ln "$execdir/git-add" 
> "$execdir/git-stripspace" 2>/dev/null || ln -s "git-add" "$execdir/git-stripspace" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-stripspace" || exit;  rm -f 
> "$execdir/git-symbolic-ref" && ln "$execdir/git-add" "$execdir/git-symbolic-ref" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-symbolic-ref" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-symbolic-ref" || exit;  rm -f "$execdir/git-tag" 
> && ln "$execdir/git-add" "$execdir/git-tag" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-tag" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-tag" || 
> exit;  rm -f "$execdir/git-tar-tree" && ln "$execdir/git-add" "$execdir/git-tar-
> tree" 2>/dev/null || ln -s "git-add" "$execdir/git-tar-tree" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-tar-tree" || exit;  rm -f "$execdir/git-unpack-
> objects" && ln "$execdir/git-add" "$execdir/git-unpack-objects" 2>/dev/null || ln 
> -s "git-add" "$execdir/git-unpack-objects" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-unpack-objects" || exit;  rm -f "$execdir/git-update-index" && ln 
> "$execdir/git-add" "$execdir/git-update-index" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-update-index" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> update-index" || exit;  rm -f "$execdir/git-update-ref" && ln "$execdir/git-add" 
> "$execdir/git-update-ref" 2>/dev/null || ln -s "git-add" "$execdir/git-update-ref" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-update-ref" || exit;  rm -f 
> "$execdir/git-upload-archive" && ln "$execdir/git-add" "$execdir/git-upload-
> archive" 2>/dev/null || ln -s "git-add" "$execdir/git-upload-archive" 2>/dev/null 
> || cp "$execdir/git-add" "$execdir/git-upload-archive" || exit;  rm -f 
> "$execdir/git-verify-pack" && ln "$execdir/git-add" "$execdir/git-verify-pack" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-verify-pack" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-verify-pack" || exit;  rm -f "$execdir/git-
> verify-tag" && ln "$execdir/git-add" "$execdir/git-verify-tag" 2>/dev/null || ln -
> s "git-add" "$execdir/git-verify-tag" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-verify-tag" || exit;  rm -f "$execdir/git-write-tree" && ln 
> "$execdir/git-add" "$execdir/git-write-tree" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-write-tree" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> write-tree" || exit;  rm -f "$execdir/git-cherry-pick" && ln "$execdir/git-add" 
> "$execdir/git-cherry-pick" 2>/dev/null || ln -s "git-add" "$execdir/git-cherry-
> pick" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-cherry-pick" || exit;  rm 
> -f "$execdir/git-cherry" && ln "$execdir/git-add" "$execdir/git-cherry" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-cherry" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-cherry" || exit;  rm -f "$execdir/git-format-
> patch" && ln "$execdir/git-add" "$execdir/git-format-patch" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-format-patch" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-format-patch" || exit;  rm -f "$execdir/git-fsck-objects" && ln 
> "$execdir/git-add" "$execdir/git-fsck-objects" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-fsck-objects" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-
> fsck-objects" || exit;  rm -f "$execdir/git-get-tar-commit-id" && ln 
> "$execdir/git-add" "$execdir/git-get-tar-commit-id" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-get-tar-commit-id" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-get-tar-commit-id" || exit;  rm -f "$execdir/git-init" && ln 
> "$execdir/git-add" "$execdir/git-init" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-init" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-init" || 
> exit;  rm -f "$execdir/git-merge-subtree" && ln "$execdir/git-add" "$execdir/git-
> merge-subtree" 2>/dev/null || ln -s "git-add" "$execdir/git-merge-subtree" 
> 2>/dev/null || cp "$execdir/git-add" "$execdir/git-merge-subtree" || exit;  rm -f 
> "$execdir/git-peek-remote" && ln "$execdir/git-add" "$execdir/git-peek-remote" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-peek-remote" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-peek-remote" || exit;  rm -f "$execdir/git-repo-
> config" && ln "$execdir/git-add" "$execdir/git-repo-config" 2>/dev/null || ln -s 
> "git-add" "$execdir/git-repo-config" 2>/dev/null || cp "$execdir/git-add" 
> "$execdir/git-repo-config" || exit;  rm -f "$execdir/git-show" && ln 
> "$execdir/git-add" "$execdir/git-show" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-show" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-show" || 
> exit;  rm -f "$execdir/git-stage" && ln "$execdir/git-add" "$execdir/git-stage" 
> 2>/dev/null || ln -s "git-add" "$execdir/git-stage" 2>/dev/null || cp 
> "$execdir/git-add" "$execdir/git-stage" || exit;  rm -f "$execdir/git-status" && 
> ln "$execdir/git-add" "$execdir/git-status" 2>/dev/null || ln -s "git-add" 
> "$execdir/git-status" 2>/dev/null || cp "$execdir/git-add" "$execdir/git-status" 
> || exit;  rm -f "$execdir/git-whatchanged" && ln "$execdir/git-add" "$execdir/git-
> whatchanged" 2>/dev/null || ln -s "git-add" "$execdir/git-whatchanged" 2>/dev/null 
> || cp "$execdir/git-add" "$execdir/git-whatchanged" || exit; } && \
>         ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
> 
> There's a problem with "make quick-install-man":
> LANG= make quick-install-man
> make -C Documentation quick-install-man
> make[1]: Entering directory `/git/git-1.6.1.3/Documentation'
> make -C ../ GIT-VERSION-FILE
> make[2]: Entering directory `/git/git-1.6.1.3'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/git/git-1.6.1.3'
> sh ./install-doc-quick.sh origin/man /git/inst/share/man
> ./install-doc-quick.sh: line 9: /git/inst/libexec/git-sh-setup: No such file or 
> directory
> make[1]: *** [quick-install-man] Error 1
> make[1]: Leaving directory `/git/git-1.6.1.3/Documentation'
> make: *** [quick-install-man] Error 2
> 
> Regards,
> Ulrich Windl
> 
