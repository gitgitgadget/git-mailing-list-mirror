From: Nicolas Pitre <nico@cam.org>
Subject: Re: git 1.5.3.5 error over NFS (pack data corruption)
Date: Tue, 13 Nov 2007 20:28:59 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711132027430.21255@xanadu.home>
References: <18228.32091.865519.312011@lisa.zopyra.com>
 <20071109232106.GA3435@steel.home> <18232.29603.856766.275854@lisa.zopyra.com>
 <20071112233309.GI2918@steel.home> <18233.47472.890658.729250@lisa.zopyra.com>
 <20071113214802.GH3268@steel.home> <18234.14781.55429.671459@lisa.zopyra.com>
 <20071114000218.GL3268@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is74A-0000U1-Hn
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbXKNB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbXKNB3B
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:29:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36078 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbXKNB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:29:00 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRH001FJ2SBTM00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Nov 2007 20:28:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071114000218.GL3268@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64940>

On Wed, 14 Nov 2007, Alex Riesen wrote:

> Bill Lear, Wed, Nov 14, 2007 00:56:45 +0100:
> > On Tuesday, November 13, 2007 at 22:48:02 (+0100) Alex Riesen writes:
> > >...
> > >> >I extend the part you quoted. The file is opened here:
> > >> >...
> > >> >This is strange. The current git should not produce anything like
> > >> >this (and does not, here). ...
> > >> 
> > >> You are absolutely correct.  My comrade ran this with 1.5.0.1 by
> > >> mistake.  He reran the strace with 1.5.3.5, and I have replaced
> > >> the tarball on my server:
> > >> 
> > >>     http://www.zopyra.com/~rael/git/git-trace.tar.bz2
> > >
> > >Still looks like v1.5.0.1:
> > >
> > >    write(2, "fatal: ", 7)                  = 7
> > >    write(2, "cannot pread pack file: No such "..., 49) = 49
> > 
> > Well, I just grepped for the above string in git-1.5.3.5:
> > 
> > % grep 'cannot pread pack file' *.c
> > index-pack.c:                   die("cannot pread pack file: %s", strerror(errno));
> 
> oh, you should be looking for usage.c, the function report (it is
> called by default die handler). The old code used to fputs("fatal:"),
> the new just vfprintf's everything, so the write should look like:
> 
>     write(2, "fatal: cannot pread pack file: No such "...

This is not included in 1.5.3.5 though.


Nicolas
