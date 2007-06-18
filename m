From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Jun 2007 19:20:44 +0200
Message-ID: <20070618172044.GA1197@moooo.ath.cx>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net> <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net> <7vodkb1adr.fsf@assigned-by-dhcp.cox.net> <7virac547s.fsf@assigned-by-dhcp.cox.net> <7v6466oygl.fsf@assigned-by-dhcp.cox.net> <7vfy54tt3l.fsf@assigned-by-dhcp.cox.net> <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0KuH-0000uj-SI
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 19:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760737AbXFRRUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 13:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756816AbXFRRUs
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 13:20:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:38207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760717AbXFRRUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 13:20:47 -0400
Received: (qmail invoked by alias); 18 Jun 2007 17:20:46 -0000
Received: from pD9EBB5AD.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.173]
  by mail.gmx.net (mp027) with SMTP; 18 Jun 2007 19:20:46 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19lH/AMJe5l53gfb8pPv9X9PHOYZyAk/M/kfYGLS7
	jTahEwSTSnVGfb
Content-Disposition: inline
In-Reply-To: <7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50402>

Junio C Hamano <gitster@pobox.com> wrote:
> * ei/worktree+filter (Wed Jun 6 09:16:56 2007 +0200)
>  - filter-branch: always export GIT_DIR if it is set
> * ml/worktree (Fri Jun 8 22:57:55 2007 +0200) 9 commits
>  - make git barf when an alias changes environment variables
>  - setup_git_directory: fix segfault if repository is found in cwd
>  - test GIT_WORK_TREE
>  - extend rev-parse test for --is-inside-work-tree
>  - Use new semantics of is_bare/inside_git_dir/inside_work_tree
>  - introduce GIT_WORK_TREE to specify the work tree
>  - test git rev-parse
>  - rev-parse: introduce --is-bare-repository
>  - rev-parse: document --is-inside-git-dir
> 
> Undecided.  Some people would want to have a way to have GIT_DIR
> point at somewhere unusual and still want to work from within a
> subdirectory, which is probably a valid thing to support.  This
> is not something I would use myself, so I am mostly worried
> about the impact these changes may have on people who do not use
> this feature.

The only problem I know of up to now seems the one which happened with
git-filter-branch: if GIT_DIR is set and GIT_WORK_TREE/core.worktree is
set the specified working tree is used instead of cwd.

So for users not using GIT_WORK_TREE/core.worktree there should be no
problem.  There might be problems if someone distributes scripts for
git which expect the old behaviour and the user specified the
worktree.  OTOH the fix is to export GIT_WORK_TREE=. which does not
break the script for older versions of git versions and is quite
short (i.e. should not require any restructuring of the script).
