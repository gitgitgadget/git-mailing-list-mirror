From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 10:25:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603011023080.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <200603011814.43573.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
 <200603011906.33433.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 19:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEW16-00005W-Dj
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 19:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCASZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWCASZd
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 13:25:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbWCASZc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 13:25:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21IPMDZ017967
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 10:25:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21IPLgo010722;
	Wed, 1 Mar 2006 10:25:21 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603011906.33433.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17003>



On Wed, 1 Mar 2006, Josef Weidendorfer wrote:
>
> On Wednesday 01 March 2006 18:40, Linus Torvalds wrote:
> > But if somebody does the get_sha1() magic, and Junio agrees, then I think 
> > it would be a great thing to do.
> 
> Yes.
> 
> 	git log origin/master..
> 
> is really not that bad

It really is.

Think like a user. If I pull from "origin", then the name of that thing is 
"origin", not "origin/master" or "o/master". A user doesn't care what the 
remote branch name is - the whole _point_ of the .git/remotes/xyzzy file 
is to give a short description that includes the names of the branches you 
pull from.

The good news is that "get_sha1()" shouldn't be that hard to extend on. 
Just add a case at the end that says "do we have a .git/remotes/%s file, 
and if so, parse it".

				Linus
