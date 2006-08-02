From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 02 Aug 2006 00:41:52 -0700
Message-ID: <7v7j1rwpmn.fsf@assigned-by-dhcp.cox.net>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608020215470.17230@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 09:42:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8BMm-0000Fn-Ox
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWHBHly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHBHly
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:41:54 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19088 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751307AbWHBHly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 03:41:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060802074153.TBJF12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Aug 2006 03:41:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608020215470.17230@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 2 Aug 2006 02:34:30 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24634>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Although I am admittedly not a big fan of this dependency (it is one thing 
> to depend on perl, but another to depend on compiling C modules for perl), 
> I have to say that on all machines I tested, it works fine now. The only 
> platform I did not test is IRIX, and I'll do that on Friday.

Thanks.

>>    Johannes Schindelin:
>>       Add the --color-words option to the diff options family
>
> BTW I realized it is not really colouring words, since I erroneously 
> selected word boundaries at whitespace. But if the only reaction to this 
> is your "soooooooo strange", I guess you'll drop it...

Perhaps, I dunno.

>>       read-tree --rename and merge-rename
>
> Do you have any numbers on that? I could imagine that merge-recursive 
> could be rewritten as a shell script using this and git-merge-base...

I think "read-tree --rename" is now becoming into a debuggable
shape.

One bad thing about it is that merge-rename uses the usual
merge-one-file, and it loses a rename merge conflict because of
that.  When our branch renames A to B while their branch renames
A to C, "read-tree --rename" notices it and leaves A, B, and C
in stage #1, #2, and #3, but merge-one-file resolves these paths
following the usual 3-way merge rules, resulting A to be removed
and both B and C created.
