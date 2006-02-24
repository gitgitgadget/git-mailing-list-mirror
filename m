From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Thu, 23 Feb 2006 16:17:42 -0800
Message-ID: <7vek1thaop.fsf@assigned-by-dhcp.cox.net>
References: <11404323692193-git-send-email-ryan@michonline.com>
	<20060220234054.GA7903@c165.ib.student.liu.se>
	<20060223221048.GA6423@mythryan2.michonline.com>
	<20060223225547.GB8673@c165.ib.student.liu.se>
	<Pine.LNX.4.63.0602240055080.31816@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 24 01:17:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCQed-0003Qq-9W
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBXARr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBXARr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:17:47 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31110 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932223AbWBXARp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:17:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224001751.YMPG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Feb 2006 19:17:51 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602240055080.31816@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 24 Feb 2006 01:00:41 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16675>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > This could probably benefit a *LOT* from the libification project, I
>> > think, though.
>> 
>> Yes, perhaps. Some of the git-rev-list bits might simplify a couple of
>> things.
>
> The major problem is probably not solved: What Linus calls a "stream 
> interface".
>
> I.e. if you pipe the output of git-rev-list to another program, you 
> *need* to execute the two semi-simultaneously. The "alternative" would be 
> to use buffers, which can get huge (and are sometimes not needed: think 
> git-whatchanged, which starts outputting before it's getting no more 
> input).

You need a limited coroutine support, something like generator
functions in Python ;-).  In C, traditional way of doing it is
to make your application specific function a callback of
rev-list or whatever generator is, which is very unpleasant to
code.

>> I have found some severe problems with the code I posted, in
>> particular it doesn't handle parallel development tracks at all. I am
>> working on fixing it, but it isn't finished yet.
>
> Looking forward to them!

Likewise.
