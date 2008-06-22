From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why does diff --binary include content of files being deleted?
Date: Sun, 22 Jun 2008 00:15:10 -0400
Message-ID: <20080622041510.GE11793@spearce.org>
References: <20080622033454.GA10578@lifeintegrity.com> <20080622035118.GD11793@spearce.org> <20080622040536.GA10813@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Allan Wind <allan_wind@lifeintegrity.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 06:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAGzt-0005Nk-D8
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 06:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbYFVEPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 00:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbYFVEPR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 00:15:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45900 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYFVEPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 00:15:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAGyx-000585-FO; Sun, 22 Jun 2008 00:15:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69CE220FBAE; Sun, 22 Jun 2008 00:15:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080622040536.GA10813@lifeintegrity.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85749>

Allan Wind <allan_wind@lifeintegrity.com> wrote:
> On 2008-06-21T23:51:18-0400, Shawn O. Pearce wrote:
> > In order to apply the diff in reverse we need the old binary data
> > in the diff output.  So that's why its larger.
> 
> Makes sense, thanks.  In my use case (where I do not need the reverse 
> diff) this adds 500+ MB or 43159% overhead.

Well, then in that case you have to omit --binary I think, or use a
filter script to strip out the binary data from the resulting patch.

> When I tried to apply the large diff my virtual private server with 512 
> MB of memory git apply ran out of memory and died.  Is there any way to 
> bound the memory usage of git apply?

If you submit patches for it.  ;-)

git-apply today is meant for applying small patches, like those that
would typically be written by a developer hacking on open source
software.  It tries to be completely atomic; either the entire
patch applies at once, or the entire patch rejects with no changes
being made to the local directory.  As such it applies everything in
memory, and only writes out when we are sure the patch applies clean.

So no, there isn't a way to make git-apply use less memory.

-- 
Shawn.
