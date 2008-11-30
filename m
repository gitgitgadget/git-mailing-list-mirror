From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] wt-status: show sparse checkout info
Date: Sun, 30 Nov 2008 17:54:38 +0700
Message-ID: <1228042478-1886-9-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
 <1228042478-1886-3-git-send-email-pclouds@gmail.com>
 <1228042478-1886-4-git-send-email-pclouds@gmail.com>
 <1228042478-1886-5-git-send-email-pclouds@gmail.com>
 <1228042478-1886-6-git-send-email-pclouds@gmail.com>
 <1228042478-1886-7-git-send-email-pclouds@gmail.com>
 <1228042478-1886-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jzn-0005sQ-Tu
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYK3K4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbYK3K4F
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:56:05 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:31243 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbYK3K4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:56:02 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2162618wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LtShBPNSChXNUI2aF9JG0AA2IXff9pbEuxAk98vf4U4=;
        b=wDG3ReGtVbI2mWpHW1sFnbsFJKBynexGx8vYB+d2fIQdRTbPUIuE9X3NdXgWajVNnT
         gHKomrrbRFg82Ew5//Nfk96mbIvANBqkYrw7kb64/YAhhxeSKdbQ2wNt7oTsGTJ2gzfD
         EWdXIUi9FPxwoMpg+3pwfxF0aL9lFVJK30h3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Z71iB0l4tMSKV2HEdJyRCrZwoZmYQgvSxNhbQHvp8JGfg9MzRdcQKR1FO70jqjJLhA
         quVEZKnA8S2dXHETOO4/P6SMqokAEde/8tifqQQMJOoeSAp49wf+/xNePEBBK6/Vxgi1
         ZeRCNqIzTWOhShH2EZcFQZMIcrc5dNsPwhbvE=
Received: by 10.142.139.14 with SMTP id m14mr4058613wfd.100.1228042561680;
        Sun, 30 Nov 2008 02:56:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id 30sm5186780wfa.41.2008.11.30.02.55.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:56:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:55:45 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101968>

This will make "git status" show core.defaultsparse and list of
orphaned files if present.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h |    1 +
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 3edae43..71cf809 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -20,6 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] =3D {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 	"\033[31m", /* WT_STATUS_NOBRANCH: red */
+	"\033[31m", /* WT_STATUS_ORPHANED: red */
 };
=20
 enum untracked_status_type show_untracked_files =3D SHOW_NORMAL_UNTRAC=
KED_FILES;
@@ -83,6 +84,16 @@ static void wt_status_print_dirty_header(struct wt_s=
tatus *s,
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
+static void wt_status_print_orphaned_header(struct wt_status *s)
+{
+	const char *c =3D color(WT_STATUS_HEADER);
+	color_fprintf_ln(s->fp, c, "# Orphaned files:");
+	color_fprintf_ln(s->fp, c, "#   (these are tracked, but marked no-che=
ckout and should not be present)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git update-index --checkout\" =
to remove no-checkout status)");
+	color_fprintf_ln(s->fp, c, "#   (otherwise remove them to avoid confu=
sion because git will ignore them)");
+	color_fprintf_ln(s->fp, c, "#");
+}
+
 static void wt_status_print_untracked_header(struct wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
@@ -211,6 +222,33 @@ static void wt_status_print_changed(struct wt_stat=
us *s)
 	run_diff_files(&rev, 0);
 }
=20
+static void wt_status_print_orphaned(struct wt_status *s)
+{
+	int i, show_header =3D 0;
+	struct stat st;
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	for (i =3D 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce =3D the_index.cache[i];
+
+		if (ce_checkout(ce) || lstat(ce->name, &st))
+			continue;
+
+		if (!show_header) {
+			wt_status_print_orphaned_header(s);
+			show_header =3D 1;
+		}
+
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_ORPHANED), "%s",
+				 quote_path(ce->name, -1, &buf, s->prefix));
+	}
+
+	if (show_header)
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),"#");
+}
+
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
 	struct child_process sm_summary;
@@ -344,8 +382,14 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 	}
=20
+	if (core_default_sparse) {
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Sparse patterns:=
 %s", core_default_sparse);
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+	}
+
 	wt_status_print_updated(s);
 	wt_status_print_changed(s);
+	wt_status_print_orphaned(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
 	if (show_untracked_files)
diff --git a/wt-status.h b/wt-status.h
index 78add09..52f1eb5 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -9,6 +9,7 @@ enum color_wt_status {
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
+	WT_STATUS_ORPHANED,
 };
=20
 enum untracked_status_type {
--=20
1.6.0.3.890.g95457
