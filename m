From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pull failure, truncated object
Date: Tue, 8 May 2007 11:05:36 -0400
Message-ID: <20070508150536.GR11311@spearce.org>
References: <17984.35097.568689.482933@lisa.zopyra.com> <20070508145916.GQ11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue May 08 17:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRgB-0004fb-2N
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966444AbXEHPYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966142AbXEHPKV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:10:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39175 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966027AbXEHPFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:05:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlRFs-0008BF-BH; Tue, 08 May 2007 11:05:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2F55220FBAE; Tue,  8 May 2007 11:05:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070508145916.GQ11311@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46586>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Don't run git-gc on a repository that is acting strangely, unless
> you have concluded that the correct course of action is to just
> repack the repository.  (It rarely is, btw.)  You could make things
> worse if a packfile contains a corrupt object and you have the
> same valid loose object; a gc would delete the valid object and
> keep the corrupt one.

OK, my statement is a little blown-out-of-proportion.  Its pretty
hard these days to corrupt an object within a packfile such that
we'll be able to reuse it during the repack that goes on in git-gc,
but still actually have it be corrupt enough that the object is
useless.  The recent index version 2 work from Nico makes it even
harder, as the index adds an additional checksum over the entire
object header and body.

But still, even though the risk is pretty small, I think that
running a destructive operation like git-gc in a repository that is
not acting normally is a bad idea.  You should try to diagnose and
correct the issue before making further changes (or reorganizations)
to that repository's contents.

-- 
Shawn.
