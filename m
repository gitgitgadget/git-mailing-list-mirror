From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 7 May 2006 20:34:58 -0400
Message-ID: <BAYC1-PASMTP08D42DA222BA9843352CC1AEA80@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 02:40:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FctnD-0004mC-6X
	for gcvg-git@gmane.org; Mon, 08 May 2006 02:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWEHAkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 20:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWEHAkE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 20:40:04 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:37093 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751199AbWEHAkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 20:40:01 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 May 2006 17:44:31 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 28727644C28;
	Sun,  7 May 2006 20:40:00 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060507203458.439d8815.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 May 2006 00:44:31.0656 (UTC) FILETIME=[91CDDA80:01C67238]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 7 May 2006 17:05:26 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> So you could have something like
> 
> 	["Origin"]
> 		URL = ...
> 		fetch = master
> 
> and it would just turn it into
> 
> 	branch.Origin.url = ...
> 	branch.Origin.fetch = master
> 

Having magic sections that prepend "branch." seems a bit suspect;
why not just be explicit:

  [branch.Origin]
      URL = ...
      fetch = master

Wouldn't it be reasonable for git to impose modest restrictions on
branch names; such as restricting them to [a-zA-Z0-9] characters?
Then we just have to make section names case sensitve within the
config file; keys could still be case insensitive.

Actually it would be nice if we were consistent.  If case matters to
git then the config file should be case sensitive.  If case doesn't
matter to git, then it should consider "Branch", "branch" and "BrAnCh"
as the same in all contexts (eg. git branch -b BrAnCh).  It seems
silly for us to say people are too dumb to handle case sensitivity
in a config file, but it's perfectly acceptable everywhere else.

Sean
