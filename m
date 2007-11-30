From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 06:42:13 +0100
Message-ID: <1BC9698A-80D3-4189-B24B-7E3C4934B043@zib.de>
References: <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 06:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixyds-0006Tr-Lc
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 06:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbXK3Flz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 00:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbXK3Fly
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 00:41:54 -0500
Received: from mailer.zib.de ([130.73.108.11]:37147 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbXK3Flu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 00:41:50 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAU5f44N018698;
	Fri, 30 Nov 2007 06:41:04 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83fde.pool.einsundeins.de [77.184.63.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAU5f2Ff018392
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 30 Nov 2007 06:41:02 +0100 (MET)
In-Reply-To: <20071130011748.GC11683@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66614>


On Nov 30, 2007, at 2:17 AM, Jeff King wrote:

>
> The only reason I have heard to remove them entirely is that Windows
> doesn't properly support hardlinks, which I addressed in my other  
> mails
> (and to which I have seen no rebuttal).

We don't have a problem with hardlinks for git-* commands in
msysgit.  The msysgit installer already creates hardlinks if
installing on NTFS.  On non-NTFS partitions, though, it needs
to copy the files.

Note, this doesn't mean we love hardlinks in msysgit.  Actually,
msys does _not_ support them in its Unix emulation layer.  So,
for daily work git does not have hardlinks.  For examples, the
test script skip all hardlink related tests.  The installer
handles hardlinks using the Windows API directly and not using
the Unix emulation layer.

We already have a setup that supports exporting only git and
gitk to the a Windows Command Prompt (not the bash that comes
with msysgit).  If you choose this setup, a directory that
contains only these two commands will be added to the system
wide PATH. We use this indirection to hide all the the Unix
tools that are included in msysgit (and needed by git) from
the Windows Command Prompt.

	Steffen
