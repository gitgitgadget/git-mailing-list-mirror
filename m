From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 2/7] t5520: ensure consistent test conditions
Date: Sat,  2 Apr 2016 23:28:27 +0530
Message-ID: <1459619912-5445-3-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPqS-0008Sw-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbcDBSAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:00:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36030 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbcDBSAU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:00:20 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so17164046pfb.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIeHi4uC1dv4VgRASANemkqMhNJlydUy43UBAowdGEg=;
        b=EsiYKIjwBlcTefpvasvhuXwUNNi/16CS/hhodCmFzV6GpGWU/2Rbduqf9wJ5f1n6k2
         jDIRwU/UZSj9VqMMXgLdKmBiCrcpL2awtzUwG9vEUbNImmthPKpvd7VZVWqdAaHvT4qA
         WLhwXmseOdcAIy8gpSfo4mfFz5dJ3v2HjQzF3aXZYYNYhzDd3H3lO0EUi2uyspgme7++
         zt2Gqd2A1S1rGCRlrzAVgvwHhE/uP/GT8ywU+T6ZnBRuo/NVgIbAmfPlCh0D/lqMGTf7
         3pKKL/rmuBAtavCAQw/9R6XsU/bC9qyVxCXLhYYbiFOrgNYZHt5q31puR37ELkBcFTCP
         ToSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIeHi4uC1dv4VgRASANemkqMhNJlydUy43UBAowdGEg=;
        b=bV77yZr3PgZbr9K2ioAGFxYSJLic0ylWQ49VfQng9sj34/LeZwqLfDzjBAmhWK9vJW
         yABe1D3VCNz0OBpziu1bD0e8EZU17uVQoaiQZIWSQZBcBbhOa0yxmV9PGe4xtbyebnwQ
         JeJgVpqwRs5jugBbS7Nd3rKzdDe5h52auOWlbaAAXPS2IRgY4v9YVvzVhIaansjZ8pLO
         c+6qJJv2hWGkZH73SbPhIsX4ZHbe+3xmERx+fZJ4vsGdgfuoxokn1aMlKXTdFZncjrm0
         f+dmL3vjRNoQHusSo5nK1kScybLyOoV2F4vytG1mP6s6IOMf6LK8K6Eh8DBa+QfSPq9X
         u4Ow==
X-Gm-Message-State: AD7BkJIGNwCCGscX6sIJJOHiu0LsrunZOOTMxJE/ZFuj4Lb+oqfOS+iyG59ojx+vSN13Dg==
X-Received: by 10.98.72.213 with SMTP id q82mr7817994pfi.164.1459620019801;
        Sat, 02 Apr 2016 11:00:19 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:00:19 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290598>

Test title says that tests are done with rebase.autostash unset,
but does not take any action to make sure that it is indeed unset.
This may lead to test failure if future changes somehow pollutes
the configuration globally.

Ensure consistent test conditions by explicitly unsetting
rebase.autostash.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5be39df..9ee2218 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -279,6 +279,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 '
 
 test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
+	test_unconfig rebase.autostash &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
@@ -307,6 +308,7 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
+	test_unconfig rebase.autostash &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-- 
2.7.1.340.g69eb491.dirty
