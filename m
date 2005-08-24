From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 11:57:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508241152240.3317@g5.osdl.org>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
 <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 21:00:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80Ro-0002N8-Kk
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVHXS5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVHXS5s
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:57:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751359AbVHXS5r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 14:57:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7OIvdjA024840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Aug 2005 11:57:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7OIvcFB031452;
	Wed, 24 Aug 2005 11:57:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7722>



On Wed, 24 Aug 2005, Linus Torvalds wrote:
> 
> Basically, he had two branches, A and B, and both contained the same patch
> (but _not_ the same commit). One undid it, the other did not.  There's no
> real way to say which one is "correct", and both cases clearly merge
> perfectly, so both outcomes "patch applied" and "patch reverted" are
> really equally valid.

In fact, the case that git selected ("patch applied"), is not only the one
that is very fundamentally the one git will always select in this kind of
situation - in some respects is actually the nicer choice of the two.

While it may cause problems (ie the revert was the right thing to do),
it's at least the state that is less likely to be "lost". Having a revert
disappear is likely better than having a real change disappear. The
reaction to the reverted code showing up again is likely "damn, won't that
bug ever go away, I fixed it once already" - but at least people will see 
that it's fair: "it was applied twice, so let's revert it twice".

In contrast, the reaction to a patch going away is likely just very
confusing: you have two people applying it, but only one reverting it will
revert both, while the first person who applied it may never have realized 
it got reverted.

		Linus
