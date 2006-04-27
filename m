From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to trace the patch?
Date: Thu, 27 Apr 2006 08:55:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604270843190.3701@g5.osdl.org>
References: <6d6a94c50604270306j44c280bdo283591f2f595f74e@mail.gmail.com>
 <BAYC1-PASMTP029B6CB13A6C0BA3956E17AEBD0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aubrey <aubreylee@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 17:56:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ8qi-0007OF-Tk
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWD0P4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWD0P4I
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 11:56:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965157AbWD0P4H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 11:56:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RFtqtH020306
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 08:55:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RFtphC001888;
	Thu, 27 Apr 2006 08:55:52 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP029B6CB13A6C0BA3956E17AEBD0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19236>



On Thu, 27 Apr 2006, sean wrote:
> 
> $ git log -- <filename>
> 
> To see a list of commits that affected the file you're interested in.
> 
> $ git log -p -- <filename>
> 
> Will include a diff after each commit showing you how the file was
> changed.  And if you want to see what other changes happened in each
> commit that modified your file, add "--full-diff" to the command above.

Side note: the "git log -p" thing only works with git 1.3.0+, and even 
without the "-p", old versions will be very slow.

So if you have anything older than 1.3.0, you're likely better off using 
"git whatchanged [-p] -- <filename>".

Also, regardless of which one you use, it's worth pointing out that:

 - for tracking multiple files, just use more than one filename, and you 
   can also use a directory name. 

 - you can combine this with all the normal revision limiting rules, which 
   is often useful when you know you're not interested in stuff you've 
   already seen.

For example, if you have just done a "git pull" and you noticed that a 
file (or set of files) you cared about changed - or you just wonder _if_ 
it changed - you can do something like

	gitk ORIG_HEAD.. -- drivers/scsi/ include/scsi/

to see what changed due to the pull within those files. Useful whether 
you're tracking certain subsystems, individual drivers, architectures, 
whatever.. It can be useful also just to split the logs up (ie maybe 
you're not interested in anything in particular, but you do a "git log" 
and see something that strikes your fancy, you can decide to see what 
_else_ changed in that area).

And instead of "gitk", use "git log -p" or "git whatchanged" or whatever. 
It's all the same thing, just different ways of looking at it.

		Linus
