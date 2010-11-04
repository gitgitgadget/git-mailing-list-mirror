From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff,difftool: Don't use the {0,2} notation in usage
 strings
Date: Thu, 4 Nov 2010 13:49:17 -0400
Message-ID: <20101104174917.GA30628@sigill.intra.peff.net>
References: <20101021222129.GA13262@burratino>
 <20101024155121.GA9503@headley>
 <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
 <87wrp12p00.fsf@gmail.com>
 <AANLkTinyPkGmsgbGM9qpXMNcZRzOXvtjDDEkJ-i3nWXz@mail.gmail.com>
 <87fwvl2d4d.fsf@gmail.com>
 <87hbfxgg86.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3vh-0007qO-IR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab0KDRsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 13:48:40 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45360 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab0KDRsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 13:48:38 -0400
Received: (qmail 1102 invoked by uid 111); 4 Nov 2010 17:48:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Nov 2010 17:48:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Nov 2010 13:49:17 -0400
Content-Disposition: inline
In-Reply-To: <87hbfxgg86.fsf_-_@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160740>

On Thu, Nov 04, 2010 at 06:18:17PM +0100, =C5=A0t=C4=9Bp=C3=A1n N=C4=9B=
mec wrote:

> This was the only occurence of that usage, and square brackets are
> sufficient and already well-established for that purpose.
>=20
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
> ---
>=20
> As per discussion upthread, this notation is not worth keeping; hence
> not mentioning it in the v2 of the CodingGuidlines patch and this
> removal.

I agree the notation is kind of odd. But the intent of the original is
to point out that diff has several modes of operation, depending on the
number of arguments it is given. Your change seems to make that even
more subtle. I would be more in favor of showing the major modes of
operation, one per line, which is what we do in other places. E.g., see
git-branch(1).

Now in the case of diff, as soon as the "description" section starts, w=
e
do start talking about those modes (and there are a lot of them). But I
think it may make sense to cover them with a short comment in the
synopsis. Something like:


  # diff between index and working tree
  git diff [options] [--] [<path>...]

  # diff between HEAD and index
  git diff --cached [options] [--] [<path>...]

  # diff between commit and working tree
  git diff [options] <commit> [--] [<path>...]

  # diff between commit and index
  git diff --cached [options] <commit> [--] [<path>...]

  # diff between commits
  git diff [options] <commit> <commit> [--] [<path>...]

  # diff two paths
  git diff [options] [--] <path> <path>

which obviously is way more verbose, but I think it improves in two
ways:

  1. New users will immediately see what diff is for: it is the
     all-purpose diffing tool in git, and it has several modes of
     operation.

  2. People who know what diff does but need a quick reference on which
     mode they are looking for can quickly scan the list.

If it's too verbose, we could collapse a few cases (e.g., "HEAD and
index" and "commit and index" could come in one line).

-Peff
