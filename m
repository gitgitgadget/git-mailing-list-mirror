From: Tom Lord <lord@emf.net>
Subject: on when to checksum
Date: Wed, 20 Apr 2005 15:25:07 -0700 (PDT)
Message-ID: <200504202225.PAA15992@emf.net>
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONZf-00087q-Jt
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDTWZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDTWZS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:25:18 -0400
Received: from emf.emf.net ([205.149.0.19]:38670 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261834AbVDTWZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:25:09 -0400
Received: (from lord@localhost) by emf.net (K/K) id PAA15992; Wed, 20 Apr 2005 15:25:07 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Linus, 

I think you have made a mistake by moving the sha1 checksum from the
zipped form to the inflated form.  Here is why:

What you have set in motion with `git' is an ad-hoc p2p network for
sharing filesystem trees -- a global distributed filesystem.  I
believe your starter here has a good chance of taking off to be much,
much larger than just a tool for the kernel.

A subset of your work: blobs and blob databaes, has much wider application
than just sharing trees:  Those parts of `git' can form a very solid 
foundation for many other applications as well.   To the extent `git'
succeeds in the context of the kernel, it will be invested in and
extended and generalized --- and the kernel project will benefit.
So don't ignore those wider applications even though they are not your
focus today: they will generate investment that feeds back to your project.

Your `git' is silent on transports and mirroring of blob databases --
tasks for scripting, sure -- but those elements won't be far behind.

Eventually, slinging around blobs as atomic elements
of payloads will become very common.

The blob handle (aka "address")/payload model of a blob db is very
clean and simple.   In a network of nodes speaking to one and other
by exchanging blobs, I forsee a prominent need for intermediate
nodes that process blobs "blindly" and as quickly as possible.

Blob compression is mostly goofy if regarded just as a way to 
save on (diminishingly cheap) disk space but it is mostly 
sane if regarded as a way to cut the cost of network bandwidth
roughly in half.

Must intermediate nodes inflate the payloads passing through them
or which they cache just to validate them?   That's not a desirable otucome
for many obvious reasonhs.

There *are* concerns about checksumming zips: it is necessary to nail
down the zip process and make sure it is absolutely and permanently
deterministic for this application.   But *that* is the problem to 
solve, not avoid by moving what the checksum refers to.

Thanks,
-t
