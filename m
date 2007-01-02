From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 01 Jan 2007 19:45:45 -0800
Message-ID: <7vodpiytue.fsf@assigned-by-dhcp.cox.net>
References: <926020.70066.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 04:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ab2-00037X-Cn
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 04:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXABDpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 22:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbXABDpt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 22:45:49 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41578 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbXABDps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 22:45:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102034547.ONMQ2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 22:45:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 63kz1W00K1kojtg0000000; Mon, 01 Jan 2007 22:45:00 -0500
To: ltuikov@yahoo.com
In-Reply-To: <926020.70066.qm@web31802.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Mon, 1 Jan 2007 15:56:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35768>

Luben Tuikov <ltuikov@yahoo.com> writes:

> It is in this sense that I do "cd <branch>; git-pull . <branch>"
> in a sequence, and I'd rather do "cd <branch>; git-pull <symbolic-ref>"
> to define which branch is the merge coming from given the current branch
> _and_ the symbolic ref.

If I am reading you correctly, you have multiple directories,
each with its own .git/ directory but major parts of these .git/
directories are shared (namely, objects/ and refs/).  You would
not be able to have separate checkout in these directories if
you shared .git/HEAD and .git/index, so at least each of these
directories has these two files for its own.

Is that what you are doing?

If that is the case, I think you do not even have to have the
"branch spec" to express the patchflow among them.  Essentially
you are using "one branch, one directory, one repository"
workflow (my understanding is that this is how BK worked but I
haven't seen it) but with your own improvements.  The reason
this is an improvement is because such a shared .git/refs/
allows you to do diff and log across branches this way, so if
you have a separate .git/config just like you already have
separate .git/HEAD and .git/index in these directories, you can
use [remote "xyz"] sections in each of them to achieve what you
called 'symbolic'.
