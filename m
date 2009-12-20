From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git as electronic lab notebook
Date: Sat, 19 Dec 2009 23:55:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912192347250.28241@xanadu.home>
References: <loom.20091219T130946-844@post.gmane.org>
 <8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
 <4B2D6CA5.3070304@gmail.com> <alpine.LFD.2.00.0912192212400.28241@xanadu.home>
 <19245.43871.588697.532035@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan 't Hart <johanthart@gmail.com>,
	"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>,
	Thomas Johnson <thomas.j.johnson@gmail.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 05:57:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMDrC-0001KV-Vh
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 05:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbZLTEzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 23:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZLTEzF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 23:55:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58302 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZLTEzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 23:55:04 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUX00GJWPNQW960@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 19 Dec 2009 23:55:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <19245.43871.588697.532035@lisa.zopyra.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135518>

On Sat, 19 Dec 2009, Bill Lear wrote:

> On Saturday, December 19, 2009 at 22:15:00 (-0500) Nicolas Pitre writes:
> >On Sun, 20 Dec 2009, Johan 't Hart wrote:
> >
> >> Is git able to handle 4Gig files? I've heard git loads every file completely
> >> in memory before handling it...
> >
> >Right.  Sowith current Git you will be able to deal with 4GB files only 
> >if you have a 64-bit machine and more than 4GB of RAM.
> 
> ??
> 
> % uname -a
> Linux pppp 2.6.31.6-166.fc12.i686 #1 SMP Wed Dec 9 11:14:59 EST 2009 i686 i686 i386 GNU/Linux
> % cat /proc/meminfo  | grep MemTotal
> MemTotal:        3095296 kB
> % mkdir gogle
> % cd gogle
> % git init
> % dd if=/dev/zero of=zerofile.tst bs=1k count=4700000
> % git add *
> % git commit -a -m new
> [master (root-commit) 35a25be] new
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 zerofile.tst
> % git --version
> git version 1.6.5.7
> 
> Seems ok to me...

That's the easy part.  Diffing such files and delta compressing them, or 
even checking them out especially when delta compressed, just won't work 
if you don't have the RAM.  Fixing this limitation would introduce 
significant complexity in the code that no one felt was worth it.

I had some thoughts about supporting the addition of really huge files 
in a Git repository where only add/commit/checkout/fetch/push would work 
with no delta compression.  That didn't materialized yet though.


Nicolas
