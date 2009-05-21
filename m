From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 1/6] Make sure we get the right storage for loose/pack/loose and packed refs
Date: Thu, 21 May 2009 17:22:33 +0200
Message-ID: <200905211722.33995.robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org> <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com> <20090520214359.GQ30527@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 21 17:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7A6h-0000sF-HY
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZEUPWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 11:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZEUPWl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:22:41 -0400
Received: from mail.dewire.com ([83.140.172.130]:1124 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbZEUPWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 11:22:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 43479147D9B4;
	Thu, 21 May 2009 17:22:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fglCJasnmnPg; Thu, 21 May 2009 17:22:36 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 570CA147D9AC;
	Thu, 21 May 2009 17:22:35 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090520214359.GQ30527@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119689>

onsdag 20 maj 2009 23:43:59 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > Also adds a few some more test for refs, though not complete.
> 
> Hmm, tests fail, wrong expected values?

Gah, not sure how that passed. It's not random failures...

> Actual was Result.REJECTED_CURRENT_BRANCH.
> 
> > @@ -349,12 +355,20 @@ private synchronized Ref readRefBasic(final String origName,
> > +
> > +		if (!origName.equals(name)) {
> > +			ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
> > +			looseRefs.put(origName, ref);
> > +		}
> 
> Seems fine, but I'm starting to hate our current way of handling
> symrefs.  Not for this series.  But its starting to worry me.

I agree. For decorating the history it's convenient, but it's inconsistent. For some reason
it was harder to see without the unit tests. All kinds of things slip by when testing is
done on the surface only.

I'll update, and and even more tests. 

Should we use multiple Ref objects for symrefs? I.e. a Ref referring to another in a chain,
with all symrefs in between visible?

-- robin
