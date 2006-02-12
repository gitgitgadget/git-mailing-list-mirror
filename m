From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 10:32:56 -0800
Message-ID: <7vaccwbf6v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602121006360.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:33:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8M1v-00059R-0v
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWBLSdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWBLSdA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:33:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25548 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750798AbWBLSc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 13:32:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212183148.HTY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 13:31:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602121006360.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Feb 2006 10:10:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16008>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 12 Feb 2006, Linus Torvalds wrote:
>> 
>> I actually didn't see any of this trigger in real life, so maybe my 
>> analysis is wrong. Junio? Johannes?
>
> Btw, if it does trigger, the behaviour would be that a subsequent object 
> lookup will fail, because the last old slot would be NULL, and a few 
> entries following it (likely just a couple - never mind that the event 
> triggering in the first place is probably fairly rare) wouldn't have 
> gotten re-hashed down.
>
> As a result, we'd allocate a new object, and have _two_ "struct object"s 
> that describe the same real object. I don't know what would get upset, but 
> git-fsck-index certainly would be (one of them would likely be marked 
> unreachable, because lookup wouldn't find it, but you might have other 
> issues too).

This "fix" makes the symptom that me fire two (maybe three)
Grrrrr messages earlier this morning disappear.  I haven't had
my caffeine nor nicotine yet after my short sleep, so I need to
take some time understanding your explanation first, but I am
reasonably sure this must be it (not that I do not trust you,
not at all -- it is that I do not trust *me* applying a patch
without understanding when I have a bug reproducible).

Thanks.
