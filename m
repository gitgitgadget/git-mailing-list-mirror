From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 16:50:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171644480.7211@ppc970.osdl.org>
References: <E1DNI0G-0000bo-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.58.0504171530150.7211@ppc970.osdl.org> <20050417232905.GA2721@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, pasky@ucw.cz, simon@himi.org,
	david.lang@digitalinsight.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:48:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJV3-0007Ha-H1
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDQXv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDQXv4
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:51:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:47550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261571AbVDQXt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:49:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HNmns4030031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 16:48:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HNmlhO013700;
	Sun, 17 Apr 2005 16:48:48 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20050417232905.GA2721@gondor.apana.org.au>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Herbert Xu wrote:
> 
> I wasn't disputing that of course.  However, the same effect can be
> achieved in using a single hash with a bigger length, e.g., sha256
> or sha512.

No it cannot.

If somebody actually literally totally breaks that hash, length won't 
matter. There are (bad) hashes where you can literally edit the content of 
the file, and make sure that the end result has the same hash.

In that case, when the hash algorithm has actually been broken, the length 
of the hash ends up being not very relevant. 

For example, you might "hash" your file by blocking it up in 16-byte
blocks, and xoring all blocks together - the result is a 16-byte hash.  
It's a terrible hash, and obviously trivially breakable, and once broken
it does _not_ help to make it use its 32-byte cousin. Not at all. You can 
just modify the breaking thing to equally cheaply make modifications to a 
file and get the 32-byte hash "right" again.

Is that kind of breakage likely for sha1? Hell no. Is it possible? In your 
"in theory" world where practice doesn't matter, yes.

		Linus
