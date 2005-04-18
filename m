From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Merge with git-pasky II.
Date: Mon, 18 Apr 2005 05:16:59 +0100
Message-ID: <E1DNNgy-0003He-00@skye.ra.phy.cam.ac.uk>
References: <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Petr Baudis <pasky@ucw.cz>,
	Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 06:13:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNNdY-0008F1-QD
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 06:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDRERO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 00:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDRERO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 00:17:14 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:43671 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261646AbVDRERL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 00:17:11 -0400
Received: from skye.ra.phy.cam.ac.uk ([131.111.48.158] ident=mail)
	by mraos.ra.phy.cam.ac.uk with esmtp (Exim 4.43)
	id 1DNNgz-0001Lq-5w; Mon, 18 Apr 2005 05:17:01 +0100
Received: from sanjoy by skye.ra.phy.cam.ac.uk with local (Exim 3.35 #1)
	id 1DNNgy-0003He-00; Mon, 18 Apr 2005 05:17:00 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Your message of "Sun, 17 Apr 2005 10:34:57 PDT."
             <Pine.LNX.4.58.0504171014430.7211@ppc970.osdl.org> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> So until proven otherwise, I worry about accidental hashes, and in
> 160 bits of good hashing, that just isn't an issue either...[Going
> from 128 bits to 160 bits made it] so _unbelievably_ less likely to
> happen that it's not even funny.

You are right.  Here's how I learnt to stop worrying and love the 160
bits.

A 160-bit hash requires 2^80=10^24 files before the collision
probability is roughly 0.5 (actually 1-e^{-1/2}).  Now be very
conservative: Instead of tolerating a 0.5 probability, worry about
even a 10^-8 probability of a collision anywhere, anytime.

The magic number of files for that probability is 10^20 (roughly 10^40
pairs for 2^160=10^48 boxes).

Given 10 billion people using git, each producing 1 source file per
second -- busy beavers all -- they would need 300 years to produce
10^20 files.  And to reach the 10^-8 collision probability, all 10^20
files must belong to the same project, and even OpenOffice will not be
that bloated.

-Sanjoy
