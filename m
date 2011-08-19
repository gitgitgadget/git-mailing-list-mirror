From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection
 threshold.
Date: Fri, 19 Aug 2011 04:47:19 -0700
Message-ID: <20110819114719.GB15639@padd.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
 <1313706054-11740-2-git-send-email-vitor.hda@gmail.com>
 <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
 <CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 13:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuNXp-000500-NT
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 13:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1HSLrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 07:47:21 -0400
Received: from honk.padd.com ([74.3.171.149]:39376 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1HSLrU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 07:47:20 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id 95F045B51; Fri, 19 Aug 2011 04:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179693>

vitor.hda@gmail.com wrote on Fri, 19 Aug 2011 00:43 +0100:
> On Fri, Aug 19, 2011 at 12:04 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > This is not a new problem you introduced with this patch, but unles=
s you
> > are invoking "git config --bool" in your gitConfig() (I didn't both=
er to
> > check), you will misunderstand different ways to say "Yes", e.g.
> >
> > =A0 =A0 =A0 =A0[git-p4]
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D on
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D yes
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1
> >
> > If you use --bool, you can rely on the values being either true or =
false,
> > and do not have to do the .lower() thing.
> >
>=20
> Now that I look at this carefully, Tor added the possibility to add a=
rguments to
> gitConfig() exactly for that purpose. This is helpful for processing =
the
> detectCopiesHarder option I added.
>=20
> For detectRenames and detectCopies it is a bit more complex. I think =
that if I
> use --bool or --bool-or-int then it is possible that certain values w=
ill fail to
> be processed. Let me give you some examples:
>=20
>  =A0 =A0 =A0 =A0[git-p4]
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D true
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 80%
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 80
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1%
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1
>=20
> It will be difficult for me to, for example, to understand if a 1 rep=
resents 1%
> or true. Or am I overcomplicating this? :)

I think you have to decide that 1 means 1 in this case.
Everything else can mean true.  That may suggest that using
--bool or --bool-or-int isn't possible in this case.

		-- Pete
