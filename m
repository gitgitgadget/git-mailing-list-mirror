From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0.5/4] t4041 (diff-submodule-option): don't hardcode SHA-1 in
 expected outputs
Date: Tue, 27 Nov 2012 14:36:25 +0530
Message-ID: <CALkWK0=0SfOuKRZvgt=BOBsKTXtaO5Y7-wAWK4XftE_aY9idyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 10:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdH8C-0004vX-GH
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 10:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468Ab2K0JGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 04:06:48 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:32965 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339Ab2K0JGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 04:06:46 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so12227600oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=2XND7B/ci5gzRgQ0km5MlbqLpLohT0nQomK+LfIQrCw=;
        b=u3ysnyiYLpvetJWEqf6HgSa9SYp6/qNSt5hH7Mf8m0qcoGmqZKEYkBjMWMSVsV6B3u
         Y04XrSIeCrJKr9mYd/tsDRIiPghmSGkVymIdvkWXKTYGeLDtC90nSUPhiVFduqjerpay
         VLKJXzWv6Fx15J9UJfQx9ocCiMPNp28CdAU04e2OfUdhhL1kxlXfurIgv8WVTtme3BKL
         JBTwyw94pXtXQ/5YBK8GzehI2wOHLlwHw3Ub2Qznj4CDoaJnpt0mcU3/Do3UlyK23dbz
         kVqxzVn2raqUGZlB7CPUhK7ITCnGRGwk9iVzh6d1fsEXSzwwMAK6eVa7NX1d+HDnQnPL
         fZ/Q==
Received: by 10.60.169.243 with SMTP id ah19mr11847017oec.127.1354007205651;
 Tue, 27 Nov 2012 01:06:45 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Tue, 27 Nov 2012 01:06:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210551>

The expected SHA-1 digests are always available in variables.  Use
them instead of hardcoding.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Oops, I forgot to send this part.  It comes before part 1, and it's
essential to make tests pass.

 t/t4041-diff-submodule-option.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 57e8a9d..5377639 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -62,7 +62,7 @@ test_expect_success '--submodule=short overrides
diff.submodule' "
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 new file mode 160000
-index 0000000..a2c4dab
+index 0000000..$head1
 --- /dev/null
 +++ b/sm1
 @@ -0,0 +1 @@
@@ -77,7 +77,7 @@ test_expect_success 'diff.submodule does not affect
plumbing' '
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
 	new file mode 160000
-	index 0000000..a2c4dab
+	index 0000000..$head1
 	--- /dev/null
 	+++ b/sm1
 	@@ -0,0 +1 @@
@@ -173,10 +173,10 @@ mv sm1-bak sm1
 test_expect_success 'typechanged submodule(submodule->blob), --cached' "
 	git diff --submodule=log --cached >actual &&
 	cat >expected <<-EOF &&
-Submodule sm1 41fbea9...0000000 (submodule deleted)
+Submodule sm1 $head4...0000000 (submodule deleted)
 diff --git a/sm1 b/sm1
 new file mode 100644
-index 0000000..9da5fb8
+index 0000000..$head5
 --- /dev/null
 +++ b/sm1
 @@ -0,0 +1 @@
@@ -190,7 +190,7 @@ test_expect_success 'typechanged
submodule(submodule->blob)' "
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
 deleted file mode 100644
-index 9da5fb8..0000000
+index $head5..0000000
 --- a/sm1
 +++ /dev/null
 @@ -1 +0,0 @@
-- 
1.7.12.1.428.g652398a.dirty
