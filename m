From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 15:55:23 -0800
Message-ID: <7v64bd15lg.fsf@assigned-by-dhcp.cox.net>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
	<7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701102241230.4964@xanadu.home>
	<20070111080035.GA28222@spearce.org>
	<7v1wm16gyd.fsf@assigned-by-dhcp.cox.net>
	<20070111100800.GB28309@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 00:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59lm-0004t2-DV
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbXAKXzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 18:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbXAKXzk
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:55:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64567 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932819AbXAKXzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:55:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111235538.HLON15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 18:55:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9zun1W00X1kojtg0000000; Thu, 11 Jan 2007 18:54:47 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070111100800.GB28309@spearce.org> (Shawn O. Pearce's message
	of "Thu, 11 Jan 2007 05:08:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36637>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> One minor problem that you inherited from the original algorithm
>> is the name priority.  If you have an annotated tag A and a
>> lightweight tag b, and ask "git describe --tags" in this graph:
>> 
>>     ---o---o---o---o---x
>>            A   b
>> 
>> you would still want to describe 'x' with A, not b.
>> Unfortunately you don't (and the original doesn't either).
>
> Actually I think you want to describe it with b.  If you ask
> '--tags' then you want the lightweight ones too.  In the case above
> the lightweight tag b better describes x as it has more in common
> with x than A has.

The reason why I would run the command with --tags is to cope
with this kind of graph.

             o---o---o---x
            /
    ---o---o---o---o---o---y
       b       A

in order to use lightweight ones as a back-up.  Otherwise we
would not have had the "prio" business there.

And I would prefer if the presense of lightweight 'c' tag did
not change how 'y' is described:


             o---o---o---x
            /
    ---o---o---o---o---o---y
       b       A       c
