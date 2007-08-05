From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Sat, 04 Aug 2007 23:12:44 -0700
Message-ID: <7v4pjeh5lv.fsf@assigned-by-dhcp.cox.net>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
	<7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
	<20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
	<7v643vj316.fsf@assigned-by-dhcp.cox.net>
	<46B4A350.9060806@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Sven Verdoolaege <skimo@kotnet.org>,
	git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 08:12:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHZM9-0005q0-4R
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 08:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbXHEGMq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 02:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbXHEGMq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 02:12:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64683 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbXHEGMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 02:12:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805061244.QQZX23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 02:12:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y6Ck1X0031kojtg0000000; Sun, 05 Aug 2007 02:12:44 -0400
In-Reply-To: <46B4A350.9060806@tromer.org> (Eran Tromer's message of "Sat, 04
	Aug 2007 12:03:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54957>

Eran Tromer <git2eran@tromer.org> writes:

> Another approach is for pull, checkout etc. to automatically update the
> submodule' head ref, but no more. In this case the supermodule always
> sees a consistent state with traditional semantics, but the *submodule*
> ends up with a dirty working tree and a head referring to a
> possibly-missing commit; "git submodule update" would need to clean that up.

That however would introduce the same problem as "pushing into
live repository to update its HEAD while the index and working
tree are looking the other way".  We would need to somehow make
it possible for the subdirectory to remember which commit the
index and the working tree are derived from, so that the local
changes can be merged back to the revision the submodule HEAD
points at.
