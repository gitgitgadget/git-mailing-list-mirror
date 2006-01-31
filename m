From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Tue, 31 Jan 2006 09:49:53 -0800
Message-ID: <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
	<7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 18:50:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3zdu-0003LI-P5
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWAaRuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWAaRuK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:50:10 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58584 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751301AbWAaRuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 12:50:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131174905.QZLI15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 12:49:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 31 Jan 2006 14:58:21 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15327>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> apart from my thinking this is not backward-compatible (you are supposed 
> to be able to pull from a complete repo, even if it has a 
> non-shallow-capable upload-pack), here are my comments:

It cannot do a shallow clone against older servers, no.  I think
it should be able to do a full clone from older servers, but I
need to double check -- at least that is how I meant to write
that thing but it was late night ;-).

> - it is good that MAXPARENT and struct commit_graft are in more public 
> 	places now.
>
> - reparse_* is misleading. Nothing is reparsed, but rather "unparsed".

I meant to reparse them thear but forgot.  Will remember to fix.

> - I'd hesitate to let git-daemon write temporary files. That is a whole 
> 	new can of security worms.
>
> - The custom_graft issue could be handled in a more elegant manner if 
> 	git was lib'ified (no temporary file). Since that is already the 
> 	plan, why not do that first, and come back later?

That is why it does not write any temporary files.  It
introduces a way to read graft information from an environment
variable.

> - It looks wrong to me to define MAX_PARENTS as 20 in upload-pack.c, when 
> 	MAXPARENT is defined as 16 in cache.h.

This is remnant from my earlier one that did not move MAXPARENT
out from commit-tree I forgot to clean up before calling it a
day.  Will remember to clean up.
