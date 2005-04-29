From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git network protocol
Date: Fri, 29 Apr 2005 17:15:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504291706400.30848-100000@iabervon.org>
References: <Pine.LNX.4.62.0504291333550.7439@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:12:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcmH-00046e-QH
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVD2VQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVD2VQv
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:16:51 -0400
Received: from iabervon.org ([66.92.72.58]:35846 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262996AbVD2VPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:15:03 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRcpB-0005be-00; Fri, 29 Apr 2005 17:15:01 -0400
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504291333550.7439@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, David Lang wrote:

> would it make sense for the network git protocol to be something along the 
> lines of
> 
> client contacts server and sends
> the tag you want to sync with (defaults to head)
> the local index file

Actually, you really want to have a bidirectional interaction, where the
client first fetches the info to determine where to start, and then goes
through the reachable space, asking for anything it doesn't already have.

(In the long run, we want to keep track of some things we already have all
of, or know we're missing, etc., so the receiver side doesn't have to
look over its whole tree.)

git already includes two versions of this protocol; the first runs against
a static HTTP server, and the second uses ssh to get a socket. At some
point, I'm going to enable these programs to read and write
.git/refs/?/? to figure out what they're supposed to get.

	-Daniel
*This .sig left intentionally blank*

