From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 16:16:35 -0800
Message-ID: <20121115001635.GA17370@sigill.intra.peff.net>
References: <20121113175205.GA26960@sigill.intra.peff.net>
 <50A2B14C.9040608@web.de>
 <50A2F17D.4010907@gmail.com>
 <20121114190228.GA3860@sigill.intra.peff.net>
 <50A40978.2060504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYn8W-0007ag-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933236Ab2KOAQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 19:16:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48775 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933080Ab2KOAQi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:16:38 -0500
Received: (qmail 8678 invoked by uid 107); 15 Nov 2012 00:17:27 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 19:17:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 16:16:35 -0800
Content-Disposition: inline
In-Reply-To: <50A40978.2060504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209763>

On Wed, Nov 14, 2012 at 10:13:28PM +0100, Torsten B=C3=B6gershausen wro=
te:

> >>>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
> >>>>  - Update cygwin.c for new mingw-64 win32 api headers
> >>>>
> >>>>  Make git work on newer cygwin.
> >>>>
> >>>>  Will merge to 'next'.

I'm cc-ing Junio in case he missed the discussion; my original plan had
been to move this topic right to 'next' to get exposure from other
cygwin people. But it seems we have already got that, and it might need
re-rolling, so it probably makes sense to hold back until the discussio=
n
reaches a conclusion.

> There are a couple of things which we may want consider:
> a) the name V15_MINGW_HEADERS:
>   It indicates that this is true for Version 1.5 (of what?)
>   If I assume Cygwin version 1.5 , then this name is confusing.
>   Even cygwin versions like 1.7.7 use the same (or similar) include f=
iles as 1.5
>   A better name could be CYGWIN_USE_MINGW_HEADERS (or the like) and t=
o revert the logic.

Regardless of flipping the logic, I agree that having CYGWIN in the nam=
e
makes a lot of sense.

> b) Autodetection:
>   (Just loud thinking), running=20
> $grep mingw /usr/include/w32api/winsock2.h
>  * This file is part of the mingw-w64 runtime package.
> #include <_mingw_unicode.h>
>=20
> on cygwin 1.7.17 indicates that we can use grep in the Makefile to
> autodetect the "mingw headers"

Hmm. Can we rely on the /usr/include bit, though?

I assume a test-compile would be sufficient, but currently we do not do
anything more magic than "uname" in the Makefile itself to determine
defaults.  Maybe it would be better to do the detection in the configur=
e
script? And then eventually flip the default in the Makefile once
sufficient time has passed for most people to want the new format (whic=
h
would not be necessary for people using autoconf, but would help people
who do not).

-Peff
