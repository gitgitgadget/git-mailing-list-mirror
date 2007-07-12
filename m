From: Gerrit Pape <pape@smarden.org>
Subject: Re: pull-fetch-param.txt (was Re: [PATCH] escape tilde in Documentation/git-rev-parse.txt)
Date: Thu, 12 Jul 2007 13:06:31 +0000
Message-ID: <20070712130631.13667.qmail@594d46613ccd9b.315fe32.mid.smarden.org>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> <7vhcymt07a.fsf@assigned-by-dhcp.cox.net> <452211C2.8020402@s5r6.in-berlin.de> <7vven1rfpj.fsf@assigned-by-dhcp.cox.net> <45222B18.1090305@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 15:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yN7-0007he-FL
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763742AbXGLNGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763743AbXGLNGN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:06:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:38777 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763742AbXGLNGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:06:12 -0400
Received: (qmail 13668 invoked by uid 1000); 12 Jul 2007 13:06:31 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45222B18.1090305@s5r6.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52282>

On Tue, Oct 03, 2006 at 11:19:20AM +0200, Stefan Richter wrote:
> Junio C Hamano wrote:
> > It's a bit sad that asciidoc's nicer quoting features
> > are not backward compatible.
> 
> Yes, this is awkward. Here comes the next candidate for quoting.
> In pull-fetch-param.txt:
> 
> ----8<----
> <refspec>::
> 	The canonical format of a <refspec> parameter is
> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
> 	by the source ref, followed by a colon `:`, followed by
> 	the destination ref.
> +
> The remote ref that matches <src>
> is fetched, and if <dst> is not empty string, the local
> ref that matches it is fast forwarded using <src>.
> Again, if the optional plus `+` is used, the local ref
> ---->8----
> 
> "man git-fetch" and "man git-pull" show:
> ----8<----
>        <refspec>
>               The  canonical  format of a <refspec> parameter is ?<src>:<dst>;
>               that is, an optional plus, followed by the source ref,  followed
>               by a colon :, followed by the destination ref.
> 
>               The  remote  ref  that matches <src> is fetched, and if <dst> is
>               not empty string, the local ref that matches  it  is  fast  for-
>               warded  using  <src>. Again, if the optional plus + is used, the
> ---->8----

Hi, this still is a problem, at least on Debian/unstable; with asciidoc
8.2.1, the git-push(1) and git-fetch(1) man pages have this 'broken'
refspec description[0].

Additionally there're problems with callouts, whereever <n> is used to
refer to a callout list, it renders broken man pages[1], e.g.:

 $ man git-reset
 [...]
 EXAMPLES
        Undo a commit and redo
 
                $ git commit ...
                $ git reset --soft HEAD^      \fB(1)\fR
                $ edit                        \fB(2)\fR
                $ git commit -a -c ORIG_HEAD  \fB(3)\fR
            .sp \fB1. \fRThis is most often done when you remembered what you
            just committed is incomplete, or you misspelled your commit
            message, or both. Leaves working tree as it was before "reset".
 
            .br \fB2. \fRmake corrections to working tree files.
 
            .br \fB3. \fR"reset" copies the old head to .git/ORIG_HEAD; redo
            the commit by starting with its log message. If you do not need to
            edit the message further, you can give -C option instead.
 
            See also the --amend option to git-commit(1).
 
            .br
 
        Undo commits permanently
 
                $ git commit ...
                $ git reset --hard HEAD~3   \fB(1)\fR
            .sp \fB1. \fRThe last three commits (HEAD, HEAD^, and HEAD~2) were
            bad and you do not want to ever see them again. Do not do this if
            you have already given these commits to somebody else.
 
            .br
 
        Undo a commit, making it a topic branch
 [...]


Regards, Gerrit.

[0] http://bugs.debian.org/432560
[1] http://bugs.debian.org/420114
