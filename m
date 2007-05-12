From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow fetching references from any namespace
Date: Sat, 12 May 2007 00:55:23 -0700
Message-ID: <7vveey4gt0.fsf@assigned-by-dhcp.cox.net>
References: <20070511203522.GA2741@steel.home>
	<7vlkfv9j3c.fsf@assigned-by-dhcp.cox.net>
	<20070512074049.GA2410@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 09:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmmRu-00047v-LG
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXELHz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbXELHz0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:55:26 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61554 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbXELHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:55:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512075524.RHBB22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 03:55:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id y7vQ1W0031kojtg0000000; Sat, 12 May 2007 03:55:24 -0400
In-Reply-To: <20070512074049.GA2410@steel.home> (Alex Riesen's message of
	"Sat, 12 May 2007 09:40:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47028>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Fri, May 11, 2007 22:54:47 +0200:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > not only from the three defined: heads, tags and remotes.
>> >
>> > Noticed when I tried to fetch the references created by git-p4-import.bat:
>> > they are placed into separate namespace (refs/p4import/, to avoid showing
>> > them in git-branch output). As canon_refs_list_for_fetch always prepended
>> > refs/heads/ it was impossible, and annoying: it worked before. Normally,
>> > the p4import references are useless anywhere but in the directory managed
>> > by perforce, but in this special case the cloned directory was supposed
>> > to be a backup, including the p4import branch: it keeps information about
>> > where the imported perforce state came from.
>> 
>> Have no objection to the patch itself, but mind pointing out
>> where we broke it (I suspect it is around 1.5.0)?
>> 
>
> Maybe even much earlier. According to
>
>     git log -p --decorate -- git-fetch-script git-parse-remote-script
>
>     commit ac4b0cff00b7629657e61a1d6e1f1a1250d03198
>     Author: Junio C Hamano <junkio@cox.net>
>     Date:   Sat Aug 20 02:52:24 2005 -0700
>
> 	[PATCH] Start adding the $GIT_DIR/remotes/ support.

Sounds like it is not even a regression but just was not
supposed to work from the beginning.

Not that I think lifting that restriction is a bad idea,
though.
