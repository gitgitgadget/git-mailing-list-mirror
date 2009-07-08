From: "Andre Mostert" <Andre.Mostert@intecbilling.com>
Subject: RE: git svn fetch fails with Temp file with moniker 'svn_delta'already in use
Date: Wed, 8 Jul 2009 09:52:42 +0200
Message-ID: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD5C1@IBCPTEX01.intecbilling.com>
References: <20090707212608.GB31195@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Marcus Griep" <marcus@griep.us>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MORxt-0007Th-He
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 09:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbZGHHxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 03:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757864AbZGHHxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 03:53:09 -0400
Received: from gateway.cpt.intecbilling.com ([196.30.79.194]:16928 "HELO
	gateway.cpt.intecbilling.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756842AbZGHHxI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 03:53:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090707212608.GB31195@dcvr.yhbt.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git svn fetch fails with Temp file with moniker 'svn_delta'already in use
Thread-Index: Acn/SZWYbuPxJGeORiWRJh6RsGRJ6AAVUQWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122894>

=20
Hi Eric

I'm getting the same thing with a several internal repositories.=20

It will happen almost immediately if I try to clone any one of them.=20

I also have some existing clones created using earlier versions of git =
& svn. When fetching on an existing clone it usually works, until it fa=
ils. When it fails, it will keep on failing on attempting to fetch the =
same commit. I then tried to run "strace -f git svn fetch" to see if th=
at will show anything helpful, but then it worked! So my guess is it co=
uld be some race condition?

This is on Ubuntu 8.10 on x86_64 with libc-2.8.90.

Git 1.6.3.3, perl 5.10.0 and svn 1.5.1 have all been built from officia=
l sources with mostly default options.

I'll check if I can reproduce it with some public repos as well.

Thanks
--Andr=E9


-----Original Message-----
=46rom: Eric Wong [mailto:normalperson@yhbt.net]=20
Sent: 07 July 2009 11:26 PM
To: Andre Mostert
Cc: git@vger.kernel.org; Marcus Griep
Subject: Re: git svn fetch fails with Temp file with moniker 'svn_delta=
'already in use

Andre Mostert <Andre.Mostert@intecbilling.com> wrote:
> Hi
>=20
> I'm getting this error when trying to "git svn fetch":
>=20
> Temp file with moniker 'svn_delta' already in use at=20
> /usr/lib/perl5/site_perl/5.10.0/Git.pm
>=20
> I've found some mention of this in the archives, but no conclusive=20
> fixes or workarounds.
>=20
> This is with git 1.6.3.3, perl 5.10.0 and svn 1.5.1

Hi Andre,

Is there a public repository we can test and reproduce this on?

Which OS, C library and architecture?  This might be a memory corruptio=
n issue inside SVN itself.  I think last time we managed to avoid it by=
 using a different build of SVN or Perl on OSX, but apparently somebody=
 on Debian hit it in a very odd way too: http://bugs.debian.org/534763

I've never been able to see or reproduce this issue myself, maybe Marcu=
s can help since he implemented this piece.

--
Eric Wong
