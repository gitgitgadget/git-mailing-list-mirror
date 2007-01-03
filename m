From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Skip excessive blank lines before commit body
Date: Wed, 03 Jan 2007 09:03:03 -0800
Message-ID: <7v64booxfc.fsf@assigned-by-dhcp.cox.net>
References: <11678312532251-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 18:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H29W9-00015x-L7
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 18:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbXACRDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 12:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXACRDG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 12:03:06 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40666 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbXACRDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 12:03:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103170304.MAAX2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jan 2007 12:03:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6h2G1W00F1kojtg0000000; Wed, 03 Jan 2007 12:02:16 -0500
To: Lars Hjemli <hjemli@gmail.com>
In-Reply-To: <11678312532251-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Wed, 3 Jan 2007 14:34:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35878>

Lars Hjemli <hjemli@gmail.com> writes:

> This modifies pretty_print_commit() to make the output of
> git-rev-list and friends a bit more predictable.
>
> A commit body starting with blank lines might be unheard-of,
> but still possible to create using git-commit-tree (so is
> bound to appear somewhere, sometime).

This is unfortunately (!!) a good change.  By design,
commit-tree should take whatever binary garbage the user throws
at it as-is (there is no requirement for it to be even text),
and the "punchline + LF + body + LF + signoffs" is strictly by
convention.  We already reformat using indentations and friends,
so your change is a very sane thing to do.

We might want to tighten the formatting convention enforced at
the Porcelain level -- we can start the process by shipping a
sample commit message hook that checks a well formatted commit
log message, perhaps?
