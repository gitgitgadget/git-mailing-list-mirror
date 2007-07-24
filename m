From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 01:15:29 +0200
Message-ID: <20070724231529.GA29156@steel.home>
References: <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net> <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241337470.14781@racer.site> <46A5FDF0.3060801@trolltech.com> <Pine.LNX.4.64.0707241431540.14781@racer.site> <46A63EAA.6080203@trolltech.com> <Pine.LNX.4.64.0707241923450.14781@racer.site> <46A654A6.5070802@trolltech.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDTbk-0008KO-Uk
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 01:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889AbXGXXPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757158AbXGXXPj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 19:15:39 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16612 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761893AbXGXXPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 19:15:33 -0400
Received: from tigra.home (Fa855.f.strato-dslnet.de [195.4.168.85])
	by post.webmailer.de (mrclete mo52) (RZmta 10.1)
	with ESMTP id B04cf5j6OHjcvd ; Wed, 25 Jul 2007 01:15:30 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43168277BD;
	Wed, 25 Jul 2007 01:15:30 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C9C01BDD0; Wed, 25 Jul 2007 01:15:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A654A6.5070802@trolltech.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggT2BuA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53657>

Marius Storm-Olsen, Tue, Jul 24, 2007 21:36:06 +0200:
> IMO Windows user expect files to be DOS style, since all other files
> are.  Yes, most newer tools 'handle' Unix style files, but creating new
> ones will mostly be DOS style. Some will actually wreak havoc on your
> files, and start adding DOS line endings in the middle of your Unix line
> ending file. I've seen it happen. So, dealing with Unix style text files
> on Windows can be a problem for some people.

I have to stay with Windows, but I'd absolute hate having their stupid
line-ending by default. As will my project supervisor, and he gets
changes from something like 300 developers. You will definitely get
their votes against changing the default

> > Git is really slowed down tremendously just by the fact that it runs on 
> > Windows.  You should not add to that.
> 
> The auto crlf conversion is not the slow down here, and the time spent
> there is negligible. I use autocrlf on all my repos on Windows, and
> don't notice it. Filestat'ing on the other hand.. :-)

Of course you wont notice it: you're already on Windows.

> > IMHO in most cases -- even on Windows -- you do not want to set autocrlf 
> > at all.  Because you do not need to store the file different from the 
> > version you have in the working tree.
> 
> Not true. I believe, especially at the moment, most Git users on Windows
> are mostly developing code in a cross-platform manner, and therefore
> care about this problem.

Yes. They solve it by working fulltime in \n-lineending. Avoiding that
stupid Visual Studio and Notepad helps too.

> > The only situation where I think it makes sense, is when you have both 
> > Windows and Unix developers, _and_ your Windows tools sometimes produce 
> > CR/LF stupidly.  But then I'd set it to "input".
> 
> That's ok _now_, because most of the Git user group is experienced
> developer that understand the problem. I'm trying to see past that
> state, and prepare Git for more 'common' usage on Windows. They'd expect
> text files on Windows to be handled correctly, without any fuzz.

Just make the windows installer to setup templates for CR/LF depending
on checkbox "[ ] I am Windows idiot, standard issue".

> No tweaking of config options to make it work on Windows. No problems
> with sharing repositories with Unix developers. Just work. That's not
> the current state. But it could be.

It is for me. It will not be that with your suggested default.

> Ok, I come from the Perforce world, so here how it works there:
> 1) Files are stored with Unix line endings in the repository.
> 2) Conversion is done on Windows (and older Macs) upon checkout, if the
> file is a text file.
> 3) It has binary file detection when you add it to the depot, so if you
> and to add a DOS line ending file to the repo, you have to mark it as a
> binary file manually

You always setup the lineending conversion in perforce. For each and
every client. There is no default. I just don't see what to learn from
them (if there ever was something to learn from).

> ... And Git would probably be adapted on
> Windows more quickly, which this is all about. :-) IMHO.

It is hardly worth it. Git already has to put up with ugly workarounds
just because of the stupidities coming from that windows. It has had
seldom any benefit from supporting this !@#$ing awkward platform.
