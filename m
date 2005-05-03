From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 08:07:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505030804170.3594@ppc970.osdl.org>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
 <200505030724.57827.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 17:01:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSyt8-000282-1B
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVECPGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVECPGW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:06:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:12945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbVECPGF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 11:06:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43F5hs4021701
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 08:05:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43F5gi4029975;
	Tue, 3 May 2005 08:05:42 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200505030724.57827.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Chris Mason wrote:
> 
> On the full import of all the bk->cvs changesets, the average file size 
> in .git is 4074 bytes.  73% of the files are 4096 bytes or smaller.

Have you checked how many of those are blobs?

For many commits, we generate as many (or more) _tree_ objects as we 
generate blobs. 

And tree obejcts from the same "supertree" really is something that I
wouldn't mind packing some way, because they really tend to be very much
related (since they refer to each other). Eg the commit and the top-level
tree are almost always a pair, since you'd get a shared top-level tree
only with two commits that have the exact same content (which definitely
happens, don't get me wrong, but it we get some duplication for that case,
we'd still be winning).

		Linus
