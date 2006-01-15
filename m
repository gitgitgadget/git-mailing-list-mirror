From: Junio C Hamano <junkio@cox.net>
Subject: Re: Starting a new project remotely
Date: Sun, 15 Jan 2006 11:24:48 -0800
Message-ID: <7vd5it47lr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601151323320.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 20:25:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyDUq-0005rx-R2
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 20:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWAOTYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWAOTYv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 14:24:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38373 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750811AbWAOTYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 14:24:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115192218.FOQM17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 14:22:18 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601151323320.25300@iabervon.org> (Daniel
	Barkalow's message of "Sun, 15 Jan 2006 13:45:01 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14702>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Is there something currently that acts like git-clone, except that it sets 
> up automatic connections in the opposite direction? That is, you run it in 
> a repository with no origin, and it pushes the data to the specified 
> location (which probably needs to be set up already as an empty 
> repository) and sets the local side's origin remote to the location given.

The "git push" command allows you to push into an empty or even
unrelated destination, but I do think there no wrapper that
creates remotes/ file.  BTW, calling that "origin" is probably
confusing.  In the scenario you outlined, your local side is the
source and the remote is the sink.

FYI, here is what I have in my remotes/ko file to interact with
my kernel.org repository (the one that is mirrored out to the
public machines):

        URL: zzz.kernel.org:/pub/scm/git/git.git/
        Push: master
        Push: +pu
        Push: maint
        Pull: master:refs/tags/ko-master
        Pull: +pu:refs/tags/ko-pu
        Pull: maint:refs/tags/ko-maint

and with this, I first run

	$ git fetch ko
	$ git show-branch master ko-master

to make sure I am not rewinding what I have already pushed out
by mistake, and then

	$ git push ko
        $ git push --tags ko ;# if I added a new tag
