From: Jeff King <peff@peff.net>
Subject: Re: Change default branch name (server side) while cloning a
 repository
Date: Fri, 27 Mar 2015 12:47:14 -0400
Message-ID: <20150327164714.GA10191@peff.net>
References: <1427459241861-7627964.post@n2.nabble.com>
 <551568CF.2050301@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Garbageyard <varuag.chhabra@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbXPm-0007T0-MP
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 17:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbbC0QrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2015 12:47:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:39160 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752291AbbC0QrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 12:47:17 -0400
Received: (qmail 26153 invoked by uid 102); 27 Mar 2015 16:47:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Mar 2015 11:47:17 -0500
Received: (qmail 855 invoked by uid 107); 27 Mar 2015 16:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Mar 2015 12:47:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Mar 2015 12:47:14 -0400
Content-Disposition: inline
In-Reply-To: <551568CF.2050301@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266378>

On Fri, Mar 27, 2015 at 03:27:27PM +0100, Stefan N=C3=A4we wrote:

> > If i now clone the repository on my local machine, then the default=
 branch
> > should be pointing to mainline and not master. However, the issue i=
s that it
> > still points to master. Am I /wrong/ in assuming that changing the =
entry in
> > file HEAD for a given repository on Git server will change the defa=
ult
> > branch while cloning? If I=E2=80=99m wrong, can anyone please tell =
me how can I
> > enforce this change on the /server/ side correctly?
>=20
> Works for me with  "gitolite3 v3.6.2-24-g8e36230 on git 2.3.4".

It may be related to the version.

Prior to v1.8.4.3, git servers did not communicate the symbolic ref dat=
a
to the client. The client guessed it based on which branch had the same
sha1 as HEAD, and if there was ambiguity, it guessed "master" over
others. So it would usually work, but would sometimes have odd results.

In v1.8.4.3, the server started advertising the name of the branch. You
need the client and server both to be that version or more recent for i=
t
to work (otherwise, git falls back to the guessing behavior).

-Peff
