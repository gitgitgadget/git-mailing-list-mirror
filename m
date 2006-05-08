From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 19:30:05 -0400
Message-ID: <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 01:35:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFG5-0005ST-Qe
	for gcvg-git@gmane.org; Tue, 09 May 2006 01:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWEHXfP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 19:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWEHXfP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 19:35:15 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:16423 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750848AbWEHXfN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 19:35:13 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 May 2006 16:35:12 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4BA11644C28;
	Mon,  8 May 2006 19:35:11 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Message-Id: <20060508193005.40f249a1.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 23:35:12.0713 (UTC) FILETIME=[0D4B4390:01C672F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 8 May 2006 19:20:17 -0400 (EDT)
Daniel Barkalow <barkalow@iabervon.org> wrote:

> You could tell people always to use:
> 
>  [branch."name"]
> 
> even if the branch name is all lowercase anyway. They could even use:
> 
>  [Branch."MyMixedCaseBranch"]
> 
> Then when you refer to something case-sensitive with the possibility of 
> funny characters, you put it in quotes, regardless of what it is.
> 
> For that matter, we could retain the quotes when we parse the file, and 
> reject [branch.master] for lacking the quotes, so that people who are only 
> exposed to branch names all in lowercase letters don't get habits that 
> will fail when they have a v2.6.16.x branch.
> 
> I don't think that people are likely to use older versions of git on the 
> same repository they've used newer versions on. (Clones of it, sure, but 
> that doesn't matter here.) But we should, in any case, make the code 
> ignore sections or lines with syntax errors, under the assumption that 
> they're a later extension and possibly legal but not anything the code 
> could be interested in getting from a parser that doesn't support them.


Unfortunately that's not the only place where you have to use the 
excessive quoting; you also have to do the same when using the git
repo-config command line.   All because we're clinging to case
insensitivity and a very restrictive set of characters for 
identifiers in the config file.  And just why are we clinging?

Believe when Linus offered the code originally he said that it was
easier to start out very restrictive and loosen up later than it was
to start loose and become restrictive later.  That makes a lot of
sense, but somewhere along the way we seem to have made a virtue
out of something that is actually getting in the way of natural
syntactic usage.  There's no good reason for git to break with 
traditional and common practice in this case.

Sean
