From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: RE: Files different for me
Date: Wed, 25 Feb 2009 13:02:12 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:04:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcO6i-0005Xr-Nf
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbZBYSCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 13:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbZBYSCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:02:16 -0500
Received: from mail5.tradestation.com ([63.99.207.76]:53714 "EHLO
	mail5.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbZBYSCP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 13:02:15 -0500
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Feb 2009 13:02:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Files different for me
thread-index: AcmXa1WVs0zSoSm1QtmBcVw8UnlKQgABT/vg
X-OriginalArrivalTime: 25 Feb 2009 18:02:13.0500 (UTC) FILETIME=[2FC14BC0:01C99773]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111473>

> Generally when I keep changes like this, I make a commit called "Local

> Changes" or similar and have branch.master.rebase set to true so that

> my changes get rebased on top of origin when I pull.

That sounds ideal.  However, I don't understand the specific steps you
mention.  Looking in the help for git-config,

	branch.<name>.rebase

		When true, rebase the branch <name> on top of the
fetched branch, 
		instead of merging the default branch from the default
remote when 
		"git pull" is run. NOTE: this is a possibly dangerous
operation; 
		do not use it unless you understand the implications 
		(see git-rebase(1) for details).

So, assuming you are working on the "master" branch, this will rebase
the pulled content on top of the existing "master" rather than merging.
If my local changes are committed to "master" first, then this will take
all the commits from other developers that I don't already have in my
local copy and apply them on top of my existing (including Local
Changes).  But since those will now be different commits, what happens
next time?  Ah, "...which introduce the same textual changes..." so
that's covered in how rebase works.

But this will have Local Changes present, and different commits (with
the same textual changes) in my branch.  So what happens when I "push"?

	Oldstuff--A--B--C  remote
	       \
	        LC--X--Y  mine

LC is "Local Changes", X and Y are changes I made, and A, B, C are
changes from other developers.

After a fetch, I have:

	Oldstuff--LC--X--Y--A'--B'--C'  mine

So what happens when I "push"?

In any case, the whole point is that I don't want to publish LC.
