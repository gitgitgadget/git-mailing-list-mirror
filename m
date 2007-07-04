From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG (or misfeature?)] git checkout and symlinks
Date: Wed, 04 Jul 2007 13:52:32 -0700
Message-ID: <7vabubhoxb.fsf@assigned-by-dhcp.cox.net>
References: <20070704203541.GA13286@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 22:52:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Bq0-0006wy-Ou
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 22:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbXGDUwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbXGDUwe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 16:52:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33044 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbXGDUwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 16:52:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704205231.WSPG3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 16:52:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KYsY1X0041kojtg0000000; Wed, 04 Jul 2007 16:52:32 -0400
In-Reply-To: <20070704203541.GA13286@artemis.corp> (Pierre Habouzit's message
	of "Wed, 4 Jul 2007 22:35:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51640>

Pierre Habouzit <madcoder@debian.org> writes:

>   if in a branch [branch1] you track the file: dir1/file1.c
> and in the branch [branch2] you track elsewhere/file1.c and dir1 be
> symlink on elsewhere, then it's not possible to checkout the branch
> [branch1] if your previous checkout was [branch2]. You have to manually
> remove the symlink `dir1` else git complains that checkouting branch1
> would overwrite dir1/file1.c.
>
>   I'm not sure how to fix this, and it's quite painful actually :)

Yeah, I think our handling of symlinks in both read-tree and
merge-recursive codepath are Ok for symlinks at the leaf level
but not for intermediate levels.  I think we have some patches
in the recent git (post 1.5.1) to fix (perhaps some of) the
issues, though.
