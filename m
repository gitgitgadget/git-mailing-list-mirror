From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 06:29:04 -0400
Message-ID: <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
References: <20100701121711.GF1333@thunk.org> <20100701150331.GA12851@sigill.intra.peff.net> <20100701153842.GA15466@sigill.intra.peff.net> <20100702192612.GM1333@thunk.org> <20100703080618.GA10483@sigill.intra.peff.net> <20100704005543.GB6384@thunk.org> <20100705122723.GB21146@sigill.intra.peff.net> <20100705141012.GA25518@thunk.org> <20100706115826.GA15413@sigill.intra.peff.net> <1278430303.32094.15.camel@wpalmer.simply-domain> <20100707174546.GA4979@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 12:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWoQv-0003Js-88
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 12:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0GHKeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 06:34:16 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:53061 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753887Ab0GHKeP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 06:34:15 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2010 06:34:15 EDT
X-AuditID: 1209190e-b7bb8ae0000009f9-ef-4c35a87a7678
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 3B.8D.02553.A78A53C4; Thu,  8 Jul 2010 06:29:14 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o68ATDZg025072;
	Thu, 8 Jul 2010 06:29:13 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o68AT8aj027045
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 8 Jul 2010 06:29:12 -0400 (EDT)
In-Reply-To: <20100707174546.GA4979@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150556>


On Jul 7, 2010, at 1:45 PM, Jeff King wrote:

>     And of course it's just complex, and I tend to shy away from
>     complexity when I can. The question to me comes back to (1) above.
>     Is massive clock skew a breakage that should produce a few
>     incorrect results, or is it something we should always handle?

Going back to the question that kicked off this thread, I wonder if there
is some way that cacheing could be used to speed up the all cases,
or at lest the edge cases, without imposing as much latency as tracking
the max skew?   i.e., some thing like gitk's gitk.cache file.  For bonus
points, it could be a cache file that is used by both gitk and git tag
--contains, git branch --contains, and git name-rev.

Does that sound like reasonable idea?

--Ted
