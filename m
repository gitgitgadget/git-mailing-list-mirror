From: David Turner <dturner@twopensource.com>
Subject: [PATCH 03/24] t1430: test the output and error of some commands more carefully
Date: Thu,  7 Apr 2016 15:02:50 -0400
Message-ID: <1460055791-23313-4-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEa-0007wR-0w
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbcDGTD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:27 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35864 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbcDGTDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:25 -0400
Received: by mail-qk0-f175.google.com with SMTP id i4so34925782qkc.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=07vE97my1HbDKgCeOnguIFDgUvUQLaHxVk+54EkMvgI=;
        b=i369W4gGnwEjuqaRKftFWQcsCW+S73dh+Jui5YrRGBjekJW7kU8HoP7TCJyUCncb6+
         6LAyLPaGH8bhb2d+hIdNSQYpoDNYPr27dCDW3SmNlE2ZcVpw/bHmKECjwhDSXU5Nu0re
         GjmAbojfdmvg7URDNtY8CfMxqsCs2L/fyNmbyByYopzEiy/Dbp3CX6/yCJICRvnxL0Oy
         Bk9PmE+BXohEqO07pRys6FY74j5X76qKHVlHAuAgzRNwim5X6W1knfmrJ55bWr4F0Dcb
         yTEivf+MnU9nMi1UmIqtb6NmQuxxqiYHAQwvGbS4lLJS4PGnSYjKtshJUfhI8QE2C7lc
         UrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=07vE97my1HbDKgCeOnguIFDgUvUQLaHxVk+54EkMvgI=;
        b=L1C/LrRplCb6u0GPO0aWLw6dyEjYzZjwEBc73SV4bOsWoTBEi5Ypaa91/XMV11XjLe
         ekqEyENIt8siubDGnF/wBCDOW/Ve+ougNySe66h3EoQVY6JX0yBthm0JyMYGvyyXo0Gf
         vY9A6Q1c+tGAlyrL6VDXF7WK9DqPKruSxy/2l8i1zaxLWqYCAlp9FfrTIRcRnQ5VFFQs
         q9v8qNNE69I8H6GhFA+OFhA3DdKwPIVVePkt8290gyBPC/a70200RTUWNT+aEXaszcYp
         youBv/AZD7iHKvUvmGvLoUZ/gbqbUq3rJm6aENxOUmg8T9d2GV6jIJmoVYyeiapaf+Dm
         Nmew==
X-Gm-Message-State: AD7BkJIQQ0Y6EK6yH3Pihez2+dxxEvaOC61KGRlnGOE3vg3oAsT5RMmkdRqSc+mboYiauA==
X-Received: by 10.55.54.14 with SMTP id d14mr5968741qka.64.1460055804172;
        Thu, 07 Apr 2016 12:03:24 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290972>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c465abe..005e2b1 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -42,7 +42,7 @@ test_expect_success 'git branch shows badly named ref as warning' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch >output 2>error &&
-	grep -e "broken\.\.\.ref" error &&
+	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
@@ -152,21 +152,25 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
-	test_i18ngrep "ignoring.*refs/tags/shadow" err
+	test_i18ngrep "ignoring dangling symref refs/tags/shadow" err
 '
 
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
 	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	test_path_is_file .git/refs/heads/badname &&
-	git update-ref --no-deref -d refs/heads/badname &&
-	test_path_is_missing .git/refs/heads/badname
+	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_must_be_empty output &&
+	test_must_be_empty error
 '
 
 test_expect_success 'update-ref -d can delete broken name' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git update-ref -d refs/heads/broken...ref &&
+	git update-ref -d refs/heads/broken...ref >output 2>error &&
+	test_must_be_empty output &&
+	test_must_be_empty error &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
@@ -175,7 +179,9 @@ test_expect_success 'update-ref -d can delete broken name' '
 test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
 	echo precious >.git/my-private-file &&
 	echo precious >expect &&
-	test_must_fail git update-ref -d my-private-file &&
+	test_must_fail git update-ref -d my-private-file >output 2>error &&
+	test_must_be_empty output &&
+	test_i18ngrep -e "cannot lock .*: unable to resolve reference" error &&
 	test_cmp expect .git/my-private-file
 '
 
-- 
2.4.2.767.g62658d5-twtrsrc
