From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD was
Date: Tue, 27 Oct 2009 12:41:56 +0900
Message-ID: <20091027124156.6117@nanako3.lavabit.com>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
	<76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
	<alpine.LNX.2.00.0910141509200.32515@iabervon.org>
	<alpine.LFD.2.00.0910141616530.20122@xanadu.home>
	<7v7huxbtbk.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	<7vws2xa9lu.fsf@alter.siamese.dyndns.org>
	<20091014230934.GC29664@coredump.intra.peff.net>
	<alpine.LFD.2.00.0910141926170.20122@xanadu.home>
	<7viqeha2zv.fsf@alter.siamese.dyndns.org>
	<20091015014737.GA9923@coredump.intra.peff.net>
	<alpine.LFD.2.00.0910142237010.20122@xanadu.home>
	<alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de>
	<alpine.LFD.2.00.0910152118360.20122@xanadu.home>
	<alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de>
	<BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl>
	<alpine.DEB.1.00.0910262317430.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 04:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2cwc-0006lE-Si
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 04:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZJ0Dlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 23:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbZJ0Dlx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 23:41:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58154 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbZJ0Dlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 23:41:52 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 86FD411B801;
	Mon, 26 Oct 2009 22:41:57 -0500 (CDT)
Received: from 6540.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 1XM4M8EPPL3Z; Mon, 26 Oct 2009 22:41:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=PbB0BuiCUx7V47Xmp++sX87uqksWY+UYa1RqnTBhvo1GV/dNJZA8LJ2TzInSzz0boEuc1/dRZQvFEfUTmLbjZ+x0r3QyCjJIDKTFy+a8DVOPFDfzr6KmhhkqpdK4bJdnPWM6pCQ2muCMRr5dN5zMXyyKo9D9tYaSeuJB9quVzDo=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0910262317430.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131307>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>

> On Sat, 17 Oct 2009, Sean Estabrooks wrote:
>
>> On Fri, 16 Oct 2009 04:07:23 +0200 (CEST)
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> > Just recently, I had a user request (a very valid one, mind you) where 
>> > the user does not want to provide a commit message, and wants to just 
>> > commit all the current changes.  In that particular case, it is very 
>> > sensible to ask for these things.  It is something utterly simple to 
>> > ask for. Yet, it is utterly hard with Git, especially if I have to 
>> > explain it.
>> 
>> Hey Johannes,
>> 
>> It's actually easy, but maybe hard to find:
>> 
>> 	$ git commit --cleanup=verbatim -m ""
>
> Of course that leaves out the main part.  But it is simple once you 
> know it (I did not): git add -A (we even went out of our way _not_ to name 
> the long option --addremove, but --all -- it does not seem to be an 
> expressive-enough option name to me, but what does my impression 
> matter...)
>
> So I retract my claim that it is utterly hard to do with Git (but not the 
> rest).

Last week, Junio gave this comment to your message.

> I suspect the above is another example of your needing to do 
> a better job explaining yourself here, but from "just commit 
> all the changes without saying message", my knee-jerk 
> reaction is "git commit -a -m 'no message'".

> You would need to justify why -m 'no message' does not fit 
> the bill better than just saying "is very sensible to ask for 
> these things", as I highly suspect that I misunderstood what 
> "these things" are in your five lines to come up with that 
> "solution" that you are now going to explain why that is not 
> what the end user wanted.  And in this case, I do not think 
> it is that me being disconnected from the real world, but 
> that your explanation is insufficient.

I'm also curious about the situation when a commit with no message 
is useful, but unfortunately I don't think I saw you explained 
clearly enough what this user request wanted to achieve or what 
"these things" in your message were for us to understand why it is 
a sensible and valid thing to ask. Did I miss some messages in the 
thread?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
