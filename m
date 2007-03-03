From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating attachments using git-format-patch
Date: Sat, 03 Mar 2007 14:49:01 -0800
Message-ID: <7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070303T215950-974@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNd2K-0001pq-J7
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbXCCWtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbXCCWtF
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:49:05 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45564 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbXCCWtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:49:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303224901.NAZH24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 17:49:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WNp21W0091kojtg0000000; Sat, 03 Mar 2007 17:49:02 -0500
In-Reply-To: <loom.20070303T215950-974@post.gmane.org> (Panagiotis Issaris's
	message of "Sat, 3 Mar 2007 21:07:26 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41335>

Panagiotis Issaris <takis.issaris@uhasselt.be> writes:

> I've been trying to start using git-format-patch together with
> git-send-email, but I've encountered some problems. The
> mailinglist I want to send the patches to, requires patches to
> be sent as attachments. So, I tried using the --attach option
> of git-format-patch.

Strictly speaking, I think --attach option is misnamed.  It's
sole purpose is to create a multipart/mixed whose first part is
the commit log message and the second part is the patch text to
help cases where the patch text is not UTF-8 but the log message
is.

We mark the second part inline because it is easier to review if
the patch is shown inline in MUA.

For now, I think you could edit "inline;" to "attachment;".

We could introduce a new option "--inline" that does what the
current "--attach" does, and make "--attach" write "attachment;"
instead of "inline;" there, but that changes the behaviour, and
people who are used to use "--attach" to send out patches to
mailing lists suddenly start sending more cumbersome-to-read
variant, so...
