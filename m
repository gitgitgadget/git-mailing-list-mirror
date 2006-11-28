X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: Mozilla, git and Windows
Date: Tue, 28 Nov 2006 13:30:08 +1300
Message-ID: <456B8310.5020102@vilain.net>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 00:30:38 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32470>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goqrg-0004ZV-M4 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934432AbWK1AaV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934440AbWK1AaV
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:30:21 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56448 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S934432AbWK1AaU (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:30:20 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id E03D91398CD;
 Tue, 28 Nov 2006 13:30:17 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id DB2AE1398CB; Tue, 28
 Nov 2006 13:30:10 +1300 (NZDT)
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Jon Smirl wrote:
> In the other thread we are discussing the conversion of Mozilla CVS to
> git format. This is something that has to be done but it is not the
> only issue. Without a native Windows port they won't even consider
> using git. There is also the risk that the features needed by Mozilla
> will be completed after they choose to use a different SCM.
>
> Even if we implement all of the needed features git still needs to win
> the competition against the other possible choices. The last I heard
> the leading candiate is SVN/SVK.

Jon,

When I met clkao in August to discuss the possibility of using git as a
depot for SVK, he seemed very open to the idea, and we worked on an
initial plan for this.  This should eventually allow svk to be used as a
porcelain, which might make it more palatable to the Windows crowd.

However that doesn't solve the Windows porting issue - it would still
need to access the repository.

I've been working on and off on an abstraction to git, in Moose (perl 6
objects on perl 5) - what's working so far is making core objects, and
producing correct checksums.

You can see this early implementation at
http://utsl.gen.nz/gitweb/?p=VCS-Git

What I've found is that I need a good abstraction of UNIX pipelines that
is as portable as Perl, so that I can prototype the code basing it on
setting up command pipelines on UNIX, and have it gracefully degrade to
either using temporary files on Windows, or threading if portions are
re-implemented using Perl (or a ported libgit).  I am currently working
on this and hope to have a release by the end of the week, though I will
not have tested the Windows portability by then.

I would love it if anyone interested in the project would like to help
me complete the OO-based API, provide tests, documentation, or any kind
of feedback really.

