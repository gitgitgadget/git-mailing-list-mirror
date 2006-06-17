From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-1.4.0 make problems
Date: Sat, 17 Jun 2006 13:56:09 -0700
Message-ID: <7vbqsra4d2.fsf@assigned-by-dhcp.cox.net>
References: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>
	<4493A810.6010706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Somos <somos@grail.cba.csuohio.edu>
X-From: git-owner@vger.kernel.org Sat Jun 17 22:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frhq2-0003dX-NI
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 22:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWFQU4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWFQU4M
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 16:56:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9371 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750892AbWFQU4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 16:56:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617205610.RJEJ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 16:56:10 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4493A810.6010706@lsrfire.ath.cx> (Rene Scharfe's message of
	"Sat, 17 Jun 2006 08:58:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22028>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> | 1) The untar process creates a stray file "pax_global_header".
> | I am using GNU tar v1.13.22 and I get this message :
> |
> | ======================================================================
> | > tar jxf ~/u/source/git-1.4.0.tar.bz2
> | tar: pax_global_header: Unknown file type 'g', extracted as normal
> | file
> | ======================================================================
>
> You can ignore or delete that file.  It is a pax extended global header,
> containing the git commit ID as a comment.  GNU tar started supporting
> pax headers with version 1.13.93 (released 2004-02-23).  Version 1.13.22
> was released on 2001-08-29, by the way.  May I ask what operating system
> and version you are using?

I've been using (in my non-git related project aka day-job)

  git-tar-tree HEAD^{tree} $(PROJECT)-$(RELNAME) >$(PROJECT)-$(RELNAME).tar 

to avoid this.  Although all of my target machines have gtar
that are recent enough so I do not need it, but when the tarball
has version string in its name, there is not much point having
the pax header to identify the contents (where the pax header
shines is when the result does not have the version string in
its name).

This might be a sensible thing to do for our dist target as
well.  The product of our dist target is for people who build
from the source to bootstrap themselves (if they have git, then
fetching the source using git is preferred anyway), as opposed
to using pre-built binaries, so being as friendly as we can to
different implementations of tar is a good thing.
