From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 17:56:54 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221743470.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
 <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
 <20080123013325.GB1320@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUsK-0000Sa-91
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 02:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbYAWB5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 20:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYAWB5a
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 20:57:30 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33748 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751784AbYAWB5a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 20:57:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N1utp6012446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 17:56:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N1utww018526;
	Tue, 22 Jan 2008 17:56:55 -0800
In-Reply-To: <20080123013325.GB1320@mit.edu>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71489>



On Tue, 22 Jan 2008, Theodore Tso wrote:
> 
> It's pretty clear the Unicode conversion is being done in HFS+, not in
> the VFS layer of Mac OS X.

Ok. That's going to make it both easier and harder for them in the future. 
In particular, it probably means that their VFS layer really has no notion 
of this at all, and it's going to be fairly hard to support any kind of 
generic "backwards compatibility" layer on top of other filesystems.

> So presumably if and when Mac OS adopts ZFS, they will be able to be
> free of this mess, at least if they care about being compatible with
> Solaris.

I wouldn't hold my breadth on ZFS, considering the memory requirements. 
ZFS apparently wants *lots* of memory:

	http://www.solarisinternals.com/wiki/index.php/ZFS_Best_Practices_Guide#ZFS_Administration_Considerations
	http://wiki.freebsd.org/ZFSTuningGuide

in fact it seems that the FreeBSD people basically recomment against using 
ZFS on 32-bit kernels because of the memory use issues.

Yes, it could be BSD-specific, but considering Solaris has the same 
recommendation, it sure seems like ZFS isn't ready for prime time on any 
low-end (read: consumer) hardware.

Of course, in a year or two, 2GB will be the norm. Right now it's still 
fairly unusual on Mac hardware outside of the Mac Pro line (which, I 
think, comes with a *minimum* of 2GB), and the people who get it want it 
not for the filesystem caches, but for big photo editing jobs..

			Linus
