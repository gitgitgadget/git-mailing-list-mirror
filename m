From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add the --numbered-files option to git-format-patch.
Date: Wed, 06 Jun 2007 00:50:25 -0700
Message-ID: <7vps497c8u.fsf@assigned-by-dhcp.cox.net>
References: <1181074013.2585.14.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 09:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqHr-0002Oz-1x
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 09:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXFFHu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 03:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXFFHu1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 03:50:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:37549 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbXFFHu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 03:50:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606075025.VOZN7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 03:50:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 87qR1X00A1kojtg0000000; Wed, 06 Jun 2007 03:50:25 -0400
In-Reply-To: <1181074013.2585.14.camel@ld0161-tx32> (Jon Loeliger's message of
	"Tue, 05 Jun 2007 15:06:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49258>

Jon Loeliger <jdl@freescale.com> writes:

> With this option, git-format-patch will generate simple
> numbered files as output instead of the default using
> with the first commit line appended.
>
> This simplifies the ability to generate an MH-style
> drafts folder with each message to be sent.

I'll take the patch but wouldn't something like:

	git-format-patch --stdout $args |
        FILENO=7 formail -s sh -c 'cat >.junk/$FILENO'

be equivalent to

	git-format-patch -o .junk/ --numbered-files --start-number=7 $args

and more flexible?
