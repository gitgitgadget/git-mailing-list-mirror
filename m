From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/4] Accept commit in some places when tree is needed.
Date: Wed, 20 Apr 2005 08:32:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200826360.6467@ppc970.osdl.org>
References: <7vis2ikmj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:27:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOH5g-00009E-EJ
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVDTPaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDTPaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:30:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:35230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261687AbVDTPaU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 11:30:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KFUFs4004001
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 08:30:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KFUE3A009259;
	Wed, 20 Apr 2005 08:30:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis2ikmj0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Junio C Hamano wrote:
> 
> This patch lifts the tree-from-tree-or-commit logic from
> diff-cache.c and moves it to sha1_file.c, which is a common
> library source for the SHA1 storage part.

I don't think that's a good interface. It changes the sha1 passed into it: 
that may actually be nice, since you may want to know what it changed to, 
but I think you'd want to have that as an (optional) separate 
"sha1_result" parameter. 

Also, the "type" or "size" things make no sense to have as a parameter 
at all.

IOW, it was fine when it was an internal hacky thing in diff-cache, but 
once it's promoted to be a real library function it should definitely be 
cleaned up to have sane interfaces that make sense in general, and not 
just within the original context.

		Linus
