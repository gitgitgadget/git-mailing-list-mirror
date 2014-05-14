From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 19/31] tests: move tests for -z update/delete/verify to after the ref is created
Date: Wed, 14 May 2014 15:13:18 -0700
Message-ID: <1400105610-21194-20-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRa-0007Zp-8v
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbaENWOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:11 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:59724 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbaENWNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:39 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so442972vcb.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dU2nzxfFbo74yUgBYQi+r9YnwEvUUh6VJMSzgp1U1rw=;
        b=P4zpLkjcJxwNedouaCwmH0lc5U99VS8COV8MNwHA8JvVy2O+g8Dr01JCSpNxstZZ05
         e7wNV73nWL2CW84msQe1R9c7ZxJH9er4B+vdy7vqHG0j5M6zc0fJy4A4Rz9A+q5Vh44O
         CHju5FNrUMRfyPTz5r+S3AmD425HClrj+0gyNWOLRxLe1f+eBXAc0x1/2AstL7btXQ1i
         3zYcWynRX/5gWExuaTzPGuzOGvZNIysHlRi1bUogJCQNHaUzItrbT9M9khyT4hildQ65
         bGoXguY0EC6NwHBRy0aZbFDo4II8ITTkuGBjPmba8+SgxFTYO311N1mtLBiXolJJ/z5v
         +ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dU2nzxfFbo74yUgBYQi+r9YnwEvUUh6VJMSzgp1U1rw=;
        b=IjkXGeYYrqP8qz04WA4wGJipfyUiGKNzgh6k0ZoBYfXjoapfndrvAwsTarJfrz1qoP
         Ps80VjCc9X7PSz8EVAxR7/+ZI9dxYsCepqU37g64Yt1QujKNSR6sYWUujrM25mCIeEcE
         96UIsjqZUnhI5Xn67LxvUjSya6y9n+Tc+y6YuEEuVauoM+usEttlWpanzePiMBBuPINL
         BU+jvuI6mJOKMzznK0URc3P5O2vmAQq8r/i0v+5vQX+SG3rwrWyuxiBSIKK9NI+D5Qp7
         j4i6A3aHaqRoQqkNj2D/qeJcQuWnmcYKuv/ore6No1CZE3vAL3DxeDGJWhs9qo2+98t8
         Ptuw==
X-Gm-Message-State: ALoCoQm19uUqrxD2ogln4D1eQdxu/4ASAGva8ZUJ8j4wR/hY5leXRqECqki90MkHGFV4yafqv/cz
X-Received: by 10.52.61.197 with SMTP id s5mr2853280vdr.8.1400105619021;
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si152251yhq.3.2014.05.14.15.13.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id BB07A5A4202;
	Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 804DDE038E; Wed, 14 May 2014 15:13:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249023>

The tests for stdin -z fails for update/delete/verify are of the form
update refs/heads/a $m $m $m
and rely on the fact that when parsed we will first parse everything except
the trailing $m. And once that command has completed it will start parsing
the next command, find the trailing $m from before and fail because this
would not look like a proper command. I.e. we do not detect that there are
too many arguments so much as detect that the next command looks like
garbage.

But since the ref refs/heads/a does not exist at this point in the test we
actually have two failures that trigger. We have one error that is due to
update refs/heads/a $m $m would be invalid because the ref does not exist
and we have a second error that is due to the trailing $m causing a "too
many arguments". The current test depends on the order of check for these two
which makes the test fragile (and would break after the next patch).

Move these tests further down in the test to occur after we have created
refs/heads/a so that there is only one error condition in the test and that
we no longer depend on in which order the checks for error occur.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t1400-update-ref.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4e2459a..f9b7bef 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -756,12 +756,6 @@ test_expect_success 'stdin -z fails update with no old value' '
 	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
-test_expect_success 'stdin -z fails update with too many arguments' '
-	printf $F "update $a" "$m" "$m" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
-'
-
 test_expect_success 'stdin -z fails delete with no ref' '
 	printf $F "delete " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
@@ -780,18 +774,6 @@ test_expect_success 'stdin -z fails delete with no old value' '
 	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
 '
 
-test_expect_success 'stdin -z fails delete with too many arguments' '
-	printf $F "delete $a" "$m" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
-'
-
-test_expect_success 'stdin -z fails verify with too many arguments' '
-	printf $F "verify $a" "$m" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: unknown command: $m" err
-'
-
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
@@ -818,6 +800,24 @@ test_expect_success 'stdin -z create ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin -z fails update with too many arguments' '
+	printf $F "update $a" "$m" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails delete with too many arguments' '
+	printf $F "delete $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
+test_expect_success 'stdin -z fails verify with too many arguments' '
+	printf $F "verify $a" "$m" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: unknown command: $m" err
+'
+
 test_expect_success 'stdin -z update ref creates with zero old value' '
 	printf $F "update $b" "$m" "$Z" >stdin &&
 	git update-ref -z --stdin <stdin &&
-- 
2.0.0.rc3.506.g3739a35
