From: Ben Jackson <ben@ben.com>
Subject: Re: [PATCH 2/2] Add 'git svn reset' to unwind 'git svn fetch'
Date: Mon, 1 Jun 2009 10:49:44 -0700
Message-ID: <20090601174943.GA80846@kronos.home.ben.com>
References: <1243732627-82282-1-git-send-email-ben@ben.com> <1243732627-82282-2-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, normalperson@yhbt.net, ben@ben.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 19:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBBe5-0006uu-6N
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 19:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbZFARtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 13:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbZFARtr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 13:49:47 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:54688 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZFARtq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 13:49:46 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n51HniV2081151;
	Mon, 1 Jun 2009 10:49:44 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n51HniuV081148;
	Mon, 1 Jun 2009 10:49:44 -0700 (PDT)
	(envelope-from bjj)
Content-Disposition: inline
In-Reply-To: <1243732627-82282-2-git-send-email-ben@ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.3/9411/Mon Jun  1 07:35:19 2009 on kronos.home.ben.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120479>

On Sat, May 30, 2009 at 06:17:07PM -0700, Ben Jackson wrote:
> Add a command to unwind the effects of fetch by moving the rev_map
> and refs/remotes/git-svn back to an old SVN revision.

I just realized this morning that I didn't do any special handling for
bad revision input.  I will submit a revised patch.  In the mean time
I would still like feedback on the concept and the docs.

Known issues:

1.  Garbage revision input is accepted and prints several internal errors
before bombing out.  The repo is not harmed, though.

2.  Huge revision numbers cause git-svn to spin for quite a while because
I used the pre-existing find_rev_before which is a linear search.

3.  Without --parent it should probably fail for a nonexistent rev rather
than automatically find_rev_before..

-- 
Ben Jackson AD7GD
<ben@ben.com>
http://www.ben.com/
