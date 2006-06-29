From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 11:26:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291123360.12404@g5.osdl.org>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com>
 <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Thu Jun 29 20:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1E6-0000I1-1u
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWF2S0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWF2S0h
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:26:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751249AbWF2S0g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:26:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5TIQOnW011265
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 11:26:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5TIQNoT001918;
	Thu, 29 Jun 2006 11:26:23 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22885>



On Thu, 29 Jun 2006, Johannes Schindelin wrote:
> 
> My point being: it makes no sense to split off get_merge_bases() if nobody 
> uses it except for git-merge-base.

I disagree. Your get_merge_bases() function is another small step in 
cleanup and libification, so I think it's perfectly valid regardless of 
whether somebody uses it yet.

A lot of the libification effort ends up being preparatory, because often 
you need to get past a hump of libifying a _lot_ in order to actually use 
something in a library.

So at first, the only user is usually the old separate program. So you 
libify get_merge_bases, and initially the only user is git-merge-base, 
which could now be made a built-in, since the bulk of its code is going to 
be linked in regardless..

		Linus
