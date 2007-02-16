From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix incorrect diff of a link -> file change if core.filemode = false.
Date: Fri, 16 Feb 2007 15:13:21 -0800
Message-ID: <7vejop1ysu.fsf@assigned-by-dhcp.cox.net>
References: <200702170009.02500.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 17 00:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HICGc-0002vE-5W
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 00:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946281AbXBPXNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 18:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXBPXNX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 18:13:23 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48515 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXBPXNW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 18:13:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216231322.TRBE1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 18:13:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QPDM1W00l1kojtg0000000; Fri, 16 Feb 2007 18:13:22 -0500
In-Reply-To: <200702170009.02500.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 17 Feb 2007 00:09:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39958>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> After this sequence:
>
> $ ln -s foo A
> $ git add A
> $ git commit -m link
> $ rm A && echo bar > A
>
> the working copy contains a regular file A but HEAD contains A as a link.
>
> Normally, at this point 'git diff HEAD' displays this change as a removal
> of the link followed by an addition of a new file. But in a repository where
> core.filemode is false this is displayed as a modification of the link.
> The reason is that the check when the cached mode is allowed to override the
> file's actual mode is not strict enough.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>

I do not follow.  core.filemode aka trust_executable_bit is
about executable bit and not symlink.
