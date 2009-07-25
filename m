From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix WindowCacheGetTest.testCache_TooSmallLimit
	failures
Date: Sat, 25 Jul 2009 16:30:26 -0700
Message-ID: <20090725233026.GH11191@spearce.org>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com> <20090725194254.GC11191@spearce.org> <20090725200056.GD11191@spearce.org> <200907260125.32306.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqhG-0004X5-7a
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZGYXa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZGYXa0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:30:26 -0400
Received: from george.spearce.org ([209.20.77.23]:34803 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbZGYXa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:30:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 87AC5381FD; Sat, 25 Jul 2009 23:30:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907260125.32306.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124097>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l?rdag 25 juli 2009 22:00:56 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Ever since 2d77d30b5f when I rewrote WindowCache we have been seeing
> > random failures inside of the TooSmallLimit test case.
> > 
> > These test failures have been occurring because the cache contained
> > more open bytes than it was configured to permit.
> > 
> > The cache was permitted to open more bytes than its configured limit
> > because the eviction routine was always skipping the last bucket
> > under some conditions.  If the cache table was sized the same as its
> > evictBatch, which happens for any fairly small table, the eviction
> > routine broke too early if it started at a non-zero position in the
> > table and wrapped around during its search.  By breaking too early
> > the routine did not actually perform an eviction, leaving windows
> > open it should have closed.
> 
> We should have a test for that then.

We did, this one.  :-)

-- 
Shawn.
