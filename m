From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] revert: change help_msg() to take no argument
Date: Tue, 1 Jun 2010 01:40:35 -0400
Message-ID: <20100601054034.GA6638@sigill.intra.peff.net>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.49459.chriscool@tuxfamily.org>
 <20100601050815.GB22441@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 07:40:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJKDV-0007m6-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 07:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab0FAFkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 01:40:40 -0400
Received: from peff.net ([208.65.91.99]:35942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab0FAFkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 01:40:39 -0400
Received: (qmail 24525 invoked by uid 107); 1 Jun 2010 05:40:45 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Jun 2010 01:40:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jun 2010 01:40:35 -0400
Content-Disposition: inline
In-Reply-To: <20100601050815.GB22441@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148079>

On Tue, Jun 01, 2010 at 12:08:15AM -0500, Jonathan Nieder wrote:

>   Automatic cherry-pick failed.
>     After resolving the conflicts,
>   mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
>   and commit the result with:=20
>=20
>   	git commit -c 8a7cdf
>=20
> Is there any reason not to suggest =E2=80=98git commit=E2=80=99 witho=
ut the -c?  This
> way, the template message includes a helpful Conflicts: string, too.

You cc'd me, which I guess means you git-blame'd the line in question.
But you really need to parent-blame about five steps back to find
f52463a (cherry-pick: Suggest a better method to retain authorship,
2007-03-04) from Dscho, which introduced the "commit -c" suggestion.

So the answer to your question is that "-c" will retain the proper
authorship of the cherry-picked commit. We could instead:

  1. Say only "git commit" when author =3D=3D committer.

  2. When author and committer do not match, explicitly say "git commit
     --author=3D...". This retains the "conflicts" information from the
     template.

Those are both easy.  Alternatively, we could actually make it stash th=
e
original authorship information somewhere (in addition to the commit
message template) and then pull it out automatically. That's harder, bu=
t
probably what the user would want (and it behaves more like a rebase
conflict).

-Peff
