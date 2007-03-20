From: Junio C Hamano <junkio@cox.net>
Subject: Re: relocating the binaries
Date: Tue, 20 Mar 2007 00:45:05 -0700
Message-ID: <7v8xds9x4u.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0703200012o6f479defs6a8edc8fb1179b8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 08:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTZ1s-0007oT-Di
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 08:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbXCTHpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 03:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbXCTHpH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 03:45:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36797 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbXCTHpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 03:45:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320074504.RCFT321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 03:45:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cvl51W0061kojtg0000000; Tue, 20 Mar 2007 03:45:05 -0400
In-Reply-To: <f36b08ee0703200012o6f479defs6a8edc8fb1179b8c@mail.gmail.com>
	(Yakov Lerner's message of "Tue, 20 Mar 2007 09:12:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42727>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> Let's say the git binaries were built with prefix=/usr/local.
> I wanto to copy them (relocate) to other machine under
> $HOME/run. WHich env.var. do I set to tell the git binaries  that
> it's new prefix is $HOME/run ? nb: i'm not talking about rebuild.

See INSTALL.

 - You can use git after building but without installing if you
   wanted to.  Various git commands need to find other git
   commands and scripts to do their work, so you would need to
   arrange a few environment variables to tell them that their
   friends will be found in your built source area instead of at
   their standard installation area.  Something like this works
   for me:

	GIT_EXEC_PATH=`pwd`
	PATH=`pwd`:$PATH
	GITPERLLIB=`pwd`/perl/blib/lib
	export GIT_EXEC_PATH PATH GITPERLLIB

GIT_EXEC_PATH won't be `pwd` but wherever you will take git-*
binaries to; adjust GITPERLLIB too accordingly.
