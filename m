From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Sat, 16 May 2009 01:07:19 -0400
Message-ID: <20090516050718.GA7330@sigio.peff.net>
References: <1242349041.646.8.camel@Joe-Laptop.home> <7v63g2tewu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joe Perches <joe@perches.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 07:11:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5CBe-0004ly-Pl
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 07:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbZEPFHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 01:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZEPFHT
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 01:07:19 -0400
Received: from peff.net ([208.65.91.99]:35868 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbZEPFHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 01:07:18 -0400
Received: (qmail 7345 invoked by uid 1000); 16 May 2009 05:07:19 -0000
Content-Disposition: inline
In-Reply-To: <7v63g2tewu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119334>

On Fri, May 15, 2009 at 11:11:13AM -0700, Junio C Hamano wrote:

> This is a tangent, but I do not think the current cover-letter that u=
ses
> shortlog matches everybody's needs.  The shortlog format lists commit=
s
> grouped by the author and does not number them, and it makes it hard =
to
> match which message in the series corresponds to which entry in the c=
over
> letter, especially when your series have a resend of somebody else's =
patch
> in it.  I wouldn't be surprised if somebody comes up with a different
> style that is based on "git log --reverse --oneline A..B" output (per=
haps
> without the shortened object name part) and name it the "oneline" sty=
le,
> e.g.
>=20
>     From: Jeff King
>=20
>     *** BLURB HERE ***
>     The following patches do ...
>=20
>     1/2	parseopt: add OPT_NEGBIT (R=C3=A9ne Scharfe)
>     2/2 ls-files: make --no-empty-directory negatable

At one point I was working on --pretty=3Dformat specifiers for "total
number of commits" and "incremental commit number". The eventual goal
being an option like coverletter.logformat that you could set to
"%xi/%xn %s".

Sadly, the code got a bit messy because the feature straddles the line
of pretty.c and actual rev traversal. I started some refactoring, but
dropped it halfway through, and now of course it is woefully out of dat=
e
(a lesson in "merge early, merge often"). So I just pipe "git log
--oneline" through nl manually. ;)

So yes, I think somebody would be interested in alternate styles. And
while I think most people would want to set their default style as a
config variable, it may make sense to override on the command-line
(e.g., for a series that is mostly from you versus one that is from
mixed authors).

-Peff
