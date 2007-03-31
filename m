From: Junio C Hamano <junkio@cox.net>
Subject: Re: Did I miss something? git-clone doesn't grab all branches????
Date: Fri, 30 Mar 2007 18:30:18 -0700
Message-ID: <7v1wj6yzbp.fsf@assigned-by-dhcp.cox.net>
References: <460D336E.9040708@freescale.com>
	<AF0367BA48C55940A43CCF08DF35553C0114148C@az33exm24.fsl.freescale.net>
	<460D42FE.1080703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Loeliger Jon-LOELIGER <jdl@freescale.com>, git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 03:30:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXSQg-0007QN-7i
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 03:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbXCaBaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 21:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933290AbXCaBaV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 21:30:21 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56883 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbXCaBaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 21:30:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331013020.MFWS28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 30 Mar 2007 21:30:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hDWJ1W0071kojtg0000000; Fri, 30 Mar 2007 21:30:18 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43522>

Timur Tabi <timur@freescale.com> writes:

> In the past, my clone of paulus/powerpc.git contained everything.
> Every time I did a git-pull, it would grab everything.  Then I could
> do a local clone/checkout if I ever wanted to work on a branch (like
> for-2.6.22).  I didn't have to know the names of the branches when I
> did git-clone.

If that is how you use multiple trees, I think you can make that
"My central repository which is a mirror of Paulus" a bare
repository clone; keep updating it with git-fetch instead as a
bare repository does not have an associated working tree.

	( setup )

	$ git clone --bare git://git.kernel.org/.../ paulus-mirror.git

	( periodical mirror update from upstream )

        $ cd paulus-mirror.git && git fetch

	( forking off your play area )

	$ git clone -l -s paulus-mirror.git foobranch.git
        $ cd foobranch.git
        $ git checkout --track -b foobranch origin/foobranch
	$ hack hack

	( after mirror update )
        $ cd foobranch.git
        $ git pull ;# this pulls from your mirror
