From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [DOCBUG] git subtree synopsis needs updating
Date: Fri, 18 Jan 2013 15:37:34 +0100
Organization: Bertin Technologies
Message-ID: <20130118153734.54640b2d@chalon.bertin.fr>
References: <20121019152158.4297707b@chalon.bertin.fr>
 <877gnx39aa.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Fri Jan 18 15:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwD4u-0002MK-GS
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 15:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab3AROhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 09:37:35 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:65296 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab3AROhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 09:37:34 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 19D32A1008
	for <git@vger.kernel.org>; Fri, 18 Jan 2013 15:37:33 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id EED38A1005
	for <git@vger.kernel.org>; Fri, 18 Jan 2013 15:37:32 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MGT004M6SMK4410@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 18 Jan 2013 15:37:32 +0100 (CET)
In-reply-to: <877gnx39aa.fsf@waller.obbligato.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-7.0.0.1014-19564.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213912>

On Mon, 31 Dec 2012 20:51:41 -0600
greened@obbligato.org wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > As the examples in git-subtree.txt show, the synopsis in the same file should
> > surely get a patch along the lines of:
> >
> > -'git subtree' add   -P <prefix> <commit>
> > +'git subtree' add   -P <prefix> <repository> <commit>
> >
> > Failure to specify the repository (by just specifying a local commit) fails with
> > the cryptic:
> >
> >  warning: read-tree: emptying the index with no arguments is deprecated; use --empty
> >  fatal: just how do you expect me to merge 0 trees?
> 
> Specifying a local branch works fine, though, as does a raw commit
> hash.  What do you mean by "local commit?"

With no <repository> arg documented, my understanding was that I should first 
"git remote add" and fetch the repo in which the branch to be added as subtree
lived.  This when running "git subtree add", the commit was indeed existing
locally.

> > As a sidenote it someone wants to do some maintainance, using "." as repository when
> > the branch to subtree-add is already locally available does not work well either
> > (fails with "could not find ref myremote/myhead").
> 
> Seems to work for me.  Can you give me the command you're using when you
> see the problem?

Hm, can't remember exactly how I reached that.  But when experimenting to
reproduce:

$ contrib/subtree/git-subtree.sh add -P foo . origin/maint
git fetch . origin/maint
From .
 * remote-tracking branch origin/maint -> FETCH_HEAD
Added dir 'foo'

=> OK

$ contrib/subtree/git-subtree.sh add -P fooo . origin/maint^0
git fetch . origin/maint^0
fatal: Invalid refspec 'origin/maint^0'

=> a commit is advertised, but in fact it seems to require a refspec

-- 
Yann Dirson - Bertin Technologies
