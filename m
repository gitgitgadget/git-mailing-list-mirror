From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix compilation
Date: Thu, 06 Jul 2006 17:15:31 -0700
Message-ID: <7vmzbm46e4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607070120590.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 02:15:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fye0P-0008MV-0Y
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 02:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWGGAPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 20:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWGGAPd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 20:15:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2781 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751096AbWGGAPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 20:15:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707001532.KNLS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Jul 2006 20:15:32 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607070120590.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 7 Jul 2006 01:21:57 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23410>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Without this, make 3.79.1 (Darwin) says
>
> rm -f git-archimport git-archimport+
> INSTLIBDIR=`make -C perl -s --no-print-directory instlibdir` && \
> sed -e '1s|#!.*perl|#!/usr/bin/perl|1' \
>     -e '2i\
>         use lib (split(/:/, $ENV{GITPERLLIB} || '\'"$INSTLIBDIR"\''));' \
>     -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
>     -e 's/@@GIT_VERSION@@/1.4.1.gb564-dirty/g' \
>     git-archimport.perl >git-archimport+
> sed: 1: "2i use lib (split(/:/,  ...": command i expects \ followed by text
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Traditionally 'i' and 'a' command to sed has been unfriendly
with make, primarily because different make implementations did
unexpected things to backslashes at the end of lines.

For portability I would even suggest making that command into a
separate helper shell script, and call that from the Makefile.

> 	Note that this just fixes compilation, not the tests. All of
> 	a sudden, I have to install Scalar::Util, where things were
> 	fine before Git.pm.

I recall Pasky talking about Scalar::Util removal and I thought
I took a patch.

 ... goes "git grep" ...

Ah the private edition of Error.pm pulls that in.  Sheesh.
