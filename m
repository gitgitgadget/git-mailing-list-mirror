From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: parallel dev. with email
Date: Tue, 3 Mar 2009 20:35:33 +0100
Message-ID: <20090303193533.GC9964@m62s10.vlinux.de>
References: <20090303153141.246620@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: stoecher@gmx.at
X-From: git-owner@vger.kernel.org Tue Mar 03 20:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaOk-0000jx-H4
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZCCTd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZCCTd6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:33:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:42248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750867AbZCCTd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:33:57 -0500
Received: (qmail invoked by alias); 03 Mar 2009 19:33:39 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp026) with SMTP; 03 Mar 2009 20:33:39 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19w1OI2TudwJC6OTkwX7eXqgUCJdixDZRb/4eJt19
	/dxXYmw9NFQmTp
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 43B9C199AF; Tue,  3 Mar 2009 20:35:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090303153141.246620@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112155>

On Tue, Mar 03, 2009 at 04:31:41PM +0100, stoecher@gmx.at wrote:
> Hi,
> 
> I am new to git and I am wondering what git commands to use for this szenario: two developers without the possibility of sharing a server communicate their changes via email.
> 
> This is how far I have come reading the online docu:
> * Each developer can create the diff-info of his commits with
>   git format-patch
> * and the other developer can incorporate these changes with
>   git am
> 
> After creating the patches with format-patch one could set a tag:
>   git tag -f patchesDone
> so next time one wants to create patches, this tag can be used as the starting point:
>   git format-patch patchesDone..
> 
> But what if in the meantime one has incorporated the other developer's changes with git am? Then these changes will also be among the patches created with format-patch. What will happen, if these patches are sent to the other developer, who does not need his own changes again. Will his own changes be silently ignored by git am? Or how else to effectively coordinate the work of two developers with git via email?
> 
> thank you,
> 
> Wolfgang

[ Disclaimer: It was a *very* long time since I used this; there might
  be a better way to use bundles already ]

You could also use 'git bundle' to send your changes.  E.g. if you have
all your already released/send patches in master branch and all your
locale changes in private

 $ git bundle create mybundle private ^master  	# not sure if private..master
						# will work here


and your friend could to

 $ git bundle verify mybundle
 $ git fetch mybundle master:localRef

to import the changes. (Pls have a look in the manpage of git bundle,
there are many examples)

-Peter
