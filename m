From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-rc6-mm2
Date: Thu, 15 Jun 2006 23:39:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> 
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> 
 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
 <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 08:39:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr7zb-0007H9-D0
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 08:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWFPGjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 02:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWFPGjk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 02:39:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWFPGjj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 02:39:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G6dagt015837
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 23:39:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G6dZax009113;
	Thu, 15 Jun 2006 23:39:36 -0700
To: Goo GGooo <googgooo@gmail.com>
In-Reply-To: <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21933>



On Fri, 16 Jun 2006, Goo GGooo wrote:
> 
> Thanks for explanation. Unfortunately I can't use git:// with "git
> pull" (at least in git-1.3.2). First it does some traffic, that
> suddenly stops - I guess the server starts doing *something*, perhaps
> preparing the update for me or whatnot.

Yeah, for a big pull, the server will have to think about the objects it 
is going to send you.

> I suggest adding SO_KEEPALIVE option on the git socket.

Actually, the really irritating thing is that we actually generate all 
these nice status updates, which just makes pulling and cloning a lot more 
comfortable, because you actually see what is going on, and what to 
expect. 

Except they only work over ssh, where we have a separate channel (for 
stderr), and with the native git protocol all that nice status work just 
gets flushed to /dev/null :(

Dang. It's literally the most irritating part of the thing: the protocol 
itself is exactly the same whether you go over ssh:// or over git://, but 
that visual information about what is going on is missing, and it's 
surprisingly important from a usability standpoint.

And in your case, the usability downside actually turned into a real 
accessibility bug.

Oh, well.

		Linus
