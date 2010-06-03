From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [RFC/PATCH 1/4] textconv: make the API public
Date: Thu,  3 Jun 2010 12:47:15 +0200
Message-ID: <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 13:18:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK8Ri-00016h-Ej
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0FCLSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 07:18:43 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mx2.imag.fr ([129.88.30.17]:44534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab0FCLSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 07:18:41 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o53AfGm1001811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 3 Jun 2010 12:41:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o53AmgWY023199;
	Thu, 3 Jun 2010 12:48:42 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o53Amgx1008458;
	Thu, 3 Jun 2010 12:48:42 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o53AmgAL008455;
	Thu, 3 Jun 2010 12:48:42 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 Jun 2010 12:41:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o53AfGm1001811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148311>

The textconv functionality allows one to convert a file into text befor=
e
running diff. But this functionality can be useful to other features
such as blame.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 diff.c |   12 ++++--------
 diff.h |    8 ++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 494f560..b4a830f 100644
--- a/diff.c
+++ b/diff.c
@@ -43,10 +43,6 @@ static char diff_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
=20
-static void diff_filespec_load_driver(struct diff_filespec *one);
-static size_t fill_textconv(struct userdiff_driver *driver,
-			    struct diff_filespec *df, char **outbuf);
-
 static int parse_diff_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -1629,7 +1625,7 @@ void diff_set_mnemonic_prefix(struct diff_options=
 *options, const char *a, const
 		options->b_prefix =3D b;
 }
=20
-static struct userdiff_driver *get_textconv(struct diff_filespec *one)
+struct userdiff_driver *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
@@ -4002,9 +3998,9 @@ static char *run_textconv(const char *pgm, struct=
 diff_filespec *spec,
 	return strbuf_detach(&buf, outsize);
 }
=20
-static size_t fill_textconv(struct userdiff_driver *driver,
-			    struct diff_filespec *df,
-			    char **outbuf)
+size_t fill_textconv(struct userdiff_driver *driver,
+		     struct diff_filespec *df,
+		     char **outbuf)
 {
 	size_t size;
=20
diff --git a/diff.h b/diff.h
index 9ace08c..2a0e36d 100644
--- a/diff.h
+++ b/diff.h
@@ -9,6 +9,8 @@
 struct rev_info;
 struct diff_options;
 struct diff_queue_struct;
+struct diff_filespec;
+struct userdiff_driver;
=20
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -287,4 +289,10 @@ extern void diff_no_index(struct rev_info *, int, =
const char **, int, const char
=20
 extern int index_differs_from(const char *def, int diff_flags);
=20
+extern size_t fill_textconv(struct userdiff_driver *driver,
+			    struct diff_filespec *df,
+			    char **outbuf);
+
+extern struct userdiff_driver *get_textconv(struct diff_filespec *one)=
;
+
 #endif /* DIFF_H */
--=20
1.6.6.7.ga5fe3
