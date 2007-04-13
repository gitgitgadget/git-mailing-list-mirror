From: Junio C Hamano <junkio@cox.net>
Subject: Re: sha1 of the repo excluding history ?
Date: Thu, 12 Apr 2007 17:24:15 -0700
Message-ID: <7v7ishi0k0.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0704121626i6a27dcecp8b0b10e0f7db2ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 02:24:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc9aO-00006A-9f
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 02:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbXDMAYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 20:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbXDMAYR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 20:24:17 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61921 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbXDMAYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 20:24:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413002416.LHGV1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 20:24:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mQQF1W00z1kojtg0000000; Thu, 12 Apr 2007 20:24:16 -0400
In-Reply-To: <f36b08ee0704121626i6a27dcecp8b0b10e0f7db2ef7@mail.gmail.com>
	(Yakov Lerner's message of "Fri, 13 Apr 2007 02:26:40 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44374>

"Yakov Lerner" <iler.ml@gmail.com> writes:

>    Can I obtain from git the sha1 of the total last state of the
> repo excluding history ? This is a state that covers contents and
> names of all files and dirs, and x perm of files;
> but excludes history, timestamps, ownerhisp, and inode numbers.
>
> That would be approximately like the slow method:
>          'find | egrep -v '/\.git(/|$)' | sort | Xcpio -o | sha1sum -'
> (imagining Xcpio that does not archive any ownership, timestamps,
> and inode numbers). Can I obtain this result immediately from git ?
>
> Yakov

I think you are talking about tree object name.  git-cat-file
commit HEAD and look at "tree xxx" line.

You can use "git tar-tree $tree_object_name" to tar it up,
and "git ls-tree -r $tree_object_name" to list all the blob
object names with their perms.
