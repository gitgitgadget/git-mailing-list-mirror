X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 13:53:52 -0800
Message-ID: <7vzm9zqsnj.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	<7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	<20061207192632.GC12143@spearce.org>
	<7vhcw7scln.fsf@assigned-by-dhcp.cox.net>
	<20061207202931.GB12502@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 21:54:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207202931.GB12502@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Dec 2006 15:29:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33637>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRCG-0002aY-4W for gcvg-git@gmane.org; Thu, 07 Dec
 2006 22:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163466AbWLGVxy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 16:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163465AbWLGVxy
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 16:53:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48924 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163460AbWLGVxx (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 16:53:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207215353.HBDV9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 16:53:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vxu21V0121kojtg0000000; Thu, 07 Dec 2006
 16:54:03 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> What may help (and without using assume unchanged) is:
>
>  * skip the `update-index --refresh` part of git-status/git-commit
>  * skip the status template in COMMIT_MSG when using the editor
>
> As Git will still at least make sure a `commit -a` includes
> everything that is dirty.
>
> Files whose modification dates may have been messed with (but
> whose content are unchanged) will just go through expensive SHA1
> computation to arrive at the same value, which is fine.
>
> Users skipping the first part are doing so under the assumption that
> their modification dates are usually always correct, and that then
> they aren't the SHA1 computation of a handful of files is cheap
> compared to stat'ing the entire set of files.
>
> Users skipping the second part are doing so under the assumption
> that knowing the names of the files they are committing doesn't
> really improve their odds of writing a good commit message.

The second part is not about a good commit message but more
about a path that should have been updated but forgotten (the
same mistake you would be likely to make and that is the reason
assume-unchanged is not good for you).

I do not mind too much if you added a new --quick option to "git
commit" for this rather specialized need.
