From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] new tutorial
Date: Sun, 15 Jan 2006 21:32:16 -0800
Message-ID: <7vmzhwybz3.fsf@assigned-by-dhcp.cox.net>
References: <7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
	<20060112005531.GB14599@fieldses.org>
	<7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
	<20060113030837.GD27214@fieldses.org>
	<7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
	<20060113151005.GA29804@fieldses.org>
	<7v4q477vqj.fsf@assigned-by-dhcp.cox.net>
	<20060113200152.GI4369@fieldses.org>
	<20060115185458.GA3985@fieldses.org>
	<7v64olysw2.fsf@assigned-by-dhcp.cox.net>
	<20060116035731.GA14849@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 06:32:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyMyl-0006jf-FY
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 06:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWAPFcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 00:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWAPFcU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 00:32:20 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27083 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750927AbWAPFcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 00:32:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116052957.PWZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 00:29:57 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14724>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> Empirically the first 7 hexdigits are enough (even 5 for small
>> projects such as git itself).  In fact, in the linux-2.6
>> repository itself, it appears 5 hexdigits are enough to identify
>> all 171902 objects (not just commits) uniquely currently
>
> Five hex digits is only 20 bits, and 171902/2^20 > 1/10, so each
> additional object has a better than 1-in-10 chance of colliding with an
> existing object.  The chances there hasn't been a collision in the first
> 5 digits by now must be practically zero.  Maybe you're thinking bytes,
> not hex digits?  Unless my math is wrong.

Your math is right and my script was wrong.

For linux-2.6 repository:

	$ git rev-list --objects HEAD | sort >/var/tmp/objnames
        $ wc -l </var/tmp/objnames
        171902
        $ sed -e 's/^\(........\).*/\1/' </var/tmp/objnames | uniq | wc -l
        171899
        $ sed -e 's/^\(.........\).*/\1/' </var/tmp/objnames | uniq | wc -l
        171902

So 8 is enough for most but not all objects; you need 9 to
uniquely cover everybody.
