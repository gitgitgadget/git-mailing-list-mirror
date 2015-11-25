From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] git submodule init to pass on groups
Date: Tue, 24 Nov 2015 17:32:17 -0800
Message-ID: <1448415139-23675-4-git-send-email-sbeller@google.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Own-0005sT-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbbKYBcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:35 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35596 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398AbbKYBcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:25 -0500
Received: by pacej9 with SMTP id ej9so39616089pac.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p7Wuvv1OnpMuUH8HljGWz+MqZKZUvR0lxL4PzErIHiE=;
        b=SVUV7B7bk/IiPxuzpn3RsFXuczfaPy7ooRTDoL0F8ywx16xGQxQEeABEww5clFetaO
         OPKuhEk6VY+tONxuAVWlpyM5a67RWYbwik1ihio+BeqkldKI2Rh0/Ox8YCGxeVQ+d/fj
         0nBQFZ5yvjSSNz2HlKCiHMwDB/CKiVuFQHinoFmpFYf8Q//R/ur1XcwKyxjSo6KlcAyK
         2SUnxtk4LjvpxKgiNOORWcgqrIb1P3HwbEbK4Hd9qNlluUuFFJsc5qkFqsmgHJNdv1d6
         ES9Z0fEgdSqK7cSMPqYw04xZ5jDPaYQyXzunYhXDBi5wckCtZ3jR1CgKhg8CQgE0E7Vk
         7RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p7Wuvv1OnpMuUH8HljGWz+MqZKZUvR0lxL4PzErIHiE=;
        b=mKrVx3tNwO6JNlRU8sJBMFDyXC/r98Zty63EEb18YlAhf0PLDODyn228/ecthteM7u
         s5udI0uhwt5quz+ZDOOesdPofVo9HjDlPBjzsDM/B/LMYHFL8aQ4Dp8XdOq7KR8BMhMN
         opRkrPxkBJK4fBjlk1BFuWkq9s8l51VdhhMI7EyoFAjiyGmvz1vlz5liPnyWvoz5B4T4
         4hE+fOLVTma+nHwD1tfkUMxdkiI/0C8NMI+aS5oqQO1zXERy4wKvNNsiwtuSVDL2T60s
         xkH8klpBz4SQeKmcymFUrQE6zlsjQdrAylIbsxlEZIMa0HVk60rUx7alCxPn92a0VSyw
         8+JQ==
X-Gm-Message-State: ALoCoQk8rmb+VKkgowNymB24yjeCkyNTd9CwepLBpqDs5zMGtOdId2WykP45UY3zIrBeyAV7hKXJ
X-Received: by 10.66.240.4 with SMTP id vw4mr47642807pac.9.1448415145055;
        Tue, 24 Nov 2015 17:32:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id w85sm16828408pfa.48.2015.11.24.17.32.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:24 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281672>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           |  6 +++++-
 t/t7400-submodule-basic.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bbdcf78..4092a48 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -455,6 +455,7 @@ cmd_foreach()
 #
 cmd_init()
 {
+	submodule_groups=
 	# parse $args after "submodule ... init".
 	while test $# -ne 0
 	do
@@ -462,6 +463,9 @@ cmd_init()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		-g|--groups)
+			submodule_groups=1
+			;;
 		--)
 			shift
 			break
@@ -476,7 +480,7 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git submodule--helper list ${submodule_groups:+--groups} --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a422df3..caed4be 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1028,4 +1028,25 @@ test_expect_success 'submodule add records groups' '
 	)
 '
 
+test_expect_success 'submodule init --group works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule init --groups &&
+		git config submodule.submodule.url &&
+		test_must_fail git config submodule.submodule1.url
+	)
+'
+
 test_done
-- 
2.6.1.261.g0d9c4c1
