From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 22:54:21 +0200
Message-ID: <6382A127-7A81-4ADE-B2C1-1FCCBE9EA239@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home> <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de> <20070624093017.GC2467@steel.home> <EA80EB51-97F9-4C5F-BEF7-C8C1BF39B8D2@zib.de> <20070624183552.GA2374@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 22:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Z5E-0007Yr-BL
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 22:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXFXUxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 16:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXFXUxR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 16:53:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:46442 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbXFXUxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 16:53:16 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5OKrEvr004129;
	Sun, 24 Jun 2007 22:53:14 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5OKrDeD014158
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 22:53:13 +0200 (MEST)
In-Reply-To: <20070624183552.GA2374@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50820>


On Jun 24, 2007, at 8:35 PM, Alex Riesen wrote:

> Your script works, just it can be made simplier: no need for diff,
> it'll only hurt perfomance and complicates things. And you don't have
> to care about additions/deletions, and it is trivially extensible to
> support merges, and the current index is untouched - your user can
> continue working in predictable environment.

I understand that I can leave the default index untouched by using
a different index. I knew that this must be possible somehow but was
too lazy to find out how. Thanks for the details.

I don't see how I can avoid tree diffs. As I pointed out earlier I need
to mix the tree of the base commit of the newly built branch with
files that were changed in the series of commits that I'm transplanting.

Just taking the whole tree from the commits I'm transplanting is  
_wrong_.
I need to only take files that were touched by a commit. The tree of
the tip of the resulting branch can be quite different from the tree
of the tip of the original branch.

> As to perfomance: read-tree doesn't actually _read_ the blobs to
> populate index, just the trees. And diff-tree has do do the same, but
> also _compare_ two trees recursively: more work, more memory needed.

I'm still pretty convinced that I need tree diffs (not file diffs!).

> BTW, Johannes moved that ident code you copied from git-filter-branch
> into its own shell file, so it can be sourced and trivially reused.

I see, thanks.

Anyway, the script worked for me and I still think it may be useful for
fixing broken repositories resulting from a wrong cvsimport. I would
probably improve many details if someone else considered my work useful.
But up to now it seems as if I failed to explain, why the script would
be needed in the first place.

However, the best way would be to fix git-cvsimport to handle branches
correctly independently of the time of the first commit to a branch;
and avoid insane, broken repositories altogether.

	Steffen
