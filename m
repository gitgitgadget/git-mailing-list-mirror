From: Jeff King <peff@peff.net>
Subject: Re: How does Git know which files no longer needed during upgrade?
Date: Wed, 4 Mar 2009 07:38:13 -0500
Message-ID: <20090304123813.GA17521@coredump.intra.peff.net>
References: <22318714.post@talk.nabble.com> <20090303233058.GE4371@genesis.frugalware.org> <20090304094951.GA32433@coredump.intra.peff.net> <loom.20090304T122643-455@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 13:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeqO4-00081q-Sk
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 13:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbZCDMiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 07:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbZCDMiV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 07:38:21 -0500
Received: from peff.net ([208.65.91.99]:33250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZCDMiU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 07:38:20 -0500
Received: (qmail 24248 invoked by uid 107); 4 Mar 2009 12:38:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 07:38:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 07:38:13 -0500
Content-Disposition: inline
In-Reply-To: <loom.20090304T122643-455@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112208>

On Wed, Mar 04, 2009 at 12:28:07PM +0000, Stefan N=C3=A4we wrote:

> > > cd /path/to/copy
> > > rm -rf *
> > > cp -a /path/to/new/version/* .
> > > git add -A
> > > git commit -m 'update foo to 2.0'
> >=20
> > Nit: "rm -rf *" will miss files starting with '.'. So it is probabl=
y
> > simpler to say what you mean: delete all files managed by git:
> >=20
> >   git ls-files -z | xargs -0 rm -f
>=20
> But maybe one wants to keep a .gitignore file.=20

True. The problem is that you have no way of saying "give me all the
files that git cares about, except the ones that I put there manually
and not from this tarball." If you guess that dot-files are manual and
everything else isn't, then that is easy, but not necessarily right.

If you tagged the last import, you use "git ls-tree" to get you the lis=
t
of files just from the tarball.

-Peff
