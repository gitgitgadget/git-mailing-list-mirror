From: Jeff King <peff@peff.net>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 20:10:25 -0400
Message-ID: <20130609001025.GB29964@sigill.intra.peff.net>
References: <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
 <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
 <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
 <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
 <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
 <CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
 <CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
 <20130608171513.GA28029@sigill.intra.peff.net>
 <CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 02:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlTDa-0008T2-03
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 02:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab3FIAK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 20:10:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab3FIAK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 20:10:28 -0400
Received: (qmail 30288 invoked by uid 102); 9 Jun 2013 00:11:17 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 19:11:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 20:10:25 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226864>

On Sat, Jun 08, 2013 at 12:40:19PM -0500, Felipe Contreras wrote:

> > These are problems that can be solved. But there is a lot of work
> > involved in finding these subtle bugs and coming up with fixes. I think
> > you would be better off working on an implementation of git that was
> > designed from scratch to work in-process, like libgit2.
> 
> So you are in favor of never ever having an official Git library. Got it.

No, I didn't say that at all.

I do think that it would be more work to try to slowly massage the git
code into a library-ready form than it would be to simply start with
more library-friendly code and pull in bits of git.git as appropriate.

That is what the libgit2 project is doing.  Perhaps one day that project
will reach a point where we start building git.git commands off of it or
sometihng like it (for that matter, there is no reason you could not
build external commands off of libgit2 right now).  Would it be the
"official" Git library then? I don't know. It is not clear to me what
that even means.

In the meantime, I think it cannot be a bad thing for libgit2 to proceed
along its path, and I don't see a good reason for people not to use it.

But hey, you don't need to listen to me. If you think it would be easier
to make the git.git code into a library, go ahead and work on it. But I
think you will find that there are a large number of hard-to-find bugs
caused by implicit assumptions about global state, how file descriptors
are used, and so forth.

> There's a reason why the Git project doesn't use libgit2, and for the
> same reason the official Ruby scripts should not use it.

What reason is that?

> As history indicates, the Git project will never have any pressure to
> fix it's re-entrancy and re-run issues, so these issues will remain
> there forever.
> 
> Only if you allow code that exposes those issues will there ever be
> any pressure to fix them.

I think it is a matter of critical mass. If you were to start linking
against libgit.a and 90% of it worked, you might have a reason to fix
the other 10%. But I suspect it is more the other way around.

-Peff
