From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 17:41:13 +0100
Message-ID: <20091208164113.GB2005@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <20091208160822.GA1299@atjola.homenet>
 <20091208161142.GA32045@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI37r-0002Ha-F5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbZLHQlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 11:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbZLHQlL
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:41:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932574AbZLHQlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 11:41:10 -0500
Received: (qmail invoked by alias); 08 Dec 2009 16:41:15 -0000
Received: from i59F55883.versanet.de (EHLO atjola.homenet) [89.245.88.131]
  by mail.gmx.net (mp053) with SMTP; 08 Dec 2009 17:41:15 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19OWxZMxmlO+95a/ymBceoWuWyMDsv9thho0ZqkF7
	Id3mrSVEljoYAg
Content-Disposition: inline
In-Reply-To: <20091208161142.GA32045@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134894>

On 2009.12.08 18:11:44 +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2009 at 05:08:22PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> > > Add --revisions flag to rebase, so that it can be used
> > > to apply an arbitrary range of commits on top
> > > of a current branch.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >=20
> > > I've been wishing for this functionality for a while now,
> > > so here goes. This isn't yet properly documented and I didn't
> > > write a test, but the patch seems to work fine for me.
> > > Any early flames/feedback?
> >=20
> > This pretty much reverses what rebase normally does. Instead of "re=
base
> > this onto that" it's "'rebase' that onto this". And instead of upda=
ting
> > the branch head that got rebased, the, uhm, "upstream" gets updated=
=2E
> >=20
> > Also, AFAICT this needs to be called like this:
> > git rebase --revisions foo..bar HEAD
> >=20
> > Changing the meaning of the <upstream> argument and relying on the =
fact
> > that <newbase> defaults to <upstream>. If such a thing gets added, =
it
> > should rather work like --root, not using <upstream> at all, but --=
onto
> > <newbase> only. Maybe defaulting to HEAD for <newbase> and making -=
-onto
> > optional, as it's reversed WRT what it does compared to the usual
> > rebase.
>=20
> Sorry, I had trouble parsing the above.  Could you suggest e.g. how t=
he
> help line should look?

Current:
git rebase [-i | --interactive] [options] [--onto <newbase>]
	<upstream> [<branch>]
git rebase [-i | --interactive] [options] --onto <newbase>
	--root [<branch>]

Add:
git rebase [-i | --interactive] [options] --revisions <range> [<branch>=
]

(Thinking about it, I guess an explicit --onto makes no sense with the
--revisions flag)

> > But generally, I'd say it would be better to add such a range featu=
re to
> > cherry-pick than abusing rebase for that.
>=20
> The reason to use rebase is that I often want to combine
> this with -i flag, editing patches as they are applied.

Hm, well, your patch didn't touch git-rebase--interactive.sh ;-)

Bj=F6rn
