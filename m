From: Junio C Hamano <junkio@cox.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 12:49:02 -0700
Message-ID: <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
References: <ps5qyry4.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhWRJ-0004mx-Ch
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbXD0TtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbXD0TtF
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:49:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52213 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbXD0TtE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 15:49:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427194903.CKUM1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 15:49:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sKp21W00U1kojtg0000000; Fri, 27 Apr 2007 15:49:03 -0400
In-Reply-To: <ps5qyry4.fsf@cante.net> (Jari Aalto's message of "Fri, 27 Apr
	2007 14:31:15 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45748>

Jari Aalto <jari.aalto@cante.net> writes:

> FEAURE REQUEST
> --------------
>
> Add sme option to git-format-path to encode thae patch content 
> (MIME/base64)

One possibility is to have a separate mail sending or formatting
program that works on format-patch output.  In any case, I feel
that _generating_ base64 natively does not belong to core git.
We _tolerate_ MIME in mailinfo, but that does not mean we
encourage MIME.  Keeping patches reviewable in recipient's MUA
is important.

Now, after having given the "official" party-line answer, I
personally think it would make sense to always do base64 when
attaching the patch (i.e. "--attach", not "--inline").

In the community git originates from, even --inline attachments
are frowned upon, let alone --attach multiparts (yes, I am
talking about the kernel list and this list).  Nobody who sends
patches over e-mail in communities that have a tradition against
unreadable patches would be using --inline nor --attach anyway,
so making --attach to do base64 would not hurt there.

On the other hand, in circles whose recipients are prepared to
(or even "prefer to") accept messages formatted with --attach,
there should be no harm done if the patch text is base64
encoded either.

Am I going to do it?  Not likely.  But if a patch is cleanly
done, I do not think there is much reason to reject one.
