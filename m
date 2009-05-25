From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: git submodule update --merge (Was: What's cooking in git.git
	(May 2009, #02; Sun, 17))
Date: Tue, 26 May 2009 09:15:46 +1000
Message-ID: <20090525231544.GA3999@dingo.bne.redhat.com>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302> <200905191526.40471.johan@herland.net> <200905251359.37619.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, markus.heidelberg@web.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 26 01:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8jni-00070k-UA
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 01:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbZEYXlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 19:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbZEYXln
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 19:41:43 -0400
Received: from leo.clearchain.com ([199.73.29.74]:50418 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbZEYXlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 19:41:42 -0400
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2009 19:41:42 EDT
Received: from leo.clearchain.com (localhost [127.0.0.1])
	by mail.clearchain.com (8.14.3/8.14.3) with ESMTP id n4PNGRSd043082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 May 2009 08:46:27 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
Received: (from whot@localhost)
	by leo.clearchain.com (8.14.3/8.14.3/Submit) id n4PNGPoh043081;
	Tue, 26 May 2009 08:46:25 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Content-Disposition: inline
In-Reply-To: <200905251359.37619.johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (mail.clearchain.com [127.0.0.1]); Tue, 26 May 2009 08:46:27 +0930 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119984>

On Mon, May 25, 2009 at 01:59:37PM +0200, Johan Herland wrote:
> On Tuesday 19 May 2009, Johan Herland wrote:
> > On Tuesday 19 May 2009, Johannes Schindelin wrote:
> > > On Tue, 19 May 2009, Johan Herland wrote:
> > > > I still don't see any reason why one should be added (--rebase)=
,
> > > > and not the other (--merge).
> > >
> > > When you rebase, you see your personal stuff (i.e. stuff that you
> > > do not want to submit, or not in its current form, or that you
> > > submitted and it waits for inclusion) on top of things right away=
=2E
> >
> > But if there are developers downstream whose work is based on your
> > submodule branch, the rebase will disrupt _their_ work, in the same
> > way that rebasing any other public branch would disrupt people's
> > work.
> >
> > > In contrast, if you merge, you will have a different state from t=
he
> > > upstream _forever_.  Even if your stuff gets included.
> >
> > Correct, but there are cases where reconciliation with the upstream
> > repo is less important than not disrupting downstream developers (s=
ee
> > below).
> >
> > > Needless to say, I do not see much use for the latter case, but
> > > tons for the former.
> >
> > I fully agree that for a regular downstream (or "leaf") developer,
> > there is not much use for git submodule rebase --merge.
> >
> > But not all developers fit nicely into your scenario above.
> >=20
> > [Workflow description in which "git submodule update --merge" would
> >  be a helpful addition]
> >
> > I understand that the above scenario is not common in the free
> > software world, but I believe it is much more common in an
> > enterprise/company setting. Therefore, the support of such workflow=
s
> > is important to companies that are currently considering (or have
> > already chosen) Git. I believe there is value in supporting such
> > workflows, especially when doing so is as straightforward as my pat=
ch
> > shows.
>=20
> I haven't received any replies to my attempt to describe the context =
in=20
> which "git submodule update --merge" is useful. A hint as to whether =
my=20
> argument is valid, or just crap, would be nice.
>=20
> In any case, even if we don't include "git submodule update --merge",=
=20
> could we _please_ consider changing the associated config variable fr=
om
>=20
> =A0 submodule.<name>.rebase =3D true/false (false if unset)
>=20
> to something like
>=20
> =A0 submodule.<name>.update =3D checkout/rebase (checkout if unset)
>=20
> or (Junio's suggestion)
>=20
>   submodule.<name>.rebind =3D never/rebase (never if unset)
>=20
> so that we at least have the _option_ of adding other alternatives in=
=20
> the future?

I can't really chime in on the merge debate since it's not part of my
workflow, but I definitely support the above. Even if we never add any
options other than checkout/rebase, it's still better than the prospect=
 of
having possibly conflicting boolean settings in the future.

Cheers,
  Peter
