From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 1/2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 23:11:34 -0200
Message-ID: <1455671495-10908-2-git-send-email-felipegassis@gmail.com>
References: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 02:13:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVqgG-0004cF-3H
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 02:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbcBQBNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 20:13:19 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33208 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793AbcBQBNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 20:13:17 -0500
Received: by mail-qg0-f45.google.com with SMTP id b35so1411503qge.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CVYJCiO5IcDqdjbLgYsShRsu+zEehQ46zJI/4wmv6Io=;
        b=vHWhMH6OQMxvcjpivEKJ6iSWWGS3Fo/8QSxxHIoM1GHnfPAlWMdFyA60O+G23EjX9M
         owlAa9RZrUwSK8u0N7CH7ZC/bhS9k1MsjxDm3qcAauBnNSHLTqApSMuq4JltROcf0Dsv
         mS2NueV07AkvgKXHv2RsCLWvdthjogSDZ11mfOwjlAx7hYYVJAVNy9qYNXB+W+TExcn7
         wsDvNJc5UsCGWv6kW0j0rR+Q3uDW6uUgU3SpyhNJDeYVS/yfqg+MVCvkCH/cdwY2LiuE
         mTZ4TS3VP2/o+/UghfRKKZ0PLWNxBDwhzUgo6fFVi5PU/93ZwurWgC0cIXAcw5MeBHu4
         Zsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CVYJCiO5IcDqdjbLgYsShRsu+zEehQ46zJI/4wmv6Io=;
        b=X7tbR8g/nEHSBPKH8SHmItnPKD1IDzRDJqHCJTikB3aF441nU6HQN04lUVO8K/timM
         /h1KSt1GncfFmzi8z3/OX+x4j+jL44O8/GyA9mSfzp6I2oYahej5DKXIVkV4VZ3LDs+3
         Zwo0rQPpRBZYWqqRVCHQYfh8Mk1f7TPPSBoVEppq9E5T5GN5CKGUXmOI6/k28kvjFNUm
         0Si+HJJXioNiDZZizDRtKZvq4GFAltUEf0TDP0RMSt++LfCMXJd3oO77OCVtnJm9wnFp
         r8UAdPsIqEUXpfhWY+EQ2sxpm7+VArhvwSjicgZSex+nSnwBMp2aqi8UxvK6/5/E9tkV
         3hEw==
X-Gm-Message-State: AG10YORPZdFiXmUcEYwU1FcYVi3lIQ3EARN+R4YejcRA+cGnJexnPoWllZFniQ3xnRZOeQ==
X-Received: by 10.141.4.139 with SMTP id g133mr32707435qhd.34.1455671596803;
        Tue, 16 Feb 2016 17:13:16 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id a88sm14361238qkj.32.2016.02.16.17.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 17:13:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.288.gfad33a8
In-Reply-To: <1455671495-10908-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286470>

The recursive strategy turns on rename detection by default. Add a
strategy option to disable rename detection even for exact renames.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 Documentation/merge-strategies.txt | 6 ++++++
 merge-recursive.c                  | 7 +++++++
 merge-recursive.h                  | 1 +
 3 files changed, 14 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 7bbd19b..1a5e197 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -81,8 +81,14 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
=20
+no-renames;;
+	Turn off rename detection.
+	See also linkgit:git-diff[1] `--no-renames`.
+
 rename-threshold=3D<n>;;
 	Controls the similarity threshold used for rename detection.
+	Re-enables rename detection if disabled by a preceding
+	`no-renames`.
 	See also linkgit:git-diff[1] `-M`.
=20
 subtree[=3D<path>];;
diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..6dd0a11 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -482,6 +482,9 @@ static struct string_list *get_renames(struct merge=
_options *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
@@ -2039,6 +2042,7 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
 	o->renormalize =3D 0;
+	o->detect_rename =3D 1;
 	merge_recursive_config(o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =3D
@@ -2088,9 +2092,12 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize =3D 0;
+	else if (!strcmp(s, "no-renames"))
+		o->detect_rename =3D 0;
 	else if (skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
 			return -1;
+		o->detect_rename =3D 1;
 	}
 	else
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
2.7.1.288.gfad33a8
