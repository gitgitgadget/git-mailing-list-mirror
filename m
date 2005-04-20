From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 09:33:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504200931020.6467@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:28:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOI2q-0003RS-Hz
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDTQbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDTQbh
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:31:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:3247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbVDTQbg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 12:31:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KGVUs4009134
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 09:31:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KGVSkl012448;
	Wed, 20 Apr 2005 09:31:29 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Linus Torvalds wrote:
> 
> To actually go faster, it _should_ need this patch. Untested. See if it 
> works..

NO! Don't see if this works. For the "sha1 file already exists" file, it 
forgot to return the SHA1 value in "returnsha1", and would thus corrupt 
the trees it wrote.

So don't apply, don't test. You won't corrupt your archive (you'll just
write bogus tree objects), but if you commit the bogus trees you're going
to be in a world of hurt and will have to undo everything you did.

It's a good test for "fsck" though. It core-dumps because it tries to add 
references to NULL objects.

		Linus
