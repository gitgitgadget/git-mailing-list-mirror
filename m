From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 21:34:45 -0400
Message-ID: <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:40:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcujF-0006lA-R2
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWEHBjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWEHBjv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:39:51 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:4957 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932248AbWEHBjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 21:39:51 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 May 2006 18:39:48 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6CA27644C28;
	Sun,  7 May 2006 21:39:47 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060507213445.66a2a3b0.seanlkml@sympatico.ca>
In-Reply-To: <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 01:39:48.0707 (UTC) FILETIME=[4AEBAB30:01C67240]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 07 May 2006 18:27:32 -0700
Junio C Hamano <junkio@cox.net> wrote:


> How about keeping the default syntax as it is (tokens are case
> insensitive and alnums only, dot separates tokens into
> sections), and when a token that violates that rule needs to be
> spelled out, require quoting, so:
> 
> 	branch.foo	BranCh.FoO	branch.FOO
 
> are the same (section "branch.foo"),

Doesn't that mean you have to then prohibit creating mixed
case branches with "git branch" and "git checkout -b" ?

> and if I have js/fmt.patch
> branch, I need to spell the configuration for that branch like
> so:
> 
> 	branch."js/fmt.patch"	or   "branch.js/fmt.patch"        
> 
> and the URL variable for that section is
> 
> 	$ git repo-config '"branch.js/fmt.patch".url'

How about transforming slashes into dots?  so the above would 
be:

   [branch.js.fmt.patch]

      And could be accessed by either:

    $ git repo-config branch.js.fmt.patch
    $ git repo-config branch.js/fmt.patch

> (BTW, you could even have a variable with dots in it by quoting
> the variable name, like "branch.js/fmt.patch"."fetch.option"; I
> do not know if it is worth it).

Not worth it.  Branch names should be alnums and imho should be
case sensitive too.
 
> My repository is full of topic branches that are named xx/yyyy.
> It is very handy to be able to say "show-branch --topics master
> 'heads/??/*' next" which would not show my other branches like
> "test", "throwaway", "rework", "temp", etc.

Very nice.

Sean
