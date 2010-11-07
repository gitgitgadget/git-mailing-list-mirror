From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] attr: support quoting pathname patterns in C style
Date: Sun, 7 Nov 2010 15:05:07 +0700
Message-ID: <20101107080507.GA29738@do>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
 <1288878944-14066-1-git-send-email-pclouds@gmail.com>
 <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 09:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF0Gd-0000aG-Mj
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 09:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab0KGIGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 03:06:16 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab0KGIGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 03:06:15 -0500
Received: by pzk28 with SMTP id 28so681334pzk.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xtkcczhpJ2I6I6SVNcFMILJxo9C+9zRqgymbHhf3G88=;
        b=bloCKQBJXRSw9svRy8XSQb2nSti/0wkPs+H/hpbDo5yfjC/6FAatFQvnv+9Hc0AQUg
         +1bZkRI3TF99axYLc8zIBFJKyzLKI4+cQuDcTodj1BvIhScZN/EpMKSC0kkw8jHkKnh2
         QG9CoKtQnmP0nJDWFXnecvZ409U6Khkbqgn7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QthEVmOQCLyIF2q3YB6A6/KFiH1TBiNN/gSjlI3O3C3/3Mt3SXb4zMP/yxCZ7rRICy
         9DLe5yb9qhGSkMJCbY1WewBhaga/O29TOZTgFOs3Rms4mN+nhaCV1OeoRju5YmO7AOZ6
         jTPY/WhyvYcDgjMuySH5l2beaBBQqjQwPye38=
Received: by 10.143.165.15 with SMTP id s15mr3780233wfo.154.1289117175162;
        Sun, 07 Nov 2010 01:06:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.233.195])
        by mx.google.com with ESMTPS id w42sm5526509wfh.3.2010.11.07.01.06.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 01:06:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 07 Nov 2010 15:05:07 +0700
Content-Disposition: inline
In-Reply-To: <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160867>

=46ull pattern must be quoted. So 'pat"t"ern attr' will give exactly
'pat"t"ern', not 'pattern'.

If Git fails to unquote it, it warns users and takes the pattern
literally. This keeps existing patterns that begin with a double
quotation mark work until they get annoyed by the warnings and fix
their patterns.

Also clarify that leading whitespaces are not part of the pattern and
document comment syntax.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Nov 05, 2010 at 09:58:46AM -0700, Junio C Hamano wrote:
 > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
 >=20
 > > Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
 > > 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces =
are
 > > not part of the pattern and document comment syntax.
 > >
 > > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
 > > ---
 > >  Obvious regression: patterns that begin with double quote will
 > >  now work differently.
 >=20
 > I'm really hesitant to pursue this route and break people's existing
 > setups

 How about this? No more breaking current setups.
 =20
 Documentation/gitattributes.txt |    8 +++++---
 attr.c                          |   32 ++++++++++++++++++++++++++++---=
-
 t/t0003-attributes.sh           |   21 ++++++++++++++++++++-
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index c80ca5d..f7954dd 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,9 +21,11 @@ Each line in `gitattributes` file is of form:
 	pattern	attr1 attr2 ...
=20
 That is, a pattern followed by an attributes list,
-separated by whitespaces.  When the pattern matches the
-path in question, the attributes listed on the line are given to
-the path.
+separated by whitespaces. Leading and trailing whitespaces are
+ignored. Lines that begin with '#' are ignored. Patterns
+that begin with a double quotation mark are quoted in C style.
+When the pattern matches the path in question, the attributes
+listed on the line are given to the path.
=20
 Each attribute can be in one of these states for a given path:
=20
diff --git a/attr.c b/attr.c
index 6aff695..fdc4aae 100644
--- a/attr.c
+++ b/attr.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "quote.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
@@ -181,21 +182,40 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 {
 	int namelen;
 	int num_attr;
-	const char *cp, *name;
+	const char *cp, *name, *ep;
 	struct match_attr *res =3D NULL;
 	int pass;
 	int is_macro;
+	struct strbuf pattern =3D STRBUF_INIT;
=20
 	cp =3D line + strspn(line, blank);
 	if (!*cp || *cp =3D=3D '#')
 		return NULL;
 	name =3D cp;
-	namelen =3D strcspn(name, blank);
+	if (*cp =3D=3D '"') {
+		if (unquote_c_style(&pattern, name, &ep)) {
+			fprintf(stderr, "Misquoted pattern at %s:%d\n"
+				"Pattern is taken literally.\n",
+				src, lineno);
+			namelen =3D strcspn(name, blank);
+			ep =3D name + namelen;
+		}
+		else {
+			namelen =3D ep - name;
+			name =3D pattern.buf;
+		}
+	}
+	else {
+		namelen =3D strcspn(name, blank);
+		ep =3D name + namelen;
+	}
+
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
+			strbuf_release(&pattern);
 			return NULL;
 		}
 		is_macro =3D 1;
@@ -206,6 +226,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 			fprintf(stderr,
 				"%.*s is not a valid attribute name: %s:%d\n",
 				namelen, name, src, lineno);
+			strbuf_release(&pattern);
 			return NULL;
 		}
 	}
@@ -215,12 +236,14 @@ static struct match_attr *parse_attr_line(const c=
har *line, const char *src,
 	for (pass =3D 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills */
 		num_attr =3D 0;
-		cp =3D name + namelen;
+		cp =3D ep;
 		cp =3D cp + strspn(cp, blank);
 		while (*cp) {
 			cp =3D parse_attr(src, lineno, cp, &num_attr, res);
-			if (!cp)
+			if (!cp) {
+				strbuf_release(&pattern);
 				return NULL;
+			}
 		}
 		if (pass)
 			break;
@@ -238,6 +261,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 		res->is_macro =3D is_macro;
 		res->num_attr =3D num_attr;
 	}
+	strbuf_release(&pattern);
 	return res;
 }
=20
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 25205ac..7c55482 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -10,17 +10,32 @@ attr_check () {
 	expect=3D"$2"
=20
 	git check-attr test -- "$path" >actual &&
-	echo "$path: test: $2" >expect &&
+	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual
=20
 }
=20
+attr_check_quote () {
+
+	path=3D"$1"
+	quoted_path=3D"$2"
+	expect=3D"$3"
+
+	git check-attr test -- "$path" >actual &&
+	echo "\"$quoted_path\": test: $expect" >expect &&
+	test_cmp expect actual
+
+}
=20
 test_expect_success 'setup' '
=20
 	mkdir -p a/b/d a/c &&
 	(
 		echo "[attr]notest !test"
+		echo "\"c	test=3Dc"
+		echo "\" d \"	test=3Dd"
+		echo " e	test=3De"
+		echo " e\"	test=3De"
 		echo "f	test=3Df"
 		echo "a/i test=3Da/i"
 		echo "onoff test -test"
@@ -44,6 +59,10 @@ test_expect_success 'setup' '
=20
 test_expect_success 'attribute test' '
=20
+	attr_check_quote \"c \\\"c c &&
+	attr_check " d " d &&
+	attr_check e e &&
+	attr_check_quote e\" e\\\" e &&
 	attr_check f f &&
 	attr_check a/f f &&
 	attr_check a/c/f f &&
--=20
1.7.3.2.210.g045198
