From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commit ID in exported Tar Ball
Date: Mon, 21 May 2007 02:56:34 -0400
Message-ID: <74FC1AD6-199E-4A01-BB9F-AD030659AE29@silverinsanity.com>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de> <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com> <20070520163026.GA7387@cip.informatik.uni-erlangen.de> <20070521062953.GL3141@spearce.org> <20070521063752.GB23350@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon May 21 08:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1p1-0002YT-S6
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbXEUG4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbXEUG4l
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:56:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:41489 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbXEUG4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:56:40 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 37BD41FFC03B;
	Mon, 21 May 2007 06:56:38 +0000 (UTC)
In-Reply-To: <20070521063752.GB23350@cip.informatik.uni-erlangen.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47976>


On May 21, 2007, at 2:37 AM, Thomas Glanzmann wrote:

> so maybe it isn't that useless as I thought it initial is. But my  
> point
> still stands. I want the commit id of the HEAD in a _file within_ the
> tarball and I definitively don't want to tag my project before I get a
> unique identifier.

If you haven't tagged anything, then git can't give you anything  
better than the SHA-1.  Giving a reference relative to a branch isn't  
useful, as the branch can change.  If the branch doesn't change, it's  
really a tag and you should mark it as such.

Hopefully the patch for the "in a file" flag for git-archive will go  
in soon (or something like it).  I don't think we should make it any  
more complex than just the hash, myself.  If you want something more  
complex a Makefile rule like

dist:
	git archive HEAD > dist.tar
	git describe HEAD > version-file
	tar rf dist.tar version-file
	gzip dist.tar

should do the trick.  (And you can replace "git describe" with "git  
parse-rev" for a bare hash if you'd like.)

~~ Brian
