From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 17:25:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505011337070.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 23:41:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSMBU-0002jV-3C
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVEAVqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVEAVo3
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:44:29 -0400
Received: from iabervon.org ([66.92.72.58]:19460 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262677AbVEAVZS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 17:25:18 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSLw2-0001JO-00; Sun, 1 May 2005 17:25:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011337070.2296@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 1 May 2005, Linus Torvalds wrote:

> On Sun, 1 May 2005, Daniel Barkalow wrote:
> > 
> > Right; what I want to make programs able to do is take explicit
> > references, instead of only taking the objects they reference. So you
> > say heads/master or heads/linus instead of
> > "198b0fb635ed8a007bac0c16eab112c5e2c7995c".
> 
> That's fine. 
> 
> This is really just an issue of havign a function that does "get_sha1()", 
> and then making the things that take command line arguments use that 
> one instead of "get_sha1_hex()".

I added a get_ref_sha1() that just does the .git/refs/ case; I think that
most things that want to accept various forms will also want to know what
form they got and do something with it, so get_sha1() isn't a big win.

The biggest thing so far is actually writing the references when the user
has specified where to write them, and I wanted to restrict that to a
target of the right format.

> The _only_ thing I want to be careful about is that all the _internal_
> stuff still have to use the strict "get_sha1_hex()" function, ie we should
> never _ever_ accept a tree object where the "sha1" ends up being anything
> but the hex thing. So this "generalized get_sha1()" would have to be used 
> only on real user input (ie argv[] array and the like).

Agreed.

	-Daniel
*This .sig left intentionally blank*

