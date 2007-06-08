From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Date: Fri, 08 Jun 2007 03:33:40 -0700
Message-ID: <7vfy52ka63.fsf@assigned-by-dhcp.cox.net>
References: <20070608100831.GA2335@cip.informatik.uni-erlangen.de>
	<7vodjqkazp.fsf@assigned-by-dhcp.cox.net>
	<20070608102113.GB2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwbnP-0001W4-Fo
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937922AbXFHKdn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934345AbXFHKdn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:33:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33492 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbXFHKdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 06:33:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608103341.DVR25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 06:33:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yZg1X00K1kojtg0000000; Fri, 08 Jun 2007 06:33:41 -0400
In-Reply-To: <20070608102113.GB2335@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Fri, 8 Jun 2007 12:21:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49457>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> I see it. Last line. I tried to clone from a repository which itself had a
> detached HEAD. Could that be the problem?

Ah, our mails crossed.

There is no reason to forbid cloning of a repository whose HEAD
is detached, but detached HEAD is a relatively recent invention,
and I would not be surprised if that was indeed the breakage,
nor nobody has hit this so far.

It's sufficiently late here so I do not think I would be able to
take a look at it tonight, though.  Sorry.

Just in case you need unblocking (although I think you know how
already), you should be able to continue with:

	$ git rev-parse v2.6.20^0 >.git/HEAD
        $ git read-tree HEAD
        $ git checkout-index -f -q -u -a

That would give you a normal detached state at v2.6.20; you
should be able to come back to your branches with usual "git
checkout".
