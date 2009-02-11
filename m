From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 19:54:39 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902101953170.3590@localhost.localdomain>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net> <200902101958.21284.bss@iguanasuicide.net> <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain>
 <49924642.6000609@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 04:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX6Dm-0008Ev-P8
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 04:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZBKDyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 22:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbZBKDyz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 22:54:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41976 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753263AbZBKDyy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 22:54:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1B3seU8019766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Feb 2009 19:54:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1B3sdi9029979;
	Tue, 10 Feb 2009 19:54:39 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <49924642.6000609@vilain.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-2.757 required=5 tests=AWL,BAYES_00,PLING_QUERY
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109372>



On Wed, 11 Feb 2009, Sam Vilain wrote:
> 
> The only case where it hurts is when you want to merge. Nothing else
> should care. So, if a merge of these note trees sees two different trie
> sizes then it can convert the shorter one to the longer length first,
> and then try the merge again. So you get the pain, but only once. And
> when a project decides that its split is too small, it can split then
> and it should "silently" spread out to others.

But what's the advantage of the added complexity?

The non-fixed trie only helps for the case that doesn't matter - just a 
few annotations. If you have a thousand annotations or less, you _really_ 
don't care. Whatever you do will be fine.

So the whole thing only matters once you have tens of thousands of 
entries, and then you do want to have fan-out. No?

			Linus
