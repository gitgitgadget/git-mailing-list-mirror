From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] get_pathspec(): free() old buffer if rewriting
Date: Sun, 7 May 2006 00:44:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070041540.26058@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0605061532190.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun May 07 00:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcVWW-0003k4-5L
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWEFWog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWEFWog
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:44:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:7642 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932098AbWEFWog (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 18:44:36 -0400
Received: (qmail invoked by alias); 06 May 2006 22:44:34 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp039) with SMTP; 07 May 2006 00:44:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605061532190.16343@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19680>

Hi,

On Sat, 6 May 2006, Linus Torvalds wrote:

> On Sun, 7 May 2006, Johannes Schindelin wrote:
> > 
> > This might be the wrong way to do it, but as it is without this patch,
> > get_pathspec() is leaking memory.
> 
> I'm not at all convinced we want to do somethng like this.
> 
> get_pathspec() is a one-time event. It doesn't "leak" memory. To me, 
> "leaking" is when you continually lose a bit of memory, and you eventually 
> run out. I don't see that happening here.

I see your point. That was exactly why I put "RFC" and not "PATCH" on the 
subject.

> So there's a difference between "don't care" and "leak memory". It sounds 
> like you may be using some automated tool that warns because it simply 
> doesn't understand that difference.

Nope. No automated tool. Just my brain which wanted to fix _all_ 
occurrences of that prefix_path() usage bug.

But in case anybody uses Valgrind et al. on git, how about at least a 
comment telling the casual observer why we don't free() the buffers?

Ciao,
Dscho
