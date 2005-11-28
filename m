From: Sven Verdoolaege <skimo@kotnet.org>
Subject: rebase problems
Date: Mon, 28 Nov 2005 15:58:14 +0100
Message-ID: <20051128145814.GW8383MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 28 16:00:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgkSf-0004IK-Sn
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 15:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVK1O6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 09:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVK1O6S
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 09:58:18 -0500
Received: from psmtp03.wxs.nl ([195.121.247.12]:12441 "EHLO psmtp03.wxs.nl")
	by vger.kernel.org with ESMTP id S1750874AbVK1O6R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 09:58:17 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IQO00HW06X2UU@psmtp03.wxs.nl> for git@vger.kernel.org; Mon,
 28 Nov 2005 15:58:14 +0100 (MET)
Received: (qmail 3362 invoked by uid 500); Mon, 28 Nov 2005 14:58:14 +0000
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12885>

Recently, rebasing has stopped working for me.
Here is an example:

bash-3.00$ git-show-branch origin HEAD
! [origin] fix in which we remove the definition of index statements that are *not* used in the control vector
 ! [HEAD] propagate LinearizationType typo fix.
--
 + [HEAD] propagate LinearizationType typo fix.
 + [HEAD^] LinearizationType: typo
 + [HEAD~2] espam::DecomposeChannels: actually decompose the channel if valid.
 + [HEAD~3] DecomposeChannels: split channel and check whether result is a pair of fifos.
 + [HEAD~4] Use proper class for LinearizationType.
 + [HEAD~5] espam/../DecomposeChannels: partial implementation.
 + [HEAD~6] espam: add flag for channel decomposition.
+  [origin] fix in which we remove the definition of index statements that are *not* used in the control vector
++ [HEAD~7] espam/../IndexVector::toString: include contents of IndexVector.
bash-3.00$ git rebase origin

Applying 'espam::DecomposeChannels: actually decompose the channel if valid.'

error: pa/espam/operations/transformations/DecomposeChannels.java: does not exist in index
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Trying simple merge.
Simple merge failed, trying Automatic merge.
ERROR: pa/espam/operations/transformations/DecomposeChannels.java: Not handling case 09322db769adbc03bfd4f3ac2720c6d1db5a85b1 ->  -> 32da8b1de4205c4adb0da50648a0a00d60b67582
fatal: merge program failed
Failed to merge in the changes.
Patch failed at 0007.
0001-espam-add-flag-for-channel-decomposition.txt


I'm not sure what rebase is doing here, but the only change in origin
modified a file untouched by the changes in HEAD, so there shouldn't
be any conflict whatsoever.
Apparently it's trying to apply the change in HEAD~2 without having
applied the earlier changes (which and the file named above).

skimo

PS: I'll try and look into the gitk thing this evening.
