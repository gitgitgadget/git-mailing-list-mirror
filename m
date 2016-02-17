From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v4 1/2] merge-recursive: option to disable renames
Date: Wed, 17 Feb 2016 01:15:25 -0200
Message-ID: <1455678926-15105-2-git-send-email-felipegassis@gmail.com>
References: <1455678926-15105-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 04:17:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVscn-0003sp-T8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933760AbcBQDRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 22:17:53 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36302 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933169AbcBQDRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 22:17:49 -0500
Received: by mail-qg0-f49.google.com with SMTP id y9so3050329qgd.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 19:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4Sy21GJjeFUHWbbx20DNaa/SkF/zBlGuCyQk9fcB1ik=;
        b=uHZHwR9tsxgHweEfVvO24bXeGGBwE7xhGaW8FOTLlsSyIOIl1lsFgSijJgzeNjv2WY
         NIVq13sJ0Vu2OAhkv0F0DbeVOjnYx6bYqGw19dpK0Sh1RApXpIf21bWNA6ylvByp31hc
         z3klqCsEbjcc9vIe8AVi0dupiZ+THjjlObC846HwDF7BLDcpmRhQoPm1TLG97GuFi9vi
         txJSt+XtQ31MlZzJxRxGusP5QyDM4b1rsdZjC/G/E4gu2UwN1sgTHJgyYxBT3nrzm3wK
         2zo8rV0168VJYQ2I4GIjGmkXH1saA6wj0isGfRT6zyj6ZnaVOqVi5JYgNuxFHC/nxDnf
         bMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=4Sy21GJjeFUHWbbx20DNaa/SkF/zBlGuCyQk9fcB1ik=;
        b=CI3L5Rr+ptaxjB2R5k6QsGuMTiY960j3rXdiUnkePLks0QyzyQ6C2HzXEPXMUWZeaq
         x/H1TQIzO/tA+qGv/HNAbLo3M4mYfjK+b9S95GOcFaggT/i0jkXtDnMOd4e1+eLvXad1
         yWOHXfsbSJLYhh7ttk0PjvQkngrLf3Fb7uHn0gan0MIOyqDhS3+R5Zps4B2qSz+Xnzhr
         FurgCjHW85VNs0ImdgyZiL+njWLaDDfY7JWxcHSebODnp7tsQsye8JXGrqOeUqSrjGAD
         lPN9NraYuzNY1JKbCZpz3994rCmeBBlym3NTTXbOKnvvwlWJlVGF6TYCD/iZjZsosiMs
         DOnQ==
X-Gm-Message-State: AG10YOTUpNXxPm3jgJGhvsPKYOTa9KjW5Pk/NazOEjPyKOI2o8EmdlKqqSxRxEiWQhGLlQ==
X-Received: by 10.140.98.116 with SMTP id n107mr32876143qge.9.1455679068916;
        Tue, 16 Feb 2016 19:17:48 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id b111sm14501148qge.47.2016.02.16.19.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 19:17:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.289.ga0c045c
In-Reply-To: <1455678926-15105-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286478>

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
2.7.1.289.ga0c045c
