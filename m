X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: pass --no-left-right to rev-list
Date: Tue, 19 Dec 2006 02:28:31 -0800
Message-ID: <7vac1krxgw.fsf@assigned-by-dhcp.cox.net>
References: <20061219100534.GA9206@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:29:03 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219100534.GA9206@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 Dec 2006 05:05:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34812>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcD9-0000Z8-RA for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932743AbWLSK2d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWLSK2d
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:28:33 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45324 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932743AbWLSK2c (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:28:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219102832.KQCM20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 05:28:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0aUk1W0041kojtg0000000; Tue, 19 Dec 2006
 05:28:44 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think there are three fixes:
>   1. this patch (avoid using left-right)
>   2. gitk can detect and parse the new format
>   3. revert automatic use of left-right
> The third makes the most sense to me.

1. has the problem that it requires the version of Porcelains
and the core to be tightly linked.  2. is nice but unnecessary
burden in the short term.  3. does not break things for anybody,
but if left-right output is useful on the terminal, it burdens
the end-user typing from the command line.

So in the longer term, 2 is probably slightly more preferrable,
but my philosophy is "do not change anything unless absolutely
necessary", so 3 is also sensible, at least in the short term.

Thanks for catching this quickly, before it hit the master.
Let's revert 57612319.
