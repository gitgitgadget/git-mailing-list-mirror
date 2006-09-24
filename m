From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sun, 24 Sep 2006 10:47:29 -0700
Message-ID: <7vodt59mxa.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
	<20060924000051.GI20017@pasky.or.cz>
	<7virjem3tp.fsf@assigned-by-dhcp.cox.net>
	<20060924111737.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRY4s-0001FS-IE
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWIXRrc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWIXRrc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:47:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12981 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWIXRra (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 13:47:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924174730.MEUO26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 13:47:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SHnX1V00j1kojtg0000000
	Sun, 24 Sep 2006 13:47:32 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060924111737.GL20017@pasky.or.cz> (Petr Baudis's message of
	"Sun, 24 Sep 2006 13:17:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27684>

Petr Baudis <pasky@suse.cz> writes:

> Hmm, well, what's curious is that the documentation says
>
> 	Every commit with a changeset that doesn't exist in the other branch
> 	has its id (sha1) reported, prefixed by a symbol.  Those existing only
> 	in the <upstream> branch are prefixed with a minus (-) sign, and those
> 	that only exist in the <head> branch are prefixed with a plus (+)
> 	symbol.
>
> which is in contradiction of Ilpo's description of the old algorithm
> (and also your description of it). It would seem he just wants to fix it
> according to the documented behaviour.
>
> I guess the documentation is what's broken then?

Ah I did not realize that, but yes the documentation is
incorrect.

I wonder if we can kill it by introducing a new rev notation and
using regular rev-list family of commands instead.

What we want here is a way to say "give me commits that are in B
but not in A, but before returning a commit see if there is an
equivalent change in the set of commits that are in A but not in
B, and filter it out".

Time for "rev-list A....B"? ;-)
