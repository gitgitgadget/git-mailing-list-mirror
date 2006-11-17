X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-PS1 bash prompt setting
Date: Fri, 17 Nov 2006 04:20:51 -0500
Message-ID: <BAYC1-PASMTP0635A081EAC964E03599B4AEE80@CEZ.ICE>
References: <20061116130111.921396df.seanlkml@sympatico.ca>
	<20061117083801.GB11468@fry.bender.fht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 09:21:15 +0000 (UTC)
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117042051.d2fbddb6.seanlkml@sympatico.ca>
In-Reply-To: <20061117083801.GB11468@fry.bender.fht>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 09:24:19.0656 (UTC) FILETIME=[2906BC80:01C70A2A]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkzu5-00048S-Pc for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755022AbWKQJUy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 04:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbWKQJUy
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:20:54 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:47737 "EHLO
 BAYC1-PASMTP06.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1755017AbWKQJUx (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006
 04:20:53 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 17 Nov 2006 01:24:19 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gkyxu-0008Js-JQ; Fri, 17 Nov 2006 03:20:50 -0500
To: Nicolas Vilz <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 09:38:02 +0100
Nicolas Vilz <niv@iaglans.de> wrote:

> Just a note:
> 
> this doesn't work with bash 3.2. I think they altered the way of
> trimming variables in this version.
> 
> on systems with bash 3.2 installed, i get
> [master!linus-2.6/vm/vm]$ 
> with the example above.
> 
> on systems with bash 3.1, it works properly.

Sorry bout that, I knew it was a bit fragile.  Was rather
comical reading Junio's recent message about all the things not
to do if you want portable shell code and noticing my 6 line script
did 90% of them ;o)  Strange though, I downloaded Bash 3.2
and gave it a try and didn't see the problem here..

Wanna try this small change, to see if it helps? :

#!/bin/bash
BR=$(git symbolic-ref HEAD 2>/dev/null) || { echo "$@" ; exit ; }
BR=${BR#refs/heads/}
REL=$(git rev-parse --show-prefix)
REL="${REL%\/}"
LOC="${PWD%/$REL}"
echo "[$BR!${LOC/*\/}${REL:+/$REL}]$ "
