From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Improving git-svn documentation
Date: Thu, 25 Jun 2009 01:47:27 -0700
Message-ID: <20090625084727.GA2901@dcvr.yhbt.net>
References: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJkce-0007u0-0E
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 10:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbZFYIrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 04:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbZFYIrb
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 04:47:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47546 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbZFYIr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 04:47:29 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 7319E1F44D;
	Thu, 25 Jun 2009 08:47:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122184>

Yann Dirson <ydirson@altern.org> wrote:
> While diving into the git-svn code, I realized that many things could
> be done to make it more documented/understundable.  I need to get more
> understanding of it, so I'd like to improve this state of things.  But
> first, I'd like to be sure there is a consensus on what is a good idea
> to do, since that could easily turn up into a lot of textual change.
> 
> - (on the user doc side of things) some options appear not to be
>   documented (I spotted --parent for 'clone' and --revision for
>   'dcommit').  But looking at where to document them, I found it not
>   always easy, since some options are documented together with the
>   command they modify, some others in the "options" section (even when
>   they are documented as applying to a single command, like --shared
>   or --stdin).  This IMHO leads to confusion for the user looking for
>   information, as well as to the reviewer trying to check that nothing
>   was forgotten.  I would rather make that only very commons are
>   described in a common "options" section, and that all commands using
>   them explicitely say so in their descriptions (with xref).

Sadly I haven't ever done much maintenance on the documentation myself.
I've found building/formatting the docs too painful of an experience for
me (this coming from a guy willing to deal with SVN) so I haven't made
many attempts in several years.

> - (on the code side of things) git-svn.perl weights more than 5500
>   lines, most classes functions and methods severely lack
>   documentation, and some extensively-used variable names are so short
>   they make the code harder to grasp
> 
>   Eg. $gs to refer to an instance of the Git::SVN class, which I would
>   suggest to change to something like $gsrepo, while at the same time
>   renaming Git::SVN to eg. Git::SVN::Repository - which would make it
>   much easier for a newcomer to grasp what this is supposed to
>   represent - supposing, that is, that my understunding of this part
>   is accurate enough, which it is probably not after spending many
>   hours in there :)

I think I was at least fairly consistent with naming most Git::SVN
objects $gs, at least (and vectors are "$gsv" (a la arg => argv).  But I
do admit it's not the easiest code to follow since the majority of it
was written in a short time span in early 2007 before I was to
(knowingly) embark on other life-changing (or life-consuming :)
projects.  I seem to recall most of my time was spent dealing
with/working around various issues I had with SVN Perl bindings, but
I've probably blocked out the most traumatizing experiences.

>   As to the size of the file, it seems natural to me to split the
>   classes into their own files.  That would still let git-svn.perl and
>   the Git::SVN class to be 1500-lines tall, the largest others
>   achieving around 500 lines.  That should be much more manageable
>   pieces, and would require some refactoring wrt a couple of global
>   variables used throughout the script; which, incidentally, could
>   make it much easier to simultanously look at several git-svn
>   repositories (for my work on mapping externals to submodules), and
>   to allow reusing the existing code, eg. as a git-vcs backend.
> 
> How are you people feeling about this rough plans ?

I've been planning on splitting git-svn.perl out into separate modules
for years now.  Please take the lead on it if you wish to, since I've
obviously been unable to dedicate much time to git-svn in over two years
now.

-- 
Eric Wong
