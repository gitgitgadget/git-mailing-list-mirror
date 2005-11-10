From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 00:26:18 +0100
Message-ID: <200511110026.18324.Josef.Weidendorfer@gmx.de>
References: <1124832796.23795.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 11 00:30:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaLqK-0008Tq-Ho
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 00:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVKJX2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 18:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVKJX2X
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 18:28:23 -0500
Received: from pop.gmx.de ([213.165.64.20]:47789 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932270AbVKJX2X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 18:28:23 -0500
Received: (qmail invoked by alias); 10 Nov 2005 23:28:21 -0000
Received: from p5496BEC1.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.190.193]
  by mail.gmx.net (mp008) with SMTP; 11 Nov 2005 00:28:21 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <1124832796.23795.9.camel@dv>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11535>

On Tuesday 23 August 2005 23:33, Pavel Roskin wrote:
> Hello!
> 
> This patch changes cg-pull so that if the branch is not specified, it
> takes origin's .git/HEAD without first trying .git/refs/heads/master.
> This removes preferential treatment of the "master" branch, allowing the
> upstream to use another name for the default branch.  To get the master
> branch, users would have to append "#master" to the URL.

I think this is wrong.

Why would anybody want to fetch the current upstream HEAD at cg-pull
time? If you do this, and you have no control on the upstream
repository, "origin" will jump randomly around after cg-pull, depending
on the current HEAD of the origin repository.

Besides, this is a incompatible change in cg-pull behavior: I am sure that
a lot of people did a cg-clone in the past without any specific remote branch,
and expect that cg-pull will update their origin to the remote "master".
Now, if they update to a new Cogito with this patch, the next cg-pull
sometimes will rebase their origin to another random branch, depending
on remote HEAD ?!

Or am I missing something here?

Josef
