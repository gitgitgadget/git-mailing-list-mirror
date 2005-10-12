From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-mv]
Date: Wed, 12 Oct 2005 07:28:09 -0700
Message-ID: <20051012142809.GA17037@tumblerings.org>
References: <20051007143333.GA18843@tumblerings.org> <20051012100757.GM30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:30:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPhap-0004QJ-4c
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 16:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVJLO22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJLO22
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 10:28:28 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:52192 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S964792AbVJLO22
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 10:28:28 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.52)
	id 1EPhaT-0006Ha-MU; Wed, 12 Oct 2005 07:28:09 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051012100757.GM30889@pasky.or.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10029>

On Wed, Oct 12, 2005 at 12:07:57PM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Oct 07, 2005 at 04:33:33PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > Hi,
> 
> Hello,
> 
> > IIRC, file renaming is something we only care about at read time, we don't
> > actually need to track it while making the change, because git allows us to
> > track data from file to file without having to tell it that the data is moving.
> > 
> > So, just to keep certain people happy, why not have the cg-mv command defined to
> > something like this:
> > 
> > #!/bin/bash
> > cp $1 $2
> > cg-rm $1
> > cg-add $2
> 
> so it should keep the file under the original name as well, but
> untraced? That's weird.

Yes, I mistyped. cp is wrong.

> What about
> 
> 	#!/usr/bin/env bash
> 
> 	if [ -e $2 ]; then
> 		! got_parameter -f && die "dest exists"
> 		[ -e $1 ] || die "no source nor destination"
> 	fi
> 	( [ -e $1 ] && mv $1 $2 ) && cg-add $2 && cg-rm $1
> 
> plus quoting and stuff?

Yes, that's nicer. Maybe the last line should be:

( [ -e $1 ] && mv $1 $2 ) && cg-add $2 && cg-rm $1 || die "unable to rename file"

But you've already done "-e $1" earlier, right? So maybe you don't need it at
the end. Just have:

mv $1 $2 && cg-add $2 && cg-rm $1 || die "unable to rename file"

No?

Be well,
Zack

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> VI has two modes: the one in which it beeps and the one in which
> it doesn't.

-- 
Zack Brown
