From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 15:18:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201515060.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 16:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGbxl-0004x7-RZ
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 16:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbYATPTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYATPTF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 10:19:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:45854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753709AbYATPTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 10:19:03 -0500
Received: (qmail invoked by alias); 20 Jan 2008 15:19:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 20 Jan 2008 16:19:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AxNgEk/xAgMsRUe8FPIQTO644mjGxH6dPxS3IJ/
	bNyhpFhzyQC3UW
X-X-Sender: gene099@racer.site
In-Reply-To: <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71178>

Hi,

On Sun, 20 Jan 2008, Steffen Prohaska wrote:

> On Jan 20, 2008, at 2:48 AM, Johannes Schindelin wrote:
> 
> > On Sat, 19 Jan 2008, Linus Torvalds wrote:
> > 
> > > Best time before:
> > > 
> > > 	[torvalds@woody linux]$ time git commit > /dev/null
> > > 	real    0m0.399s
> > > 	user    0m0.232s
> > > 	sys     0m0.164s
> > > 
> > > Best time after:
> > > 
> > > 	[torvalds@woody linux]$ time git commit > /dev/null
> > > 	real    0m0.254s
> > > 	user    0m0.140s
> > > 	sys     0m0.112s
> > 
> > Wow.
> > 
> > > I bet you'll see a much bigger performance improvement from this on
> > > Windows in particular.
> > 
> > I bet so, too.  Traditionally, filesystem calls are painfully slow on
> > Windows.
> > 
> > But I cannot test before Monday, so I would not be mad if somebody else
> > could perform some tests on Windows.
> 
> Here are timings for Windows XP running in a virtual machine on a
> Laptop.  The work tree contains 7k files.  I stripped user and
> sys times because they are apparently meaningless for MINGW.
> 
> Best time before:
> 
>    $ time git commit >/dev/null
>    real    0m1.662s
> 
> Best time after:
> 
>    $ time git commit >/dev/null
>    real    0m1.196s
> 
> The absolute time improvement is obviously larger, although the
> relative improvement is slightly smaller than in Linus' example.
> 
> 
> And here are the timings for the host system, which is Mac OS X,
> on the same work tree.
> 
> Best time before:
> 
>    $ time git commit >/dev/null
>    real    0m0.571s
>    user    0m0.332s
>    sys     0m0.237s
> 
> Best time after:
> 
>    $ time git commit >/dev/null
>    real    0m0.463s
>    user    0m0.273s
>    sys     0m0.186s
> 
> Interestingly, the relative improvements are even smaller on Mac
> OS X.

Still, nothing to spit at.

FWIW I have made two patches which should be probably folded into Linus' 
patch; I will post them as a reply.

Ciao,
Dscho
