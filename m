From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Starting to think about sha-256?
Date: Mon, 28 Aug 2006 16:48:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281647300.27779@g5.osdl.org>
References: <44F1DCB7.6020804@garzik.org>  <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
 <Pine.LNX.4.63.0608290101320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 29 01:49:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHqqu-0001pI-OJ
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 01:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWH1XtD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 19:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWH1XtD
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 19:49:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964901AbWH1XtB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 19:49:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SNmqnW010429
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 16:48:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SNmpkP020469;
	Mon, 28 Aug 2006 16:48:52 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608290101320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.434 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26186>



On Tue, 29 Aug 2006, Johannes Schindelin wrote:
>
> > Nope. If it has the same SHA1, it means that when we receive the object 
> > from the other end, we will _not_ overwrite the object we already have.
> 
> The only notable exception I can think of: "git fetch -k". If you then try 
> to retrieve the bogus object, it will return the one of whichever pack was 
> returned first be readdir(). (If I read the source correctly.)

Good point.

I didn't even think of "-k", since I mentally put that in the "initial 
clone usage only" category, but yeah, if people use it for incremental 
updates too, that could indeed cause ambiguity in which object to use when 
the other end does something bad.

		Linus
