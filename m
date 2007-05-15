From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Tue, 15 May 2007 11:58:56 -0700
Message-ID: <7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
References: <11792246701367-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 20:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho2Eg-0005Qm-OV
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbXEOS66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 14:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbXEOS66
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:58:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62599 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbXEOS65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:58:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515185857.OGOL24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 14:58:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zWyw1W00N1kojtg0000000; Tue, 15 May 2007 14:58:57 -0400
In-Reply-To: <11792246701367-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Tue, 15 May 2007 12:24:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47366>

Jakub Narebski <jnareb@gmail.com> writes:

> Add -l/--long/--size option to git-ls-tree command, which displays
> object size of an entry after object id (left-justified with minimum
> width of 7 characters).

Not a NAK at all (but not an ACK either yet), but just asking
questions on some design considerations.

* Do these options do different things?  If not, why have more
  than one (or two, --long and its shorthand -l)?

* Why pad to 7 places?  Do we have a similar padding elsewhere?
  Will this ever used by non-scripts?  How does this padding
  affect parsers other than Perl that read this information?

* Does it make sense to show size information when giving a tree
  entry?  I realize not having it in the output would make the
  job of the script reading the output a bit harder, but if this
  output is meant also for human consumption I think it would
  not be so interesting and raise a confusion factor.

  Also I suspect that having to show the size of a tree object,
  expressed in terms of the canonical representation, might
  force packv4 aware ls-tree to convert its traversal efficient
  representation to the canonical one only to get its size.
