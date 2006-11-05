X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Push and remote refs
Date: Sun, 5 Nov 2006 13:50:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611051333210.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 5 Nov 2006 18:50:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30979>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggn4U-0004fv-Au for gcvg-git@gmane.org; Sun, 05 Nov
 2006 19:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161503AbWKESuO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 13:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161499AbWKESuO
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 13:50:14 -0500
Received: from iabervon.org ([66.92.72.58]:21769 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1161503AbWKESuN (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 13:50:13 -0500
Received: (qmail 643 invoked by uid 1000); 5 Nov 2006 13:50:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 5
 Nov 2006 13:50:11 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

My current workflow as maintainer of a couple of projects is:

I have a publicly-accessible repository, whose master is the important 
branch. When there are changes that I want to add, I fetch this branch on 
a workstation to the workstation's "mainline" branch, pull into 
"for-mainline" (which is a fast-forward), apply patches, test, commit, and 
push back to master.

Usually, I use the same computer to do this multiple times in a row, and 
it's a bit inconvenient that, after pushing local "for-mainline" to remote 
"master", I have to fetch remote "master" to local "mainline". It would be 
nice if git would update local tracking of remote refs when it pushes to 
those remote refs.

(Furthermore, I'm also using another branch to do development, by being a 
lot less careful about the quality of commits in it, and generating 
patches out of the diff between the development branch and mainline. But I 
do development on multiple workstations, so I have a remote branch on my 
server that I push the development work to, so that I can get it from 
other computers even before I clean it up and put it in the mainline. When 
I'm generating patches, I'm doing it between "for-mainline" and the 
tracking branch for the remote development, which means that I remember to 
push my development to the server. But then I have to fetch it back 
immediately so that I can use it to generate patches.)

I can't think of a situation in which you would want to not get the effect 
of an immediate fetch after a successful push, and it saves a couple of 
ssh connections to use the local knowledge that, at least for an instant, 
the remote ref matches the local one. Is there some reason not to do this?

	-Daniel
