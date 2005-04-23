From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] make file merging respect permissions
Date: Sat, 23 Apr 2005 13:17:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231311300.2344@ppc970.osdl.org>
References: <1114280570.5068.5.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:11:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQxp-0003zA-O9
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVDWUPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVDWUPV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:15:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:32424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261765AbVDWUPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 16:15:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NKFCs4001286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 13:15:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NKFBVB015744;
	Sat, 23 Apr 2005 13:15:12 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1114280570.5068.5.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, James Bottomley wrote:
>
> The attached fixes both issues

The attached patch was seriously corrupt. Did you edit it by hand? The 
second chunk of the git-merge-one-file-script patch claims to have 12 
source lines, but only has 11, causing patch no end of confusion.

I fixed up the line counts by hand, and the end result looked almost sane,
but when looking closer, I noticed the

	+       if [ $ -ne 0 ]; then
	+               echo "ERROR: Leaving conflict merge in $src2"
	                exit 1

which just can't be right either ("$" never equals 0, so the above will 
always report an error), so I assume that whatever editing you did was 
really quite corrupt. Yeah, yeah, you obviously meant "$?", but the fact 
is, your patch is bogus, and I don't trust it. Can you re-send a valid one 
(and sign off on it).

		Linus
