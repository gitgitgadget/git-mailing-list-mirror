From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: Re: [PATCH] Add DEST Makefile variable
Date: Thu, 21 Apr 2005 15:59:45 -0700
Message-ID: <7vr7h3d9cu.fsf@assigned-by-dhcp.cox.net>
References: <20050421123904.9F2EB7F8AD@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:56:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOka9-0002aB-Ap
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDUW76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDUW76
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:59:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:32734 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261573AbVDUW7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:59:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421225944.RGWU7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 18:59:44 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050421123904.9F2EB7F8AD@smurf.noris.de> (Matthias Urlichs's
 message of "Thu, 21 Apr 2005 22:39:04 +1000 (EST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MU" == Matthias Urlichs <smurf@smurf.noris.de> writes:

MU>  # (my ext3 doesn't).
MU>  CFLAGS=-g -O3 -Wall
MU> +DEST=$(HOME)/bin
 
MU>  install: $(PROG) $(GEN_SCRIPT)
MU> -	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(HOME)/bin/
MU> +	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DEST)/
 
I sent essentially the same some time ago and got a comment to
follow established naming convention.

Many people seem to call What you are calling DEST above BINDIR
and DEST or DESTDIR usually means something completely
different.  It goes like this:

    # DESTDIR=
    BINDIR=$(HOME)/bin

    install:
            install foobar $(DESTDIR)$(BINDIR)/

  $ su ;# personal machine install by local root
  # make BINDIR=/usr/local/bin install

  # binary package creation
  $ make BINDIR=/usr/bin DESTDIR=/var/tmp/tmp-inst install
  $ tar Ccf /var/tmp/tmp-inst tarball.tar.gz .

