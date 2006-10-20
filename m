From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: StGIT and rerere
Date: Sat, 21 Oct 2006 00:39:09 +0200
Organization: Dewire
Message-ID: <200610210039.10215.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 00:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb30P-0008Sx-Kh
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992708AbWJTWiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJTWiS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:38:18 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15704 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S2992708AbWJTWiR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 18:38:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id DD5D28028BA
	for <git@vger.kernel.org>; Sat, 21 Oct 2006 00:35:07 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07649-08 for <git@vger.kernel.org>; Sat, 21 Oct 2006 00:35:07 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 8AB528028AB
	for <git@vger.kernel.org>; Sat, 21 Oct 2006 00:35:05 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29545>

Hi,

It seems stgit does not use git-rerere, so why not? Any reason other than it
hasn't been done yet?

I abuse stgit heavily, by frequently reording patches, which for some patches
result in re-occuring conflicts. git-rerere seems to be the solution.

What's the "rules" for when to invoke rerere? It seems it is mostly automatic 
in git, but since only the porcelainish commands use it, that means StGIT 
doesn't.

So here is what I *think* needs to be done. Seems simple enough.

stg push, stg pick, stg import, stg goto, stg fold, stg float
	do what push does and invoke git-rerere at the end whether the push ends with 
conflicts or not

stg pop
	nothing, or do I need to remove rr-cache/MERGE_RR, like git-reset does?

stg status --reset, stg push --undo
	remove rr-cache/MERGE_RR ?

stg refresh
	do what stgit does normally and then invoke git-rerere

stg resolved:
	do what stgit does normally and then invoke git-rerere

stg clean, stge delete:
	remove rr-cache/MERGE_RR ?

Anything else or comments on this list?

-- robin
