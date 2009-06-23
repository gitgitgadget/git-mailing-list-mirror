From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 12:34:28 +0200
Message-ID: <20090623103428.GA4214@pvv.org>
References: <h1nks1$vdl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 12:57:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ3gQ-0007FX-TG
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 12:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbZFWK4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 06:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbZFWK4r
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 06:56:47 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:53292 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036AbZFWK4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 06:56:45 -0400
X-Greylist: delayed 1340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2009 06:56:45 EDT
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1MJ3Ke-0005DF-FU; Tue, 23 Jun 2009 12:34:28 +0200
Content-Disposition: inline
In-Reply-To: <h1nks1$vdl$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122083>

On Mon, Jun 22, 2009 at 12:02:33PM +0200, Paolo Bonzini wrote:
> Hi all, I just upgraded to git 1.6.3 and found this new little gem  
> called push.default...
> [...]

You should have been here when we discussed this! :)

> 1) Also in 1.6.3, invent a special refspec for "tracking", something  
> like "HEAD>" (of course this is not a special case; "refs/heads/*>"  
> would also work, yadda yadda)

Yes, this is a weakness righ now - the only way to get tracking
semantics is to set push.default. I could not find a very good way of
specifying this. We currently have the magic refspecs : and
HEAD. Adding a ">" to "HEAD>" would be annoying I think, since it has
to be quoted in the shell.

Maybe we can use ":" as an escape, it is not allowed in refspecs.
Something like "::tracking" (and we cold also have "::matching",
"::current" and so on for completeness)

> 2) Also in 1.6.3, add a "--push={current,tracking,matching,mirror}"  
> option to "git remote add" that would set up a push refspec without the  
> need to actually know refspec syntax. (--mirror would become just a  
> synonym for --push=mirror).

Sounds like a good idea, the options would also make sense to push I think,
so you can "git push [--current|tracking|...] ".

> 3) Possibly, in 1.6.3 make "git clone" add a "push = :" line for the  
> origin branch.  This was actually suggested in a patch by myself.

This would destroy the intention of my patch, it would render the
configuration variable pointless I think (and would also silently push
matching).

> 4) in 1.6.4 or 1.7.0, make "git push" fail outright if there is no push  
> line, with text suggesting [...]

Hopefully we can get to this stage, that a unconfigured "git push"
gives a small message, indicating how to configure it, and not push
anything. Most "oldtimers" should have configured this already, so it
should not break many setups.

- Finn Arne
