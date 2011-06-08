From: Jeff King <peff@peff.net>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 17:51:32 -0400
Message-ID: <20110608215130.GA13021@sigill.intra.peff.net>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net>
 <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
 <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
 <vpqsjrkqmdj.fsf@bauges.imag.fr>
 <BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, thomas@xteddy.org,
	git@vger.kernel.org
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 23:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQfM-0006Oq-1Q
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 23:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1FHVvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 17:51:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50168
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446Ab1FHVvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 17:51:39 -0400
Received: (qmail 4723 invoked by uid 107); 8 Jun 2011 21:51:47 -0000
Received: from m9a2036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.154)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 17:51:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 17:51:32 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175463>

On Wed, Jun 08, 2011 at 08:03:26PM +0200, J=C3=A9r=C3=A9mie NIKAES wrot=
e:

> - I pull the "Et=C3=A9.mw" file from mediawiki
> - I edit it
> - When I commit it I get this message from git :
> [master sha1] commit message
> 1 files changed [...]
> create mode 100644 "Bl\303\251.mw"
>=20
> As a result, when I parse commit information, the title of the file i=
s
> indeed Bl\303\251... so a new page is created on the mediawiki.

Ick. I hope you aren't parsing the output of "git commit"; it's not
guaranteed to be stable.

But if you are parsing "diff", then yes, filenames with high-bit
characters (or special characters like tab or double-quote) may be
quoted C-style, and you should be unquoting them. Or, as Matthieu
suggested, use "-z" to get a NUL-terminated, non-quoted version.

-Peff
