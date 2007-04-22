From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Controversial blob munging series
Date: Sat, 21 Apr 2007 23:08:22 -0700
Message-ID: <11772221041630-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:08:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVFY-0007Eb-DA
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbXDVGI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbXDVGI0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:08:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62128 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXDVGIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:08:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422060825.GPTA1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 22 Apr 2007 02:08:25 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q68R1W0041kojtg0000000; Sun, 22 Apr 2007 02:08:25 -0400
X-Mailer: git-send-email 1.5.1.2.919.g280f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45215>

This is on top of 'next' I'll push out after I am done with
v1.5.1.2 I am preparing today.

[1/2] Add 'filter' attribute and external filter driver definition.
[2/2] Add 'ident' conversion.

I'll park them near the tip of 'pu', but consider they are
primarily for interested people to experiment with.

I suspect this might have helped me (and other Asians) a year
ago.  I did not manage to configure my Emacs to work well with
utf-8 encoded Japanese text, and had some difficulties in
maintaining documentation for git-lost-found (it has my name
spelled in Japanese).

I could have had:

	(in .git/info/attributes)
	Documentation/git-lost-found.txt filter=eucjp-n-utf8

	(in config)
	[filter "eucjp-n-utf8"]
		clean  = nkf -E -w
		smudge = nkf -W -e

so that checked-out copy is after "nkf -W -e" (filter to EUC-JP,
treating the input as UTF-8) to allow my Emacs work with EUC-JP.
Check-in will be done after "nkf -E -w" (filter to UTF-8,
treating the input as EUC-JP), which would keep the "official"
version in the repository as UTF-8.  The best part of this is
that the configurations above are both private to me, and people
do not even have to know that I am suffering from the inability
to use UTF-8 in my editor.

These days I configured my Emacs to deal with UTF-8 much better
than when I added git-lost-found manual page, so I would not
need the above hack, though.

I also suspect a "fun but probably not very useful in practice"
application would be to have "indent" as the clean filter while
leaving "smudge" filter empty.
