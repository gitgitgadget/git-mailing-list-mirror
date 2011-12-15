From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 20:18:55 -0500
Message-ID: <20111215011855.GA24568@sigill.intra.peff.net>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 <CADCnXoaqEXJV+Mb1=nQge_bjA3H6R7=BPt213CKLX55zyTHEtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 02:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RazyY-0005G5-WF
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 02:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1LOBTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 20:19:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50292
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758506Ab1LOBS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 20:18:58 -0500
Received: (qmail 4787 invoked by uid 107); 15 Dec 2011 01:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 20:25:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 20:18:55 -0500
Content-Disposition: inline
In-Reply-To: <CADCnXoaqEXJV+Mb1=nQge_bjA3H6R7=BPt213CKLX55zyTHEtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187182>

On Thu, Dec 15, 2011 at 10:04:06AM +0900, Miles Bader wrote:

> > + =C2=A0 =C2=A0 =C2=A0 commitWideEncoding::
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Advice shown whe=
n linkgit::git-commit[1] refuses to
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proceed because =
there are NULs in commit message.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Default: true.
>=20
> Although "wide encoding" is a reasonable guess at cause of embedded
> zero characters (and so a useful term for diagnostic messages, as it
> can help users identify the problem in their environment which is
> causing such zero bytes), it's really only a guess in most cases...
>=20
> Shouldn't the variable be named based on what it actually does, which
> is allow zero-bytes in commit messages...?

I agree, but...

Really this variable is overkill. The advice.* subsystem is for
silencing hints and warnings from git that you see repeatedly because
you are smarter than git, and want to ignore its advice.

But in this case, I don't see a user saying "stupid git, of _course_ I
want to commit NULs. Stop nagging me". Especially because it is not a
warning, but a fatal error. :)

So yes, it's verbose, but no, it's not something somebody is going to b=
e
so bothered by that they will find the config option to turn it off.
Instead, they will stop doing the bad thing and never see it again.  At
best this config option is useless, and at worst it clutters the
advice.* namespace, making it harder for people to find the advice
option they _do_ want to turn off).

Perhaps it should just be dropped.

-Peff
