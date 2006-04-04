From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 04 Apr 2006 11:52:07 -0400
Message-ID: <1144165927.30675.32.camel@dv>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	 <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
	 <20060404105818.GA17326@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 17:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQnpI-00063Q-Us
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDDPwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWDDPwM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 11:52:12 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:26820 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750720AbWDDPwL
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 11:52:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FQnpC-0001jT-9g
	for git@vger.kernel.org; Tue, 04 Apr 2006 11:52:10 -0400
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FQnp9-000869-A8; Tue, 04 Apr 2006 11:52:07 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060404105818.GA17326@mars.ravnborg.org>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18395>

On Tue, 2006-04-04 at 12:58 +0200, Sam Ravnborg wrote:
> On Mon, Apr 03, 2006 at 05:06:36PM -0700, Junio C Hamano wrote:
> > 
> > I am not opposed to the command in the sense that I do not want
> > to forbid people from doing what they want to do, but on the
> > other hand I do not see why people (apparently many people) want
> > to have something like this.  Are their "make clean" broken?

Normally it is not, but if it is, they want to know it.  If git-clean
remove something after "make clean" then maybe the later is incomplete.

To put it another way, if I make changes and share them with others, I
want to make sure that my changes will work for them.  If the mechanism
for sharing my changes is make-based, I rely on make to check them.  In
projects using Automake it's called "make distcheck".  If I'm sharing my
changes as a git patch, I want a git-based verification that the project
still builds from scratch.

Also, the files cleaned by "make clean" are normally build products.
Things that you _really_ don't want to be in the source tree at the
release time are other files, such as backup files with changes that you
decided to back out, sources that you may not share, firmware that cost
your company $50000 and so on.  "make clean" won't remove them.

> No reason to waste time on make clean.
> git ls-files -o | xargs rm
> Does the same job nicely.

This would remove ignored files.  It's not always what I want.

> Other typical usecases for me:
> Remove temporaries that I created while trying out stuff.
> Often I have a bunch of files named 'x', 'xx', 'fisk' etc.
> around for no use. An easy way to remove these without breaking
> my 'allmodconfig' build is nice. It anyway > 1 hour to build and
> I like to get rid of the untracked stuff in an easy way.
> 
> So use cases goes like this:
> - Remove everything not tracked by git (including .gitignore files)
> - Remove everything except tracked by git or ignored
> - Remove ignored files (replacement of make clean) (seldom)

I'll think about the later.

> Above should work both from top-level dir and in subdirectories.
> 
> That is my minimal expectations to git clean.
> What Pavel came up with cover everything except the make clean
> replacement part.

Exactly.  The "make clean" replacement is actually the one I didn't
implement.

-- 
Regards,
Pavel Roskin
