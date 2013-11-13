From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] transport.c: mark push status strings for translation
Date: Wed, 13 Nov 2013 19:30:33 +0700
Message-ID: <1384345833-8345-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 13:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgZWY-0001WG-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 13:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759082Ab3KMM0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Nov 2013 07:26:19 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36059 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758730Ab3KMM0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 07:26:17 -0500
Received: by mail-ie0-f170.google.com with SMTP id to1so372829ieb.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 04:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RFDO3E1O/dWc1tKuu1UicfJMhvYDrNGJaivmevAMM/c=;
        b=AgUeaIKrzlxPPwDOu0PdHaABcVJJ33dM6wSXWqON4NHOGGRdfdU55X1hI/fLuT+cXL
         BkWhRc/ebd4Vo8L/GBe33yh3Y9I1c4iZKOdAw0k6fNjTGcJqJUcyb+ggaYo2fb026emm
         ZWJk9w+mFitzNAX/jRaz6ynSoBgdRyFaCYQ40phbE6riRvkKYpAWvQ+rphGUUkpBLV3o
         l2Ez1n1e2F/LHFYLyxisQEJHOoZfi+LQh8aFLQ0IaU7tJXS/JTQpLRQ+jjlMc9iox6XO
         9Wy5LyxFk9y2Xm8IMQlHVIrayhhYpzQguxE8/Tl1x//OQMB4xt8pCuXoW8XK626E69/d
         xybQ==
X-Received: by 10.50.22.67 with SMTP id b3mr18325088igf.39.1384345577168;
        Wed, 13 Nov 2013 04:26:17 -0800 (PST)
Received: from lanh ([115.73.231.62])
        by mx.google.com with ESMTPSA id w7sm29998685igp.1.2013.11.13.04.26.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 04:26:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Nov 2013 19:30:38 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237789>

Strings are only marked for translations, the actual lookup is delayed
until inside print_ref_status(), so we only have to check for
porcelain flag once.

While at there, mark some error strings in git push for translation
too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I was doing something else and stumbled upon this code block, the
 porcelain flag says there's low risk that this change may break
 something.

 builtin/push.c |  8 +++----
 transport.c    | 75 ++++++++++++++++++++++++++++++++------------------=
--------
 2 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..22e2d4c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -319,7 +319,7 @@ static int push_with_options(struct transport *tran=
sport, int flags)
=20
 	if (!is_empty_cas(&cas)) {
 		if (!transport->smart_options)
-			die("underlying transport does not support --%s option",
+			die(_("underlying transport does not support --%s option"),
 			    CAS_OPT_NAME);
 		transport->smart_options->cas =3D &cas;
 	}
@@ -426,7 +426,7 @@ static int option_parse_recurse_submodules(const st=
ruct option *opt,
=20
 	if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
 		      TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
-		die("%s can only be used once.", opt->long_name);
+		die(_("%s can only be used once."), opt->long_name);
=20
 	if (arg) {
 		if (!strcmp(arg, "check"))
@@ -434,9 +434,9 @@ static int option_parse_recurse_submodules(const st=
ruct option *opt,
 		else if (!strcmp(arg, "on-demand"))
 			*flags |=3D TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
 		else
-			die("bad %s argument: %s", opt->long_name, arg);
+			die(_("bad %s argument: %s"), opt->long_name, arg);
 	} else
-		die("option %s needs an argument (check|on-demand)",
+		die(_("option %s needs an argument (check|on-demand)"),
 				opt->long_name);
=20
 	return 0;
diff --git a/transport.c b/transport.c
index 7202b77..097b1fe 100644
--- a/transport.c
+++ b/transport.c
@@ -14,6 +14,7 @@
 #include "url.h"
 #include "submodule.h"
 #include "string-list.h"
+#include "utf8.h"
=20
 /* rsync support */
=20
@@ -627,16 +628,17 @@ static void print_ref_status(char flag, const cha=
r *summary, struct ref *to, str
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summary)=
;
+		int width =3D TRANSPORT_SUMMARY_WIDTH;
+		const char *localized_summary =3D _(summary);
+		/* compensate the invisible bytes in utf-8 strings */
+		width +=3D strlen(localized_summary) - utf8_strwidth(localized_summa=
ry);
+		fprintf(stderr, " %c %-*s ", flag, width, localized_summary);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_=
refname(to->name));
 		else
 			fputs(prettify_refname(to->name), stderr);
-		if (msg) {
-			fputs(" (", stderr);
-			fputs(msg, stderr);
-			fputc(')', stderr);
-		}
+		if (msg)
+			fprintf(stderr, " (%s)", _(msg));
 		fputc('\n', stderr);
 	}
 }
@@ -649,11 +651,11 @@ static const char *status_abbrev(unsigned char sh=
a1[20])
 static void print_ok_ref_status(struct ref *ref, int porcelain)
 {
 	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
+		print_ref_status('-', N_("[deleted]"), ref, NULL, NULL, porcelain);
 	else if (is_null_sha1(ref->old_sha1))
 		print_ref_status('*',
-			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
+			(!prefixcmp(ref->name, "refs/tags/") ? N_("[new tag]") :
+			 N_("[new branch]")),
 			ref, ref->peer_ref, NULL, porcelain);
 	else {
 		char quickref[84];
@@ -664,7 +666,7 @@ static void print_ok_ref_status(struct ref *ref, in=
t porcelain)
 		if (ref->forced_update) {
 			strcat(quickref, "...");
 			type =3D '+';
-			msg =3D "forced update";
+			msg =3D N_("forced update");
 		} else {
 			strcat(quickref, "..");
 			type =3D ' ';
@@ -678,50 +680,57 @@ static void print_ok_ref_status(struct ref *ref, =
int porcelain)
=20
 static int print_one_push_status(struct ref *ref, const char *dest, in=
t count, int porcelain)
 {
-	if (!count)
-		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);
+	if (!count) {
+		if (porcelain)
+			fprintf(stdout, "To %s\n", dest);
+		else
+			fprintf_ln(stderr, _("To %s"), dest);
+	}
=20
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL, porcelain);
+		print_ref_status('X', N_("[no match]"), ref, NULL,
+				 NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
-		print_ref_status('!', "[rejected]", ref, NULL,
-						 "remote does not support deleting refs", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, NULL,
+				 N_("remote does not support deleting refs"),
+				 porcelain);
 		break;
 	case REF_STATUS_UPTODATE:
-		print_ref_status('=3D', "[up to date]", ref,
-						 ref->peer_ref, NULL, porcelain);
+		print_ref_status('=3D', N_("[up to date]"), ref,
+				 ref->peer_ref, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "non-fast-forward", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, ref->peer_ref,
+				 N_("non-fast-forward"), porcelain);
 		break;
 	case REF_STATUS_REJECT_ALREADY_EXISTS:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "already exists", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, ref->peer_ref,
+				 N_("already exists"), porcelain);
 		break;
 	case REF_STATUS_REJECT_FETCH_FIRST:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "fetch first", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, ref->peer_ref,
+				 N_("fetch first"), porcelain);
 		break;
 	case REF_STATUS_REJECT_NEEDS_FORCE:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "needs force", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, ref->peer_ref,
+				 N_("needs force"), porcelain);
 		break;
 	case REF_STATUS_REJECT_STALE:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-						 "stale info", porcelain);
+		print_ref_status('!', N_("[rejected]"), ref, ref->peer_ref,
+				 N_("stale info"), porcelain);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
-		print_ref_status('!', "[remote rejected]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 ref->remote_status, porcelain);
+		print_ref_status('!', N_("[remote rejected]"), ref,
+				 ref->deletion ? NULL : ref->peer_ref,
+				 ref->remote_status, porcelain);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
-		print_ref_status('!', "[remote failure]", ref,
-						 ref->deletion ? NULL : ref->peer_ref,
-						 "remote failed to report status", porcelain);
+		print_ref_status('!', N_("[remote failure]"), ref,
+				 ref->deletion ? NULL : ref->peer_ref,
+				 N_("remote failed to report status"),
+				 porcelain);
 		break;
 	case REF_STATUS_OK:
 		print_ok_ref_status(ref, porcelain);
--=20
1.8.2.82.gc24b958
