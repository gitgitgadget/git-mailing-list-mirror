From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation/CodingGuidelines: improve header includes rules
Date: Thu, 16 Apr 2009 07:10:28 +0200
Message-ID: <200904160710.28473.chriscool@tuxfamily.org>
References: <20090414003433.39cbdea2.chriscool@tuxfamily.org> <20090415075819.GC23332@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 07:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuJuY-0000gp-AJ
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbZDPFLp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 01:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZDPFLo
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 01:11:44 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:42832 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbZDPFLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 01:11:44 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 7C4AA4B005D;
	Thu, 16 Apr 2009 07:11:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 26C674B0042;
	Thu, 16 Apr 2009 07:11:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090415075819.GC23332@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116668>

Le mercredi 15 avril 2009, Jeff King a =C3=A9crit :
> On Tue, Apr 14, 2009 at 12:34:33AM +0200, Christian Couder wrote:
> > 	- The third one means that for example if we have "revision.h"
> > 	that includes "diff.h" and "commit.h", then it's ok to include
> > 	"revision.h" in a C file, only if at least one feature from
> > 	"revision.h" is actually used in the C file.
> >
> > 	It is not ok to include "revision.h" if features from "diff.h"
> > 	and "commit.h" are used but no feature from "revision.h" is
> > 	used.
>
> Why? I thought the guiding principle mentioned earlier was "don't was=
te
> programmers' time figuring out what should and shouldn't be included"=
=2E
>
> Sure, I would not expect somebody to include a header that is totally
> unrelated, but it seems that most of the source files lazily include
> cache.h just to get "everything".

The third rule is:

+ - After the first #include in a C file, only header files containing
+   features that are actually used in the C file should be included.
+   (This means that it is not ok to include an header file only
+   because this header file includes other header files with features
+   that are used in the C file.)

So this rule is only for #include after the first one, and "cache.h" sh=
ould=20
be the first one if it is included.

I added this rule because we need a little sanity too and it can be=20
misleading to see an include of some feature when in fact no features f=
rom=20
the include are used.

> Stripping unnecessary includes doesn't even speed up compilation, as =
our
> Makefile overspecifies the header dependencies anyway.

Perhaps the dependencies will not be overspecified one day, and I think=
 it=20
should at least speed up a little bit compilation of the C file where=20
unnecessary includes have been stripped. And anyway it looks simpler an=
d=20
does not mislead into thinking that some feature are used when they are=
=20
not.

Best regards,
Christian.
