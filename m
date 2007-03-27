From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/workdir: add a simple script to create a working directory
Date: Mon, 26 Mar 2007 21:13:39 -0700
Message-ID: <7v4po7tjbg.fsf@assigned-by-dhcp.cox.net>
References: <7vtzw7tvvv.fsf@assigned-by-dhcp.cox.net>
	<20070327003033.4226.8413.julian@quantumfyre.co.uk>
	<1174963350.6018.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 06:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW344-0006nz-00
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 06:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933963AbXC0ENl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 00:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933964AbXC0ENl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 00:13:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42130 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933963AbXC0ENk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 00:13:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327041340.ARM22511.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 00:13:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fgDf1W00J1kojtg0000000; Tue, 27 Mar 2007 00:13:39 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43226>

Eric Lesh <eclesh@ucla.edu> writes:

> On Tue, 2007-03-27 at 00:15 +0100, Julian Phillips wrote:
>> +# want to make sure that what is pointed to has a .git directory ...
>> +test -d ${orig_git}/.git || die "${original_git} is not a git repository!";
>> +
>
> Shouldn't this be made to work with bare repositories as well?

I think you could enhance Julian's script for that.

But you need to be careful that bare and non-bare repositories
are often of quite different nature.  The script might need to
decide which parts to borrow from the original and which parts
to have in the borrowing repository depending on that.

For example, a bare repository by default does not have reflog,
but a working tree that borrows from the bare repository might
want to enable reflog.  In such a case, creating a symlink to
orig.git/logs/refs would not be sufficient, and you would either
want to enable reflog for the original bare repository and/or
have .git/logs/refs hierarchy as a non-symlinked, real directory
of your own.
