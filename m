From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sun, 30 Dec 2007 11:46:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301145360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1198593316-7712-1-git-send-email-dpotapov@gmail.com>
 <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071230103146.GU13968@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:47:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vhg-0004BT-1P
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXL3KrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXL3KrD
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:47:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:42171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751389AbXL3KrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:47:01 -0500
Received: (qmail invoked by alias); 30 Dec 2007 10:46:59 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp004) with SMTP; 30 Dec 2007 11:46:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Qts5DnhcQlmHjDQhJokYTBBWrssZrBsFnswd5Ug
	3mKcQ94XZrdFXM
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071230103146.GU13968@dpotapov.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69346>

Hi,

On Sun, 30 Dec 2007, Dmitry Potapov wrote:

> On Sat, Dec 29, 2007 at 11:36:51PM +0100, Johannes Schindelin wrote:
> > 
> > On Tue, 25 Dec 2007, Dmitry Potapov wrote:
> > 
> > > 'git-filter-branch branch' could fail producing the error: "Which 
> > > ref do you want to rewrite?" if existed another branch or tag, which 
> > > name was 'branch-something' or 'something/branch'.
> > > 
> > > Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> > > ---
> > >  git-filter-branch.sh     |    2 +-
> > >  t/t7003-filter-branch.sh |   10 ++++++++++
> > >  2 files changed, 11 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > > index dbab1a9..b89a720 100755
> > > --- a/git-filter-branch.sh
> > > +++ b/git-filter-branch.sh
> > > @@ -219,7 +219,7 @@ do
> > >  	;;
> > >  	*)
> > >  		ref="$(git for-each-ref --format='%(refname)' |
> > > -			grep /"$ref")"
> > > +			grep '^refs/[^/]\+/'"$ref"'$')"
> > 
> > Hmm.  I wonder if this is a proper solution.  It still does not error 
> > out when you have a tag and a branch of the same name.
> 
> Are you sure? I had created a tag and a branch with the same name, and
> then tried git filter-branch on it, and it did error out:
> ===
> warning: refname 'test1' is ambiguous.
> Which ref do you want to rewrite?
> ===

Okay, bad example.  But try "heads/master".  Or "origin" in a repository 
which has "refs/remotes/origin/HEAD".

Ciao,
Dscho
