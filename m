From: Junio C Hamano <junkio@cox.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 13:22:11 -0800
Message-ID: <7v649qrkzg.fsf@assigned-by-dhcp.cox.net>
References: <45E1E47C.5090908@verizon.net>
	<7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
	<7vfy8urngi.fsf@assigned-by-dhcp.cox.net>
	<45E1FC1C.4090409@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 22:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLQp5-0004Cj-ME
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 22:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbXBYVWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 16:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbXBYVWO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 16:22:14 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48244 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965119AbXBYVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 16:22:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225212212.OJVX233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 16:22:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TxNB1W0081kojtg0000000; Sun, 25 Feb 2007 16:22:12 -0500
In-Reply-To: <45E1FC1C.4090409@verizon.net> (Mark Levedahl's message of "Sun,
	25 Feb 2007 16:14:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40577>

Mark Levedahl <mlevedahl@verizon.net> writes:

> ... Is it the case that
> the size info stored in the index reflects the size of the blob rather
> than of the working copy?

The size field among other fields is to cache the last lstat(2)
information so that later "is the path modified?" question can
be answered efficiently.  So the size should in general match
both blob and filesystem but on CRLF filesystems it is compared
against and updated with the data from the filesystem.  There
could be a subtle bug that when updating an index entry we might
be incorrectly storing the size of the blob, but I haven't
checked.
