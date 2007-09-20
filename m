From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 14:11:00 -0400
Message-ID: <20070920181100.GV3099@spearce.org>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com> <Pine.LNX.4.64.0709201819340.28395@racer.site> <20070920172736.GU3099@spearce.org> <70952A932255A2489522275A628B97C3052E993B@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYQUa-0002WX-EI
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 20:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761AbXITSLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbXITSLF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 14:11:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51721 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbXITSLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 14:11:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYQUJ-0001TY-A4; Thu, 20 Sep 2007 14:10:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A2E020FBAE; Thu, 20 Sep 2007 14:11:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <70952A932255A2489522275A628B97C3052E993B@xmb-sjc-233.amer.cisco.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58795>

"Matt Seitz (matseitz)" <matseitz@cisco.com> wrote:
> The git-update-index and git-update-ref manual references are the
> closest to what I was looking for.  Both are more low-level and
> technical than what I was hoping for, and the discussion in
> git-update-index seems targeted primarily at how symlinks are translated
> on file systems that don't support symlinks.
> 
> I guess I was looking for something like the GNU "tar" documentation of
> how symlinks are handled
> (http://www.gnu.org/software/tar/manual/html_node/dereference.html#deref
> erence).

Git never dereferences a symlink that are stored as part of the
revision data.  The only time we dereference a symlink is when it
is used inside of .git/refs, or as .git/HEAD, which is what the
git-update-ref manpage was talking about.

So Git handles symlinks in the working tree *without* dereferencing
them.  Internally we store the target of the symlink, much as
tar would store the target of the symlink.  There is no way to
activate a dereference behavior (--dereference / -h in GNU tar)
as typically you want to preseve the symlink as a symlink to the
target; its part of your source code.

Maybe this is a good hint that the user manual should have a section
on symbolic links.  Its obvious to old Git hands that a symlink is
nothing more than a file with a slightly different mode, but that
may not be obvious to people who are new to Git.

-- 
Shawn.
