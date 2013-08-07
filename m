From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFH/PATCH 4/4] OPT__FORCE(): clarify its expected use by using
 OPT_COUNTUP
Date: Wed, 07 Aug 2013 09:33:16 +0200
Message-ID: <5201F83C.60503@googlemail.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org> <1375831889-9610-1-git-send-email-gitster@pobox.com> <1375831889-9610-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3363CAC89151D14CC280040A"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 09:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6yFG-0003Wz-Do
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab3HGHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 03:33:18 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:63176 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab3HGHdR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 03:33:17 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so665209eaj.12
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=D02SWs75mjJuvyK19MWXt1n7U+LJic4V+rMbKDfEkyM=;
        b=Kxb0C7SPDGFPvykDhUWdhjVbcO/m9s7r/fG2JGZySgwmbsyuc7lJIoq6TeMMV8iqjH
         bcuM4flThu6oeKhtmQXXZKkXz+H6T+WVBzG9Vu+Nu30TATpRfKogGHRhZ6DHAYpFJXho
         9rCyNy5tIAfKOESma2lJqUdAVh50HyDEVcNyGQ/6qjWRBt9MvUPo2KJxGE0tFeFHnNOX
         +rk+VB3Y15Uy6mU6gL0beuO7wZVxw7KR1mRoyCMW6jvyF/M9ywR3Q7mDteTJAycJ4kFp
         hNdWqrXXo2gB9trpLzO7vFXaMFrwUjCh8vwveyjDjAhreNjDzGjY+c6mSNngIV7FrE7n
         v/mQ==
X-Received: by 10.14.210.129 with SMTP id u1mr1740892eeo.68.1375860795749;
        Wed, 07 Aug 2013 00:33:15 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bq1sm7300579eeb.9.2013.08.07.00.33.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 00:33:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1375831889-9610-5-git-send-email-gitster@pobox.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231808>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3363CAC89151D14CC280040A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/07/2013 01:31 AM, Junio C Hamano wrote:
> The parseopt parsing for OPT__FORCE() is implemented in terms of
> OPT_BOOLEAN() and users of it can take advantage of the "counting
> up" behaviour to implement increasing levels of forcefulness by
> differentiating "git cmd -f" and "git cmd -f -f".
>=20
> Clarify this by explicitly using OPT_COUNTUP() instead.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * This _should_ be done with a similar audit of existing callers,
>    but I ran out of concentration.
>=20
>  parse-options.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/parse-options.h b/parse-options.h
> index 78f52c2..1eeb0d9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -238,7 +238,7 @@ extern int parse_opt_noop_cb(const struct option *,=
 const char *, int);
>  	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
>  	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
>  #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
> -#define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
> +#define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
>  #define OPT__ABBREV(var)  \
>  	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
>  	  N_("use <n> digits to display SHA-1s"),	\
>=20

We need the COUNTUP, because in builtin/clean.c we have
	OPT__FORCE(&force, N_("force")),
	...
	if (force > 1)
		rm_flags =3D 0;

So a OPT_BOOL definitely doesn't cut it.
Now that I started reviewing the OPT_FORCE parts, I realize
there is still an error in the patch, which needed correction.
(branch, commit, name-rev: ease up boolean conditions):

-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!=
unset_upstream > 1)
+	if (force_create + list + unset_upstream +
+	    !!delete + !!rename + !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);

force_create is set via OPT_FORCE as well, so we cannot remove the !! bef=
ore the force_create,
hence we'd only remove it from list and unset_upstream, which are set by =
OPT_BOOL.

-- 8< --
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Wed, 7 Aug 2013 09:32:25 +0200
Subject: [PATCH] branch, commit, name-rev: ease up boolean conditions

Now that the variables are set by OPT_BOOL, which makes sure
to have the values being 0 or 1 after parsing, we do not need
the double negation to map any other value to 1 for integer
variables.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c   | 3 ++-
 builtin/commit.c   | 2 +-
 builtin/name-rev.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4daed0b..0903763 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -872,7 +872,8 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 	if (with_commit || merge_filter !=3D NO_FILTER)
 		list =3D 1;
=20
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!=
unset_upstream > 1)
+	if (!!delete + !!rename + !!force_create + !!new_upstream +
+	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
=20
 	if (abbrev =3D=3D -1)
diff --git a/builtin/commit.c b/builtin/commit.c
index c20426b..b0f86c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1072,7 +1072,7 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 	if (patch_interactive)
 		interactive =3D 1;
=20
-	if (!!also + !!only + !!all + !!interactive > 1)
+	if (also + only + all + interactive > 1)
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be=
 used."));
 	if (argc =3D=3D 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a908a34..20fcf8c 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -331,7 +331,7 @@ int cmd_name_rev(int argc, const char **argv, const c=
har *prefix)
=20
 	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (!!all + !!transform_stdin + !!argc > 1) {
+	if (all + transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
--=20
1.8.4.rc0.16.g7fca822.dirty



--------------enig3363CAC89151D14CC280040A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAfg8AAoJEJQCPTzLflhqHusP/R4dkH4JaVopxrVyv+p3MVB+
9PoxGLKB9n9mA5dJxQUMxAGPrlPiaO5yrcYkbGmSC9p8q2856YSfozgwkVLLmpQ0
rwblUP7OAAiKSYL6GbbbUxX77a7P4a5AplcbLme4UMjp2D/9kz+pHTBoiuHHP597
i/ywUWlGfaq0TQkttiYmTMUPl3GWMf7x2u9zJ/q4pmFEltD8uvkeb/k74uDLumum
tUd4X3u4iDTEFlX/evnzXmta63pATpqzrrcZ1wsp4b8c8KwaJy/Js4rkY1IMWaHf
nGM08+511+S7ze2H1VMocjw98r23g8leCUfluGssFHXPiEiDa/oVEz8mJp6ffBqu
Pr7TNRAXoj29jqXmlsm2R8LFM1R6qNkjrIRrscghBz9Ax42h+3bhoTlvrwcaG0e4
k/LITQYr8othi3lWsZvQI6JdKpX5jk5Di0Mmo65gMiaXxTRntQ8U0JA7NnZka3Bw
d2NS7F9qMFXZybQZI46RAJvvl3JPxXhTRyHDW29rbUQnxdjdxHZQ9KMoOKRkgAnZ
z6b+Xys1o4Fy5UcTKe1FprD7U6zh8JTExkyid1Z2GBesav1RSzSt7E4Rfy/cyiVv
4yuGV2PQhcG6pJpLd1pKPnqSm1OQbmidbb4V51VUfFAwPErmBBSmF5Dimdu9KAbc
NbjdeyXcstpW7yFQx3N0
=E440
-----END PGP SIGNATURE-----

--------------enig3363CAC89151D14CC280040A--
