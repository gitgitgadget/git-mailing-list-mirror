From: Jeff King <peff@peff.net>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 02:48:15 -0400
Message-ID: <20080731064814.GA32431@sigill.intra.peff.net>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 08:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KORyS-0007hA-EG
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 08:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYGaGsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 02:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYGaGsR
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 02:48:17 -0400
Received: from peff.net ([208.65.91.99]:3183 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYGaGsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 02:48:16 -0400
Received: (qmail 20900 invoked by uid 111); 31 Jul 2008 06:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 02:48:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 02:48:15 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90899>

On Wed, Jul 30, 2008 at 05:43:52PM +0200, Sverre Rabbelier wrote:

> On Wed, Jul 30, 2008 at 17:01, Bj=C3=B6rn Steinbrink <B.Steinbrink@gm=
x.de> wrote:
> > git blame doesn't know --find-copies-harder, it's -C -C for blame.
>=20
> Shouldn't it have died with "don't know option --find-copies-harder" =
then?

Unfortunately, it _does_ know --find-copies-harder, because unknown
options get sent to the revision option parser, which chains to the dif=
f
option parser. So it recognizes --find-copies-harder, but just sets a
flag that doesn't do what we expect.

I'm not sure if there is a simple fix. Does blame actually need the dif=
f
option parsing? If not, then we might be able to pass a flag to
parse_revision_opt that says "don't do diff options, too".

-Peff
