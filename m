From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 1/3] t3034: add rename threshold tests
Date: Tue, 23 Feb 2016 20:48:10 -0300
Message-ID: <1456271292-4652-2-git-send-email-felipegassis@gmail.com>
References: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipeg.assis@gmail.com>,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:50:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMiS-0001Zu-5o
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcBWXt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 18:49:59 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34524 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcBWXt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:49:57 -0500
Received: by mail-qg0-f47.google.com with SMTP id b67so1705134qgb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LdDhc7sbXiIdEvwEQUdmucZI/qGuaWR/V0LUYiv4vXg=;
        b=EaLjdkZPBv/+jm72fwYZ8dQMsIFAgSmDc47KcwQx7ztEZMJW/QuXBJHXisX8XpxVCU
         MXKF+ZlS0l/iLjnO/9l9zW3djeNsVHUKsg528dy9XQ6zdA5YfkhjTiw/33z63NDAt4o5
         Hyc9cpl6rxlKP/hjD6Kpa/KAeliLK1xfMr+DjJQNDKAJJ8B9juRgUGv6zHE3SkfxIQj8
         4dd1j6OHXYhqzFA/NGW7IrUs3qXBX4ZYDlKdeSATtKwgm0gGAMoUX0Duc6QbrX07PgQb
         XgsKoj1tV6zy1Xp0FxIUoBXjqhrCyaBgtTl2ZKPQHcJKMJL1eH1KCwFDdQceTup8gtGr
         aBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=LdDhc7sbXiIdEvwEQUdmucZI/qGuaWR/V0LUYiv4vXg=;
        b=CO7ti4N482ClmZhLz3+LP+51MCWDsQOKWOLDVOZUuxrJ/4ri+OJUyhXS5uIIDkWsEE
         vgMrBNzex+gedj1UUgyhJKGif2JC10KAMedaG/RGflGPFPuEjScl8UtoB0XNKfuukuLH
         vBLepbt/01eMD4DALrWsY2WKdj/+EJ+Y22TJEaomWBMtGUiQrMNnb2eh8+iZB3B9xrib
         IKl/XiFaciUJpRcdJwQIxwuVNQFTz0/Atqdxq/B5Da63RjlJdzUVB8ktISKohEzYuGss
         3z7sj+wiJf2/fwHuHreguvln26sefe1ioXmSoKplw1S9OsZ1zSmaiWQH3xudqLtHgWzT
         6NiA==
X-Gm-Message-State: AG10YOQAkP/ED2AfWRXzJQTZHqzibt3qz1Er778DeDzsh2Jj64AnGeWk8DcnRZLDJfKdSg==
X-Received: by 10.140.101.147 with SMTP id u19mr46514730qge.71.1456271396895;
        Tue, 23 Feb 2016 15:49:56 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id w1sm126080qha.3.2016.02.23.15.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 15:49:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
In-Reply-To: <1456271292-4652-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287147>

=46rom: Felipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com>

10ae752 (merge-recursive: option to specify rename threshold,
2010-09-27) introduced this feature but did not include any tests.

The tests use the new option --find-renames, which replaces the then
introduced and now deprecated option --rename-threshold.

Also update name and description of t3032 for consistency:
"merge-recursive options" -> "merge-recursive space options"

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 235 +++++++++++++=
++++++++
 2 files changed, 236 insertions(+), 1 deletion(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

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
diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
new file mode 100755
index 0000000..fbec68c
--- /dev/null
+++ b/t/t3034-merge-recursive-rename-options.sh
@@ -0,0 +1,235 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive rename options
+
+Test rename detection by examining rename/delete conflicts.
+
+* (HEAD -> rename) rename
+| * (master) delete
+|/
+* base
+
+git diff --name-status base master
+D	0-old
+D	1-old
+D	2-old
+D	3-old
+
+git diff --name-status -M01 base rename
+R025    0-old   0-new
+R050    1-old   1-new
+R075    2-old   2-new
+R100    3-old   3-new
+
+Actual similarity indices are parsed from diff output. We rely on the =
fact that
+they are rounded down (see, e.g., Documentation/diff-generate-patch.tx=
t, which
+mentions this in a different context).
+'
+
+. ./test-lib.sh
+
+get_expected_stages () {
+	git checkout rename -- $1-new &&
+	git ls-files --stage $1-new >expected-stages-undetected-$1 &&
+	sed "s/ 0	/ 2	/" <expected-stages-undetected-$1 \
+		>expected-stages-detected-$1 &&
+	git read-tree -u --reset HEAD
+}
+
+rename_detected () {
+	git ls-files --stage $1-old $1-new >stages-actual-$1 &&
+	test_cmp expected-stages-detected-$1 stages-actual-$1
+}
+
+rename_undetected () {
+	git ls-files --stage $1-old $1-new >stages-actual-$1 &&
+	test_cmp expected-stages-undetected-$1 stages-actual-$1
+}
+
+check_common () {
+	git ls-files --stage >stages-actual &&
+	test_line_count =3D 4 stages-actual
+}
+
+check_threshold_0 () {
+	check_common &&
+	rename_detected 0 &&
+	rename_detected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_threshold_1 () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_detected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_threshold_2 () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_undetected 1 &&
+	rename_detected 2 &&
+	rename_detected 3
+}
+
+check_exact_renames () {
+	check_common &&
+	rename_undetected 0 &&
+	rename_undetected 1 &&
+	rename_undetected 2 &&
+	rename_detected 3
+}
+
+test_expect_success 'setup 1/2: basic setup' '
+	cat <<-\EOF >3-old &&
+	33a
+	33b
+	33c
+	33d
+	EOF
+	sed s/33/22/ <3-old >2-old &&
+	sed s/33/11/ <3-old >1-old &&
+	sed s/33/00/ <3-old >0-old &&
+	git add [0-3]-old &&
+	git commit -m base &&
+	git rm [0-3]-old &&
+	git commit -m delete &&
+	git checkout -b rename HEAD^ &&
+	cp 3-old 3-new &&
+	sed 1,1s/./x/ <2-old >2-new &&
+	sed 1,2s/./x/ <1-old >1-new &&
+	sed 1,3s/./x/ <0-old >0-new &&
+	git add [0-3]-new &&
+	git rm [0-3]-old &&
+	git commit -m rename &&
+	get_expected_stages 0 &&
+	get_expected_stages 1 &&
+	get_expected_stages 2 &&
+	get_expected_stages 3 &&
+	check_50=3D"false" &&
+	tail=3D"HEAD^ -- HEAD master"
+'
+
+test_expect_success 'setup 2/2: threshold array' '
+	git diff --name-status -M01 HEAD^ HEAD >diff-output &&
+	test_debug "cat diff-output" &&
+	test_line_count =3D 4 diff-output &&
+	grep "R[0-9]\{3\}	\([0-3]\)-old	\1-new" diff-output \
+		>grep-output &&
+	test_cmp diff-output grep-output &&
+	th0=3D$(sed -n "s/R\(...\)	0-old	0-new/\1/p" <diff-output) &&
+	th1=3D$(sed -n "s/R\(...\)	1-old	1-new/\1/p" <diff-output) &&
+	th2=3D$(sed -n "s/R\(...\)	2-old	2-new/\1/p" <diff-output) &&
+	th3=3D$(sed -n "s/R\(...\)	3-old	3-new/\1/p" <diff-output) &&
+	test "$th0" -lt "$th1" &&
+	test "$th1" -lt "$th2" &&
+	test "$th2" -lt "$th3" &&
+	test "$th3" =3D 100 &&
+	if [ 50 -le "$th0" ]; then
+		check_50=3Dcheck_threshold_0
+	elif [ 50 -le "$th1" ]; then
+		check_50=3Dcheck_threshold_1
+	elif [ 50 -le "$th2" ]; then
+		check_50=3Dcheck_threshold_2
+	fi &&
+	th0=3D"$th0%" &&
+	th1=3D"$th1%" &&
+	th2=3D"$th2%" &&
+	th3=3D"$th3%"
+'
+
+test_expect_success 'assumption for tests: rename detection with diff'=
 '
+	git diff --name-status -M$th0 --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-0 &&
+	git diff --name-status -M$th1 --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-1 &&
+	git diff --name-status -M$th2 --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-2 &&
+	git diff --name-status -M100% --diff-filter=3DR HEAD^ HEAD \
+		>diff-output-3 &&
+	test_line_count =3D 4 diff-output-0 &&
+	test_line_count =3D 3 diff-output-1 &&
+	test_line_count =3D 2 diff-output-2 &&
+	test_line_count =3D 1 diff-output-3
+'
+
+test_expect_success 'default similarity threshold is 50%' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive $tail &&
+	$check_50
+'
+
+test_expect_success 'low rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D$th0 $tail &&
+	check_threshold_0
+'
+
+test_expect_success 'medium rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D$th1 $tail &&
+	check_threshold_1
+'
+
+test_expect_success 'high rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D$th2 $tail &&
+	check_threshold_2
+'
+
+test_expect_success 'exact renames only' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D100% $tail &&
+	check_exact_renames
+'
+
+test_expect_success 'rename threshold is truncated' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D200% $tail &&
+	check_exact_renames
+'
+
+test_expect_success 'last wins in --find-renames=3D<m> --find-renames=3D=
<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D$th0 --find-renames=3D$th2 $tail &&
+	check_threshold_2
+'
+
+test_expect_success '--find-renames resets threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive \
+		--find-renames=3D$th0 --find-renames $tail &&
+	$check_50
+'
+
+test_expect_success 'assumption for further tests: trivial merge succe=
eds' '
+	git read-tree --reset -u HEAD &&
+	git merge-recursive HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D$th0 HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D$th2 HEAD -- HEAD HEAD &&
+	git diff --quiet --cached &&
+	git merge-recursive --find-renames=3D100% HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects negative argument' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D-25 \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_expect_success '--find-renames rejects non-numbers' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --find-renames=3D0xf \
+		HEAD -- HEAD HEAD &&
+	git diff --quiet --cached
+'
+
+test_done
--=20
2.7.1.492.gd821b20
