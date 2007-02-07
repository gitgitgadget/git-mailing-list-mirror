From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 07 Feb 2007 12:37:39 -0800
Message-ID: <7vabzp7lgs.fsf@assigned-by-dhcp.cox.net>
References: <7vired7mkw.fsf@assigned-by-dhcp.cox.net>
	<20070207203133.GG12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtZr-0003qF-Sx
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161433AbXBGUiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbXBGUhq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:37:46 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48009 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161439AbXBGUhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:37:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207203739.THYJ1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 15:37:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lkdf1W00i1kojtg0000000; Wed, 07 Feb 2007 15:37:40 -0500
In-Reply-To: <20070207203133.GG12140@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 7 Feb 2007 22:31:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38965>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> Since git-rebase currently ignores merge commits
>
> Ugh. This is the bit I did not know about.
>
> So the following script is kind of equivalent to rebase -
> it applies commits in range $1..$2 that touch files in list on top of current tree:
>
> from=$1
> shift
> to=$1
> shift
> git-show --pretty=email `git-rev-list --no-merges $from..$to -- $* | tac` > box
> ../git-am box
>
> And here I was hoping rebase will be smarter and help me out.
>
> OK.
>
> Questions about the above line now:
>
> 1. What is annoying in the above is that
> git-show can not limit its output to just the part of patch
> that affects the list of files I give, the way git-diff can.
> Would such an extension be a good idea?

It is a good idea and I think it is implemented.

	$ git-show <commit>... --- <paths>

would probably give what you want (although I am not absolutely
sure I understand what you want).

> 2. It's unfortunate that I need a temp file here.
> Can git-am get stdin somehow?

See "git-rebase.sh" around ll.325.
