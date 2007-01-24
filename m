From: Junio C Hamano <junkio@cox.net>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 21:05:04 -0800
Message-ID: <7vk5zdhv5r.fsf@assigned-by-dhcp.cox.net>
References: <200701192148.20206.johannes.sixt@telecom.at>
	<200701231506.32396.andyparkins@gmail.com>
	<Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701231624.41716.andyparkins@gmail.com>
	<Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
	<Pine.LNX.4.63.0701231805100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkjtkxlm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701240251230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 06:05:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9aJz-00048T-Mw
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 06:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbXAXFFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 00:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965649AbXAXFFH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 00:05:07 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55764 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965527AbXAXFFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 00:05:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124050505.KISI15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 00:05:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Et5P1W00B1kojtg0000000; Wed, 24 Jan 2007 00:05:23 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37603>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Seriously again, the users of merge-index are
>
> git-merge, which I do not really understand
>
> What I am nervous about is git-merge.

I think you are referring to the "carry forward local change"
logic in 'next'.

First of all, BAD DSCHO.  You should be looking at 'master', not
'next' during -rc period ;-).

Seriously again, the codepath is taken when the merge is a fast
forward to another commit (iow, our HEAD is an ancestor of the
other branch, so we will end up updating the branch tip with the
tip of the other branch).  The use of merge-index there can be
replaced when we use merge-recursive instead of the 3-way
"read-tree -m" the same way as how "checkout -m" implements the
branch switching with local changes.
