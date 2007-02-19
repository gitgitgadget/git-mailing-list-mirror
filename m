From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 04:49:55 -0500
Message-ID: <20070219094955.GE30030@spearce.org>
References: <200702190916.35813.andyparkins@gmail.com> <7virdy8p25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 10:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ5A9-0000yN-Rx
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbXBSJuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbXBSJuN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:50:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56740 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbXBSJuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:50:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ59r-0006cj-MK; Mon, 19 Feb 2007 04:50:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D250E20FBAE; Mon, 19 Feb 2007 04:49:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7virdy8p25.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40112>

Junio C Hamano <junkio@cox.net> wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> 
> > I'm working on bringing my hash width literals patch up to
> > date now that 1.5.0 has passed.  It's all been trivial apart
> > from one line:
> >
> > #define HASH_WIDTH_ASCII 40
> > -               printf("%-40s %s%s (%d subtrees)\n",
> > +               printf("%-" HASH_WIDTH_ASCII "s %s%s (%d subtrees)\n",
> >
> > This compiles, but I suspect that it's not going to do what I
> > want it to do.
> 
> Doesn't writing "foo" "bar" (two string literals next to each other)
> tell the compiler to concatenate them?

Yes, but here HASH_WIDTH_ASCII is a number...  wtf is the compiler
generating for the following?

  printf("%-" 40 "s %s%s (%d subtrees)\n",

I did not even realize that was legal C...  Now if the 40 was in
quotes (e.g. "40") then the concatenate rule would apply and we
would get a nice argument to printf.

-- 
Shawn.
