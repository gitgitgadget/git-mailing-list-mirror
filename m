From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Mon, 07 Nov 2005 16:13:38 -0800
Message-ID: <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 08 01:15:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZH7Q-0003xI-E4
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 01:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965619AbVKHANl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 19:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965621AbVKHANl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 19:13:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34018 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965619AbVKHANk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 19:13:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108001319.VOMZ1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 19:13:19 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051107225807.GA10937@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Mon, 7 Nov 2005 23:58:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11295>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> On Mon, Nov 07, 2005 at 08:48:06AM -0800, Linus Torvalds wrote:
>> 
>> Guys,
>> 
>>   I just hit my first real rename conflict, and very timidly tried the 
>> "recursive" strategy in the hopes that I wouldn't need to do things by 
>> hand.
>> 
>> It resolved things beautifully. Good job. 
>
> I'm glad that it worked.

This is the first time I see you pleased by something in git
that was done without very close supervision from you.  All the
credits for this one goes to Fredrik, of course, but it is a
small victory for me as the maintainer as well, and I am very
happy about it.

>> ..., I'd almost suggest making "recursive" the default. I'm a
>> bit nervous about it, but knowing how it works would probably
>> put most of that to rest.

Another thing to consider is if it is fast enough for everyday
trivial merges.

In any case, I've been thinking about teaching git-merge to look
into .git/config to make it overridable which strategy to use by
default.  This would eliminate the hardcoded 'resolve for
two-head, octopus for more' rule from git-pull.  Then we could
ship git-merge with the default rule of 'recursive for two-head,
octopus for more', and if it turns out to be premature, you can
update your config file to use resolve for two-head case while
we sort things out.  That way, recursive would get wider test
coverage, and people who really need a working merge this minute
can choose to run resolve in emergency without specifying '-s
resolve' on the command line of 'git pull' every time.
