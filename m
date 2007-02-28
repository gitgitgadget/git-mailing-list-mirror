From: Theodore Tso <tytso@mit.edu>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 22:03:47 -0500
Message-ID: <20070228030347.GE2178@thunk.org>
References: <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com> <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org> <7vejob9l70.fsf@assigned-by-dhcp.cox.net> <20070228023208.GC2178@thunk.org> <7vr6sb2e5m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMF6l-0008Ic-FA
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbXB1DD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbXB1DD4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:03:56 -0500
Received: from thunk.org ([69.25.196.29]:46342 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbXB1DDz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:03:55 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMFC4-0004OA-7I; Tue, 27 Feb 2007 22:09:28 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMF6Z-0006Wh-NV; Tue, 27 Feb 2007 22:03:47 -0500
Content-Disposition: inline
In-Reply-To: <7vr6sb2e5m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40880>

On Tue, Feb 27, 2007 at 06:45:41PM -0800, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > Well, the other design alternative is to make git-show take a list of
> > objects, so that
> >
> > 	git show v1.5.0..v1.5.0.1
> >
> > ends up displaying the same thing as
> >
> > 	git show `git-rev-list v1.5.0..v1.5.0.1`
> >
> > ... but I'm not really convinced that's really all that useful.  
> 
> I think we are better off doing "git show v1.5.0..v1.5.0.1" for
> that, but we do take multiple objects.

Not sure I understand what you mean?  That:

	git show v1.5.0..v1.5.0.1

should should show all the commits between v1.5.0 and v1.5.0.1, or
just print the commit corresponding to v1.5.0.1 (and the v1.5.0 is
completely meaningless?)

> > Note the use of singular.  That would imply that it takes a single
> > object, and not a range of objects.  Of course, if the above behavior
> > were actually shown to be useful, man pages can always be easily
> > changed.  :-)
> 
> I find myself running "git show --stat v1.X.Y v1.X.Y+1" every
> time I tag a new release Y+2 to find out things like:
> 
> 	* Should I say "Git v1.5.1" or "GIT 1.5.1"?
> 	* Ah, I have to update GIT-VERSION-GEN, which I did, good.

But why not just type:

	git show --stat v1.X.Y+1

instead?  Or if you don't want the tag information, you could type:

	git show --stat v1.X.Y+1^{commit}

since 

	git show --stat v1.5.0..v1.5.0.1
and
	git show --stat v1.4.4.0..v1.5.0.1
and
	git show --stat v1.0.0..v1.5.0.1

all print exactly the same thing!  

Hence Linus's and my argument that as currently implemented the
".." operator to git doesn't make a lot of sense....

						- Ted
