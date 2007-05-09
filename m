From: Pavel Roskin <proski@gnu.org>
Subject: Re: FFmpeg considering GIT
Date: Wed, 09 May 2007 18:30:43 -0400
Message-ID: <1178749843.1680.17.camel@dv>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503180016.GB21333@informatik.uni-freiburg.de>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
	 <20070506111411.GC17498@diana.vm.bytemark.co.uk>
	 <e5bfff550705060519s2c1abd7cl7ecedeb497e10e3b@mail.gmail.com>
	 <e5bfff550705060533x18f63c09rc6a742058b82f712@mail.gmail.com>
	 <20070506125938.GA19317@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marco Costalba <mcostalba@gmail.com>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>, git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 10 00:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlugS-0003gE-EX
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbXEIWav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 May 2007 18:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbXEIWau
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:30:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:50600 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbXEIWat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 18:30:49 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HludR-00048v-9h
	for git@vger.kernel.org; Wed, 09 May 2007 18:27:49 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HlugF-0000yE-Ol; Wed, 09 May 2007 18:30:43 -0400
In-Reply-To: <20070506125938.GA19317@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46804>

Hello!

On Sun, 2007-05-06 at 14:59 +0200, Karl Hasselstr=F6m wrote:
> configure.ac: 9: required file `./[config.h].in' not found

Sorry for being late with the comments, but it looks like some very old
Automake doesn't understand that the argument to AC_CONFIG_HEADER or
AM_CONFIG_HEADER can be quoted.

Regarding AM_CONFIG_HEADER vs AC_CONFIG_HEADERS, the documentation for
Automake says:

AC_CONFIG_HEADERS
Automake will generate rules to rebuild these headers.  Older versions
of Automake required the use of AM_CONFIG_HEADER; this is no longer the
case today.

So I suggest that we keep AC_CONFIG_HEADERS.  Automake's NEWS file says
AM_CONFIG_HEADER is obsolete since version 1.7.

> src/Makefile.am:30: invalid unused variable name:
> `nodist_qgit_SOURCES'

That's another sign of an obsolete version of Automake.  "nodist_" was
introduced many years ago, back in the good old days when I had time to
track its progress.  NEWS says it was introduced in Automake 1.5!

Perhaps we should require version 1.7 by adding this to the top-level
Makefile.am:

AUTOMAKE_OPTIONS =3D 1.7

--=20
Regards,
Pavel Roskin
