X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sat, 28 Oct 2006 12:04:24 -0700
Message-ID: <7vmz7g8don.fsf@assigned-by-dhcp.cox.net>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
	<BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
	<7vr6wt9enk.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP060BC6AED24731185AD6E5AE050@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 19:04:38 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30388>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdtTq-0004C4-1R for gcvg-git@gmane.org; Sat, 28 Oct
 2006 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751356AbWJ1TE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWJ1TE1
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 15:04:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49352 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751356AbWJ1TE0
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 15:04:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028190425.VUIH28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 15:04:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fv4V1V00C1kojtg0000000 Sat, 28 Oct 2006
 15:04:29 -0400
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> On Fri, 27 Oct 2006 22:45:51 -0700
> Junio C Hamano <junkio@cox.net> wrote:
>
>> Eh, do you mean bisecting asciidoc?  I am not seeing the problem
>> with these on a freshly installed FC6:
>
> Yeah.. don't see the problem here either.  But assuming there
> is some strange interaction with Horst's environment, bisecting
> would narrow it down.  Even though I don't really think bisecting
> will turn up a problem in Git, it might identify the problem in
> the environment.. 

Horst has a non-working combination that is:

 - tip of "master" of the day
 - Fedora rawhide i386 (whatever that is -- sorry I am new to RPM world)
 - asciidoc 7.0.2 3.fc6
 - xmlto 0.0.18 13.1

I have a working combination:

 - tip of "master" of the day
 - FC6 i386 (freshly installed)
 - asciidoc 7.0.2 3.fc6
 - xmlto 0.0.18 13.1

So the difference between me and Horst that can be bisected is
not what are listed above.  I wonder what other things come into
the picture.

"rpm -q --requires" tells us that:

 - asciidoc wants python >= 2.3
 - xmlto wants docbook-dtds, docbook-xsl >= 1.56.0, flex,
   libxslt, passivetex >= 1.11, util-linux, w3m

and here is what I have:

   asciidoc-7.0.2-3.fc6
   xmlto-0.0.18-13.1
   python-2.4.3-18.fc6
   docbook-dtds-1.0-30.1
   package docbook-xsl is not installed
   flex-2.5.4a-41.fc6
   libxslt-1.1.17-1.1
   passivetex-1.25-5.1.1
   util-linux-2.13-0.44.fc6
   w3m-0.5.1-14.1

"rpm -q --whatprovides docbook-xsl" says:

   docbook-style-xsl-1.69.1-5.1

and it is installed on the FC6 box.
