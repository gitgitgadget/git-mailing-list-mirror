From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] tag: Use OPT_BOOL instead of OPT_BOOLEAN to allow one
 action multiple times
Date: Tue, 30 Jul 2013 23:28:48 +0200
Message-ID: <51F83010.2060804@googlemail.com>
References: <1375207251-4998-1-git-send-email-stefanbeller@googlemail.com> <7va9l3x34f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C950B04D2A0EB96C1BEE764"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 23:28:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4HTF-0001y0-B3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 23:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748Ab3G3V2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 17:28:35 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:64701 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728Ab3G3V2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 17:28:33 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so2083087eek.18
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=uFvPaYZuEVwIJ31qvCqxwlemQbyx8F/peAJNhnPa29c=;
        b=WEMngSiI5lZ6EKcZ+YOPV1Iolq5EPUmVCE9ERlcSiVTA6IEdF71cIZk9iiG6ccW1F/
         KlkLdBV6XpEYrN71eMYxM+3wFZkVNaugcF172ki4Tsnngml4I0LGo8XLErixwImvOutd
         9egYCukfEs7Wd75c3Z7k5kbKbLDZ7gphWnot+cPpXA1mk/xcGzW54mxBkjY3sAYfclIX
         Wp10fsXRCuD199bAiWP2qv+yDQc8OqLfgd2IeVVRbxeyZ26T+oFy9vKo2hpqzbeGNJ90
         Qmb4LfcKK37QIlbUh0kuX0UDph6fUklyH/rFOru4Vz2h138pobWPgSTPAEEAaOgCgi5K
         ZPlg==
X-Received: by 10.14.101.13 with SMTP id a13mr66581245eeg.86.1375219711635;
        Tue, 30 Jul 2013 14:28:31 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n5sm113488849eed.9.2013.07.30.14.28.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 14:28:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7va9l3x34f.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231392>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C950B04D2A0EB96C1BEE764
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/30/13 21:24, Junio C Hamano wrote:
>=20
> ... and then "git tag" may become like so.
>=20
>  builtin/tag.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/builtin/tag.c b/builtin/tag.c
> index af3af3f..d8ae5aa 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -436,18 +436,18 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  	struct ref_lock *lock;
>  	struct create_tag_options opt;
>  	char *cleanup_arg =3D NULL;
> -	int annotate =3D 0, force =3D 0, lines =3D -1, list =3D 0,
> -		delete =3D 0, verify =3D 0;
> +	int annotate =3D 0, force =3D 0, lines =3D -1;
> +	int cmdmode =3D 0;
>  	const char *msgfile =3D NULL, *keyid =3D NULL;
>  	struct msg_arg msg =3D { 0, STRBUF_INIT };
>  	struct commit_list *with_commit =3D NULL;
>  	struct option options[] =3D {
> -		OPT_BOOLEAN('l', "list", &list, N_("list tag names")),
> +		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
>  				N_("print <n> lines of each tag message"),
>  				PARSE_OPT_OPTARG, NULL, 1 },
> -		OPT_BOOLEAN('d', "delete", &delete, N_("delete tags")),
> -		OPT_BOOLEAN('v', "verify", &verify, N_("verify tags")),
> +		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete tags"), 'd'),
> +		OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'),
> =20
>  		OPT_GROUP(N_("Tag creation options")),
>  		OPT_BOOLEAN('a', "annotate", &annotate,
> @@ -489,22 +489,19 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  	}
>  	if (opt.sign)
>  		annotate =3D 1;
> -	if (argc =3D=3D 0 && !(delete || verify))
> -		list =3D 1;
> +	if (argc =3D=3D 0 && !cmdmode)
> +		cmdmode =3D 'l';
> =20
> -	if ((annotate || msg.given || msgfile || force) &&
> -	    (list || delete || verify))
> +	if ((annotate || msg.given || msgfile || force) && (cmdmode !=3D 0))
>  		usage_with_options(git_tag_usage, options);
> =20
> -	if (list + delete + verify > 1)
> -		usage_with_options(git_tag_usage, options);
>  	finalize_colopts(&colopts, -1);
> -	if (list && lines !=3D -1) {
> +	if (cmdmode =3D=3D 'l' && lines !=3D -1) {
>  		if (explicitly_enable_column(colopts))
>  			die(_("--column and -n are incompatible"));
>  		colopts =3D 0;
>  	}
> -	if (list) {
> +	if (cmdmode =3D=3D 'l') {
>  		int ret;
>  		if (column_active(colopts)) {
>  			struct column_options copts;
> @@ -523,9 +520,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  		die(_("--contains option is only allowed with -l."));
>  	if (points_at.nr)
>  		die(_("--points-at option is only allowed with -l."));
> -	if (delete)
> +	if (cmdmode =3D=3D 'd')
>  		return for_each_tag_name(argv, delete_tag);
> -	if (verify)
> +	if (cmdmode =3D=3D 'v')
>  		return for_each_tag_name(argv, verify_tag);
> =20
>  	if (msg.given || msgfile) {


Here is just another idea:=20
	if (cmdmode =3D=3D 'v')
This may be hard to read, (What is 'v'? I cannot remember=20
all the alphabet ;)) So maybe we could have an enum instead of
the last parameter?=20
OPT_CMDMODE( short, long, variable, description, enum)

Also the variable would then only need to be an enum accepting variable,
and not an integer accepting all integer range, so we'd also catch=20
typos or wrong values in such a case:
> +	if (argc =3D=3D 0 && !cmdmode)
> +		cmdmode =3D 'l'; // maybe 'l' is a typo and not existing?


--------------enig5C950B04D2A0EB96C1BEE764
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+DAQAAoJEJQCPTzLflhqIpgP/jHtEIlhlbOirdF2zx91VbOn
f3kYzJE6VB9JS02iKsRDzgFhS713qWi/NKGq0O06rD9Raai1/IAJ7rgFvJPPx0TQ
/i/+H6r3uj6qe0+VBp4+q50YsxEynG8ULkecTnZ1gNnIxYNkfdX4QyGUufFqbJVJ
TAfm4cOfF1DlsYrqmmcvSgql1qNVsQK2IPL7z1cg9roH9gLFue/Bnww+EfnUHlsK
KC40u/v1wfRgrlD3NhHpqgZWzRHuVExuKGzebntcj2apUeP6LXyfUTtRDdROLEQq
tfXIizavl4cNED6/em2gCmc3Rn81jLMWJUcOIFzreb7RUfuKSnzkaeD45aomO7dQ
3/ZqVc/1YaTrJRnOae2DlJtKGQxAO9kmjB816hHCg+YmUYF92OLff5+eeAW1nBoW
UT2qa3oYuBqr1ErA7fA3ejufH1obKWoO3m1cGU1YoAtasyY4IJm5dQrU1MuwlJ69
7EczCADHLYuLmZ/4OjaVNgIZkoiY4UZE7oyCICGlWnpHrXcWKCRuUiECabglTZ0+
dYghe+iHhciflaFOkblY8rDu4YVMbaul2z9TG4RtEvqINHFL8Lzqa0dKpk7I13nN
wwE4jTQ6B+PCRdtWW+WaH4wZOgklr/aE64lZBtrYtw46XVSBq0xg9UC5Op3VtyF6
C3AywVUTbO8Ud0PfKfFq
=9yGk
-----END PGP SIGNATURE-----

--------------enig5C950B04D2A0EB96C1BEE764--
