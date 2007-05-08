From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 20:39:53 -0700 (PDT)
Message-ID: <57600.59393.qm@web38909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 08 05:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGYQ-0001e1-8i
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967697AbXEHDjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967705AbXEHDjy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:39:54 -0400
Received: from web38909.mail.mud.yahoo.com ([209.191.125.115]:21231 "HELO
	web38909.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S967697AbXEHDjx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 23:39:53 -0400
Received: (qmail 60131 invoked by uid 60001); 8 May 2007 03:39:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=f2a4H70rp1QdJSujxQhPACcLRbrsn1zARMSXsEKPJ5PLMaV6IOQFwfLmy5NojD2LVrOUBhyzSHzNFr0NP2Ypizcn+aLPiKCpuQzJ1cHbYlBhCNjJTcXCtWmwJBjAjPGv3WGSoHHYGsQzVMch7V9TGsk4SjW3zEkR5PXk0w0HMZc=;
X-YMail-OSG: x9lBgycVM1ntXAZpFQNi_LxHgnAmHVy30vZ3J0e9JH6tJpIj3FmahbP8g2x_gIr8K5BMBKem3eaKWKe8bBlyWTKEAgykD3G49.rwmAI9vrUJBI0kOBXQzv4abeF.ag--
Received: from [24.16.125.24] by web38909.mail.mud.yahoo.com via HTTP; Mon, 07 May 2007 20:39:53 PDT
X-Mailer: YahooMailRC/478 YahooMailWebService/0.7.41.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46529>

Sorry for the posting, my email reader sucks.

What is the real issue? Is it that there isn't enough people to maintain gitk? I've been hiding in the bushes, mostly because of time issues, but if there's a real need, I'd be willing to help. I'm a seasoned Tcl/Tk coder, and wouldn't have any problems helping out.

Also, I've been waiting for the git lib to get done. When this gets done, a lot of the procs in gitk can be re-written in 'C' as Tcl commands. This obviously gives the advantage of speed, but since it is written in 'C', the potential maintainership would be larger. The 'C' code would just be dyn loaded into the Tcl interpreter.

As Shawn mentions below, he started using namespaces for git-gui. I think gitk could benefit from that as well, along with a few other changes.


----- Original Message ----
From: Shawn O. Pearce <spearce@spearce.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>; Karl Hasselstr?m <kha@treskal.com>; Junio C Hamano <junkio@cox.net>; Carl Worth <cworth@cworth.org>; Michael Niedermayer <michaelni@gmx.at>; Git Mailing List <git@vger.kernel.org>
Sent: Monday, May 7, 2007 7:03:38 PM
Subject: Re: FFmpeg considering GIT

Paul Mackerras <paulus@samba.org> wrote:
> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK.  Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having to
> do things the object-oriented way.
> 
> Any suggestions?

Funny that you mention this.  Lately I have been hacking on git-gui,
trying to improve it and clean up some of the code.

I've thought about wxWindows but didn't really dig into it to see
how usuable it would be - primary reason is not everyone has it
installed on their system.  The same for GTK and Qt.  Actually I
don't even have GTK installed on my Mac but I did install Qt3
(took half a day!)  so I could build qgit at one point in time.

But almost everyone already has a wish installed.

I've thought about writing git-gui in C, but linking to the Tk
library for the "portable UI".  But not everyone has the Tcl/Tk
development headers and libraries installed, but they probably do
have the wish executable installed.

I want to limit the barrier to entry for git, and that means limiting
the barrier of entry for git-gui.  Keeping our requirements to a
minimum helps.

So I think I've settled on sticking to Tcl and its Tk extensions,
but making more use of newer Tcl constructs like namespaces.  If you
look at my `pu` branch of git-gui I have actually split the program
down into many files, and have started to organize the code in each
into different namespaces, depending on function.

-- 
Shawn.
-
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
