From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 20:35:52 +0200
Message-ID: <20070624183552.GA2374@steel.home>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home> <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de> <20070624093017.GC2467@steel.home> <EA80EB51-97F9-4C5F-BEF7-C8C1BF39B8D2@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 20:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Wx8-0001Te-8t
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 20:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbXFXSgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755576AbXFXSgH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 14:36:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:10615 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbXFXSf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 14:35:56 -0400
Received: from tigra.home (Fad95.f.strato-dslnet.de [195.4.173.149])
	by post.webmailer.de (fruni mo38) (RZmta 7.5)
	with ESMTP id j0166aj5OErnrz ; Sun, 24 Jun 2007 20:35:52 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BA5FB277BD;
	Sun, 24 Jun 2007 20:35:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 81B57C164; Sun, 24 Jun 2007 20:35:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <EA80EB51-97F9-4C5F-BEF7-C8C1BF39B8D2@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFly0M=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50810>

Steffen Prohaska, Sun, Jun 24, 2007 19:13:42 +0200:
> >>I am changing the repository.
> >
> >No, you don't.
> 
> Magically, the script solved my problem by creating a new, corrected
> branch that is different from the original one. I didn't run any
> other script. I promise, I ran the script that I sent in the patch.

I meant: "it does not change the working directory". It is irrelevant,
was a bit of confusion on my part.

Your script works, just it can be made simplier: no need for diff,
it'll only hurt perfomance and complicates things. And you don't have
to care about additions/deletions, and it is trivially extensible to
support merges, and the current index is untouched - your user can
continue working in predictable environment.

As to perfomance: read-tree doesn't actually _read_ the blobs to
populate index, just the trees. And diff-tree has do do the same, but
also _compare_ two trees recursively: more work, more memory needed.

BTW, Johannes moved that ident code you copied from git-filter-branch
into its own shell file, so it can be sourced and trivially reused.
