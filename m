From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Wed, 29 Apr 2009 00:07:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904290005010.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain> <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 <7vws95vete.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de> <7v1vrdqi9i.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904281647350.10279@pacific.mpi-cbg.de> <7vk554jxzm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 00:07:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyvS6-0005g6-3p
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 00:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbZD1WGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 18:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbZD1WGx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 18:06:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:46509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753471AbZD1WGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 18:06:53 -0400
Received: (qmail invoked by alias); 28 Apr 2009 22:06:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 29 Apr 2009 00:06:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T91seVo4Tt23Tw0tAtWRKoOMHyHcx8gHQjzVPvv
	lYOox5mnFWJHk2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vk554jxzm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117822>

Hi,

On Tue, 28 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Wait a bit. Wasn't this about you accessing NTFS on your EeePC via 
> >> unfs from the Linux side?
> >
> > Both.  I realized that there was a problem with the ufsd driver of the 
> > Xandros Linux on my EeePC, accessing NTFS partitions.  (This is the 
> > issue that made me add a config variable, but which was solved by 
> > Linus' core.fsyncobjects suggestion.)
> >
> > Later I had a hunch that the issues 222 and 229 of msysGit might have 
> > exactly the same reason, let the reporters test, and indeed, the 
> > problems went away.
> >
> > But come to think of it, we can _easily_ just set 
> > core.createObject=rename in msysGit, so I agree that there is no 
> > longer a need for the Makefile variable.
> >
> > Want me to resend?
> 
> If it helps msys, I think we should allow compiling things in, but this 
> "compiled in default for the platform, and possible per-repository 
> override" made me a bit confused:
> 
>  (1) in your "This is Linux and on sane filesystems I do not weaken it 
>      to rename but on this one filesystem I do" case can be handled by 
>      adding .git/config in that repository;
> 
>  (2) problems with msysgit can be handled by compiled-in defaults as 
>      long as the user does not have .git/config entry to say "link";
> 
>  (3) if you use the same repository from both sides with (1), presumably
>      by dual-booting, so having .git/config that says "rename" happens 
>      to work;
> 
>  (4) if somebody has a dual-boot setup and shares a repository hosted
>      natively on the Linux side by mounting it on the Windows side (Ext2 
>      IFS?), I wonder what should happen.  While you are using the 
>      repository from the Linux side, you may not want to weaken it to 
>      use "rename" (so you do not add .git/config that says "rename").  
>      When you are accessing it over Ext2 IFS, perhaps you would want to 
>      use "rename" (I do not know about the details of #222 and #229, so 
>      it may not applicable, though).
> 
> So,... as long as you do not have a triple-boot setup, third system 
> among which wants to use "link" on a repository where both Linux and 
> Windows side want to use "rename", I think you are Ok.

Well, my idea was to "weaken" the repository by using rename() always, 
even if the fs/OS combo happens to handle the case gracefully.

But actually, what I will use is core.fsyncObjects, as suggested by Linus, 
which should not hurt sane fs/OS combos either.

Ciao,
Dscho
