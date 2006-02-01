From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 21:19:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601312046480.25300@iabervon.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 03:17:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F47Yu-00069W-8R
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWBACRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWBACRe
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:17:34 -0500
Received: from iabervon.org ([66.92.72.58]:14094 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964878AbWBACRd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 21:17:33 -0500
Received: (qmail 5448 invoked by uid 1000); 31 Jan 2006 21:19:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2006 21:19:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15377>

On Tue, 31 Jan 2006, Linus Torvalds wrote:

> So if you do this change (which may be the right one) then please make 
> sure that "git commit <filename>" doesn't work _at_all_ when a merge is in 
> progress (ie MERGE_HEAD exists), because it would do the wrong thing.

Agreed. I suppose it could accept doing a commit of only a few files which 
weren't touched by the merge, but I don't think even you multitask enough 
to want to do that; anyway, the user can just ditch the merge, commit 
their stuff, and try the merge again. (I bet this is a case where new 
users would be really surprised by the behavior of "git commit filename", 
except that they wouldn't think it would do anything other than give an 
error.)

> And yes, then I'll just have to force my fingers to do a simple
> 
> 	git-update-index filename
> 	git commit
> 
> instead. I can do that.
>
> Oh, one final suggestion: if you give a filename to "git commit", and you 
> do the new semantics which means something _different_ than "do a 
> git-update-index on that file and commit", then I'd really suggest that 
> the _old_ index for that filename should match the parent exactly. 
> Otherwise, you may have done a
> 
> 	git diff filename
> 
> and you _thought_ you were committing just a two-line thing (because you 
> didn't understand about the index), but another, earlier, action caused 
> the index to be different from the file you had in HEAD, and in reality 
> you're actually committing a much bigger diff.
> 
> In other words: if you want "git commit <filename>" to _not_ care about 
> the current index, then it should make sure that the index at least 
> _matches_ the current HEAD in the files mentioned.
> 
> Ie "git-diff-index --cached HEAD <filespec>" should return empty. Or 
> something like that.

Agreed here, too.

	-Daniel
*This .sig left intentionally blank*
