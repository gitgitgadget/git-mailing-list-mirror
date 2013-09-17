From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 1/2] repack: rewrite the shell script in C
Date: Tue, 17 Sep 2013 22:15:01 +0200
Message-ID: <5238B845.5080603@googlemail.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com> <1377808774-12505-2-git-send-email-stefanbeller@googlemail.com> <52359D10.1060901@web.de> <5235D2D0.9030203@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAC6204BB1F36ADF49556ACBE"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1fZ-0007IH-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3IQUOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:14:41 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:64064 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab3IQUOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:14:41 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so5637421wgg.20
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=6LZaswEcwuWm5dewwMrh0UIsWcdYh65gxeRpLi6Sx6Y=;
        b=EmGwnphcyxjcoqhSYron74y9uBbP+p4cFkF8NbofIQ6Pm6Uc1DU8TUp+x6v2jTPTQ9
         ZVk8VJiX2ex4zyigIF6S3HNOs6Yj2ojFDtYX6QlTfYZamCaoIJMDKq4CMgFyjwxL7zvc
         aYUJ1koXjTnd1beD8qtrnjNLg7sXxkPhn5V8uz4Tk6SpwH9+gEXZpsDyldLqyyzxC1Y5
         ybVLyMcCgh58ExRbhyt1kyWOWsxOpk9SGJ7JSlapy/3e+lk87c4EgQBn7SLS5meTgbNH
         PGYwD+Pm1PDv5JMsztXI6hhUAtOAy4ijLT0Mn0QGP5MtZQm6l8HnvMs0M76AwwSpWINA
         zHpA==
X-Received: by 10.194.222.2 with SMTP id qi2mr29022531wjc.14.1379448879938;
        Tue, 17 Sep 2013 13:14:39 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id dl10sm6386716wib.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 13:14:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <5235D2D0.9030203@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234916>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC6204BB1F36ADF49556ACBE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 09/15/2013 05:31 PM, Stefan Beller wrote:
> Rene, thank you very much for the review!

>=20
> the parameter hex contains the "pack-" already.
> The remove_redundant_pack function is called in a loop iterating over
> elements of existing_packs, which is filled in get_non_kept_pack_filena=
mes,
> which doesn't fill in the hex, but filenames without extension.
>=20
> I'll rename the variables to base_name and dir_name as you suggested.
>=20
>=20

I did write a lengthy paragraph, but forgot to actually to it.
---8<---

=46rom 92af79a5a89929d8834ff6d585c0455c867a774f Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Tue, 17 Sep 2013 22:04:14 +0200
Subject: [PATCH 1/2] Fixup missing by Rene.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f7e91bf..e5f90c6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -92,14 +92,14 @@ static void get_non_kept_pack_filenames(struct string=
_list *fname_list)
 	closedir(dir);
 }
=20
-static void remove_redundant_pack(const char *path_prefix, const char *h=
ex)
+static void remove_redundant_pack(const char *dir_name, const char *base=
_name)
 {
 	const char *exts[] =3D {".pack", ".idx", ".keep"};
 	int i;
 	struct strbuf buf =3D STRBUF_INIT;
 	size_t plen;
=20
-	strbuf_addf(&buf, "%s/%s", path_prefix, hex);
+	strbuf_addf(&buf, "%s/%s", dir_name, base_name);
 	plen =3D buf.len;
=20
 	for (i =3D 0; i < ARRAY_SIZE(exts); i++) {
--=20
1.8.4.273.ga194ead



--------------enigAC6204BB1F36ADF49556ACBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOLhFAAoJEJQCPTzLflhqTUEQAL6A9KahdIXFCqJicTmy9WcV
8j37ojDBDk7Cpy9QmDGD2OD1PR58GGpQCd9aOVnqqLJbvczPa+Z11KAzPYU3+LmU
9N3sPMhpVBPBDKOSOW7sPXe6rBsL5tgV3p6b6lIBkkubR1TSbQwHLQqWacMDHYfP
eIlHmQifhs/iZSO/nxJb/DbpizS3Q7zmPC1o0p/ABFBJLGDWd84zk6mm23JNcF5m
eXKCo3sa/xvOpdNOwINmFiqFdbOLl4vnZljfhYR05o7q5kZhvht7Drg+9G8OKZ6y
NRrSGgzO6Kw8tVZws8GvCFcIP3n9hgwy9Js85QO7zdW5d+niiWtBH9uDTERCfBWu
+Zfpl6GFNZ65A4B/uv3BPuo3EmTnkbvcaWS2+7KsWO5JBvEV/8q5U1B8N/mESnNs
UtbGIxmNuyR8kK0G+MBz6oGx3p9S4IkXMsviZUwh/5Ikhn6cGnWL2C2qruB4ppHO
cBPlph+tiCm0O6BYOwJcduRntUd4YjDjBIMpuSbAUhp9qKztLrq82YxjpBt7z/AD
sQPa69cctNC/pUmaGBATH74H2PF+A8WHOWPUm13HOlvGOqsYEOAU9CRleLytOnT5
38Dj3bzrTwMcdcUQW+MgWlMjywfJWQl3VdekdYY3AiWtoLuzrGlDqdsebNjb8jR0
RYg21+HwTENVGSTWhR55
=pZCz
-----END PGP SIGNATURE-----

--------------enigAC6204BB1F36ADF49556ACBE--
