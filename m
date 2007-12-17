From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 12:59:39 +0100
Message-ID: <20071217115939.GJ7453@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7v7ijda81h.fsf@gitster.siamese.dyndns.org> <20071217115648.GI7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nEsDIrWrg+hrB7l1";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 13:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Edh-0004u2-FO
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935380AbXLQL7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764192AbXLQL7m
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:59:42 -0500
Received: from pan.madism.org ([88.191.52.104]:56104 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935123AbXLQL7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:59:41 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2EB0B3027D;
	Mon, 17 Dec 2007 12:59:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0E92A4BE7DB; Mon, 17 Dec 2007 12:59:39 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071217115648.GI7453@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68549>


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 11:56:48AM +0000, Pierre Habouzit wrote:
> On Mon, Dec 17, 2007 at 11:13:14AM +0000, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> >=20
> > >   Okay this is kind of disgusting, and I'm absolutely not pleased with
> > > it (I mean I'm not pleased that parse_opt forces us to write things l=
ike
> > > that). This hack allows:
> > >
> > >   git tag -l -n10 <pattern>
> > >
> > > and will then attach the <pattern> to the '-l' switch,...
> >=20
> > Heh, it turns out that we were both stupid and blind.
>=20
>   [...]
>=20
>   indeed, but then this happens to be a better patch than yours IMHO:
>=20
>=20
> From 5a3cdd255f17c7d7bc9245881f0d50146413113f Mon Sep 17 00:00:00 2001
> From: Pierre Habouzit <madcoder@debian.org>
> Date: Mon, 17 Dec 2007 12:54:55 +0100
> Subject: [PATCH] git-tag: fix -l switch handling regression.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-tag.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 274901a..219633d 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -16,7 +16,7 @@
>  static const char * const git_tag_usage[] =3D {
>  	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head=
>]",
>  	"git-tag -d <tagname>...",
> -	"git-tag [-n [<num>]] -l [<pattern>]",
> +	"git-tag -l [-n [<num>]] [<pattern>]",
>  	"git-tag -v <tagname>...",
>  	NULL
>  };
> @@ -370,13 +370,11 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  	struct ref_lock *lock;
> =20
>  	int annotate =3D 0, sign =3D 0, force =3D 0, lines =3D 0,
> -					delete =3D 0, verify =3D 0;
> -	char *list =3D NULL, *msgfile =3D NULL, *keyid =3D NULL;
> -	const char *no_pattern =3D "NO_PATTERN";
> +		list =3D 0, delete =3D 0, verify =3D 0;
> +	char *msgfile =3D NULL, *keyid =3D NULL;
>  	struct msg_arg msg =3D { 0, STRBUF_INIT };
>  	struct option options[] =3D {
> -		{ OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
> -			PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },
> +		OPT_INTEGER('l', NULL, &list, "list tag names"),
                ^^^^^^^^^^^
      that should obviously be OPT_BOOLEAN

>  		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
>  				"print n lines of each tag message",
>  				PARSE_OPT_OPTARG, NULL, 1 },
> @@ -408,7 +406,7 @@ int cmd_tag(int argc, const char **argv, const char *=
prefix)
>  		annotate =3D 1;
> =20
>  	if (list)
> -		return list_tags(list =3D=3D no_pattern ? NULL : list, lines);
> +		return list_tags(argv[0], lines);
>  	if (delete)
>  		return for_each_tag_name(argv, delete_tag);
>  	if (verify)
> --=20
> debian.1.5.3.7.1-dirty
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZmSrvGr7W6HudhwRAv1EAJ928raTTSc7T5KDc9PvGOco/cjqZQCfR3iX
RjTHXdKVUwkE+K788A1ICio=
=gDlT
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
