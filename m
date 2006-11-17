X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 17:49:10 -0800
Message-ID: <7vejs2zvu1.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<20061116051240.GV7201@pasky.or.cz>
	<7vr6w33vv3.fsf@assigned-by-dhcp.cox.net>
	<20061116222008.GA7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 01:53:04 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116222008.GA7201@pasky.or.cz> (Petr Baudis's message of
	"Thu, 16 Nov 2006 23:20:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31659>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gksr2-00054k-Rb for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424691AbWKQBtR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424892AbWKQBtR
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:49:17 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:24568 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1424691AbWKQBtR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:49:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117014911.MXJL97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 20:49:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ndpH1V00b1kojtg0000000; Thu, 16 Nov 2006
 20:49:18 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

You already said this kind of details are subjective so I'd omit
the usual "I would think" and answer them without worrying about
a big style flamewar.  People, please be civil ;-).

> What about [ instead of test?

[ ] is not more readable.

> 	if foo; then
>
> instead of
>
> 	if foo
> 	then

Having "then" on the beginning of line is much more readable.

> Am I the only one who hates
>
> case "$log_given" in
> tt*)
>         die "Only one of -c/-C/-F can be used." ;;
> *tm*|*mt*)
>         die "Option -m cannot be combined with -c/-C/-F." ;;
> esac

This is much more readable without "case".  "abandon the old
rule that told us to avoid if when case would do" applies.
Although it is about multiple possibility switch (so a case can
be made that "case" is appropriate here), we should reduce the
use of "case" to cases like the outermost big "case" you find in
git-merge-one-file-script.

> It would be really great if Git would have something alike the Cogito's
> optparse infrastructure. I'm not sure if you can implement it in Bourne
> sh with reasonable performance, though...

getopt(1) is fine, unless somebody screams that it is not
available on his platform.
