From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 10:40:52 +0100
Organization: glandium.org
Message-ID: <20080123094052.GB6969@glandium.org>
References: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org> <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHc6p-0004S9-8u
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbYAWJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 04:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYAWJkz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 04:40:55 -0500
Received: from smtp23.orange.fr ([80.12.242.97]:56525 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbYAWJky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 04:40:54 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2311.orange.fr (SMTP Server) with ESMTP id AB44A7000126
	for <git@vger.kernel.org>; Wed, 23 Jan 2008 10:40:52 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-83-190.w86-205.abo.wanadoo.fr [86.205.41.190])
	by mwinf2311.orange.fr (SMTP Server) with ESMTP id 835687000096;
	Wed, 23 Jan 2008 10:40:52 +0100 (CET)
X-ME-UUID: 20080123094052538.835687000096@mwinf2311.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JHc6G-0001wY-3N; Wed, 23 Jan 2008 10:40:52 +0100
Content-Disposition: inline
In-Reply-To: <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71529>

On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard <kevin@sb.org> wrote:
> "In Mac OS X,  SMB, MSDOS, UDF, ISO 9660 (Joliet), NTFS and ZFS file  
> systems all store in one form -- NFC.  We store in NFC since that what  
> is expected for these files systems."

That's the point. It's stored in NFC, but what applications see is NFD.

> >- Likewise for Samba shares.
> 
> See above.
> 
> >- When I had my problems with iso9660 rockridge volumes using NFC (you
> > can create that just fine with mkisofs), the volume is mounted  
> >without
> > normalisation, i.e. if you get to a shell and want to access files,
> > you must use NFC, but at least the Finder does transliteration at  
> >some
> > stage, because going into the mount point and opening some files fail
> > because it's trying to open the file with the name transliterated to
> > NFD. I just hope the same doesn't happen with other filesystems.
> 
> Can you produce a reproducible set of steps for this? Because the  
> Finder shouldn't be doing any of this work on its own, all the  
> normalization stuff happens directly in HFS+.

Simple : on a Linux host, create files with NFC names, and create an iso
image with mkisofs, with rockridge but no joliet. Burn this to a disc, and
insert the disc in your OSX host, and try to open files from the finder.
Interestingly, IIRC, Finder is able to copy the files, though.

As a bonus, try the same with an iso volume name in NFC, it's even better :
the created mount point is NFD, but it tries to mount on the name in NFC and
fails. And then you just can't eject the CD anymore.

Mike
