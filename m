From: Eric Wong <normalperson@yhbt.net>
Subject: Re: "git svn reset" only resets current branch ?
Date: Mon, 6 Jul 2009 15:14:29 -0700
Message-ID: <20090706221428.GB8219@dcvr.yhbt.net>
References: <43948.10.0.0.1.1246874857.squirrel@intranet.linagora.com> <20090706212928.GA11043@dcvr.yhbt.net> <20090706215619.GA38984@kronos.home.ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwSh-0002xW-23
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 00:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbZGFWOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbZGFWOo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 18:14:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54711 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbZGFWOo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 18:14:44 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 27AA0113077;
	Mon,  6 Jul 2009 22:14:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090706215619.GA38984@kronos.home.ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122804>

Ben Jackson <ben@ben.com> wrote:
> On Mon, Jul 06, 2009 at 02:29:28PM -0700, Eric Wong wrote:
> > Yann Dirson <ydirson@linagora.com> wrote:
> > > I just tried the new "git svn reset" from master, and got puzzled that
> > > only the svn branch which is an ancestor of current git HEAD got rolled
> > > back.  Is that the expected behaviour ?  It would not make it very easy to
> > > fixup imports from svn trees with lots of branches/tags.
> > 
> > Ben was the original implementer of this idea, so I'm not sure of his
> > reasoning behind it.  For one, it's easier to only roll back one svn
> > branch.  Perhaps adding an --all flag to this command would be the best
> > way to go?
> 
> The only SVN repos I use git-svn with are either too huge and complex to
> fully import with git (up to r135000 at work) or too small to have any
> branches (all the various open source projects I've git-svn cloned).  So
> the main reason it works that way is that I've never really used git-svn
> with branches.
> 
> Eric,
> 
> Do you expect that it would work to reset one branch and re-fetch it
> without touching the other branches?  If not, it would probably imply:
> 
> Should cmd_reset always loop over all remotes like cmd_multi_fetch?
> 
> As the "opposite of fetch" should it take '--all' and conditionally
> loop?

I think the current behavior is a reasonable default; it's least
surprising to me and the user could more easily rerun with "--all" if
needed.  If --all were the default, the user could potentially
have to refetch a lot of data they didn't want to.

-- 
Eric Wong
