From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Pushing the HEAD ref?
Date: Tue, 17 Mar 2009 07:28:35 -0700
Message-ID: <20090317142835.GB20222@spearce.org>
References: <ff6a9c820903162104v2ca62437ua3da6bafba3ea101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Cheng <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 15:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjaJk-0001YI-NU
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 15:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbZCQO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZCQO2n
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 10:28:43 -0400
Received: from george.spearce.org ([209.20.77.23]:44050 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbZCQO2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 10:28:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F254238221; Tue, 17 Mar 2009 14:28:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ff6a9c820903162104v2ca62437ua3da6bafba3ea101@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113473>

Daniel Cheng <j16sdiz+freenet@gmail.com> wrote:
> 
> When I develop the freenet transport, I found the refWriter in
> WalkPushConnection never write the HEAD refs, even if this is a new
> repository.
> Is this the expected behaviour? This cause error when I clone the repository.

Nope.

Check WalkPushConnection's createNewRepository().  The method is
called from line 162 where we try to create a new HEAD symbolic
ref to one of the refs/heads/$name being pushed, and we also put
a tiny config file.  This way a repository pushed over sftp://
is a valid repository if you later get shell access to it.

Sounds like you didn't push a refs/heads/$name when you created
the repository, or you something is broken in this section.

-- 
Shawn.
