From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 14:32:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 23:34:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESi1z-0006z2-U6
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 23:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVJTVcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJTVcy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 17:32:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbVJTVcy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 17:32:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KLWkFC029390
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 14:32:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KLWiVx008702;
	Thu, 20 Oct 2005 14:32:45 -0700
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20051020T220751-355@post.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10382>



On Thu, 20 Oct 2005, Junio C Hamano wrote:
> 
> Having said that, all is not lost.  Your message made it sound like the
> new head was completely re-rooted and there is no common commit (which
> almost gave me a heart attack), but I do not think it is that bad.  It is
> more like pulling from two places.

No. 

What you _must_ do to fix things up is that _you_ merge your current head 
with your old head, and then you push out the result.

At that point:

>                -----(A) head merlyn and everybody
>              /          pulled from kernel.org previously
>   --- common ------------------------------------(B) head rebased and pushed
>                                                      out by mistake

You should have a (C) that is the merge of both A and B (or a later 
commit, if you have other commits merged).

Now you can push out that merge, and everybody will be happy again: 
they'll see somethign that is a proper superset of whichever HEAD they 
happened to pull.

Don't make everybody else try to fix up your mistakes for you. It's easy 
enough for you to just fix it up, and everybody else can just pull.

Of course, anybody who did a pull and then did the merge by hand will 
always have their own private merge, and they should probably just undo 
that. But undoing _private_ stuff is ok.

		Linus
