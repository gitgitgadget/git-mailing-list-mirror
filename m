From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git files data formats documentation
Date: Sat, 5 Aug 2006 15:30:46 -0400
Message-ID: <20060805193046.GA20565@spearce.org>
References: <44D42F0D.3040707@gmail.com> <7vac6jfzem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 21:31:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Rrs-0002ip-QR
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 21:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWHETbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 15:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWHETbX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 15:31:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50883 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751477AbWHETbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 15:31:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9Rrc-00087F-MM; Sat, 05 Aug 2006 15:31:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A4D920FB77; Sat,  5 Aug 2006 15:30:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac6jfzem.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24926>

Junio C Hamano <junkio@cox.net> wrote:
> Not quite.  An entry for a subtree is sorted as if a '/' is
> suffixed to its name.
> 
>         $ git ls-tree $T
>         100644 blob 2398e9f8892812607f5eee6ed0d5712c2e3de197	a-
>         100644 blob 7f07527a80bd8c2b1c5087d7ccfe61073b068374	a-b
>         040000 tree 23fddf6a57ff3ba98aa93fb71431276c3f1a3c40	a
>         100644 blob 2afe6dcc5466068b8dcc7263cece05d2adf044fe	a=
>         100644 blob efc73add7dd868242a66faf2a59b145f2a60b834	a=b
> 
> This is, by the way, consistent with the order of cache entries
> in the index file.

Arrrrgh.  I didn't realize that '/' was needed on the end of a tree
name when sorting its parent for output.  jgit was/is definately
doing this wrong.  And it all comes back to how the index operates,
doesn't it?  :-)

I've got to go back now and do some surgery on how jgit sorts
entries in a tree.  Clearly it would be incorrect with the example
you just gave.  It also would have thought that core GIT generated
a corrupt tree if it tried to read in your example.  Thank you for
taking the time to clarify it!

-- 
Shawn.
