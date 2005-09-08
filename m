From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 22:05:59 +0200
Message-ID: <20050908200559.GA26088@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <Pine.LNX.4.63.0509071409470.23242@iabervon.org> <20050908060651.GA22734@c165.ib.student.liu.se> <Pine.LNX.4.63.0509081101471.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 08 22:08:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDSfH-0007Qr-Ka
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 22:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVIHUGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 16:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVIHUGU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 16:06:20 -0400
Received: from [85.8.31.11] ([85.8.31.11]:59106 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S964978AbVIHUGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 16:06:20 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 892AA4114; Thu,  8 Sep 2005 22:10:46 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EDSel-0007B3-00; Thu, 08 Sep 2005 22:05:59 +0200
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509081101471.23242@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8213>

On Thu, Sep 08, 2005 at 11:27:35AM -0400, Daniel Barkalow wrote:

...

> > The two cases my algorithm merges cleanly and git-resolve-script do
> > not merge cleanly are 0e396ee43e445cb7c215a98da4e76d0ce354d9d7 and
> > 0c168775709faa74c1b87f1e61046e0c51ade7f3. Both of them have two common
> > ancestors. The second one have, as far as I know, not been tested with
> > your read-tree.
> 
> Okay, I'll have to check whether the result I get seems right. I take it 
> your result agrees with what the users actually produced by hand?
 
The first one agrees with what was actually committed. For the second
one the difference between the tree produced by the algorithm and what
was committed is:

diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
--- a/include/net/ieee80211.h
+++ b/include/net/ieee80211.h
@@ -425,9 +425,7 @@ struct ieee80211_stats {
 
 struct ieee80211_device;
 
-#if 0 /* for later */
 #include "ieee80211_crypt.h"
-#endif
 
 #define SEC_KEY_1         (1<<0)
 #define SEC_KEY_2         (1<<1)


I have looked at the files and common ancestors involved and I think
that this change have been introduced manually. I may have missed
something when I analysed it though...


> > The merge cases reported by Tony Luck and Len Brown are both cleanly
> > merged by my code.
> 
> Do they come out correctly? Both of those have cases which cannot be 
> decided correctly with only the ancestor trees, due to one branch 
> reverting a patch that was only in one ancestor. The correct result is to 
> revert that patch, but figuring out that requires looking at more trees. I 
> think your algorithm should work for this case, but it would be good to 
> have verification. (IIRC, Len got the correct result while Tony got the 
> wrong result and then corrected it later.)

Len's merge case come out identically to the tree he committed. I have
described what I got for Tony's case in
<20050826184731.GA13629@c165.ib.student.liu.se> (my merge algorithm
produces the result Tony expected to get, but he didn't get that from
git-resolve-script).

- Fredrik
