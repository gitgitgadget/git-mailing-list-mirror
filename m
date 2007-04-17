From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD PATCH 0/3] Use "object index" rather than pointers in the object hashing
Date: Mon, 16 Apr 2007 21:21:03 -0700
Message-ID: <7vfy6zskb4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfBk-00018K-R4
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031077AbXDQEVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031079AbXDQEVF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:21:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50429 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031077AbXDQEVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:21:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417042104.QIZP1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 00:21:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o4M31W00K1kojtg0000000; Tue, 17 Apr 2007 00:21:04 -0400
In-Reply-To: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 16 Apr 2007 21:12:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44720>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This is a series of three patches that changes the low-level object 
> hashing to use a "object index" rather than the pointer to a "struct 
> object" in the hash-tables. It's something I've been thinking about for a 
> long time, so I just decided to do it.
>
> The reason to do it is that on 64-bit architectures the object hash table 
> is actually a fairly sizeable entity, and not for a very good reason. It 
> has a ton of pointers to the objects we have allocated, so each hash-table 
> entry is 64-bits, even though obviously we aren't likely to ever have that 
> many objects.

I was thinking about revamping that "keeping track of all
objects" stuff for some time, too, but in a different direction.
Glad I have not touched that area ;-).

I think this makes sense, although the numbers are somewhat
dissapointing.
