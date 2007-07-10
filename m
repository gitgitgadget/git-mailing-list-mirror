From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Tue, 10 Jul 2007 10:14:42 -0400
Message-ID: <20070710141442.GM4436@spearce.org>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com> <20070710031036.GA9045@spearce.org> <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com> <20070710140338.GA18450@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Frech <nimblemachines@gmail.com>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GUW-0000fL-2E
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbXGJOOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbXGJOOr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:14:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40178 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbXGJOOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:14:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I8GUC-0006Yp-2D; Tue, 10 Jul 2007 10:14:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AD54520FBAE; Tue, 10 Jul 2007 10:14:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070710140338.GA18450@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52075>

Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> David Frech wrote:
> > Now my challenge is that the svn dump doesn't *actually* say "rename
> > a/ to b/"; it says "copy a/ to b/; delete a/", so I have to infer the
> > rename.
> 
> I don't know fast-import very well, but why not doing exactly what the
> dump file suggests:  copy a b; delete a ?

Because there is no copy operator in fast-import.  So you cannot
do "copy a b".  Apparently that's what I should have implemented,
as rename in Git really is as simple as the copy/delete pair.  Ugh.

Copy isn't really that hard, it just can't be nearly as efficient as
rename, as copying a subtree will force me to either duplicate data
in memory or reload trees from disk to duplicate data in memory.
But its a copy, so data duplication is expected.  ;-)

I'll implement a copy opertor soon.  Shouldn't be too difficult.
Maybe someone else would like to take a shot at implementing it...

-- 
Shawn.
