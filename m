From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support custom build options in config.mak
Date: Tue, 11 Oct 2005 01:07:28 -0700
Message-ID: <7vr7astr27.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 10:08:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPFAk-0005mR-4u
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 10:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVJKIHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 04:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVJKIHc
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 04:07:32 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34761 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751415AbVJKIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 04:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011080720.LXBO4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 04:07:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 11 Oct 2005 09:49:42 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9961>

With this patch, you can store the configuration options like
NO_CURL=YesPlease or NO_OPENSSL=YesPlease into a file named
Make, and I typically do this:

    $ ./Make CFLAGS='-O1 -Wal -g' clean test install

My "Make" file looks like this:

    $ cat Make
    #!/bin/sh

    PATH=/usr/bin:/bin
    LANG=C
    LC_CTYPE=C
    export PATH LANG LC_CTYPE

    make bindir=$HOME/bin/Linux \
         PYTHON_PATH=/usr/bin/python2.4 \
         CFLAGS="${CFLAGS-'-O1 -Wall -g'}" \
         WITH_SEND_EMAIL=YesPlease "$@"

Nothing-to-sign-off-by: Junio C Hamano <junkio@cox.net>
---
  0 files changed.

    Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

    > With this patch, it is possible to store configuration options like
    > NO_CURL=YesPlease or NO_OPENSSL=YesPlease into a file named
    > config.mak, which will be included in the Makefile.

    IOW, I'll have to think about its merit ;-)
