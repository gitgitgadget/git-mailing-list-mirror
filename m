From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 5/5] merge-recursive: test more consistent interface
Date: Sun, 21 Feb 2016 12:09:18 -0300
Message-ID: <1456067358-19781-6-git-send-email-felipegassis@gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 19:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYIw-0006xV-BQ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 19:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbcBUSAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 13:00:15 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:32823 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcBUSAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 13:00:14 -0500
Received: by mail-qk0-f178.google.com with SMTP id s5so48698415qkd.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UHchnCd5ypjJvAkHtEbHL4R9QRkjf1A3rdUwvhhRsmQ=;
        b=fpyOgo4dXVPy06YR7XwlYPxRrabGoib4/7163cQWynNndiPlbE1x8sKaXfUt5NyEAs
         4VBHJOvrflsYfdTEs69c66rxw5w0addNb/sWBtl3s0lZLnm+2sW5/7TUi+BBSZygiKlG
         K1wiwdKTbUQ6LaED9MR1iKB3SFPd4yGpTKRzsFN0QOWNsQ0AZsE2YvH37GuzpQmDD+qr
         UqWapyXPcE/KPDAdEHx4p4eV9yiX98HBy+v6kc2xnbHz46GHMCxHvc/9+qtFExmErnzt
         3lIPwPdYCnQMgQ8UY6zpWcir5NZn6V5IeEm+ghGRUe89v8EBQB2AzwmUZrhTp0E96J7l
         Cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=UHchnCd5ypjJvAkHtEbHL4R9QRkjf1A3rdUwvhhRsmQ=;
        b=kxiR1ihYhnec6bHc+bHWy61+HECqyvFEx/Nf1+vTmZ1wRnOvO/l/XKCApzTJdEDtq+
         MPKQ+4OQIRUfo+V89U943jd42bWPIJVreCMBW22XOmx+e630bhbdtz9Px9UsuSZ/t7ML
         pi4gbZOG/QS2Nv6naozdHuZItvoWr8o4b5M6GDDMsWtWFJog45xaeC4d8QRfz2kwx6br
         FnFrkk0FodaTW8hZktVeWKx8IjWVC/bbf8kq2UlSCtk+fMEahR4ZfRvqIKQZc/wThnBx
         cE9iEroWxyFdRD1DuxRpnzsj1NsrIZo7GXkA9OhbKVjOpfdyri/MsgJ+Lrbg+hsdQILb
         /9Xg==
X-Gm-Message-State: AG10YOTxJARjVe34v21zs/wXbK841ynjPkz92qvCz3Ub1PuqwVhTlV4hN8MHDqjigE9DlQ==
X-Received: by 10.55.74.197 with SMTP id x188mr29079007qka.104.1456067479123;
        Sun, 21 Feb 2016 07:11:19 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id o203sm8467389qho.15.2016.02.21.07.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 07:11:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gc9722f8
In-Reply-To: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286817>

Update basic tests to use the new option find-renames instead of
rename-threshold. Add tests to verify that rename-threshold=3D<n> behav=
es
as a synonym for find-renames=3D<n>. Test that find-renames resets
threshold.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 t/t3034-merge-recursive-rename-options.sh | 48 +++++++++++++++++++++++=
++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/t/t3034-merge-recursive-rename-options.sh b/t/t3034-merge-=
recursive-rename-options.sh
index 2f10fa7..7fea7bd 100755
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
+test_expect_success '--find-renames resets threshold' '
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
2.7.1.492.gc9722f8
