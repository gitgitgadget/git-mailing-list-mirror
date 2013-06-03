From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] core: use env variable instead of config var to turn on logging pack access
Date: Tue,  4 Jun 2013 05:52:39 +0700
Message-ID: <1370299959-5573-1-git-send-email-pclouds@gmail.com>
References: <7vmwr7c59b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 00:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujdb4-0002ZT-0g
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab3FCWvW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 18:51:22 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62893 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab3FCWvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:51:21 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so6365907pbc.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mMD0Qwoa11QLBb3zcqEgbw9qSmiWjEpEu8Ao9gDuDBo=;
        b=itRoauacyNd+tilLION8wFkwYTj/3NRwgvY6whMVjtXKwWeqjomV5XepCQq1AjUV9y
         y+kSuLeFwjoNEFmA47v6veTvqGu52QCoyBoj4A0Psf+iSCFnAiinuVQVyIS1INGkzW4k
         R7y4XFSU9LhRSuewv3sZEdiRA5RNJBs/5l12eroOz5v+yZ4AAFpuYejhoPeBJiPzRS3d
         ysetAqI4JzqQh6qykYP7eZVu9mQhnSV/vIZjkV47T52Y7p1/AM75kZqzGoA3ZJttHKgR
         o6fXHo51cyHVqP5zx4ksn101w3R2Q3xXwI8VQJzgbiDfW7IbAZbJIdtVyRibokjvIqdG
         CqhA==
X-Received: by 10.68.162.163 with SMTP id yb3mr25299030pbb.212.1370299880587;
        Mon, 03 Jun 2013 15:51:20 -0700 (PDT)
Received: from lanh ([115.73.224.37])
        by mx.google.com with ESMTPSA id dc3sm22200986pbc.9.2013.06.03.15.51.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Jun 2013 15:51:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Jun 2013 05:52:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <7vmwr7c59b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226303>

5f44324 (core: log offset pack data accesses happened - 2011-07-06)
provides a way to observe pack access patterns via a config
switch. Setting an environment variable looks more obvious than a
config var, especially when you just need to _observe_, and more
inline with other tracing knobs we have.

Document it as it may be useful for remote troubleshooting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 >> + =C2=A0 =C2=A0 if (!*log_pack_access) {
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_pack_access =3D get=
env("GIT_TRACE_PACK_ACCESS");
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!*log_pack_access)
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 log_pack_access =3D NULL;
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!log_pack_access)
 >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;
 >> + =C2=A0 =C2=A0 }
 >
 > Have you ever tested this?
 >
 > Once log_pack_access goes to NULL (e.g. when it sees the empty
 > string it was initialized to), this new test will happily
 > dereference NULL.

 My bad. I did test when GIT_TRACE_PACK_ACCESS was set, not when it
 was set to an empty string. All cases tested now.

 Documentation/git.txt |  7 +++++++
 cache.h               |  3 ---
 config.c              |  3 ---
 sha1_file.c           | 10 ++++++++++
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 68f1ee6..c760918 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -838,6 +838,13 @@ for further details.
 	as a file path and will try to write the trace messages
 	into it.
=20
+'GIT_TRACE_PACK_ACCESS'::
+	If this variable is set to a path, a file will be created at
+	the given path logging all accesses to any packs. For each
+	access, the pack file name and an offset in the pack is
+	recorded. This may be helpful for troubleshooting some
+	pack-related performance problems.
+
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
diff --git a/cache.h b/cache.h
index df532f8..4f41606 100644
--- a/cache.h
+++ b/cache.h
@@ -772,9 +772,6 @@ extern int parse_sha1_header(const char *hdr, unsig=
ned long *sizep);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
=20
-/* for development: log offset of pack access */
-extern const char *log_pack_access;
-
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, =
unsigned long size, const char *type);
=20
 extern int move_temp_to_file(const char *tmpfile, const char *filename=
);
diff --git a/config.c b/config.c
index 830ee14..e68184f 100644
--- a/config.c
+++ b/config.c
@@ -675,9 +675,6 @@ static int git_default_core_config(const char *var,=
 const char *value)
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.logpackaccess"))
-		return git_config_string(&log_pack_access, var, value);
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			if (core_eol =3D=3D EOL_CRLF)
diff --git a/sha1_file.c b/sha1_file.c
index 67e815b..91c3627 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -36,6 +36,8 @@ static inline uintmax_t sz_fmt(size_t s) { return s; =
}
=20
 const unsigned char null_sha1[20];
=20
+static const char *log_pack_access =3D "";
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want read_sha1_file() to be able to return, but yet you do not want
@@ -1956,6 +1958,14 @@ static void write_pack_access_log(struct packed_=
git *p, off_t obj_offset)
 {
 	static FILE *log_file;
=20
+	if (!*log_pack_access) {
+		log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
+		if (log_pack_access && !*log_pack_access)
+			log_pack_access =3D NULL;
+		if (!log_pack_access)
+			return;
+	}
+
 	if (!log_file) {
 		log_file =3D fopen(log_pack_access, "w");
 		if (!log_file) {
--=20
1.8.2.83.gc99314b
