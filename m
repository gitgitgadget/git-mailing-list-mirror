From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 01:41:26 -0400
Message-ID: <20060907054126.GC31580@spearce.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com> <44FF5C27.2040300@gmail.com> <9e4733910609061704s429c449etcf0475841556c26b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 08:08:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLD3H-00018C-Cq
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 08:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWIGGHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 02:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWIGGHd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 02:07:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:17359 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751940AbWIGGH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 02:07:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLD2t-0001TI-6w; Thu, 07 Sep 2006 02:07:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D193A212694; Thu,  7 Sep 2006 01:41:26 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609061704s429c449etcf0475841556c26b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26596>

Jon Smirl <jonsmirl@gmail.com> wrote:
> The repack code could build a model of the tree as it is repacking,
> that is what fast-import does. If you have a model of the tree then
> when you change a TREE node you track the last sha1 that corresponded
> to that directory path. Now you know what to diff to.

Right.  But that's horribly expensive.  For the most part
pack-objects does a good job estimating this by hashing the trees
by their name and size into the same hash bucket.  And its fast.

Besides its better to store reverse deltas (like what CVS does)
as faster access to the more recent stuff is more interesting than
faster access to the older stuff.  pack-objects tries to do this
based on the order given by rev-list.

-- 
Shawn.
