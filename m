From: Jon Loeliger <jdl@freescale.com>
Subject: git bisect enhancements?
Date: Wed, 30 Nov 2005 15:36:26 -0600
Message-ID: <1133386585.30767.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 30 22:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhZct-00073X-1c
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 22:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVK3Vg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVK3Vg2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 16:36:28 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:52423 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750864AbVK3Vg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 16:36:27 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jAULnLQ0011841
	for <git@vger.kernel.org>; Wed, 30 Nov 2005 14:49:21 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jAULhC4W023053
	for <git@vger.kernel.org>; Wed, 30 Nov 2005 15:43:12 -0600 (CST)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13017>

Guys,

So, I'm in the middle of a Git Bisect War.
It all worked around 2.6.13-rc3 time, and doesn't now.

So I launched into some bisecting, and it is all going
pretty smoothly so far.  But I think there is an obvious
enhancement that I would like to propose for discussion.

First, the problem I'm seeing is that the current top
of tree hangs an mpc8555_cds_defconfig build.  Bummer.
Doesn't get past the traditional "uncompressing image..."
message.

Two or three "good builds" into things, it proposes a
new build at a272e24cc8751d125f9582befed0213a2a2b270f.
Which I build and don't quite boot.  It hangs after
the IDE probe, and before the i2c probe.  Bummer.

These are not bugs I was looking for.  Move along.

So I lie and claim "git bisect good", making a *scratch* note
of where the "git bisect log" seems to think I am so that
I might come back here and claim "git bisect bad" later.

The _next_ proposed split is at
a272e24cc8751d125f9582befed0213a2a2b270f
where I can clearly see using "git bisect visualize" that
a much better, perhaps more quiescent choice is two commits
later.  The proposed bisect location is in the middle of
a series of commits from paulus tinkering with the PPC
merge tree.  Two commits later, though, Linus has merged
it in totally.  It will be less "in the middle" of things
and more quiescent.  I want to "bump" the bisect point
up two commits and _then_ build.

So, I'm proposing something like:

    $ git bisect bump +<n>
    $ git bisect bump -<n>

To move the bisection point "up" or "down" a commit chain.

Am I off in the weeds?

Thanks,
jdl
