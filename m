From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Thu, 04 Aug 2011 19:54:19 +0200
Message-ID: <4E3ADCCB.6080206@lsrfire.ath.cx>
References: <1312478843.69439.YahooMailClassic@web29510.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: htl10@users.sourceforge.net
X-From: git-owner@vger.kernel.org Thu Aug 04 19:54:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp27s-0001z2-58
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1HDRy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 13:54:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:37102 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab1HDRy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:54:26 -0400
Received: from [192.168.2.104] (p579BE51C.dip.t-dialin.net [87.155.229.28])
	by india601.server4you.de (Postfix) with ESMTPSA id D518D2F8035;
	Thu,  4 Aug 2011 19:54:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1312478843.69439.YahooMailClassic@web29510.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178758>

Am 04.08.2011 19:27, schrieb Hin-Tak Leung:
> --- On Thu, 4/8/11, Jeff King <peff@peff.net> wrote:
>> Out of curiosity, what is the library? Putting pax headers into
>> ustar format has been standardized in POSIX since 2001.
>=20
> The R people wrote their own in the R language (and the person who
> responded to my post in that R-devel thread was possibly the one who
> wrote that part, I believe) - The main reason is probably
> cross-platform-ness and independence from other programming languages
> - they are gradually moving away from invoking system() (because they
> need to run on windows and they used to require many cygwin/mingw
> tools to build add-on packages).
>=20
> The R code which does that, scan for certain patterns after seek()
> into the gunzip'ed stream after 512(?) bytes. It is in a file=20
> R/src/library/utils/R/tar.R under the source repository.

Ah, here it is:

  https://svn.r-project.org/R/trunk/src/library/utils/R/tar.R

It's the ctype handling in function untar2 that rejects unknown entry t=
ypes.

=46or reference, the documentation of the pax format including a
suggestion to treat unknown types like regular files can be found here
(search for "typename"):

  http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html

> I think I tried the tree example and the R code also didn't like it
> much... may be I'll give it another try.

Did you try adding a ":" to the tree argument, e.g. this:

	$ git archive HEAD:

instead of this?

	$ git archive HEAD

Ren=E9
