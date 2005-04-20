From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: on when to checksum
Date: Wed, 20 Apr 2005 16:07:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201601130.6467@ppc970.osdl.org>
References: <200504202252.PAA16837@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:01:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOBw-00047W-Tq
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDTXFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDTXFW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:05:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:36564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbVDTXFP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:05:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KN5Ds4014344
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 16:05:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KN5CkY001832;
	Wed, 20 Apr 2005 16:05:13 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504202252.PAA16837@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Tom Lord wrote:
> 
> How many times per day do you invoke `write-tree' and why?

Every single commit does a write-tree, so when I merge with Andrew, it's 
usually a series of 100-250 of them in a row.

(Actually, _usualyl_ it's smaller series, but it's the big series that can
be painful enough to matter).

> It takes a large multiple of `0.3s' to get me to take you seriously
> on this point.

The thing is, I don't "trickle" things in. That would be horribly 
inefficient for me. So I go over the patches, make a mbox, and do them all 
in one go. And then they need to happen _fast_. If it takes 20 minutes, I 
go away for coffee or something, and then if something didn't apply 
half-way through, I will have lost my "context".

That's why I want things instant. Not because I have huge daily throughput 
issues, but I have huge _latency_ issues. 

I considered doing a "two-level" thing, where I first did the stuff in a
light-weigth patch manager, and then batched things up in the background
for the real thing. But the fact is, I don't think it's needed. Not the
way git performs now. If I can apply a hundred patches in a minute or two,
I have not "lost the context" if it turns out that there is some silly
glitch with one of them.

		Linus
