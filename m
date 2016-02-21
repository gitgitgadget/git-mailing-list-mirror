From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 4/5] merge-recursive: test option to disable renames
Date: Sun, 21 Feb 2016 12:09:17 -0300
Message-ID: <1456067358-19781-5-git-send-email-felipegassis@gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYI7-0006Ab-8v
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbcBUR71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 12:59:27 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33703 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcBUR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:59:27 -0500
Received: by mail-qk0-f174.google.com with SMTP id s5so48694471qkd.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MqJmMUy8elAjSPrJ4PjPqa6hWUWH+nqUhJ+1W7ZAjHU=;
        b=g7B43xBq5AEFsfjOoPspPAxqItudvaetKhQN8Uvw0arP03STfMV2/xOkUziWYeQL1u
         /sVX8i/4osHeGAsYGskrIDh+OjfH/1KudFuqTVyDbrkkqpCkx0CcgXQaeZ+9pEtMbnz8
         +t3m3EcJO+p5WI7EejbUCU4a17v4NN0aNFWsSoL9TolnxsRdGMFD0PKrTe3rdrqmHHaa
         1G/eIqvhY0T80X+ux2ah3VUWOGNllEtMXBjKP8FiKP/aaVYHy6sWusHXxrPXZW9f1/jk
         1BeDPDAnP8P7nOjTU5yi8DzeZCuodV8aPVxaQdSXHnZUSUBUfKxsCLRf3QbZI4sz2whx
         Yy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=MqJmMUy8elAjSPrJ4PjPqa6hWUWH+nqUhJ+1W7ZAjHU=;
        b=aLOZCbAmGtZBe6abAIKd0Etqj18KNfWkZc3ZO8F5MkmoN3Je58ERPbA3Jxvz5bnR4v
         mAQ+wk1ieK3J5W+rMjhZHFiBbgjbDleljkzE46wdMGUzYOAwlfmBjWFoIqOKbWxbGhrr
         BfhirBfAVpn2zNjHv9CbeCK51bjSnmhtcCs4ZdZQ6nCSMDRZ8Dep47Pq+hQeeKF4Mr/v
         wV0zPhIGu02x9RBAnmQtMeEGykrO9sSIjjumaENu37Ts1fVFNvDi6EeAm5vbR9H8vB6Q
         S6wRJuuiPrket4ra3IqvPYOkL9yrOm9h1w4AJI+kFZKcnWoa8mVnvbWGTPdrMurl3Mys
         v+zg==
X-Gm-Message-State: AG10YOSK1CSpLTztiUfM7fYjBccj4qZotVwJvIG/Q+pVA9ODh6Ess1hTbaIuneNF7xl2Lw==
X-Received: by 10.55.18.168 with SMTP id 40mr4151394qks.99.1456067476209;
        Sun, 21 Feb 2016 07:11:16 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id o203sm8467389qho.15.2016.02.21.07.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2016 07:11:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gc9722f8
In-Reply-To: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286816>

Also update name and description of tests for consistency:
"merge-recursive options"          -> "merge-recursive space options"
"merge-recursive rename threshold" -> "merge-recursive rename options"

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---
 ...ons.sh =3D> t3032-merge-recursive-space-options.sh} |  2 +-
 ...ld.sh =3D> t3034-merge-recursive-rename-options.sh} | 20 ++++++++++=
+++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 rename t/{t3034-merge-recursive-rename-threshold.sh =3D> t3034-merge-r=
ecursive-rename-options.sh} (83%)

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
2.7.1.492.gc9722f8
