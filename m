From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Sat, 31 Mar 2007 12:49:47 +0200
Message-ID: <20070331104947.GA4377@steel.home>
References: <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com> <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com> <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com> <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 12:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXb9d-0003ct-Uk
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 12:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbXCaKtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 06:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbXCaKtv
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 06:49:51 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15007 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXCaKtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 06:49:50 -0400
Received: from tigra.home (Fc8c6.f.strato-dslnet.de [195.4.200.198])
	by post.webmailer.de (mrclete mo27) (RZmta 5.5)
	with ESMTP id F01890j2V3DQrx ; Sat, 31 Mar 2007 12:49:48 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BFEBF277B6;
	Sat, 31 Mar 2007 12:49:47 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 48097D150; Sat, 31 Mar 2007 12:49:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WNdA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43544>

Linus Torvalds, Sat, Mar 31, 2007 03:03:36 +0200:
> > 
> > We're looking for a base version for a merge - think of a three-way merge 
> > on a file level. And the easiest base version is actually an empty base 
> > file (or, when it comes to a rename conflict, no base names at all).
> 
> Note that "easiest" isn't "best".
> 
> For data conflicts in intermediate merges, we use the conficted file, 
> conflict markers and all, as the base.
> 
> I suspect we should do exactly the same for filename conflicts. Write the 
> intermediate tree with *both* files, including conflict markers. I'd 
> suggest writing out the conflicting names to the intermediate tree 
> *exactly* the same way we do for the final tree in the working tree, but 
> mayne we could just write them with the SHA of the content appended to the 
> filename or something..)
> 

The names are already different (base->a, base->b), what is the SHA for?
I tried leaving all three names in the computed tree (base, a and b).
The result is sometimes spectacular, but seldom useful.
