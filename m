From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to
	follow and maintain
Date: Wed, 29 Apr 2009 10:16:59 -0700
Message-ID: <20090429171659.GF23604@spearce.org>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org> <200904290120.00039.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 19:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzDPi-0000Mr-ES
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 19:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208AbZD2RRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 13:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756490AbZD2RRA
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 13:17:00 -0400
Received: from george.spearce.org ([209.20.77.23]:33445 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbZD2RQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 13:16:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 373C938064; Wed, 29 Apr 2009 17:16:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904290120.00039.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117907>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
> > +	private void gc() {
> > +		R r;
> > +		while ((r = (R) queue.poll()) != null) {
> > +			// Sun's Java 5 and 6 implementation have a bug where a Reference
> > +			// can be enqueued and dequeued twice on the same reference queue
> > +			// due to a race condition within ReferenceQueue.enqueue(Reference).
> 
> Reference to the official Sun bug? Might help if someone wants to
> implement a flag to avoid this (if necessary...)

Actually, this is a new bug.  I tried looking through BugParade
but nobody has mentioned or discovered this before.

I submitted a bug report yesterday, but they have yet to publish it.

So, no link.
 
> > +	protected int hash(final int packHash, final long position) {
> > +		return (packHash + (int) (position >>> 4)) >>> 1;
> > +	}
>
> Since we never use the baselass this one isn't covered... ok anyway I think.

This particular implementation I planned on using in
UnpackedObjectCache if I rewrote it using OffsetCache.

But I could also just make it abstract here.  Maybe that is the
better approach.  I'll amend that into the series.
 
-- 
Shawn.
