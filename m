From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 13:51:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171350000.5473@woody.linux-foundation.org>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
 <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704172114040.8164@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdueM-0006Hj-DP
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031208AbXDQUvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031212AbXDQUvi
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:51:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35166 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031208AbXDQUvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:51:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HKpWC0017336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 13:51:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HKpVfd007643;
	Tue, 17 Apr 2007 13:51:32 -0700
In-Reply-To: <Pine.LNX.4.64.0704172114040.8164@beast.quantumfyre.co.uk>
X-Spam-Status: No, hits=-2.463 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44822>



On Tue, 17 Apr 2007, Julian Phillips wrote:
> 
> It's the tag auto-following code, I'm calling read_ref to see if I already
> have that tag - and it appears that doing that a few thousand times takes a
> while.

Heh. I think we should probably call read_refs() just once to read them 
all (when most of them are packed, that's cheap), and then after that, 
have some way to just check for a match on the refs we have cached.

		Linus
