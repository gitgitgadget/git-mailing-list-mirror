From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Mon, 26 Feb 2007 00:11:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702260009530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 00:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLSWu-0002U3-AQ
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 00:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbXBYXLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 18:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbXBYXLl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 18:11:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:54359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965210AbXBYXLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 18:11:40 -0500
Received: (qmail invoked by alias); 25 Feb 2007 23:11:39 -0000
X-Provags-ID: V01U2FsdGVkX1+/K8Bbxne/J5Be5UzG5/h90/QXoAHdUIZj7tkF8k
	/fAQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40594>

Hi,

On Sun, 25 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This allows you to say
> >
> > 	echo Hello World | git diff x -
> >
> > to compare the contents of file "x" with the line "Hello World".
> > This automatically switches to --no-index mode.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	Since the revision machinery checks for the presence of files,
> > 	diff_populate_filespec() will only change behaviour when there
> > 	is a file "-"... I have yet to think of an elegant fix for that.
> 
> Another thing is that at some point diff_populate_filespec()
> needs to have a way to discard what was cached if memory
> pressure gets tight, and we would want to keep this data read
> from the standard input.

I see this purely for purposes of --no-index diff. And in that case, we 
only compare one file pair. Either one of them is from stdin, or it is 
not. Therefore, if memory gets tight, we cannot compare that file pair 
anyway, and have to error out.

Maybe I missed something obvious?

Ciao,
Dscho
