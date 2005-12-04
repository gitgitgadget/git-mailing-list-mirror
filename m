From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-name-rev off-by-one bug
Date: Sun, 4 Dec 2005 22:34:58 +0100
Message-ID: <20051204213458.GY22159@pasky.or.cz>
References: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net> <20051129080529.20705.qmail@science.horizon.com> <20051129103157.GW22159@pasky.or.cz> <7vhd9vgumb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 22:36:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej1VV-0000Rj-BM
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 22:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLDVeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLDVeo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 16:34:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40171 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932316AbVLDVen (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 16:34:43 -0500
Received: (qmail 22909 invoked by uid 2001); 4 Dec 2005 22:34:58 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd9vgumb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13192>

Dear diary, on Tue, Nov 29, 2005 at 07:46:20PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   (ii) Cogito will handle trees with some local modifications better -
> > basically any local modifications git-read-tree -m won't care about.
> > I didn't read the whole conversation, so to reiterate: git-read-tree
> > will complain when the index does not match the HEAD, but won't
> > complain about modified files in the working tree if the merge is not
> > going to touch them. Now, let's say you do this (output is visually
> > only roughly or not at all resembling what would real tools tell you):
> >
> > 	$ ls
> > 	a b c
> > 	$ echo 'somelocalhack' >>a
> > 	$ git merge "blah" HEAD remotehead
> > 	File-level merge of 'b' and 'c'...
> > 	Oops, 'b' contained local conflicts.
> > 	Automatic merge aborted, fix up by hand.
> > 	$ fixup b
> > 	$ git commit
> > 	Committed files 'a', 'b', 'c'.
> >
> > Oops. It grabbed your local hack and committed it along the merge.
> 
> Are you sure about this?
> 
> In the above sequence, after you touch a with 'somelocalhack',
> there is no 'git update-index a', until you say 'git commit'
> there, so I do not think that mixup is possible.
> 
> The "fixup b" step is actually two commands, so after merge
> command, you would do:
> 
>         $ edit b
> 	$ git update-index b ;# mark that you are dealt with it
> 	$ git commit ;# commits what is in index
> 
> After the above steps, "git diff" (that is working tree against
> index) still reports your local change to "a", which were _not_
> committed.

Yes. I actually tried it out, but I was confused by the file list in the
commit message (I'm used to seeing just committed files there) and I
didn't check the status of the 'a' file after the commit.

Sorry about the confusion.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
