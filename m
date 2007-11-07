From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
  when not needed
Date: Thu, 08 Nov 2007 00:21:30 +0100
Message-ID: <4732487A.4050100@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site> <Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org> <472F7B2F.4050608@lsrfire.ath.cx> <7vejf4kwry.fsf@gitster.siamese.dyndns.org> <4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx> <20071107001112.GD4382@artemis.corp> <20071107001458.GE4382@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 00:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpuDv-0006WI-9r
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbXKGXVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 18:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756278AbXKGXVs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:21:48 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:34054
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756446AbXKGXVr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 18:21:47 -0500
Received: from [10.0.1.201] (p57B7C524.dip.t-dialin.net [87.183.197.36])
	by neapel230.server4you.de (Postfix) with ESMTP id B235F873BA;
	Thu,  8 Nov 2007 00:21:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071107001458.GE4382@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63895>

Pierre Habouzit schrieb:
> {
>     const char *percent =3D strchrnul(fmt, '%');
>     while (*percent) {
>         strbuf_add(sb, fmt, percent - fmt);
>         fmt =3D percent + 1;
>=20
>         /* do your stuff */
>=20
>         percent =3D strchrnul(fmt, '%');
>     }
>     strbuf_add(sb, fmt, percent - fmt);
> }
>=20
>=20
> Which would require strchrnul, but it's trivial compat/ material for =
sure.

Grepping through the source I see several places that can be simplified
by converting them to strchrnul(), so I think introducing this GNU
extension is a good idea in any case.

Using strchr()/strchrnul() instead of strbuf_addch()'ing is sensible, o=
f
course.  I don't like the duplicate code in your sketch above, though.
I'll try to look into it later today.

Thanks!
Ren=E9
