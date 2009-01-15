From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree merge strategy
Date: Thu, 15 Jan 2009 22:05:00 +0100
Message-ID: <200901152205.00600.robin.rosenberg@dewire.com>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <1223932217-4771-9-git-send-email-spearce@spearce.org> <200810232314.29867.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 15 22:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNZQf-0003ia-RD
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 22:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763588AbZAOVFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 16:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933556AbZAOVFN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 16:05:13 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:53064 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934498AbZAOVFK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 16:05:10 -0500
Received: from sleipner.localnet (213.67.102.59) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C502645839; Thu, 15 Jan 2009 22:05:07 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.1.96; i686; ; )
In-Reply-To: <200810232314.29867.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105879>

I never got a  received reply... on this.

-- robin

torsdag 23 oktober 2008 23:14:29 skrev Robin Rosenberg:
> Hi, Shawn
> 
> Shouldn't testTrivialTwoWay_disjointhistories()  work?
> 
> The two trees have nothing in common and so should be trivially mergeable.
> 
> -- robin
> 
> From cef2695431e368da616a1e9c8de3e5e419854a4c Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Thu, 23 Oct 2008 23:09:10 +0200
> Subject: [EGIT PATCH] Simple merge test
> 
> ---
>  .../org/spearce/jgit/merge/SimpleMergeTest.java    |   28 ++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
> 
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
> new file mode 100644
> index 0000000..8ec1c7f
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java
> @@ -0,0 +1,28 @@
> +package org.spearce.jgit.merge;
> +
> +import java.io.IOException;
> +
> +import org.spearce.jgit.lib.ObjectId;
> +import org.spearce.jgit.lib.RepositoryTestCase;
> +
> +public class SimpleMergeTest extends RepositoryTestCase {
> +
> +	public void testTrivialTwoWay_noway() throws IOException {
> +		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
> +		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a"), db.resolve("c") });
> +		assertFalse(merge);
> +	}
> +
> +	public void testTrivialTwoWay_disjointhistories() throws IOException {
> +		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
> +		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a"), db.resolve("c~4") });
> +		assertTrue(merge); 
> +	}
> +
> +	public void testTrivialTwoWay_ok() throws IOException {
> +		Merger ourMerger = MergeStrategy.SIMPLE_TWO_WAY_IN_CORE.newMerger(db);
> +		boolean merge = ourMerger.merge(new ObjectId[] { db.resolve("a^0^0^0"), db.resolve("a^0^0^1") });
> +		assertTrue(merge);
> +		assertEquals(db.mapTree("a^0^0").getId(), ourMerger.getResultTreeId());
> +	}
> +}
