From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] Fix t1500 for sane work-tree behavior
Date: Fri, 27 Jul 2007 13:51:48 -0700
Message-ID: <7v8x91y3h7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271958590.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:52:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWnP-0001qh-7W
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764178AbXG0UwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764043AbXG0UwG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:52:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42201 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764178AbXG0UwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:52:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727205149.GYCE7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 16:51:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ukro1X00U1kojtg0000000; Fri, 27 Jul 2007 16:51:49 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53968>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When GIT_DIR=../.git, and no worktree is specified, it is reasonable
> to assume that the repository is not bare, that the work tree is ".."
> and that the prefix is the basename of the current directory.
>
> This is the sane behavior.

That is a bit too strong blanket statement, while being weak on
exact conditions, giving only one example.

It makes me wonder...

  * When GIT_DIR=../../.git, and no worktree is specified, the
    same holds true, with worktree is "../.."? (probably yes)

  * "GIT_DIR=../../foo/.git"? (I dunno)

  * "GIT_DIR=../foo.git"? (probably not)

I am assuming that you meant something like this:

    When no worktree is specified, and GIT_DIR (or --git-dir=) is
    zero or more "../" followed by ".git" after stripping trailing
    and/or redundant slashes, it is reasonable to assume that the
    repository is not bare, and the work tree is the parent
    directory of the GIT_DIR directory.

but that requires guesswork if you give only one example and let
the readers to guess.
