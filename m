From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 09:29:36 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801180902470.817@ds9.cixit.se>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
 <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com>
 <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
 <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org>
 <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pedro Melo <melo@simplicidade.org>, Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:30:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmcM-0006y2-8D
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYARI34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 03:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbYARI34
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:29:56 -0500
Received: from ds9.cixit.se ([193.15.169.228]:35012 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbYARI3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:29:55 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0I8TbZZ005718
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Jan 2008 09:29:37 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0I8Tabt005713;
	Fri, 18 Jan 2008 09:29:36 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 18 Jan 2008 09:29:38 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70976>

Linus Torvalds:

> The difference I see between us is that when I tell you that this is
> exactly the same thing as your file *contents*,

This is the same issue as the CRLF issue I posted on earlier, and it
all stems from that git also sees file names as a stream of bytes, not
a string of characters, just as it does text.

> An OS that silently changes the contents of your files is *crap*.
> Get it?

A program that silently ignores the conventions of the platform it runs
on is *crap*, no matter if the conventions are not the same as for
other platforms.

> An OS that silently changes the contents of your directories is *crap=
*.
> Get it now?

A program that silently ignores the conventions of the file system it
tries to store its files on is *crap* :-)


In my perfect world, file names would be stored as a string of characte=
rs,
so if I save a file with an =E5 in it, that =E5 would be preserved no
matter if I run Linux on ext2 with my locale is set to latin-1 (which
stores it as byte 0xE5), on Windows with NTFS (which stores it as the
UTF-16 code 0x00E5), on Windows/DOS with FAT (which stores it as the
byte 0x86) or on Mac OS X which stores it as decomposed UTF-8 (whose
byte sequence I don't know at the top of my head). If that was just
stored as U+00E5 in whatever encoding in the filename index, the local
implementation of git can just check it out in the form needed.

--=20
\\// Peter - http://www.softwolves.pp.se/
