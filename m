From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 5 Feb 2009 19:32:24 +0100
Message-ID: <200902051932.24600.robin.rosenberg.lists@dewire.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <20090205160625.GI26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV933-00077N-5d
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760378AbZBEScd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760349AbZBEScd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:32:33 -0500
Received: from mail.dewire.com ([83.140.172.130]:2439 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760294AbZBEScb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:32:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BAE1E147E880;
	Thu,  5 Feb 2009 19:32:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EX9b5-Z1H6f2; Thu,  5 Feb 2009 19:32:25 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2F8B7147E7FF;
	Thu,  5 Feb 2009 19:32:25 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <20090205160625.GI26880@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108597>

torsdag 05 februari 2009 17:06:25 skrev Shawn O. Pearce:
> > Known issues are:
> > 
> >   - If a project has a repository more than one level above the
> >     project directory decorations will fail.
> 
> I'd like to see this fixed in the near-ish future, but I don't
> think its blocking to merging your patches.

I'm not sure this is Tore's bug. We've had problems with nested
repos before.

> >   - When a Java resource is dirty, each parent package in the
> >     package hierarcy will appear dirty, even when the layout is
> >     set to 'flat'.
> 
> Bah.  I've seen the Java compiler error marks also report like this.
> I don't think its our issue.  But maybe I'm wrong.

It's our choice here. Generally, I think we should shift behavior here
depending on layout. Java packages are not hierarchical in nature.

Currently it may look like this with flat package layout:

	>org.spearce.jgit.treewalk
		CanonicalTreeParserTest.java
		EmptyTreeIteratorTest.java
		FileTreeIteratorTest.java
		NameConflictTreeWalkTest.java
		PostOrderTreeWalkTest.java
		TreeWalkBasicDiffTest.java

	>org.spearce.jgit.treewalk.filter
		AlwaysCloneTreeFilter.java
		>NotTreeFilterTest.java
		TreeFilterTest.java


Which is odd when looking at org.spearce.jgit.treewalk, because
no files in that package have been changed. A tricky question is
how to decorate empty packages. like org, org.spearce. Probably
as unchanged.

-- robin
