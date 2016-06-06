From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] diff.h: extend "flags" field to 64 bits because we're out of bits
Date: Mon,  6 Jun 2016 18:16:40 +0700
Message-ID: <20160606111643.7122-2-pclouds@gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas.braun@virtuell-zuhause.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 13:17:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sWj-00082a-I8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbcFFLQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:16:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33227 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcFFLQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 07:16:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id u67so1660855pfu.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+nPW+Pb9nw9w6RptoBF9kj1HXKszEijgCDY+gYJoGY=;
        b=tjOFjMzMPEEJWxsWzL4oe3b1KYrSHY5ZCdVjc9kT0qK0vlY7YyLYv0xz3xt1kxdALe
         aMkCGYmJyM+h07MFVeuU8qJWCwqlEFOyHhVMnqp0rGf3ksjzubc/tJzwOvsTZclbeSEn
         5WQfWQJ23pElDAPPzCh1E45kgE79cpO8Jb2UjjF0vx9ul42fkTNUpHXTYREhizI9elF4
         mBkgmF8FJuJT396Mz429kroXIpJZImQfXuOW6NoPzg/lfSSH+hCAjA6RLKpc90hgxu1a
         wb29M2YkFYGEadvuC1VbZYBufmR1bqTFEfMDmJIVXNjxBgtE7v6dhxzMVgITrAAuTMAm
         N5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+nPW+Pb9nw9w6RptoBF9kj1HXKszEijgCDY+gYJoGY=;
        b=Bkpks0hZtKy9uZv6CR7EJjZdm4ujLowB/b0gX2YNzHlsh5F+6FGk5gOlQ0V1wo8Igh
         8cWb1P0lfN5f8c+F/wsYoa1rYGvnlRv9YPZAjSAdJsDgYB16yDXqBwP+dDNFLrigoqlq
         XEre0B7b5M20JuL+X1nBSut9p8suIUeAP8fvRkN483N8/OuBmnp9Hffnlods0exFiwRU
         VmsGkYEvMG77TtWvgp2/9Smh5WKbDVEol4CmII48qCeSHat/eGToaM9zj5nkuTKWcSlC
         dxOkOTTHGFmqm2Idm5RVgEHcAJzsWDT3lMwyC8Tu5TlWmVEpz55c9mwfMv4yS+UO4dwC
         yWow==
X-Gm-Message-State: ALyK8tKzHwbyYFqqycy6ODo4F39w6hj5fqqkuUa2J4JXojBFUuE/t3fd4sYq/4pML5FftQ==
X-Received: by 10.98.30.133 with SMTP id e127mr24871292pfe.112.1465211815193;
        Mon, 06 Jun 2016 04:16:55 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id bf4sm24563929pac.4.2016.06.06.04.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 04:16:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:16:50 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160606111643.7122-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296498>

Current flags field is 32-bits, all used except one bit and we need one
more bit is needed for to toggle i-t-a behavior. The 9th bit could be
reused for this, but we could just extend it to 64 bits now to give roo=
m
for more future flags.

gcc -Wconversion is used to catch assignments that truncate bits. No ne=
w
warning was introduced (in fact one in index_differs_from() was
eliminated),

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 2 +-
 diff-lib.c       | 4 ++--
 diff.c           | 2 +-
 diff.h           | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 443ff91..fcfaa2b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -906,7 +906,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 			 * submodules which were manually staged, which would
 			 * be really confusing.
 			 */
-			int diff_flags =3D DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+			uint64_t diff_flags =3D DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				diff_flags |=3D DIFF_OPT_IGNORE_SUBMODULES;
diff --git a/diff-lib.c b/diff-lib.c
index bc49c70..27887d0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -71,7 +71,7 @@ static int match_stat_with_submodule(struct diff_opti=
ons *diffopt,
 {
 	int changed =3D ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
-		unsigned orig_flags =3D diffopt->flags;
+		uint64_t orig_flags =3D diffopt->flags;
 		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
 		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
@@ -516,7 +516,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	return 0;
 }
=20
-int index_differs_from(const char *def, int diff_flags)
+int index_differs_from(const char *def, uint64_t diff_flags)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
diff --git a/diff.c b/diff.c
index d3734d3..f70425f 100644
--- a/diff.c
+++ b/diff.c
@@ -4936,7 +4936,7 @@ int diff_can_quit_early(struct diff_options *opt)
 static int is_submodule_ignored(const char *path, struct diff_options =
*options)
 {
 	int ignored =3D 0;
-	unsigned orig_flags =3D options->flags;
+	uint64_t orig_flags =3D options->flags;
 	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
 		set_diffopt_flags_from_submodule_config(options, path);
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
diff --git a/diff.h b/diff.h
index 125447b..b497078 100644
--- a/diff.h
+++ b/diff.h
@@ -115,8 +115,8 @@ struct diff_options {
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
-	unsigned flags;
-	unsigned touched_flags;
+	uint64_t flags;
+	uint64_t touched_flags;
=20
 	/* diff-filter bits */
 	unsigned int filter;
@@ -348,7 +348,7 @@ extern int diff_result_code(struct diff_options *, =
int);
=20
 extern void diff_no_index(struct rev_info *, int, const char **);
=20
-extern int index_differs_from(const char *def, int diff_flags);
+extern int index_differs_from(const char *def, uint64_t diff_flags);
=20
 /*
  * Fill the contents of the filespec "df", respecting any textconv def=
ined by
--=20
2.8.2.524.g6ff3d78
