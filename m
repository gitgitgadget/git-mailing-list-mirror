From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/7] gitweb: Support comparing blobs with different names
Date: Fri, 20 Apr 2007 04:24:28 -0700
Message-ID: <7vabx3z3tf.fsf@assigned-by-dhcp.cox.net>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at>
	<11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at>
	<200704201234.50134.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HerE9-0006zD-QU
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992942AbXDTLYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992954AbXDTLYa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:24:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46287 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992942AbXDTLYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 07:24:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420112428.YDON1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 07:24:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pPQU1W00T1kojtg0000000; Fri, 20 Apr 2007 07:24:29 -0400
In-Reply-To: <200704201234.50134.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 20 Apr 2007 12:34:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45090>

Jakub Narebski <jnareb@gmail.com> writes:

> Currently we have:
>
>   $ git diff -p HEAD^ HEAD -- gitweb/test/hardlink
>   diff --git a/gitweb/test/hardlink b/gitweb/test/hardlink
>   old mode 100644
>   new mode 100755
>
> but
>
>   $ git diff -p HEAD^:gitweb/test/hardlink HEAD:gitweb/test/hardlink
>
> returns empty diff.

By "blobdiff", I understand you are talking about the "diff"
link that appears on each path at the bottom of the commit view.

I think the bug is the way gitweb drives the core; it uses the
latter form, when it has perfectly good information to run the
former.  It's not like you have an UI that says "pick any path
from any comit first; after you have picked one, pick the other
arbitrary one; now we run compare them".  The UI says "Give me
diff for this path in this commit".
