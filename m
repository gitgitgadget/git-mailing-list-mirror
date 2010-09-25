From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 3/4] rev-parse: add tests for git rev-parse --flags.
Date: Sat, 25 Sep 2010 19:04:13 +1000
Message-ID: <1285405454-12521-5-git-send-email-jon.seymour@gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQdr-0001ne-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab0IYJB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:01:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49476 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0IYJB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:01:56 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so815188pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ui3BAbrNWjKISG9/IiRZD38UKS2Mx9V3DBJWNNSNlH0=;
        b=ETXcvrYYSi16aqR9GXrthDO14Iri/w+z/GcLyfsq0RMiYX7JqgRxQu5OuZEJxCsaCk
         LNjF0aW7yBIH9ySCYHVN442znKV6pN0oUgPjkkqW672YY+ersEawanQW0RgQcM4kGFO+
         LUef8IU6+YPXhxMzKD6dN/DVHdwfo+C6oP514=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lATNn+0AM0YbHYw/WqlbwObVcfy8Ynz1IEpmzNJbCTWxj7Ne+DlfWMxMI3gMGVFjOa
         VnHlKVeFR0j+uC93oxd8BRhP+6Tnd+WAolqfYSizvmNpqUXmZM4Qsro+KfET7FS0/RF8
         dhxD/eVQAgltYs/5eqecm7AdZ1heG4IAy+zx8=
Received: by 10.142.249.41 with SMTP id w41mr3818552wfh.190.1285405316420;
        Sat, 25 Sep 2010 02:01:56 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:01:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
In-Reply-To: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157137>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1510-rev-parse-flags.sh |  116 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
new file mode 100755
index 0000000..f41130d
--- /dev/null
+++ b/t/t1510-rev-parse-flags.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='test git rev-parse --flags'
+. ./test-lib.sh
+
+test_commit "A"
+
+test_expect_success 'git rev-parse --flags -> ""' \
+'
+	output=$(git rev-parse --flags) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags X -> ""' \
+'
+	output=$(git rev-parse --flags X) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
+'
+	output=$(git rev-parse --no-revs --flags HEAD) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"' \
+'
+	output=$(git rev-parse --symbolic --flags HEAD) &&
+	expected="HEAD" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -- -> ""' \
+'
+	output=$(git rev-parse --flags --) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -- X -> ""' \
+'
+	output=$(git rev-parse --flags -- X) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -- -X -> ""' \
+'
+	output=$(git rev-parse --flags -- -X) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -- -q --> ""' \
+'
+	output=$(git rev-parse --flags -- -q) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -X -> "-X"' \
+'
+	output="$(git rev-parse --flags -X)" &&
+	expected="-X" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -q -> "-q"' \
+'
+	output=$(git rev-parse --flags -q) &&
+	expected="-q" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags -X -- Y -Z -> "-X"' \
+'
+	output=$(git rev-parse --flags -X -- Y -Z) &&
+	expected="-X" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --flags --no-flags -> "--no-flags"' \
+'
+	output=$(git rev-parse --flags --no-flags) &&
+	expected="--no-flags" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --no-flags --flags -X -> ""' \
+'
+	output=$(git rev-parse --no-flags --flags -X) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --symbolic --no-flags --flags HEAD -> "HEAD"' \
+'
+	output=$(git rev-parse --symbolic --no-flags --flags HEAD) &&
+	expected="HEAD" &&
+	test "${output}" = "${expected}"
+'
+
+test_expect_success 'git rev-parse --no-flags --flags -X -> ""' \
+'
+	output=$(git rev-parse --no-flags --flags -X) &&
+	expected="" &&
+	test "${output}" = "${expected}"
+'
+
+test_done
-- 
1.7.3.1.gc81ce.dirty
