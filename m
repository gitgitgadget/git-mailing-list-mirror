From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 12:16:58 +0100
Message-ID: <200801181217.01198.jnareb@gmail.com>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org> <Pine.LNX.4.64.0801180902470.817@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pedro Melo <melo@simplicidade.org>,
	Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:17:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFpED-0006wM-11
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbYARLRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 06:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYARLRK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:17:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:23927 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYARLRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:17:09 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1136062mue.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/Y3K+QGE4iaOu023wTzgJXLChiA+k7eCAz1CFr5a7cU=;
        b=VOrfIiKz52qCDhDw0+3Onc9uWhFqEMp3UKrLTncJyd+Mjl5t4Is48WIGGc99y7ajJY7eT31/7w4hFyNWmt4WCzsYc7HKdVKXNGAEN1IW24S8cid98wcHgIR8EwYWscVDO4EE0GTUJeTpKtFk+ZgODgKr2KWoKt3CtyHywSKYwhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pxu3DQZghd3S+cGyRCbBwwCuOOpqRb78fCzME/Cm1g4X7HZNuxLSk12l2Nx/Ozv6WDZlkAJ1fpAI/yqM+dM5MIIOLPGSrGq6Hb1rsXalPCrv3zws+r8fum9JDZgS77+kif6MizLhgBK6YtmPPeZkcBYpNlsYCMDrEqoQ53IQkfE=
Received: by 10.78.200.20 with SMTP id x20mr4420944huf.16.1200655026467;
        Fri, 18 Jan 2008 03:17:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.203.217])
        by mx.google.com with ESMTPS id f8sm6170331nfh.13.2008.01.18.03.17.03
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Jan 2008 03:17:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0801180902470.817@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71000>

Peter Karlsson wrote:
> Linus Torvalds wrote:
>=20
> > The difference I see between us is that when I tell you that this i=
s
> > exactly the same thing as your file *contents*,
>=20
> This is the same issue as the CRLF issue I posted on earlier, and it
> all stems from that git also sees file names as a stream of bytes, no=
t
> a string of characters, just as it does text.

You have to be careful about CRLF conversion, lest you corrupt your
binary files. CRLF conversion is off by default.

> > An OS that silently changes the contents of your files is *crap*.
> > Get it?
>=20
> A program that silently ignores the conventions of the platform it ru=
ns
> on is *crap*, no matter if the conventions are not the same as for
> other platforms.
>=20
> > An OS that silently changes the contents of your directories is *cr=
ap*.
> > Get it now?
>=20
> A program that silently ignores the conventions of the file system it
> tries to store its files on is *crap* :-)

Git philosophy to see the contents of files and "contents" of directori=
es
(filenames) as stream of bytes, i.e. to use 'native' encoding works
perfectly well and _fast_ if all developers work in the same environmen=
t.
Troubles start if you are working across operating systems, and across
filesystems.

> In my perfect world, file names would be stored as a string of charac=
ters,
> so if I save a file with an =E5 in it, that =E5 would be preserved no
> matter if I run Linux on ext2 with my locale is set to latin-1 (which
> stores it as byte 0xE5), on Windows with NTFS (which stores it as the
> UTF-16 code 0x00E5), on Windows/DOS with FAT (which stores it as the
> byte 0x86) or on Mac OS X which stores it as decomposed UTF-8 (whose
> byte sequence I don't know at the top of my head). If that was just
> stored as U+00E5 in whatever encoding in the filename index, the loca=
l
> implementation of git can just check it out in the form needed.

Git has for a long time i18n.commitEncoding, and from some time it
saves it in 'encoding' header in commit object (if different from
'uft-8') and has also i18n.logOutputEncoding.

=46or dealing with different filesystem encodings you would also have
to have both: encoding used in 'tree' objects (by repository) for
filenames saved somewhere in repository, either in tree object (argh!)
or in some kind of .gitconfig file; encoding used by filesystem in
repository config as i18n.filesystemEncoding or something like that.
And think what to put in the on disk index, and in memory index.


NOTE, NOTE, NOTE! If filename is used somewherein the file contents
(manifest-like file, include-like statement), and this filename uses
characters which are differently encoded in different encoding you
are screwed with this fancy system, badly, anyway.

--=20
Jakub Narebski
Poland
