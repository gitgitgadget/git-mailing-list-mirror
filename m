From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 5/5] builtin-prune: protect objects listed on the command line
Date: Thu, 27 Mar 2008 22:11:43 +0100
Message-ID: <200803272211.44126.barra_cuda@katamail.com>
References: <200803232150.29971.barra_cuda@katamail.com> <7vve389lgc.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803271735010.3802@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 27 22:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JezEq-0002KF-Ln
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 22:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759887AbYC0VBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2008 17:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761382AbYC0VBW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 17:01:22 -0400
Received: from smtp.katamail.com ([62.149.157.154]:51166 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752779AbYC0VBV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 17:01:21 -0400
Received: (qmail 8810 invoked by uid 89); 27 Mar 2008 20:57:02 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host159-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.159)
  by smtp2-pc with SMTP; 27 Mar 2008 20:56:59 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0803271735010.3802@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78365>

On Thursday 27 March 2008, Johannes Schindelin wrote:
> On Thu, 27 Mar 2008, Junio C Hamano wrote:
>=20
> > Junio C Hamano <junio@pobox.com> writes:
> >=20
> > > From: Junio C Hamano <gitster@pobox.com>
> > > Date: Mon, 24 Mar 2008 23:20:51 -0700
> > >
> > > Finally, this resurrects the documented behaviour to protect othe=
r=20
> > > objects listed on the command line from getting pruned.
> > >
> > > Signed-off-by: Junio C Hamano <gitster@pobox.com> ---
> > > =A0* This is done deliberately differently from what you did. =A0=
Because=20
> > > =A0 =A0we do not want to accept "we allow losing what's reachable=
 from=20
> > > =A0 =A0master" with "git prune master..next", setup_revisions() i=
s not the=20
> > > =A0 =A0right thing to use for this command.
> >=20
> > Ping?
>=20
> I did not see any problem with your implementation

Me neither, but, as a nitpick, wouldn't something like

		if (!get_sha1(name, sha1)) {
			object =3D parse_object(sha1);
			if (!object)
				die("bad object %s", name);
		} else
			die("unrecognized argument: %s", name);

be a bit more useful?
