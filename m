From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 01:39:43 -0700
Message-ID: <7vtzt4wd68.fsf@assigned-by-dhcp.pobox.com>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
	<20070619071916.GC9177@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 19 10:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0ZFa-0007lX-L4
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 10:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbXFSIjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbXFSIjp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 04:39:45 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56915 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbXFSIjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 04:39:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070619083944.DQUL3133.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 19 Jun 2007 04:39:44 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DLfj1X0081kojtg0000000; Tue, 19 Jun 2007 04:39:44 -0400
In-Reply-To: <20070619071916.GC9177@thunk.org> (Theodore Tso's message of
	"Tue, 19 Jun 2007 03:19:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50458>

Theodore Tso <tytso@mit.edu> writes:

> Actually, the bigger missing gap is merges.  Suppose in the
> development branch, you rename a whole bunch of files.  (For example,
> foo_super.c got moved to foo/super.c, foo_inode.c got moved to
> foo/inode.c, etc.)
>
> Now suppose there are fixes made in the stable branch, in the original
> foo_super.c and foo_inode.c files.  Ideally you would want to be able
> to pull those changes into the development branch, where the files
> have new names, and have the changes be applied to foo/super.c and
> foo/inode.c in the development branch.

That happens already with merge-recursive code, which has been
the default since late November 2005 (v0.99.9k and later should
have it).

What does _not_ happen is if foo_fixes.c was _created_ in the
stable branch.  A merge that tries to forward port such a fix
would not move the foo_fixes.c to foo/fixes.c.
