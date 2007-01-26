From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Fri, 26 Jan 2007 09:37:15 +0100
Organization: eudaptics software gmbh
Message-ID: <45B9BDBB.E9C65371@eudaptics.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
		<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
		<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
		<7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
		<Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
		<Pine.LNX.4.64.0701231101040.3011@xanadu.home>
		<7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
		<Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 09:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMZS-0002sG-OG
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 09:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816AbXAZIg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 03:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030822AbXAZIg0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 03:36:26 -0500
Received: from main.gmane.org ([80.91.229.2]:37740 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030816AbXAZIgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 03:36:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAMZA-00079j-3B
	for git@vger.kernel.org; Fri, 26 Jan 2007 09:36:12 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 09:36:12 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 09:36:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37811>

Junio C Hamano wrote:
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 24 Jan 2007, Junio C Hamano wrote:
> >
> >>   Ok, how about this, on top of the previous ones?
> >
> > Thanks!
> >
> >> @@ -653,6 +663,8 @@ int main(int argc, char **argv)
> >>      struct stat st;
> >>
> >>      setup_git_directory();
> >> +    setup_ident();
> >> +    git_config(fetch_pack_config);
> >
> > Why do you need setup_ident()?
> 
> Because presumably you would be updating the reflog that records
> who did the fetch?
> 
> But then we should do the same ignore_missing_committer_name()
> we have in receive-pack to allow anonymous fetchers to fetch
> from outside world, I guess.

Instead of using ignore_missing_committer_name(), use
get_committer_info(0) in refs.c. cherry-pick 4feaf032d3 from my tree at
git://repo.or.cz/git/mingw.git if you want.

Although this approach leaves the name+email in the reflog entry empty
instead of writing "unkown"...

-- Hannes
