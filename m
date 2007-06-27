From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 09:49:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706270935340.8675@woody.linux-foundation.org>
References: <87wsxpobf0.fsf@rho.meyering.net>
 <81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
 <87r6nxo8iq.fsf_-_@rho.meyering.net> <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com>
 <87odj1mpy2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 18:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3aiW-0006YP-Ns
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 18:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbXF0QuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXF0QuG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 12:50:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35908 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752283AbXF0QuF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 12:50:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RGnjOV002978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2007 09:49:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5RGndvd022226;
	Wed, 27 Jun 2007 09:49:39 -0700
In-Reply-To: <87odj1mpy2.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.627 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51057>



On Wed, 27 Jun 2007, Jim Meyering wrote:
> 
> Subject: [PATCH] git-log: detect dup and fdopen failure
>  git-compat-util.h (xdup, xfdopen): Define functions.
> 
> Signed-off-by: Jim Meyering <jim@meyering.net>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

That said, the whole "prepend 'x' to the function name" thing is obviously 
how git does things, but maybe it would be more readable in the long term 
to make the prefix be 'safe_' instead of 'x', or something like that?

The 'x' thing is the fairly traditional thing to do for malloc(), and 
that's where it comes from, of course. In git (and other places: google 
code shows that other projects have ended up with the same kind of things, 
with busybox being one example I found), it then got extended to 
xread/xwrite, but now it's getting extended so much that I'd worry a bit 
that in the long run the easy-to-miss 'x' part really would be better off 
written out a bit more.

No really strong opinion, just throwing it out for comment.

It was brought on by the fact that I mentally parsed "xfdopen()" as "xf" + 
"dopen" for some reason (but maybe that's just me).

			Linus
