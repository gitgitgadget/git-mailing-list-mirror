From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 10:00:30 +0200
Message-ID: <20070919080030.GA28205@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org> <46F0C3AB.8010801@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="u3/rZRmxL6MmkK24";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuUA-0002ow-F5
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbXISIAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbXISIAd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:00:33 -0400
Received: from pan.madism.org ([88.191.52.104]:57191 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbXISIAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:00:32 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E23AC57F;
	Wed, 19 Sep 2007 10:00:30 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2DF3B18360; Wed, 19 Sep 2007 10:00:30 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46F0C3AB.8010801@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58684>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 06:37:31AM +0000, Andreas Ericsson wrote:
> Pierre Habouzit wrote:
> > diff --git a/builtin-blame.c b/builtin-blame.c
> >index e364b6c..16c0ca8 100644
> >--- a/builtin-blame.c
> >+++ b/builtin-blame.c
> >@@ -1430,8 +1430,7 @@ static void get_commit_info(struct commit *commit,
> > static void write_filename_info(const char *path)
> > {
> > 	printf("filename ");
> >-	write_name_quoted(NULL, 0, path, 1, stdout);
> >-	putchar('\n');
> >+	write_name_quoted(path, stdout, '\n');
> > }
> >=20
>=20
> This looks like a candidate for a macro. I'm not sure if gcc optimizes
> sibling calls in void functions with -O2, and it doesn't inline without
> -O3.

  Well, there is little point. write_name_quoted behaviour changes if
the last argument is \0 or non-\0 (see patch comment and quote.c code),
so it does not really matter to inline the "putchar" IMHO.

> > -static void diff_flush_raw(struct diff_filepair *p,
> >-			   struct diff_options *options)
> >+static void diff_flush_raw(struct diff_filepair *p, struct diff_options=
=20
> >*opt)
>=20
> Parameter rename? I'd have thought the patch was big enough as it is ;-)

  I'm anal when it comes to code: the rule of the least surprise should
apply, and consistency is fundamental. And it happens that diff_options
are always called `opt' in diff.c, except in that place (and it allows
to write the prototype of the function on one line).

> Other than that, the diffstat calls this a good patch, and given the
> fact that all your previous series passed all tests, I assume this one
> does too.

  Yes, before submitting a series I check the testsuite passes at each
step, so that it doesn't break git-bisect in obvious ways.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8NcevGr7W6HudhwRAjuEAJ40cSXxXndrju3apCUfs37X0p987ACgg6Ac
cBjHhBB5K/HxR0wwO5O2huc=
=LIK6
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
