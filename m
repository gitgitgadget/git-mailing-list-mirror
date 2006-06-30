From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] make filepairs detachable
Date: Fri, 30 Jun 2006 00:50:58 -0700
Message-ID: <7v7j2zkrod.fsf@assigned-by-dhcp.cox.net>
References: <20060630002736.GB22618@steel.home>
	<7vy7vfmoit.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0606300042r24931d9i5fad0e849b8de84c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDmL-0007gj-If
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWF3HvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWF3HvB
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:51:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:233 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751368AbWF3HvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:51:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630075059.TKOB22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 03:50:59 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606300042r24931d9i5fad0e849b8de84c@mail.gmail.com>
	(Alex Riesen's message of "Fri, 30 Jun 2006 09:42:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22969>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> BTW, is there any chance we get the struct diff_filepair's
> double-linked? They don't seem to be sorted. Will increase
> the memory footprint, though.

You do not necessarily have to do things in place.  In fact, all
of the standard diffcore transformers create a new queue, read
from the old queue and place the filtered or munged result in
the new queue, swap the global queued_diff variable to point at
the new one and discard the old queue.

See diff.c::diffcore_apply_filter() for the simplest example.
