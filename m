From: Jeff King <peff@peff.net>
Subject: Re: Git messes up =?utf-8?B?J8O4?= =?utf-8?Q?'?= character
Date: Tue, 20 Jan 2015 16:20:49 -0500
Message-ID: <20150120212049.GA22103@peff.net>
References: <54BEB08D.9090905@tronnes.org>
 <54BEB585.2030902@web.de>
 <54BEB7ED.2050103@tronnes.org>
 <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <notro@tronnes.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:20:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgEL-0001iW-8E
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbATVUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 16:20:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:36531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751474AbbATVUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 16:20:51 -0500
Received: (qmail 10786 invoked by uid 102); 20 Jan 2015 21:20:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 15:20:51 -0600
Received: (qmail 23958 invoked by uid 107); 20 Jan 2015 21:21:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 16:21:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2015 16:20:49 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262690>

On Tue, Jan 20, 2015 at 09:45:46PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> What's happened here is that:
>=20
>  1. You've authored your commit in ISO-8859-1
>  2. Git itself has no place for the encoding of the author name in th=
e
> commit object format

Is (2) right? The "encoding" header in a commit object should apply not
just to the commit message, but also to the author (and committer) name=
=2E

I think the real problem is simply that it defaults to UTF-8, but he is
giving it iso-8859-1 characters. Setting i18n.commitEncoding should fix
it.

-Peff

PS If you try experimenting with this, you may fall afoul of 08a94a1
   (commit/commit-tree: correct latin1 to utf-8, 2012-06-28), which wil=
l
   silently "correct" Latin1 characters into UTF-8 (when the commit
   message is expected to be in UTF-8, of course). So it actually
   _should_ just work under modern gits, but only for Latin1.
