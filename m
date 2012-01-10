From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 18:21:32 -0500
Message-ID: <20120110232132.GA29245@sigill.intra.peff.net>
References: <5142795.2dTmMhVRTP@xps>
 <20120110213344.GI2714@centaur.lab.cmartin.tk>
 <1431498.0yPWNQLupF@xps>
 <20120110225011.GJ2714@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Albert Astals Cid <aacid@kde.org>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Jan 11 00:21:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkl0o-0006Pm-QI
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 00:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864Ab2AJXVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 18:21:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34007
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933681Ab2AJXVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 18:21:35 -0500
Received: (qmail 15970 invoked by uid 107); 10 Jan 2012 23:28:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 18:28:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 18:21:32 -0500
Content-Disposition: inline
In-Reply-To: <20120110225011.GJ2714@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188304>

On Tue, Jan 10, 2012 at 11:50:11PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> > Unfortunately this producess a tarball with a different layout, e.g=
=2E
> >=20
> > git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD:=
doc/en_US
> >   gives me a tarball with the doc/en_US files in the root
> >=20
> > git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD =
-- doc/en_US
> >   gives me a tarball with the doc/en_US folders and then the files
> >=20
> > Is there a way to keep the old behaviour or do we need to update ou=
r scripts?
>=20
> Not as far as I know. However, the commit that hardened the input
> (ee27ca4a781844: archive: don't let remote clients get unreachable
> commits, 2011-11-17) does state that HEAD:doc/en_US should be valid,
> so it looks like it's actually a regression. As it's bedtime in my
> timezone, I'm blaming Peff and I'll look into this if it hasn't been
> fixed by the time I get to the office tomorrow.

It is definitely my fault. According to ee27ca4a, sub-trees were an
unfortunate casualty of the tightening. However, I did have some patche=
s
that moved towards allowing things like that safely (basically the rev
parser needs to pass more context back to the caller).

It's evening here and I'm doing family stuff, but I'll take a look
either late tonight or tomorrow morning.

-Peff
