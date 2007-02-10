From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 08:46:55 -0800
Message-ID: <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702101049480.1757@xanadu.home>
	<7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702101131070.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvNN-000123-1t
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXBJQq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXBJQq5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:46:57 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40928 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXBJQq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:46:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210164655.HJXR21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 11:46:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Msmv1W00x1kojtg0000000; Sat, 10 Feb 2007 11:46:56 -0500
In-Reply-To: <Pine.LNX.4.64.0702101131070.1757@xanadu.home> (Nicolas Pitre's
	message of "Sat, 10 Feb 2007 11:40:53 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39241>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 10 Feb 2007, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> ...
>> > Because git-status itself is conceptually a read-only operation, and 
>> > having it barf on a read-only file system is justifiably a bug.
>> 
>> I do not 100% agree that it is conceptually a read-only operation.
>
> It is.  It's the technical issue that makes it not so.

I do not think so.  It is a workflow issue that user indicates
the cache cleanliness information does not matter anymore.

Is it wrong for "git-status" to be losing the cache cleanliness
information?  The intended audience of that program is those who
are about to make a commit in the repository, as they are asking
"what would I be committing?"  Up to that point, they may have
cared about the reminder they get from "git diff" that they
edited a file and then ended up reverting the whole edit they
did to that file (I find that empty diff from "git diff" often
very useful, although I felt "Huh?"  when I was new to git).
But when they ask "git status", they care more about the real
change, and at that point (since they feel they may be ready to
make a commit -- and that is the whole point of running
"git-status") they do want to lose the cache cleanliness
information.  So "git-status" to be read-write application to
discard the cache-cleanliness information is probably a good
thing.
