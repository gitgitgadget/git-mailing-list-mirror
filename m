From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 22:30:11 +0100
Message-ID: <200602142230.11442.Josef.Weidendorfer@gmx.de>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97mW-000561-Cd
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWBNVcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWBNVcL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:32:11 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:3308 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1422685AbWBNVcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 16:32:11 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de [131.159.35.57])
	by mail.in.tum.de (Postfix) with ESMTP id 8A46C7AB;
	Tue, 14 Feb 2006 22:32:05 +0100 (MET)
To: Carl Worth <cworth@cworth.org>
User-Agent: KMail/1.9.1
In-Reply-To: <87fymlvgzv.wl%cworth@cworth.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16178>

On Tuesday 14 February 2006 21:10, you wrote:
> How about "git seek" for doing the operations above, and using some
> reserved branch name, (say "seek"). Then, git-bisect could easily be
> built on that, and git-commit could respect the "seek" name and refuse
> to commit to it, (could tell the user how to create the branch
> necessary to commit from the current point).

Why not allow something like

	git-checkout master~5

which implicitly does create a read-only branch "seek-point"?
I do not think that it is important to remember the branch name you seek
from.

A branch could be marked readonly by above command with

	chmod a-w .git/refs/heads/seek

And git-commit should refuse to commit on a readonly ref, telling
the user to create a writable branch before with "git-branch new".

This would also help "cg-seek" to prohibit the user to commit on
"cg-seek-point" via "git-commit" (by setting cg-seek-point read-only).

BTW, "origin" (and any local branch that tracks a remote one) should
be set to readonly this way to signal that these are not developer
branches.

Josef
