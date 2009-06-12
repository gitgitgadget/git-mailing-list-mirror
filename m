From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix CanonicalTreeParser.back to parse all trees
	correctly
Date: Fri, 12 Jun 2009 08:08:01 -0700
Message-ID: <20090612150801.GA17538@spearce.org>
References: <1244412116-13294-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF8MV-0005Xv-Nk
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 17:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZFLPH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbZFLPH7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 11:07:59 -0400
Received: from george.spearce.org ([209.20.77.23]:44947 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFLPH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 11:07:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 41DE9381FD; Fri, 12 Jun 2009 15:08:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1244412116-13294-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121428>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> The back(int delta) method needs to walk backwards delta entries in
> the tree we are iterating.  Unfortunately, despite my attempts to do
> so, there is no reliable way to parse a canonical tree in reverse.

Ping?

Without this patch the NameConflictDirWalk can get into some serious
trouble, trouble which can cause Gerrit Code Review to have its
memory explode to >8 GiB, because NCDW gets stuck in an infinite
loop, forever allocating reachable memory inside of a MergeStrategy.

I've made a private build of this and am running it in production
within day-job employer, but I can't make a release of Gerrit until
I have a stable identifier for this patch.
 
>  .../jgit/treewalk/CanonicalTreeParserTest.java     |   78 ++++++++++++++++++-
>  .../spearce/jgit/treewalk/CanonicalTreeParser.java |   74 +++++++++---------
>  2 files changed, 110 insertions(+), 42 deletions(-)

-- 
Shawn.
