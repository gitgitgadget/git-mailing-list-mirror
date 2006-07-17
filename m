From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 19:10:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607171907080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 19:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Wbn-0007ru-Hw
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 19:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWGQRKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWGQRKL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 13:10:11 -0400
Received: from mail.gmx.de ([213.165.64.21]:55948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751080AbWGQRKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 13:10:09 -0400
Received: (qmail invoked by alias); 17 Jul 2006 17:10:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 17 Jul 2006 19:10:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23976>

Hi,

On Mon, 17 Jul 2006, Juergen Ruehle wrote:

> Johannes Schindelin writes:
>  > > > It is not Cygwin really. It's windows. You can't rename or delete an
>  > > > open or mmapped file in that thing.
>  > > 
>  > > And GIT's workaround is to read the whole file into memory and close
>  > > it after that?  Uh-oh.
>  > 
>  > If you have a better idea (which does not make git source code ugly), go 
>  > ahead, write a patch.
> 
> On several boxes I've tested the mmap code passes the tests on NTFS.
> 
> It is usable for my simple work even on FAT32 with an unlink before
> the rename in lockfile.c, but that probably breaks in more involved
> scenarios.

In my not-so-simple tests, it failed. Reproducibly. If I am not mistaken, 
your test just does not hit the problem, namely fork()ing after 
rename()ing a mmap()ed file.

Now, with the diff changes a few months ago, there are way less fork()s in 
the code, that might be one reason you do not hit the wall, but I could 
imagine that a "git-read-tree -m -u" still has problems. Note: I did not 
test what I just said, but I _did_ test that there are problems with 
mmap() when you fork() with the map in use.

Ciao,
Dscho
