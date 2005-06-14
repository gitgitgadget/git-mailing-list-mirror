From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [zooko@zooko.com: [Revctrl] colliding md5 hashes of human-meaningful
 documents]
Date: Mon, 13 Jun 2005 22:06:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506132141250.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506120949150.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 04:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0pG-0007Mp-BB
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFNCLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNCLd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:11:33 -0400
Received: from iabervon.org ([66.92.72.58]:38405 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261343AbVFNCHm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 22:07:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Di0om-0001Lg-00; Mon, 13 Jun 2005 22:06:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506120949150.2286@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 12 Jun 2005, Linus Torvalds wrote:

> Put another way: you could use this exact example for a version of git
> that uses md5-sums instead of sha1's, but it wouldn't show anything at all 
> about a git vulnerability even so.

You couldn't use this exact example for an md5 git; git compresses the
files before hashing, which means that you don't have an md5 block of
arbitrary data you can replace with a different arbitrary block because it
wouldn't decompress.

Of course, if zlib has a way of saying, "if bytes 256-511 match 512-767,
decompress the first of the two records starting at 768, otherwise
decompress the second" then the attack would work, and we should all by
worried (and disturbed by zlib in general). Chances are that it would be
impractical to find a pair of blocks such that they are both valid in the
same part of a zlib record and both leave the compression context such 
that the same remaining content decompresses successfully and both have
the same md5 hash, let alone getting the results in both cases to be valid
C that depends on the difference between the blocks. It's possible that
you could get it to work with only a moderately large number of weak
collisions between very similar blocks, but it's not nearly so easy a
task.

	-Daniel
*This .sig left intentionally blank*


