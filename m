From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH] merge-recursive: option to disable renames
Date: Mon, 15 Feb 2016 22:50:34 -0200
Message-ID: <1455583834-4796-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 01:52:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVTsM-0000ez-Jt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 01:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcBPAwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 19:52:19 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35647 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbcBPAwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 19:52:18 -0500
Received: by mail-qg0-f49.google.com with SMTP id y89so122684546qge.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 16:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=1QkMpbN9XqpNiOFAgM8U/HZadXbQFRoRR0sg2m8kzsM=;
        b=VjMGmrvfeivlwRTjeRsxPMI+57hfNcEah73Rm0JVULh05G8kcOOjUu3km40BNEwKq3
         EKXIBoS9UstoIN/7MhnzH/ZcBRJLF6OKk5GkH8eDtMO6+1YvrklU+Kxe6fwbn14q+YeB
         NdmqRCN86sLC9zvaXHCcED5GsS6lE1YRMHZ8was3qtd9aw1x2/8K2JIx0eBY4+EVqNr8
         zxrhYrJAdNA3i3i1P0dxIBD47MToXYg6LG44Bjt2Bm135QiQSTkFIW8AO1/y/pp3aK+i
         cQZTmBrKMb1QLVipjwBnlLck0iNM1qA4cPvzHFrp/b+eNBTuLGnE7oUYBbNQS+e9ACyL
         2W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=1QkMpbN9XqpNiOFAgM8U/HZadXbQFRoRR0sg2m8kzsM=;
        b=b4n0LZqqIA92/EZjt9P6TuL2378sAdDcRg1Ccq8dxHFa/X+GqGqCXEMtfIIHZUZ6dm
         gVaoNYuY4Eao53kLju8gCBqBxJuBfkdW/eEjEp4y/0y4hpTkvdNScReePnb9dMQR3+o9
         z/fjMdhKXA8orAqmDdEDaVEY33JlZdEKEs6pkWj8MS+ygRa7oJur3gNLjck81BPeH1WT
         mX3drBP4hzC4c9zjemTAgKEiqeVDoqmrhEjV22+E49QS/1R5wMym4nIpmsyJeTa7UtPG
         hqHMsCNQUYl2V5nHH84EHliWFgjem46cKGUPRJrizava7HmxUcOQdpdpl3g3ZyNqMrKf
         mjxw==
X-Gm-Message-State: AG10YOQNMFqhlDuVwAXCg7zdJB3Pea7lw+yV9OTrlzPuYQCm837lCgThOPaKZwbIn/Rs9g==
X-Received: by 10.140.95.117 with SMTP id h108mr23874633qge.65.1455583937514;
        Mon, 15 Feb 2016 16:52:17 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id r123sm10172306qha.8.2016.02.15.16.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 16:52:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.287.g4943984
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286296>

The recursive strategy turns on rename detection by default. Add a
strategy option to disable rename detection even for exact renames.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Hi, this is a patch relative to the "Custom merge driver with no rename
detection" thread, based on suggestions by Junio C Hamano.

 Documentation/merge-strategies.txt |  4 ++++
 merge-recursive.c                  | 16 +++++++++++++---
 merge-recursive.h                  |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 7bbd19b..0528d85 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -81,6 +81,10 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
=20
+no-renames;;
+	Turn off rename detection.
+	See also linkgit:git-diff[1] `--no-renames`.
+
 rename-threshold=3D<n>;;
 	Controls the similarity threshold used for rename detection.
 	See also linkgit:git-diff[1] `-M`.
diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..ca67805 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1839,9 +1839,16 @@ int merge_trees(struct merge_options *o,
=20
 		entries =3D get_unmerged();
 		record_df_conflict_files(o, entries);
-		re_head  =3D get_renames(o, head, common, head, merge, entries);
-		re_merge =3D get_renames(o, merge, common, head, merge, entries);
-		clean =3D process_renames(o, re_head, re_merge);
+		if (o->detect_rename) {
+			re_head  =3D get_renames(o, head, common, head, merge, entries);
+			re_merge =3D get_renames(o, merge, common, head, merge, entries);
+			clean =3D process_renames(o, re_head, re_merge);
+		}
+		else {
+			re_head  =3D xcalloc(1, sizeof(struct string_list));
+			re_merge =3D xcalloc(1, sizeof(struct string_list));
+			clean =3D 1;
+		}
 		for (i =3D entries->nr-1; 0 <=3D i; i--) {
 			const char *path =3D entries->items[i].string;
 			struct stage_data *e =3D entries->items[i].util;
@@ -2039,6 +2046,7 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
 	o->renormalize =3D 0;
+	o->detect_rename =3D DIFF_DETECT_RENAME;
 	merge_recursive_config(o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =3D
@@ -2088,6 +2096,8 @@ int parse_merge_opt(struct merge_options *o, cons=
t char *s)
 		o->renormalize =3D 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize =3D 0;
+	else if (!strcmp(s, "no-renames"))
+		o->detect_rename =3D 0;
 	else if (skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
 			return -1;
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..52f0201 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -17,6 +17,7 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
+	int detect_rename;
 	int diff_rename_limit;
 	int merge_rename_limit;
 	int rename_score;
--=20
2.7.1.291.gd6478c6
