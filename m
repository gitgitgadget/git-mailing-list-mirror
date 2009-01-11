From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 22:39:20 +0100
Message-ID: <200901112239.20306.borntraeger@de.ibm.com>
References: <200901111602.53082.borntraeger@de.ibm.com> <20090111194258.GA4840@uranus.ravnborg.org> <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 22:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM83M-0007G6-Ve
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 22:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbZAKVjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 16:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZAKVjY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 16:39:24 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:42497 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZAKVjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 16:39:23 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id n0BLdMJ9588350;
	Sun, 11 Jan 2009 21:39:22 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id n0BLdMF64214862;
	Sun, 11 Jan 2009 22:39:22 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n0BLdLer021834;
	Sun, 11 Jan 2009 22:39:21 +0100
Received: from sig-9-146-132-128.de.ibm.com (sig-9-146-132-128.de.ibm.com [9.146.132.128])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id n0BLdKqH021829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Jan 2009 22:39:21 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105230>

Am Sonntag 11 Januar 2009 schrieb Linus Torvalds:
> Well, you don't actually have to mark that semi-random one as good either. 
> What you can do is to just mark anything that _only_ contains fs/btrfs as 
> good. IOW, you don't have to know the magic number - you just have to be 
> told that "oh, if you only have btrfs files, and you're not actively 
> bisecting a btrfs bug, just do 'git bisect good' and continue".

That should work.

<rant>
Still, I am a bit frustrated. During this weekend I reported 2 regressions 
(wlan and ata)  and I still try to find out why suspend/resume stopped 
working. In the meantime I have identified 2 patches (one was already known, 
I reported the 2nd to the usb maintainers) after 2.6.28 that caused suspend 
to ram regressions. In rc1 S2R was broken again. So I tried bisecting the 
third patch - which finally brought me to the btrfs bisect problem.

For me, this was the most annoying  merge window ever.

In my opinion we should really avoid subtree merges in the future as a curtesy 
to people who do the uncool work of testing, problem tracking and bisecting. 
</rant>

Christian
