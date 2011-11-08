From: Jeff King <peff@peff.net>
Subject: Re: git log --quiet bug?
Date: Tue, 8 Nov 2011 18:20:43 -0500
Message-ID: <20111108232043.GA21957@sigill.intra.peff.net>
References: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
 <20111108212930.GA18529@sigill.intra.peff.net>
 <1320791465.67359.YahooMailNeo@web84006.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Prasad Deshpande <prasadgdeshpande@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 00:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNuyJ-0002iw-Mk
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 00:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab1KHXUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 18:20:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37190
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231Ab1KHXUq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 18:20:46 -0500
Received: (qmail 9135 invoked by uid 107); 8 Nov 2011 23:20:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 18:20:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 18:20:43 -0500
Content-Disposition: inline
In-Reply-To: <1320791465.67359.YahooMailNeo@web84006.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185118>

On Tue, Nov 08, 2011 at 02:31:05PM -0800, Prasad Deshpande wrote:

> Thanks for your response. I was actually trying to write a script to
> determine if a workspace has commits which=C2=A0haven't=C2=A0been pus=
hed to the
> repository.=C2=A0
> For this I was using the following in a bash script:
>=20
> =C2=A0 ..
> =C2=A0 git log origin..HEAD --quiet
> =C2=A0 if [ $? -ne 0 ]
> =C2=A0 then
> =C2=A0 =C2=A0 echo
>=20
> =C2=A0 =C2=A0 echo "git log shows files committed but not pushed.. AB=
ORTING"
> =C2=A0 =C2=A0 echo
> =C2=A0 =C2=A0 echo "************* `pwd` ***************"
> =C2=A0 =C2=A0 git log origin..HEAD --color --graph --stat
> =C2=A0 =C2=A0 exit 1
> =C2=A0 fi
>=20
> =C2=A0 What is the recommended way to do this?

Try:

  test -z "$(git rev-list -1 origin..HEAD)" &&
  echo nothing that needs pushing

You can also use --count to get the exact number, but if you just care
whether there is something or nothing, using "-1" lets git stop the
graph traversal immediately.

-Peff
