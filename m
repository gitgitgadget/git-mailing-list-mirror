From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] format-patch: always print diffstat in English
Date: Sun, 26 Aug 2012 02:26:56 +0700
Message-ID: <1345922816-20616-3-git-send-email-pclouds@gmail.com>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 21:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5M7L-0007SI-Is
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab2HYTdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Aug 2012 15:33:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44666 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334Ab2HYTd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 15:33:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so5316467pbb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u3Hru0LKYs0Rs+6wguhDbQF6aEZO3YHiLMau5rK/v28=;
        b=w6asYTH/vMKtQbDC9terrOkXJbr73TCvFtlFHJ8rzEs0nQ8JDMJWMNquqK0yyRTRzb
         BbrczM7o61lexWgwedUYyEE+97aB9MIDiMHlWxnTtp1MJSdgZveHximqAfF6s8wikpOK
         pBmSEPyOwKq3J1qh3Qzg5mTW/KPBr9+mfwc0+f6ppfvsLg2kLzHZkkzcBwFLjbh+sHJV
         Jgv0Ueh+BNjBzKs5SpUasIWFInkk5S9yTO5gn4xDfquEeEWuegtSBfJf/S113abvB0Tp
         pydaB1Jc0WCbottcaCydMgxJruf0vbz1TPv2Gij49nbFxMXUT1IC8iBGIEP0dDoStD63
         5BmQ==
Received: by 10.68.130.163 with SMTP id of3mr22915978pbb.108.1345923206730;
        Sat, 25 Aug 2012 12:33:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id iu10sm11030811pbc.45.2012.08.25.12.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 12:33:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Aug 2012 02:27:20 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204284>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 1 +
 diff.c        | 4 ++--
 diff.h        | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..62f4b7e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1225,6 +1225,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
=20
 	/* Always generate a patch */
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
+	rev.diffopt.no_l10n =3D 1;
=20
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
diff --git a/diff.c b/diff.c
index 47d7e50..a20cfcc 100644
--- a/diff.c
+++ b/diff.c
@@ -1687,7 +1687,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		extra_shown =3D 1;
 	}
 	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, 0, total_files, adds, dels);
+	print_stat_summary(options->file, options->no_l10n, total_files, adds=
, dels);
 }
=20
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
@@ -1716,7 +1716,7 @@ static void show_shortstats(struct diffstat_t *da=
ta, struct diff_options *option
 				options->output_prefix_data);
 		fprintf(options->file, "%s", msg->buf);
 	}
-	print_stat_summary(options->file, 0, total_files, adds, dels);
+	print_stat_summary(options->file, options->no_l10n, total_files, adds=
, dels);
 }
=20
 static void show_numstat(struct diffstat_t *data, struct diff_options =
*options)
diff --git a/diff.h b/diff.h
index eec79ef..ea4075d 100644
--- a/diff.h
+++ b/diff.h
@@ -125,6 +125,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int no_l10n;
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
--=20
1.7.12.rc1.27.g6d3049b.dirty
