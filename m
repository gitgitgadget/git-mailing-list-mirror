From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Sun, 18 Feb 2007 17:50:50 -0800
Message-ID: <7v7iuedif9.fsf@assigned-by-dhcp.cox.net>
References: <1171838852534-git-send-email-mdl123@verizon.net>
	<Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 02:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIxgQ-0006Ia-Uj
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 02:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXBSBux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 20:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXBSBuw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 20:50:52 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55359 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbXBSBuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 20:50:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219015052.IDTU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 20:50:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RDqr1W00M1kojtg0000000; Sun, 18 Feb 2007 20:50:51 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sorry to be such a PITA, but I really, really think that it is wrong to 
> make a tar dependency here. You said your cygwin has problems with binary 
> files. Could you please try this:
>
> 	$ echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc

It might be just me, but "echo -e" makes me feel much more
uneasy than explicitly saying "Sorry, we require GNU tar in
this little corner of the system".

>> +            bfile=$1
>
> This can contain spaces (you are working on Windows, right? Windows users 
> _love_ spaces in their filenames).

Which is fine.  Try var1=$var2 with something with SP or TAB in var2
and later try running

	$ echo "<$var1>"

to see what happens.

>> +    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1
>
> Here, you rely again on the refs not containing spaces.

Which probably is fine, as refs cannot contain spaces ;-).

>> +    # git-rev-list cannot determine edge objects if a date restriction is
>> +    # given...  we do things a slow way if max-age or min-age are given
>
> Might make sense to teach max-age about boundary commits instead...

You are talking about a rather extensive change, but could be
done.  But that is a separate issue, I think.
