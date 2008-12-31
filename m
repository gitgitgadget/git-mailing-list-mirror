From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/5] Add "jgit clone" to support cloning off URLs
	that are JGit specific
Date: Tue, 30 Dec 2008 23:35:05 -0800
Message-ID: <20081231073505.GA22551@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org> <1230055423-9944-4-git-send-email-spearce@spearce.org> <1230055423-9944-5-git-send-email-spearce@spearce.org> <200812310812.15305.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 08:36:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHvd2-0001DA-71
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 08:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYLaHfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 02:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYLaHfI
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 02:35:08 -0500
Received: from george.spearce.org ([209.20.77.23]:46347 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYLaHfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 02:35:07 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD8E038200; Wed, 31 Dec 2008 07:35:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812310812.15305.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104254>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Would it be hard to get the progress look better?

This happens because we are scanning the progress channel wrong in
some cases.  Its random; most of the time we can get it right, but
every once in a while we get out of sync and get these short names.

This is a general problem with the progress client side code, not
the new server side code I've introduced.  We also see it going
against a standard C git daemon.  I haven't been able to figure
out a way to smooth out the messages.

FWIW, git-gui also gets this sort of progress corruption sometimes
when it does a clone.  So I've reproduced the same parsing bug in
two different languages and two different implementations... ;-)

 
> EGIT.contrib/jgit clone git://repo.or.cz/libgit2.git LIBGIT2
> Initialized empty Git repository in /home/me/SW/LIBGIT2/.git                  
> Counting objects:       547                                                   
> Compressing objects:    100% (192/192)                                        
> ts:                     100% (192/192)                                        
> Compressing objects:    100% (192/192)                                        
> ng objects:             100% (192/192)                                        
> Compressing objects:    100% (192/192)                                        
> bjects:                 100% (192/192)                                        
> Compressing objects:    100% (192/192)
> pressing objects:       100% (192/192)
> ts:                     100% (192/192)
> Compressing objects:    100% (192/192)
> Receiving objects:      100% (547/547)
> jects:                  100% (192/192)
> Compressing objects:    100% (192/192)
> ressing objects:        100% (192/192)
> s:                      100% (192/192)
> Compressing objects:    100% (192/192)
> ssing objects:          100% (192/192)
> ts:                     100% (192/192)
> Compressing objects:    100% (192/192)
>  objects:               100% (192/192)
> Compressing objects:    100% (192/192)
> essing objects:         100% (192/192)
> cts:                    100% (192/192)
> Compressing objects:    100% (192/192)
> g objects:              100% (192/192)
> Compressing objects:    100% (192/192)
> ressing objects:        100% (192/192)
> Resolving deltas:       100% (358/358)
> From git://repo.or.cz/libgit2.git
>  * [new branch]      master     -> origin/master

-- 
Shawn.
