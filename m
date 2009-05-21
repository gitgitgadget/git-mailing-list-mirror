From: Ryan <duderino.lebowski@gmail.com>
Subject: Re: Getting Commits from One Repository to Another
Date: Thu, 21 May 2009 20:08:01 +0000 (UTC)
Message-ID: <loom.20090521T200115-589@post.gmane.org>
References: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com> <20090521040451.GC8091@sigill.intra.peff.net> <vpq8wkq95uu.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 22:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Efx-0006Su-O7
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 22:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZEUUPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbZEUUPG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 16:15:06 -0400
Received: from main.gmane.org ([80.91.229.2]:36956 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbZEUUPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 16:15:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M7EfP-0002h9-6p
	for git@vger.kernel.org; Thu, 21 May 2009 20:15:03 +0000
Received: from pool-173-66-53-162.washdc.fios.verizon.net ([173.66.53.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 May 2009 20:15:03 +0000
Received: from duderino.lebowski by pool-173-66-53-162.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 May 2009 20:15:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.66.53.162 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en; rv:1.8.1.21) Gecko/20090327 Camino/1.6.7 (like Firefox/2.0.0.21pre))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119705>

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:

> 
> Jeff King <peff <at> peff.net> writes:
> 
> > On Wed, May 20, 2009 at 07:37:54PM -0400, Big Lebowski wrote:
> >
> >> Essentially, when I came on a project, a git repository was made  
> >> available to me (lets call that 'public_repo'). That repository was put up 
> >> on an unfuddle account, as an initial check-in; it was not cloned from the 
> >> repository they were working on (lets call that 'private_repo'). I wrote 
> >> some code, and pushed it to the repository. Now that I guess they feel 
> >> comfortable with me, they reveal to me the private_repo.
> >>
> >> How do I get my code from public_repo to private_repo?
> >
> > You could just repeat the push you made to public_repo to
> > private_repo.
> 
> As I understand the situation, no, because the public repo was not a
> clone of the private one, but a fresh import (without history?).
> So, the ancestor of the commits of the OP do not exist in the private
> repository.
> 
> But don't panic, "git rebase" will be able to replay your history on
> another branch. The commands to type will be along the lines of:
> 
> cd public-repo
> git remote add private url-of-private-repo
> git fetch private
> # not sure about the exact syntax here:
> git rebase  --onto private/master your-first-commit^ master
> 
> and then perhaps
> 
> git push private master
> 

Thanks to both of you for your help. I tried Peff's suggestion last night, and
could not get it to work. Matthieu is correct that the public repo was not a
clone but a fresh import. Furthermore, I discovered that work had been done
between the last pull from private the the import into public. (Ugh!)

Anyway, before I saw Matthieu's post (away from internet, which is so rare these
days), I managed to succeed by using git format-patch on the commits that I
needed, and then used git am on the private repo. There was one conflict, but I
was able to resolve it.

Hopefully I'm not faced with this problem again, but if so, I'll try Mattieu's
suggestion.

Thanks,
Ryan
