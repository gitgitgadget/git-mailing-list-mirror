From: Junio C Hamano <junkio@cox.net>
Subject: Re: reversible binary diff
Date: Fri, 25 Aug 2006 19:14:37 -0700
Message-ID: <7vr6z4450y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608252050140.3683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 26 04:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGngy-00075q-0G
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 04:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWHZCOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 22:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422958AbWHZCOZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 22:14:25 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38528 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422957AbWHZCOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 22:14:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826021421.FZKD6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 Aug 2006 22:14:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo02.cox.net with bizsmtp
	id ESEM1V00L4Noztg0000000
	Fri, 25 Aug 2006 22:14:21 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608252050140.3683@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 25 Aug 2006 21:04:46 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26026>

Nicolas Pitre <nico@cam.org> writes:

> I just noticed that the binary diff format was augmented in order to 
> carry the reverse diff information.
>
> Why was this needed?
>
> I mean, if you want to reverse a binary diff you only need to retrieve 
> the original blob the forward diff was meant to apply against, and it is 
> certainly already available in the object store if the forward diff has 
> been previously applied.  Or has this assumption been wrong for some 
> work flow?

It's been wrong all along, but I do not think it practically
matters because I haven't seen anybody exchange binary diffs
back and forth.

As long as you use patch to switch between states inside the
repository the patch originates from, it is not needed.  The
change is just there for completeness.

But if you are sending a patch to somebody else, you would need
the reverse information.  t/t4116 test needs to be updated to
use separate repository that has only preimage and apply a patch
in reverse there to validate the correct operation.  The log
message for the commit that introduced the test mentions it, but
nobody noticed and took hint ;-).
