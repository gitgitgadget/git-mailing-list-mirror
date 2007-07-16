From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Introduce commit notes
Date: Sun, 15 Jul 2007 17:05:01 -0700
Message-ID: <7vhco5cixe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
	<7vlkdhck8d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 02:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAE5y-0008LA-VK
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 02:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbXGPAFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 20:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763846AbXGPAFF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 20:05:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47216 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763840AbXGPAFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 20:05:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716000501.ROBQ1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 20:05:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Q0501X00W1kojtg0000000; Sun, 15 Jul 2007 20:05:01 -0400
In-Reply-To: <7vlkdhck8d.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 15 Jul 2007 16:36:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52613>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if it is worth using the fan-out tree structure for the
> underlying "note" trees, as the notes-index would be the primary
> way to access them.

Actually now I think about it I think this was a stupid
suggestion.  Creation of a new note in a reasonably well
populated note tree would be made 256-fold more efficient by
having the fan-out, as write-tree does not have to recompute the
other 255 tree objects thanks to the cache-tree data being
fresh.
