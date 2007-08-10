From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout-index needs a working tree
Date: Fri, 10 Aug 2007 01:31:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708100129200.21857@racer.site>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
 <20070809223530.GA29680@cassiopeia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJIQ2-0001NW-9w
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXHJAby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXHJAby
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:31:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:48893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751047AbXHJAbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:31:53 -0400
Received: (qmail invoked by alias); 10 Aug 2007 00:31:51 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp001) with SMTP; 10 Aug 2007 02:31:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18F0uAigl8F5otIUQ1m7JIJv/38lrH87Te62KU4t0
	5wudra9FmMTd+V
X-X-Sender: gene099@racer.site
In-Reply-To: <20070809223530.GA29680@cassiopeia>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55491>

Hi,

On Fri, 10 Aug 2007, Uwe Kleine-K?nig wrote:

> Johannes Schindelin wrote:
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	This fixes "git --work-tree=/some/where/else checkout-index".
> > 
> >  git.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git.c b/git.c
> > index 25b8274..f8c4545 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -315,7 +315,8 @@ static void handle_internal_command(int argc, const char **argv)
> >  		{ "branch", cmd_branch, RUN_SETUP },
> >  		{ "bundle", cmd_bundle },
> >  		{ "cat-file", cmd_cat_file, RUN_SETUP },
> > -		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
> > +		{ "checkout-index", cmd_checkout_index,
> > +			RUN_SETUP | NEED_WORK_TREE},
> >  		{ "check-ref-format", cmd_check_ref_format },
> >  		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
> >  		{ "cherry", cmd_cherry, RUN_SETUP },
> With this patch I'm not able to do
> 
> 	git checkout-index --prefix=/tmp/exportdir -a
> 
> to export an entire tree as described in git-checkout-index(1) in a bare
> repo.

That is _completely_ expected.  If it is a bare repository, you can _only_ 
override that check by GIT_WORK_TREE or --work-tree.

But I have to wonder: if you want to use git checkout-index, which is a 
work-tree operation, why did you mark it as bare to begin with?

Ciao,
Dscho
