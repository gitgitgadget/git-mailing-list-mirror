From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Mon, 7 Nov 2005 08:56:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511070848440.3193@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:58:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZAIA-00076I-Jt
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 17:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKGQ4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 11:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVKGQ4U
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 11:56:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932246AbVKGQ4T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 11:56:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA7Gu9nO003076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 08:56:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA7Gu7Br009394;
	Mon, 7 Nov 2005 08:56:08 -0800
To: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11270>



On Mon, 7 Nov 2005, Linus Torvalds wrote:
> 
>   I just hit my first real rename conflict, and very timidly tried the 
> "recursive" strategy in the hopes that I wouldn't need to do things by 
> hand.
> 
> It resolved things beautifully. Good job. 

Btw, one thing that it does is print out too much information.

In particular, I had renames on both sides of the merge (in case anybody 
wants to see which one I'm talking about: it's the current top-of-head 
commit in the kernel archives: 333c47c847c90aaefde8b593054d9344106333b5).

Now, renames that you've done yourself you really don't want to hear 
about, at least if the other side didn't change anything in that file.

Renames that the _other_ side has done (the one you're merging) you may or 
may not want to know about, regardless of whether they happened to files 
that are changed. But since "git pull" will do a "git-apply --stat" at the 
end and show the renames there, I'd argue that the merge strategy itself 
should be quiet about any renames that are trivial.

So how about talking about renames only if you end up also doing a 
file-level merge? As it is, doing the merge talked about renames that I 
had merged earlier in my own branch, which is just confusing.

		Linus
