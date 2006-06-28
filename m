From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 02:33:22 -0700
Message-ID: <20060628093322.GA29036@hand.yhbt.net>
References: <7v1wt94oom.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 11:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvtBJ-0006Am-Oy
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 11:51:30 +0200
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.6/8.13.1/GN) with ESMTP id k5S9Z8oK045174
	for <gcvg-git@gmane.org>; Wed, 28 Jun 2006 11:35:52 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423242AbWF1JdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWF1JdZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:33:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36313 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030487AbWF1JdW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:33:22 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 499337DC022; Wed, 28 Jun 2006 02:33:22 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wt94oom.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=ham 
	version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on mail-relay.eunet.no
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22853>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> >  I've grown used to having 'set -e' at the beginning of my shell
> >  scripts.  IMHO it'd be a good idea to start moving towards this
> >  eventually (even though shell scripts seem to be getting phased-out
> >  somewhat).
> >
> >  git-rebase.sh |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 9ad1c44..47c8e8f 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -59,8 +59,8 @@ continue_merge () {
> >  
> >  	if test -n "`git-diff-index HEAD`"
> >  	then
> > +		git-commit -C "`cat $dotest/current`" || die 'Commit failed'
> >  		printf "Committed: %0${prec}d" $msgnum
> > -		git-commit -C "`cat $dotest/current`"
> 
> Anticipating failure from "git-commit" is the right thing to do,
> but this is a "Now what?" situation.  What is the expected
> course of action to recover from this for the end user, and how
> can we phrase the error message to help that process?

I would expect git-commit to show the correct error message (or the
pre-commit hook), die "$RESOLVEMSG" might be a better option, though.

-- 
Eric Wong
