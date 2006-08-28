From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 13:20:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281317070.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org> <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org> <m34pvwfwl5.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 28 22:21:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHnbh-0000fH-VM
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWH1UUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWH1UUz
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 16:20:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751473AbWH1UUy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 16:20:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SKKRnW024832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 13:20:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SKKQ9X012902;
	Mon, 28 Aug 2006 13:20:26 -0700
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m34pvwfwl5.fsf@defiant.localdomain>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26179>



On Mon, 28 Aug 2006, Krzysztof Halasa wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> >    In related news, the question is what to do about the inadvertent 
> >    collision.. First off, let me remind people that the inadvertent kind 
> >    of collision is really really _really_ damn unlikely, so we'll quite 
> >    likely never ever see it in the full history of the universe.
> 
> Actually I think we may see it when somebody tries to put a real
> example of conflicting SHA-1 pair into git repository.

Well, by definition, I wouldn't call that "inadvertent" ;)

Anyway, the way to do it (if you want to use git to document SHA1 hash 
mismatches) is to just check the files that have an identical SHA1 in. It 
will magically work!

Why? Because a git SHA1 is actually _not_ the SHA1 of the file itself, 
it's the SHA1 of the file _with_the_git_header_added_.

So if you find two files that have the same SHA1, they would also have to 
have the same length in order to actually generate the same object name. 
If they have different lenths, you can just check them into git, and 
they'll get two different git SHA1 names and you'll have a cool git 
archive that when you check the files out, they checked-out files will 
share the same SHA1 ;)

		Linus
