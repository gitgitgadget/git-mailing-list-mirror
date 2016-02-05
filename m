From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] index-pack: add --append-pack=<path>
Date: Fri,  5 Feb 2016 15:57:52 +0700
Message-ID: <1454662677-15137-4-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcDq-0007MI-1n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbcBEI63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:29 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34379 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBEI61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:27 -0500
Received: by mail-pf0-f175.google.com with SMTP id o185so65521316pfb.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B7a6f4QK3Zc36luhqYXJ2afk7YPqiqpQSrYW0Tbxclw=;
        b=bwA7ZY0iEsaebjN6E1rboICRNpwI7S+SjKY2pfiSBmSjmk6KxeOvsvCFORkeNHxp/P
         pO0tLYtot6czoLZ8w2brY35Sz5iWv/8gk5ykF/m7HR3tREFOUQfF3N8qpiAi+sEqu/Lm
         Vc32ziBRhq1/rX+ybz0I/wh5LMvJK4YpR/wVcJ5iacczwq07h4y8EhyY+FkzXOEmn1la
         oeASfn9RW2nwV+GUcjcbnMbDOPas09mZdZ9wjb6yck0BIh2WzoURDOYoa7n1GCAlXJUF
         4lqX7Od3IBk/HTIZxR+2JZyi4FIy58yUTNHEuLL6Mmsugl1Dnm/707wEXQFqEVg7xRbi
         pJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=B7a6f4QK3Zc36luhqYXJ2afk7YPqiqpQSrYW0Tbxclw=;
        b=ckuDCKWcLe2DwSnV27K6X6vfEUL/R/QGCcH2w3SfVWfdWAieAscwOzKm9L3Y7l9iDf
         76NQF8hUsOeYqFSviAC6qt+mFB+qVAOoXT5gTKTODdJbeoXLEltJJNw89opL/hvhqS/9
         aNfic3quK3QQxMHKlfZzwwb+gOp+5sv2JP0Go27683/r3t0tGlBupFH7wK3i1zlQUS9q
         L/4JJlJnTfv6c530/mnsm2ueKlDIDUz2U1v7CzE2+x2PqwWr39xhfisNpOoAlw/CAFS2
         dCyTYjOlmbq7ixoFYIoRpVlGbQenU76gCJpa/a1t1HDJXrSaqyseSbRiuoN17AEM6Vjn
         f6YQ==
X-Gm-Message-State: AG10YOTVvPjjvOvjbdUPzymn1OMuQmUMSCKwbn1eNo3dYkkUucK7LOXnR1rEr6b2fzKI8g==
X-Received: by 10.98.79.28 with SMTP id d28mr18017335pfb.77.1454662705858;
        Fri, 05 Feb 2016 00:58:25 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 69sm22746301pfj.20.2016.02.05.00.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:40 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285557>

In this mode (--append-pack --stdin), index-pack consumes current
content in <path> first without producing anything else, then
continues to read from stdin and append to <path>. This is the
consumer end of "pack-objects --skip".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 50 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6a01509..f099ac2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -73,6 +73,7 @@ static int nr_resolved_deltas;
 static int nr_threads;
=20
 static int from_stdin;
+static int skip_mode;
 static int strict;
 static int do_fsck_object;
 static struct fsck_options fsck_options =3D FSCK_OPTIONS_STRICT;
@@ -272,7 +273,29 @@ static void *fill(int min)
 	do {
 		ssize_t ret =3D xread(input_fd, input_buffer + input_len,
 				sizeof(input_buffer) - input_len);
-		if (ret <=3D 0) {
+
+		if (ret =3D=3D 0 && skip_mode) {
+			output_fd =3D input_fd;
+			input_fd =3D 0;
+			skip_mode =3D 0;
+			/*
+			 * At this point we have 'input_len' bytes in
+			 * input_buffer, which is from the existing pack.
+			 * Assuming that we still need to read more, the
+			 * next loop will read from stdin instead.
+			 *
+			 * What's read from stdin must be written down. The
+			 * next flush() will write from &input_buffer[0],
+			 * which appends the 'input_len' bytes from existing
+			 * pack to the pack again.
+			 *
+			 * Seek back to make this an overwrite (of same
+			 * content) instead of an append.
+			 */
+			if (input_len && lseek(output_fd, -input_len, SEEK_CUR))
+				die_errno(_("cannot seek back %d bytes"), input_len);
+		}
+		else if (ret <=3D 0) {
 			if (!ret)
 				die(_("early EOF"));
 			die_errno(_("read error on input"));
@@ -323,6 +346,26 @@ static const char *open_pack_file(const char *pack=
_name)
 	return pack_name;
 }
=20
+static const char *open_pack_for_append(const char *path)
+{
+	if (!from_stdin)
+		die(_("--append-pack must be used with --stdin"));
+
+	input_fd =3D open(path, O_CREAT|O_RDWR, 0600);
+	if (input_fd < 0)
+		die_errno(_("cannot open packfile '%s'"), path);
+	output_fd =3D -1;
+	nothread_data.pack_fd =3D input_fd;
+	git_SHA1_Init(&input_ctx);
+
+	/*
+	 * fill() will eventually turn this flag off and set output_fd
+	 * after reading everything
+	 */
+	skip_mode =3D 1;
+	return xstrdup(path);
+}
+
 static void parse_pack_header(void)
 {
 	struct pack_header *hdr =3D fill(sizeof(struct pack_header));
@@ -1692,6 +1735,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 					opts.off32_limit =3D strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (skip_prefix(arg, "--append-pack=3D", &arg)) {
+				curr_pack =3D open_pack_for_append(arg);
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1742,7 +1787,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	}
 #endif
=20
-	curr_pack =3D open_pack_file(pack_name);
+	if (!curr_pack)
+		curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	if (show_stat)
--=20
2.7.0.377.g4cd97dd
