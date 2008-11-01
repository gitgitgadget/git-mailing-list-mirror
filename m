From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Sat, 01 Nov 2008 18:08:17 +0100
Message-ID: <20081101170817.GC26229@artemis.corp>
References: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081101022649.GB17961@sys-0.hiltweb.site> <20081101110439.GB3819@artemis.corp> <20081101130033.GD17961@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="oJ71EGRlYNjSvfq7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:09:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwJyh-0005sL-I9
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbYKARIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYKARIV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:08:21 -0400
Received: from pan.madism.org ([88.191.52.104]:58411 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbYKARIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:08:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AACC63B7EE;
	Sat,  1 Nov 2008 18:08:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 059CB5EE245; Sat,  1 Nov 2008 18:08:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081101130033.GD17961@sys-0.hiltweb.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99748>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 01:00:33PM +0000, Ian Hilt wrote:
> On Sat, Nov 01, 2008 at 12:04:39PM +0100, Pierre Habouzit wrote:
> > I didn't do it for a very good reason: the To field is tricker to parse
> > because very fast it's multiline, and must be split along the ',' when
> > parsed back and so on.
>=20
> Right.  So my patch is broken in that it doesn't parse the addresses
> correctly.  This _should_ be easy to fix.  I knew my patch sucked, but I
> wanted to get the idea out there.  For me, I don't like specifying all
> that information on the command-line.  It would be nice to be able to
> edit the To and Cc fields in the editor.
>=20
> > And even moreuseful than the To is the Cc list that git-send-email
> > bloats to death and that I would like to reduce very often.
>=20
> You mean git-send-email adds too many addresses to the Cc list, or the
> code for those fields is already bloated to death?

The former, I've not looked at the code I can't really say.

> > But sadly that needs an expertise of perl I absolutely don't have. We
> > probably even want to depend on some MIME perl library that knows about
> > those kind of issues and do it for us well.
>=20
> I'm confused here.  Why would a MIME library help?

Hmm maybe I'm wrong, but the idea would be to do what mutt does and be
able to parse:

To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,
  Superman <batman@nyc.us>,
  "Someone with a comma, inside its tag name" <a@b.com>

And that needs to know how to do that with perl, and _really_ I hate
perl enough for not being able to do that well. Splitting on ',' is just
not going to fly.

> > But yeah, I knew I left out those, and this was the reason.
>=20
> Anyway, do you, or does anyone else, think it's even worth coding the
> possibility for the user to edit the To and Cc fields?

*YES*

I would love to see git-send-email work like mutt does: it fills the
field like it does now, and you are allowed to fix that, and it parses
the buffer back to guess what you wanted. It allow to drop most of the
interactive prompting that is so annoying (since it's not in-shell and
has no history and stuff like that, unlike my $EDITOR).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMjQEACgkQvGr7W6HudhysRACcDP72MFS6Hc/ujOBhr8YFAgU9
RUkAn2+EUJuktwaQKW7JP4+oCJa18oIi
=2Esk
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
