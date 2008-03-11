From: Andreas Fuchs <asf@boinkor.net>
Subject: git-cvsimport: creating bogus branches (was: really convert underscores in branch names to dots with -u)
Date: Tue, 11 Mar 2008 15:56:31 +0000 (UTC)
Message-ID: <loom.20080311T153924-977@post.gmane.org>
References: <20071103115502.14532.qmail@d121e5a37ec172.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 16:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6r2-0004KY-HR
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYCKP4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYCKP4r
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:56:47 -0400
Received: from main.gmane.org ([80.91.229.2]:46336 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbYCKP4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:56:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZ6qG-0006iS-1y
	for git@vger.kernel.org; Tue, 11 Mar 2008 15:56:40 +0000
Received: from snark.boinkor.net ([213.235.219.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 15:56:40 +0000
Received: from asf by snark.boinkor.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 15:56:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.235.219.107 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9b4) Gecko/2008030317 Firefox/3.0b4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76872>

Gerrit Pape <pape <at> smarden.org> writes:
> The documentation states for the -u option that underscores in tag and
> branch names are converted to dots, but this was actually implemented
> for the tag names only.

This causes a lot of problems for me with a tree that was using -u before this
change: Now there are two git branches for each CVS branch: one with and one 
without underscores. 

That's not so bad, but git-cvsimport seems to mess up the ancestry graph
by using the current master's HEAD revision as the parent of each of these new
branches. (I haven't debugged this completely, but what I see strongly 
suggests that this is what's happening.)

If you want to take a look at the mangled branches, its gitweb is at 
<http://git.boinkor.net/gitweb/sbcl-beta.git>. See for an example:
<http://git.boinkor.net/gitweb/sbcl-beta.git?a=shortlog;h=refs/heads/alpha64.2.branch>.
That's commit from 2003 having a parent commit from 2008. Right after that 
parent commit in 2008 was when I started using the new git-cvsimport.

Note that I'm not strongly to rewriting underscores in branch names as 
documented, but the way things are now, I'd have preferred the transition 
happening in a backwards-compatible way (-:

Cheers,
Andreas.
