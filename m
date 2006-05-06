From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sun, 7 May 2006 00:01:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605062358280.6357@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viroirfur.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 00:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUq2-00072g-IT
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWEFWBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWEFWBR
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:01:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29404 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932082AbWEFWBR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 18:01:17 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1AB971C0F;
	Sun,  7 May 2006 00:01:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0E8261A5D;
	Sun,  7 May 2006 00:01:16 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E47D3F98;
	Sun,  7 May 2006 00:01:15 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viroirfur.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19675>

Hi,

On Sat, 6 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When calling "git fmt-patch HEAD~5", you now get the same as if you would
> > have said "git fmt-patch HEAD~5..". This makes it easier for my fingers
> > which are so used to the old syntax.
> 
> While this would be easier on _my_ fingers as well, I have a
> suspicion that it might make more sense to make this "single
> ref" case to mean "HEAD~5^..HEAD~5" (if we _were_ designing a
> new command that is called format-patch today, that would be
> more natural).  But probably it is too late to break it by now.

No, it is not too late. I did this patch only to prevent cluttering my 
directory with millions of patches, only because I forgot _again_ to type 
the two dots.

> > 	I wonder: would it make sense to make add_pending_object() and 
> > 	get_reference() in revision.c non-static?
> 
> I'd rather not expose such revision.c internals too much.  An
> alternative approach would be to give instruction to revision.c
> (read: another flag like rev.no_walk) to tell it to do something
> special when the user has only one commit, but I think what you
> did in your patch is cleaner and sufficient.

I just stole the function add_head() from builtin-diff.c, but that feels 
wrong. I think adding a pending object should not be internal to 
revision.c.

> Also we probably would want to default the diff options to show
> the root commit diff (rev.show_root_diff).

I gather this is needed for git-am/git-rebase to continue working?

Ciao,
Dscho
