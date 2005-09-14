From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 15:50:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141549270.26803@g5.osdl.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
 <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu>
 <Pine.LNX.4.63.0509141214490.23242@iabervon.org> <43287ECB.8090308@citi.umich.edu>
 <Pine.LNX.4.63.0509141622340.23242@iabervon.org> <4328A3F9.1010506@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 00:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFg5m-0000Q6-Eg
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 00:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVINWu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 18:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVINWu7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 18:50:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965089AbVINWu6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 18:50:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EMosBo026804
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 15:50:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EMorTK032527;
	Wed, 14 Sep 2005 15:50:54 -0700
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4328A3F9.1010506@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8573>



On Wed, 14 Sep 2005, Chuck Lever wrote:
> 
> oh, i see.  the hash table won't help cache_find_name find an insertion 
> point quickly if the name isn't already in the cache.

Note that almost all insertion tends to happen linearly.

In particular, read-tree always inserts things in order.

So probably _most_ of the file finding could actually use even a stupid 
linear search, if they just had a place to start from. And 99% of the 
time, it would be very close to where they wanted to be.

Hmm?

		Linus
