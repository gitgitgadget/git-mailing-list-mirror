From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Make 'git var GIT_PAGER' always print the
 configured pager
Date: Mon, 15 Feb 2010 00:00:07 -0500
Message-ID: <20100215050007.GE3336@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214115959.GB3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngt49-0007wd-HL
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750Ab0BOFAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 00:00:07 -0500
Received: from peff.net ([208.65.91.99]:42716 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755252Ab0BOFAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:00:06 -0500
Received: (qmail 13230 invoked by uid 107); 15 Feb 2010 05:00:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:00:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:00:07 -0500
Content-Disposition: inline
In-Reply-To: <20100214115959.GB3499@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139972>

On Sun, Feb 14, 2010 at 05:59:59AM -0600, Jonathan Nieder wrote:

> Scripted commands that want to use git=E2=80=99s configured pager kno=
w better
> than =E2=80=98git var=E2=80=99 does whether stdout is going to be a t=
ty at the
> appropriate time.  Checking isatty(1) as git_pager() does now won=E2=80=
=99t
> cut it, since the output of git var itself is almost never a terminal=
=2E
> The symptom is that when used by humans, =E2=80=98git var GIT_PAGER=E2=
=80=99 behaves
> as it should, but when used by scripts, it always returns =E2=80=98ca=
t=E2=80=99!
>=20
> So avoid tricks with isatty() and just always print the configured
> pager.

I think this is the right thing to do. But isn't "git am" broken in the
meantime, as it now always paginates (whereas before, it would never
paginate)? You fix it later in the series, but is there any test
breakage in the meantime (not rhetorical, I didn't actually check) that
would hurt bisectability?

The same would go for "git svn", except that its pagination was also
broken in other ways. :)

-Peff
