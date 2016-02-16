From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 21:26:15 -0200
Message-ID: <1455665175-8665-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:27:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVp27-0004zS-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 00:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933327AbcBPX1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 18:27:48 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34209 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933053AbcBPX1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 18:27:47 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so146309622qgb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 15:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Yr8WHay5dd9W9vMWbLGaQgb/vspYKMUfPZRXtovUQr4=;
        b=Ea7cf4RUQoRGSUFD9lk0V9bPN+72vqsq8OVag8zumCEZ0fM6p4RW8kc7WjFxF9RWrm
         AoavuMHp5K0MwgV7OozQRagYM6r6ksYa3XudFEr+hxSRs4LAxCaZ0XYGyUK1Mh3ABvtl
         1ylsZ/WVfokXwG8XX3lPDE413Scv5GFxqBLN7SX3x3ngv6WFGUcZHEwXFCYkIiI+U3bB
         c9CxXTtNFJC/JmJKjs2ElKrrt6IFpIz4e8EqMGCphTGB8HTUu/HBx3SEeZ8fnLVQbySn
         fGy1Tl/mOHt0z8FjOzAxFM6n6wS1d05ZlpzqlF6weNpmYsrUom3tS8qQ0s+DlxszQORI
         0o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Yr8WHay5dd9W9vMWbLGaQgb/vspYKMUfPZRXtovUQr4=;
        b=PArpEeXusd7wuqwT9lyZ8+rE8FEy+w+tZgiQ7Brts5j6nkxLn9Ek54ig9P4g7jb0eY
         HN/dj9jY89YfUFw7qIGtf59CqKF25Osyn/tUXAAAL67JweZ64xhTjJwfKHqy9W5KfKFp
         eqtZvx/DBQQ2nHuykUf4BERGGDswinlvHNbj/sc/gbRf1cfQCTBAS8X3kweV+J8VKu4e
         MZUvG7Oj2MqOOHvFsLIhSSMtXChQLoPQRKQgFmRminQ+IxmRypAn1/03ghWnRdQZhGDq
         +M1eMPtMXMNDVYCnwYV+2grvP5YOgc4sWZtwvZOqQl9yVVtyv8qMLCYMH/Qrmd+VntFw
         j3kQ==
X-Gm-Message-State: AG10YOQnBIoLgh2o83ePSFaPrhZgGnCMq38xudC4l9PFjYiPav8eufRbajpjz3NSQ1zS0A==
X-Received: by 10.140.250.138 with SMTP id v132mr32643515qhc.0.1455665266428;
        Tue, 16 Feb 2016 15:27:46 -0800 (PST)
Received: from traveller.moon ([187.34.45.132])
        by smtp.gmail.com with ESMTPSA id d71sm12547192qhd.18.2016.02.16.15.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 15:27:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.288.gfad33a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286456>

The recursive strategy turns on rename detection by default. Add a
strategy option to disable rename detection even for exact renames.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

=46ollowing Hamano's review, this patch includes a strategy option "ren=
ames" and
simplifies the implementation.

Also note merge-recursive.c:492, where I forward detect_rename from the=
 merge
options to the diff options, instead of hardcoding it to DIFF_DETECT_RE=
NAME,
which could cause surprises in the future.

 Documentation/merge-strategies.txt |  9 +++++++++
 merge-recursive.c                  | 10 +++++++++-
 merge-recursive.h                  |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 7bbd19b..f794d23 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -81,6 +81,15 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
=20
+renames;;
+	Turn on rename detection.
+	This is the default.
+	See also linkgit:git-diff[1] `-M`.
+
+no-renames;;
+	Turn off rename detection.
+	See also linkgit:git-diff[1] `--no-renames`.
+
 rename-threshold=3D<n>;;
 	Controls the similarity threshold used for rename detection.
 	See also linkgit:git-diff[1] `-M`.
diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..2f9c40a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -482,10 +482,13 @@ static struct string_list *get_renames(struct mer=
ge_options *o,
 	struct diff_options opts;
=20
 	renames =3D xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
-	opts.detect_rename =3D DIFF_DETECT_RENAME;
+	opts.detect_rename =3D o->detect_rename;
 	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_rename_=
limit :
 			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
 			    1000;
@@ -2039,6 +2042,7 @@ void init_merge_options(struct merge_options *o)
 	o->diff_rename_limit =3D -1;
 	o->merge_rename_limit =3D -1;
 	o->renormalize =3D 0;
+	o->detect_rename =3D DIFF_DETECT_RENAME;
 	merge_recursive_config(o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =3D
@@ -2088,6 +2092,10 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize =3D 0;
+	else if (!strcmp(s, "renames"))
+		o->detect_rename =3D DIFF_DETECT_RENAME;
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
2.7.1.288.g6752e66
