From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Tue, 17 Oct 2006 09:12:31 -0700
Message-ID: <7vodsakjkg.fsf@assigned-by-dhcp.cox.net>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
	<7virim10rb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610151135110.17085@xanadu.home>
	<7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610151150530.3952@g5.osdl.org>
	<Pine.LNX.4.64.0610160929450.17085@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 18:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZrYS-0000ku-JE
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 18:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWJQQMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 12:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJQQMd
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 12:12:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32421 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751273AbWJQQMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 12:12:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017161232.IFQG6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 12:12:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bUCK1V0011kojtg0000000
	Tue, 17 Oct 2006 12:12:19 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610160929450.17085@xanadu.home> (Nicolas Pitre's
	message of "Mon, 16 Oct 2006 09:43:04 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29091>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 15 Oct 2006, Linus Torvalds wrote:
>
>> Quite frankly, I wonder if the pure "copy size extension" (aka "v3") thing 
>> is really worth it at all. 
>> 
>> I mean, seriously, how much does it buy us? A couple of bytes per every 
>> 64kB of delta copied? And the downside is that you can't re-use the deltas 
>> with old clients and/or you have to re-create a "v2" delta at run-time 
>> from a v3 delta by inflating, fixing and deflating it.
>
>...
> In the mean time, if Junio adds the patch I posted yesterday advertising 
> the pack version capability over the native protocol then it'll help us 
> make things forward compatible if ever we decide to go with generating 
> packs v3 sooner.

I've thought about this, but we hopefully would have ofs-delta
capability exchanged soon after 1.4.3, and that would be an
enough advertisement that the client is recent enough; although
it is technically incorrect to tie these two independent
features together, the improvement between v2 and v3 is dubious
so maybe that is the easiest.
