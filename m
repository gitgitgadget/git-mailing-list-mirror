From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add missing inside_work_tree setting in setup_git_directory_gently
Date: Wed, 7 Nov 2007 20:54:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072053490.4362@racer.site>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
 <7vir4ivdcr.fsf@gitster.siamese.dyndns.org> <20071104070307.GA26071@laptop>
 <7vve8daisu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 21:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipruu-0000rE-PC
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 21:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbXKGUyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbXKGUyM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 15:54:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:35138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbXKGUyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 15:54:12 -0500
Received: (qmail invoked by alias); 07 Nov 2007 20:54:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 07 Nov 2007 21:54:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AlGUx+bOAWJaXfoA3INP0D5AjTrZVMcLKmaiL38
	PnH96/yPPB2WQJ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve8daisu.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63860>

Hi,

On Wed, 7 Nov 2007, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > On Sat, Nov 03, 2007 at 09:33:40PM -0700, Junio C Hamano wrote:
> >> 
> >> Please add automated test script for this, thanks.
> >
> > Thank you for reminding.  I tried to put a test in
> > t1501-worktree.sh and found out core.worktree can override
> > inside_work_tree previously set by setup_git_directory_gently(),
> > activating the worktree code in setup_git_directory() again.
> >
> > This made me think setup_git_directory_gently() should use
> > get_git_work_tree() instead. But then git_work_tree_cfg may not be
> > initialized when get_git_work_tree() is called (starting from
> > setup_git_directory(), git_work_tree_cfg is initialized in
> > check_repository_format_version(), which is called _after_
> > setup_git_directory_gently()).
> >
> > The interaction between these variables and functions is really beyond
> > my knowledge. Johannes, can you have a look at this? In theory the
> > following test should pass:
> >
> > diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> > index 7ee3820..bdb7720 100755
> > --- a/t/t1501-worktree.sh
> > +++ b/t/t1501-worktree.sh
> > @@ -103,6 +103,11 @@ test_expect_success 'repo finds its work tree from work tree, too' '
> >  	 test sub/dir/tracked = "$(git ls-files)")
> >  '
> >  
> > +test_expect_success 'Try a command from subdir in worktree' '
> > +	(cd repo.git/work/sub &&
> > +	GIT_DIR=../.. GIT_WORK_TREE=.. git blame dir/tracked)
> > +'
> > +
> >  test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
> >  	cd repo.git/work/sub/dir &&
> >  	GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \
> 
> I am wondering what happened to this thread...

It is still in my inbox, waiting for a time where I can actually 
concentrate.

Ciao,
Dscho
