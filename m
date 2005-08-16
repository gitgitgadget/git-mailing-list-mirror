From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 14:02:51 -0700
Message-ID: <7vzmrh8uis.fsf@assigned-by-dhcp.cox.net>
References: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:04:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58aG-0000VQ-4x
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVHPVCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVHPVCx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:02:53 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61668 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932715AbVHPVCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:02:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816210251.FHYE550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 17:02:51 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050816200132.88287.qmail@web26304.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Tue, 16 Aug 2005 13:01:32 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

> It is just a very thin layer above the two git scripts, the only extra work 
> is the cleaning up of some info that git-format-patch-script automatically adds, 
> so that the new commits look like the originals (i.e. same header and description).

> What do you think?

All good.  The existing tools are designed to work well in the
following workflow:

    $ git format-patch --mbox master..pu
    $ cat 000[234]-*.txt >to-apply
    $ git checkout master
    $ git applymbox to-apply
    $ mv .git/refs/heads/pu .git/refs/heads/old-pu
    $ git checkout -b pu master
    $ git applymbox 0001-*.txt

to advance "master" with selected commits, possibly reordered,
from the "pu" branch, and rebase the "pu" branch using the
remaining commits.

I would like to know a bit about "git format-patch" adding extra
info that you needed to get rid of.  It shouldn't be necessary.
