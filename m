From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v5 2/3] merge-recursive: option to disable renames
Date: Sat, 20 Feb 2016 23:34:31 -0300
Message-ID: <1456022072-5342-3-git-send-email-felipegassis@gmail.com>
References: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 03:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXJtI-0007X9-53
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 03:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbcBUCgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2016 21:36:51 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35727 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbcBUCgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 21:36:13 -0500
Received: by mail-qk0-f182.google.com with SMTP id o6so45071092qkc.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 18:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B3jIDjbXaD9H0QPyxxVIVwHstg6vA6QfpOPuxgt7HbI=;
        b=CdY1bzXaXuqw+a3jUnUZwRJFRaPKPkXWFB7eziLDro1kLUb4MFAM8ym4TE8TKw+6aP
         YzgorU1f53zr1d1kbE5/eCFIjHF0XD7GtuAAf+OhatJFoVRq0+We79aHB8IhBjzb28vi
         KLA03JBuIcJyfYCbxp4LDp4wZRbluarHpAM91Q8pPRa3QKLmegIAAszQBrVNdO5NfP9f
         wzMVrRY8eeAN4CFw61E7zlPVOiAugBj6ONPrHeF2x0zJ600DO8s46ytzsXENLvF9hM/n
         I5q2yeSGjf5XYt65MSBlXVyBTYhe/WyRsiOnuaGG8NfLMr5NHS0T47lFlb37vPCdflyt
         ocTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=B3jIDjbXaD9H0QPyxxVIVwHstg6vA6QfpOPuxgt7HbI=;
        b=kinTLhFstXI7q7Xe9Ok/0nDSgfoHpzy+izxX1H3HoJVTYIzQ6WivT1qi8ccqcVkNuY
         VReVKz92+y0gYWOJeohMLd8dEowiZcTfGngAsaT13kAJC9YDTzy3cWMEBklU3zoW8Q4S
         9oTzl2zse6gqugPnob/OoPEJ1Mtb7Wi0pVaejgGxyOBT0NVcau1m0J0Nn7QBAuforvM0
         AxluNuKkoPGzZK5VUIqqeUw+QEuHw7eGXzQk8nGPxfz+QpaC8F+KijD08UAZwcuB8uFr
         1e8G5Ni9inUD3J+rV3+3ZFTYHyygsj0w//wpeUXgROmYXX9XHtr0rVKfplWCEgk/Oq+t
         bDuw==
X-Gm-Message-State: AG10YORbMd/xv/zYPZTmqMvr67fBV/YofIo8bo1rS2CHEQM/wDGIKCetEXt+p+/0O/OjFA==
X-Received: by 10.55.209.148 with SMTP id o20mr8918686qkl.5.1456022172284;
        Sat, 20 Feb 2016 18:36:12 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id 188sm7618067qhi.1.2016.02.20.18.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 18:36:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.342.gf5bb636
In-Reply-To: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286798>

The recursive strategy turns on rename detection by default. Add a
strategy option to disable rename detection even for exact renames.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Added tests.

=46or consistent naming, I renamed and slightly edited the test of whit=
espace
options:
t/t3032-merge-recursive-options.sh -> t/t3032-merge-recursive-space-opt=
ions.sh

 Documentation/merge-strategies.txt                   |  6 ++++++
 merge-recursive.c                                    |  7 +++++++
 merge-recursive.h                                    |  1 +
 ...ons.sh =3D> t3032-merge-recursive-space-options.sh} |  2 +-
 ...ld.sh =3D> t3034-merge-recursive-rename-options.sh} | 20 ++++++++++=
+++++++++-
 5 files changed, 34 insertions(+), 2 deletions(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 rename t/{t3034-merge-recursive-rename-threshold.sh =3D> t3034-merge-r=
ecursive-rename-options.sh} (83%)

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
diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursi=
ve-space-options.sh
similarity index 99%
rename from t/t3032-merge-recursive-options.sh
rename to t/t3032-merge-recursive-space-options.sh
index 4029c9c..b56180e 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-space-options.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'merge-recursive options
+test_description=3D'merge-recursive space options
=20
 * [master] Clarify
  ! [remote] Remove cruft
diff --git a/t/t3034-merge-recursive-rename-threshold.sh b/t/t3034-merg=
e-recursive-rename-options.sh
similarity index 83%
rename from t/t3034-merge-recursive-rename-threshold.sh
rename to t/t3034-merge-recursive-rename-options.sh
index f0b3f44..2f10fa7 100755
--- a/t/t3034-merge-recursive-rename-threshold.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'merge-recursive rename threshold option
+test_description=3D'merge-recursive rename options
=20
 Test rename detection by examining rename/delete conflicts.
=20
@@ -137,10 +137,28 @@ test_expect_success 'rename threshold is truncate=
d' '
 	check_find_renames_100
 '
=20
+test_expect_success 'disabled rename detection' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --no-renames HEAD^ -- HEAD master &&
+	check_no_renames
+'
+
 test_expect_success 'last wins in --rename-threshold=3D<m> --rename-th=
reshold=3D<n>' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive --rename-threshold=3D25 --rename-t=
hreshold=3D75 HEAD^ -- HEAD master &&
 	check_find_renames_75
 '
=20
+test_expect_success 'last wins in --no-renames --rename-threshold=3D<n=
>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --rename-threshold=3D=
25 HEAD^ -- HEAD master &&
+	check_find_renames_25
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<n> --no-rename=
s' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --rename-threshold=3D25 --no-renames HEAD^ -- HEA=
D master &&
+	check_no_renames
+'
+
 test_done
--=20
2.7.1.342.gf5bb636
