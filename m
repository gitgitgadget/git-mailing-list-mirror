From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 08 Jul 2007 17:37:27 -0700
Message-ID: <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 02:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7hFs-0004dA-5l
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 02:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbXGIAh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 20:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbXGIAh3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 20:37:29 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51007 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXGIAh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 20:37:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709003728.GATJ3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 20:37:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MCdT1X0071kojtg0000000; Sun, 08 Jul 2007 20:37:28 -0400
In-Reply-To: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
	(Marco Costalba's message of "Sun, 8 Jul 2007 16:37:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51937>

This is whitespace damaged in a funny way (some lines do not
have leading whitespace while some do).

log_tree_diff() hence log_tree_commit() is caled by codepaths
other than "git log -p", and I am not convinced that this patch
would not break them.  Worrysome.

I wonder why we did not actually remove the duplicate parents
from "commit->parents" list after history simplification when we
originally did 88494239, instead of filtering only on the output
path.  Anybody remember the reason?
