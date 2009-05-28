From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-svn: importing internal externals
Date: Thu, 28 May 2009 13:25:43 +0200
Message-ID: <20090528112542.GA24403@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1243443089.3192.43.camel@cp-jk-linux.corp.on2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Koleszar <john.koleszar@on2.com>
X-From: git-owner@vger.kernel.org Thu May 28 13:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9djl-0001OU-Mf
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 13:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZE1LZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbZE1LZT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 07:25:19 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:43233 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbZE1LZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 07:25:19 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 727DD940128;
	Thu, 28 May 2009 13:25:13 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 493C594011C;
	Thu, 28 May 2009 13:25:11 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 52B9CA003; Thu, 28 May 2009 13:25:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243443089.3192.43.camel@cp-jk-linux.corp.on2.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120184>

On Wed, May 27, 2009 at 12:51:29PM -0400, John Koleszar wrote:
> Hi,
> 
> I'm working on a one-off import of an SVN repo that makes use of
> "internal" svn:externals; i.e. all URLs refer to different spots in the
> same repo, potentially with peg revisions. The SVN repo holds a number
> of projects, and my plan is to import them into individual git repos,
> incorporating the history from any svn:external linked sub-projects.

I have started to work on exactly this, at fetch time instead of as a
post-process.  I have for now only hooked parsing of the svn:externals
properties, and just need to find the time to resume and finish.

My plan on the user side is to provide flags to map svn urls to git urls.


> My current strategy is to let git-svn fetch the project as it normally
> would, then fix up the history on each branch by parsing the
> unhandled.log with a filter-branch script. I'm currently using an index
> filter, which works reasonably well, but has the undesired effect of
> squashing commits on the subproject into commits on the parent project.
> So if the subproject is modified in rA and rC, and the project in rB and
> rD, my modified history shows only rB and rD, with rA squashed into rB
> and rC squashed into rD, when I'd really like to see all 4 commits.

Yes, this is the main issue for correctness.  For this we would have to
check, before processing any new commit, if any of the submodules got any
intervening commits, and commit them first.


> I'd be happy to share my filter
> script (about 100 lines) if someone wants to see it.

It can be a good idea to share your script nevertheless :)

Best regards,
-- 
Yann
