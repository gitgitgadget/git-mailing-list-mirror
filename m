From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some ASCII Art
Date: Thu, 06 Oct 2005 13:38:10 -0700
Message-ID: <7v8xx67559.fsf@assigned-by-dhcp.cox.net>
References: <1128621923.29904.30.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:41:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENcVX-0008QZ-Um
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 22:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVJFUiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 16:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVJFUiM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 16:38:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23682 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751349AbVJFUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 16:38:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006203806.HXOR4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 16:38:06 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1128621923.29904.30.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Thu, 06 Oct 2005 13:05:24 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9784>

Jon Loeliger <jdl@freescale.com> writes:

> Fundamental Git Index Operations
> Git Index Operations

These two look almost the same.

I find the label "commit-tree" on index -> odb in the second
picture a bit misleading.  "commit-tree" takes a tree and zero
or more commit objects to create a new commit object, so it
works solely inside odb.

It is good that you mention that "read-tree -u" form updates
working tree in the second picture.  In the same spirit, you
might also want to mention that "checkout-index -u" updates the
index (i.e. matches the stat information) in the same picture.

Diff drawing looks good.  If you are aiming for completeness,
diff-stages is lacking -- it compares between stages in the
index file.  But diff-stages is really a specialized operation
whose usefulness is still unproven, so not drawing it for the
sake of simplicity is also OK.

> Commit DAG Revision Naming
> ==========================
>
> Both node B and C are a commit parents of node A.

I assume that parents are left to right in this picture, that
is, B's first parent is D, second E, and third F.

>
>     G   H   I   J
>      \ /     \ /
>       D   E   F
>        \  |  /
>         \ | /
>          \|/
>           B     C
>            \   /
>             \ /
>              A
>
>
>     A = rev    = rev^0
>     B = rev^   = rev^1     = rev~1
>     D = rev^^  = rev^1^1   = rev~2
>     G = rev^^^ = rev^1^1^1 = rev~3

> Is there a way to name node C, E, F, H, I or J?

C = A^2
E = B^2 = A^^2
F = B^3 = A^^3
H = D^2 = B^^2 = A^^^2 = A~2^2
I = F^ = B^3^ = A^^3^
J = F^2 = B^3^2 = A^^3^2

They look like line noise ;-)

> Is A also called rev~0?

If you are talking about only commit objects, then REV^0 is
always the same as REV.  You could write REV^0^0^0^0 if you
want but that is rather pointless ;-).
