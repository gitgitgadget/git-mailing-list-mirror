From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: behaviour of git diff, GIT_DIR & checked out tree
Date: Mon, 24 Sep 2007 14:03:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709241400410.28395@racer.site>
References: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZnbp-00069Z-2N
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 15:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbXIXNEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 09:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXIXNEP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 09:04:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbXIXNEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 09:04:14 -0400
Received: (qmail invoked by alias); 24 Sep 2007 13:04:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 24 Sep 2007 15:04:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FqkcKG4FFguCKZtfC4YZfE/YfZMfw/O+9Gx4D+o
	rAB1NZHoEy1hlh
X-X-Sender: gene099@racer.site
In-Reply-To: <e1dab3980709240545o32eeefcdkd4bc67abab0e5343@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59044>

Hi,

On Mon, 24 Sep 2007, David Tweed wrote:

> In a git tracked tree rooted at $HOME/V with
> git-dir of $HOME/V/.git, if I'm in $HOME/V then
> 
> git diff master@{midnight}
> 
> tells me the difference between the current modified files
> in the tree being tracked in V and the specified commit. In
> a different directory, OUTSIDE of $HOME/V, I tried
> 
> env GIT_DIR=$HOME/V/.git git diff master@{midnight}
> 
> to get the same effect but, whilst I do get a diff output, it
> looks like a diff of the commit against an empty tree.

Yes, this is fully expected.

The @{time} notation accesses the _reflogs_, which are purely local 
beasts.  They are not transmitted when cloning.

The rationale: in a distributed environment, you cannot trust others' 
timestamps.  Therefore we don't.

We can only (to a certain extent, at least) trust our _own_ timestamp.  
That is why we have timestamp access to the reflogs (which are purely 
local, as I mentioned above), but we have no way to reference commits by 
timestamp otherwise.

Hth,
Dscho
