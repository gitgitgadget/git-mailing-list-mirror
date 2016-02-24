From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Wed, 24 Feb 2016 02:57:03 -0500
Message-ID: <20160224075702.GA12511@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
 <56CC2B2E.6070203@uni-graz.at>
 <1456298939.5430.1.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:57:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYUJr-0001Ah-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757966AbcBXH5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 02:57:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:48094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750846AbcBXH5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:57:06 -0500
Received: (qmail 21324 invoked by uid 102); 24 Feb 2016 07:57:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:57:05 -0500
Received: (qmail 5384 invoked by uid 107); 24 Feb 2016 07:57:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:57:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:57:03 -0500
Content-Disposition: inline
In-Reply-To: <1456298939.5430.1.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287183>

On Wed, Feb 24, 2016 at 08:28:59AM +0100, Dennis Kaarsemaker wrote:

> > So that's a "please don't" leave the code as-is but provide a=C2=A0
> > (transitional) solution that fixes the reported bug and has the bes=
t=C2=A0
> > chances of not causing any more headaches :)
>=20
> I am also actively using it. It's the only way (I know of) of trying =
to
> preview a merge result without attempting the actual merge, which is
> useful in some of my scripts.

OK. I guess we can live with the series I posted earlier (to simplify
the add/add behavior and fix the overflow), and leave it in place.

I _do_ think it's a useful concept, and there isn't something quite lik=
e
it in git right now. At one point I contemplated teaching unpack-trees
to do the content-level merges too, so you could do this via read-tree,
but I didn't ever polish it[1]. So I am sympathetic to the goal, and
there's not another way to do it as efficiently.

And now I feel like both of you have been warned that the code might be
crufty. :)

I'm not sure what we should do about warning others.  Since people are
using it, I don't want to put a deprecation warning. It's not "this wil=
l
be removed in the next version" anymore, but "watch out, this might be
crufty". I guess that can go in the manpage, but I'm not quite sure how
to word it.

-Peff

[1] It looks like my patch has been collecting dust since 2011:

      git://github.com/peff/git.git jk/read-tree-content-merge-wip

    It's been rebased along with all of my other topics since then, but
    otherwise I have no clue if it works or even compiles (it's not par=
t
    of my day-to-day build). Anyone is welcome to use it as a base if
    they want to pursue it.
