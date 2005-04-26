From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 21:22:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504252120211.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050426040933.GA21178@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 06:16:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQHUe-0002xf-4C
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDZEVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDZEVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:21:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:34750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261314AbVDZEVH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 00:21:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q4Kxs4002694
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 21:21:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q4Kwa1026111;
	Mon, 25 Apr 2005 21:20:59 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050426040933.GA21178@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Chris Wedgwood wrote:
>
> On Mon, Apr 25, 2005 at 07:08:28PM -0700, Linus Torvalds wrote:
> 
> > If you're checking in a change to 1000+ files, you're doing
> > something wrong.
> 
> arch or subsystem merge?

No, if it's a merge, you just suck in all the already-compressed objects.  

You never compress anything new - you get the objects, you update your
tree index, and you're done. No overhead anywhere - a clean merge may
_look_ like it's changing thousands of files, but it didn't change a
single _object_ anywhere, it just re-arranged the objects and created a
new view of them.

Most merges are literally just a tree-level thing. Sometimes you have to 
do a content merge, but that tends to be a file or two.

			Linus
