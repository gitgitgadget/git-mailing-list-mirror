From: Junio C Hamano <junkio@cox.net>
Subject: Re: git, porcelain, darcs, and version 1.0
Date: Mon, 18 Jul 2005 12:11:25 -0700
Message-ID: <7vslycnd42.fsf@assigned-by-dhcp.cox.net>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
	<42DB341D.6050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 21:12:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dub1l-00048d-Up
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 21:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGRTLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 15:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVGRTLa
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 15:11:30 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33786 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261513AbVGRTL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 15:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718191126.JIGP17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 15:11:26 -0400
To: Bryan Larsen <bryan.larsen@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryan.larsen@gmail.com> writes:

> ... Darcs and git work together to determine the minimal amount
> that needs to go into libgit1.so.  It gets blessed by being
> documented, and doesn't change until libgit2.so.
>
> I'd like to see this added to Junio's list of "1.0" goals.

I should mention that I liked the libification work Brad Roberts
did around late April.  Unfortunately the things have been
always in great flux for the last couple of months, and it was
too hard to include that and maintain it back then.

I fully agree that supporting C-level linkage is worthy, and
should be one of our longer term goals.

> A similar 1.0 goal would be to document porcelain's use of the .git
> directory.  For instance, stacked git uses .git/patches,
> .git/patchdescr.tmpl and .git/patchexport.tmpl.  If Linus does not
> accept a patch documenting this usage, stacked git should use .stgit
> instead.

I agree that coordinating the namespace under $GIT_DIR among
Porcelains is something we need (it was what prompted me to
steal the branches/ convention from Cogito).  The job of the
core should be to help Porcelains avoid stepping on each other's
toes.

The documentation of the internals for $GIT_DIR/patches is
probably better left to StGIT documentation, though, at the
moment.  When other Porcelains start wishing to access the
"series of patches expressed as a set of commit chain" expressed
by StGIT there (e.g. show patch series in addition to regular
commit chain in gitk), the core should help the Porcelains to
work well with each other, to do things in a compatible way.
This may involve moving some common things to core side and
mention the convention for Porcelains to work well together in
the core documentation.

However, I am slightly negative about suggesting these two to be
part of the 1.0 goals.  Linus wanted to make 1.0 how many weeks
ago?  I personally think that a usable baseline, stable enough
to allow stripping out the core part currently shipped as part
of Cogito, would be a good place to stop and declare 1.0.  My
list was meant to enumuerate what might be missing from the
"usable baseline".
