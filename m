From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v5 3/3] merge-recursive: more consistent interface
Date: Sat, 20 Feb 2016 23:34:32 -0300
Message-ID: <1456022072-5342-4-git-send-email-felipegassis@gmail.com>
References: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 03:36:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXJtL-0007a0-2j
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 03:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbcBUCgy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2016 21:36:54 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35733 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcBUCgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 21:36:15 -0500
Received: by mail-qk0-f180.google.com with SMTP id o6so45071232qkc.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qh98o5khWy8Dx+ze586UzwSBmkBC3FTEWvhtlb4ZiRc=;
        b=GkfFp71l/7YpDmXSlyGVcFAcAW1WmM33Jcq9oGyRj5aAvbD73Aul7NAKA+lQryhlys
         vD1IgnsUkySUKVvKq7CwJjikk3J/V515Lev9HTodOzsGkGt1ORQon+jiBEamc0+HtYcB
         /u7AQxT9vtjEBY0qTHxdm5DyrFv0Eyx3UJyRVB/iZ+uC7LpcWti4ZqtQTgKmcr8aMQmI
         4SsH8nXHyHjAeH9u/c6mHnnIVmQokNDCdZLfCuFIDVeM3EezlfL2T9J2oTtPzvddGzSU
         G9pHF27NZYjlfqqEyVmimxL7T80FIplXr47WD1L0k+CTfvOrh5d3i2+UkWXi6E01oCtJ
         Z77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Qh98o5khWy8Dx+ze586UzwSBmkBC3FTEWvhtlb4ZiRc=;
        b=MmhQAYQKJoQwAvTtIhZqtbBPqUMAP6/EYF7NwQ0sdMhx1gUBr+IZbYDLjrBlJdRDpE
         Gqlhg86NF3pUkI2XKXun1b7ULQAsv57RNYqsnAxVOjwX5tkB+LXl7yR/Rh6DasPG8iPc
         cKd0qMIdxThESoyzMoPi7RTQbv28qTtcyv4R6OVJSCk9nTTUqSByy6rG36CTRpMT9S66
         /7ae/hhgc082socCuLQSlaPWenq88nk4fB5CsX3uQdTDbh/ze7NSA9LIZDebMA2ONpBU
         NFC2qJhP6jaQ0m1FgGCctlOrQaSm8N0p/DmLqFATPJ6gYzAjBXWWWwKSPXDLOIofOo51
         iIeQ==
X-Gm-Message-State: AG10YOQ7l8b1FmsOauzsb1wAX53Hcy90p/MRWtHxHyV2zG+1rnW6bXycEuUILw/Wegctmw==
X-Received: by 10.55.192.89 with SMTP id o86mr3088363qki.31.1456022174470;
        Sat, 20 Feb 2016 18:36:14 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id 188sm7618067qhi.1.2016.02.20.18.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 18:36:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.342.gf5bb636
In-Reply-To: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286797>

Add strategy option find-renames, following git-diff interface. This
makes the option rename-threshold redundant.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

Added tests and made --find-renames reset the similarity index to the d=
efault.

 Documentation/merge-strategies.txt        | 10 ++++---
 merge-recursive.c                         |  7 ++++-
 t/t3034-merge-recursive-rename-options.sh | 48 +++++++++++++++++++++++=
++++----
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-s=
trategies.txt
index 1a5e197..2eb92b9 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -85,11 +85,13 @@ no-renames;;
 	Turn off rename detection.
 	See also linkgit:git-diff[1] `--no-renames`.
=20
+find-renames[=3D<n>];;
+	Turn on rename detection, optionally setting the similarity
+	threshold.  This is the default.
+	See also linkgit:git-diff[1] `--find-renames`.
+
 rename-threshold=3D<n>;;
-	Controls the similarity threshold used for rename detection.
-	Re-enables rename detection if disabled by a preceding
-	`no-renames`.
-	See also linkgit:git-diff[1] `-M`.
+	Deprecated synonym for `find-renames=3D<n>`.
=20
 subtree[=3D<path>];;
 	This option is a more advanced form of 'subtree' strategy, where
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dd0a11..63b8ba8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2094,7 +2094,12 @@ int parse_merge_opt(struct merge_options *o, con=
st char *s)
 		o->renormalize =3D 0;
 	else if (!strcmp(s, "no-renames"))
 		o->detect_rename =3D 0;
-	else if (skip_prefix(s, "rename-threshold=3D", &arg)) {
+	else if (!strcmp(s, "find-renames")) {
+		o->detect_rename =3D 1;
+		o->rename_score =3D 0;
+	}
+	else if (skip_prefix(s, "find-renames=3D", &arg) ||
+	         skip_prefix(s, "rename-threshold=3D", &arg)) {
 		if ((o->rename_score =3D parse_rename_score(&arg)) =3D=3D -1 || *arg=
 !=3D 0)
 			return -1;
 		o->detect_rename =3D 1;
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 2f10fa7..4e3fefd 100755
--- a/t/t3034-merge-recursive-rename-options.sh
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -115,25 +115,25 @@ test_expect_success 'the default similarity index=
 is 50%' '
=20
 test_expect_success 'low rename threshold' '
 	git read-tree --reset -u HEAD &&
-	test_must_fail git merge-recursive --rename-threshold=3D25 HEAD^ -- H=
EAD master &&
+	test_must_fail git merge-recursive --find-renames=3D25 HEAD^ -- HEAD =
master &&
 	check_find_renames_25
 '
=20
 test_expect_success 'high rename threshold' '
 	git read-tree --reset -u HEAD &&
-	test_must_fail git merge-recursive --rename-threshold=3D75 HEAD^ -- H=
EAD master &&
+	test_must_fail git merge-recursive --find-renames=3D75 HEAD^ -- HEAD =
master &&
 	check_find_renames_75
 '
=20
 test_expect_success 'exact renames only' '
 	git read-tree --reset -u HEAD &&
-	test_must_fail git merge-recursive --rename-threshold=3D100% HEAD^ --=
 HEAD master &&
+	test_must_fail git merge-recursive --find-renames=3D100% HEAD^ -- HEA=
D master &&
 	check_find_renames_100
 '
=20
 test_expect_success 'rename threshold is truncated' '
 	git read-tree --reset -u HEAD &&
-	test_must_fail git merge-recursive --rename-threshold=3D200% HEAD^ --=
 HEAD master &&
+	test_must_fail git merge-recursive --find-renames=3D200% HEAD^ -- HEA=
D master &&
 	check_find_renames_100
 '
=20
@@ -143,12 +143,36 @@ test_expect_success 'disabled rename detection' '
 	check_no_renames
 '
=20
-test_expect_success 'last wins in --rename-threshold=3D<m> --rename-th=
reshold=3D<n>' '
+test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
 	git read-tree --reset -u HEAD &&
-	test_must_fail git merge-recursive --rename-threshold=3D25 --rename-t=
hreshold=3D75 HEAD^ -- HEAD master &&
+	test_must_fail git merge-recursive --find-renames=3D25 --find-renames=
=3D75 HEAD^ -- HEAD master &&
 	check_find_renames_75
 '
=20
+test_expect_success '--find-renames is equivalent to --find-renames=3D=
5' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D25 --find-renames=
 HEAD^ -- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'last wins in --no-renames --find-renames' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --no-renames --find-renames HEAD^ =
-- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'last wins in --find-renames --no-renames' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --find-renames --no-renames HEAD^ -- HEAD master =
&&
+	check_no_renames
+'
+
+test_expect_success 'rename-threshold=3D<n> is a synonym for find-rena=
mes=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 HEAD^ -- H=
EAD master &&
+	check_find_renames_25
+'
+
 test_expect_success 'last wins in --no-renames --rename-threshold=3D<n=
>' '
 	git read-tree --reset -u HEAD &&
 	test_must_fail git merge-recursive --no-renames --rename-threshold=3D=
25 HEAD^ -- HEAD master &&
@@ -161,4 +185,16 @@ test_expect_success 'last wins in --rename-thresho=
ld=3D<n> --no-renames' '
 	check_no_renames
 '
=20
+test_expect_success 'last wins in --rename-threshold=3D<n> --find-rena=
mes' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 --find-ren=
ames HEAD^ -- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'last wins in --find-renames --rename-threshold=3D=
<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames --rename-threshold=3D=
25 HEAD^ -- HEAD master &&
+	check_find_renames_25
+'
+
 test_done
--=20
2.7.1.342.gf5bb636
