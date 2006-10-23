From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 08:59:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610230855260.3962@g5.osdl.org>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
 <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
 <Pine.LNX.4.64.0610230826080.3962@g5.osdl.org> <ehinsa$a7n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 18:00:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2DY-0001su-VV
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJWP75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWJWP75
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:59:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751851AbWJWP74 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 11:59:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NFxraX019595
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 08:59:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NFxqLP028554;
	Mon, 23 Oct 2006 08:59:52 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehinsa$a7n$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.478 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29839>



On Mon, 23 Oct 2006, Jakub Narebski wrote:
> 
> You can try yet another approach, namely rebase v2.6.15..v2.6.18 on top of
> your patch-series applied to v2.6.15, and bisect that.

Oooh. 

Yeah, it's a great idea, but likely not practical (or even possible).

git-rebase really wants a linear set of patches to rebase, which you 
definitely don't have for that big history. In fact, even if rebase did 
the full history rebasing, if later history did a merge of an earlier 
thing (ie if the patch-series that you're trying to rebase onto was based 
on something that wasn't an "epoch tip", but that was in the middle of 
intertwined history), you'd really be screwed.

Also, let's face it, rebasing isn't _that_ fast. So trying to rebase huge 
swaths of code would be painful as hell, even if it was a nice linear 
series.

But yes, for simpler situations, you could try to switch the problem 
around like you suggest.

		Linus
