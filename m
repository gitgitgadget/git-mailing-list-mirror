From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t3000 (ls-files -o): modernize style
Date: Sat, 10 Jul 2010 23:20:25 -0500
Message-ID: <20100711042025.GA7424@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 06:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXo2V-0003yy-UE
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 06:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab0GKEVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 00:21:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38167 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0GKEVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 00:21:11 -0400
Received: by iwn7 with SMTP id 7so3565732iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=e1VRu2ImzaezhwxoMUTXV2Wh583trWUMGBiBYfmu/SE=;
        b=xSUMHP2N8C88knRlGUuff+PkT1VCbQA7ms+ZRpBfq2bi2UWKcuzYiv7gilUyDWq4DC
         ZGM9Z98uS0nyQ7voEAToBU+BmoHt2uBk4jkzuA2xMSUgEnRVWOHFVDPje4ldD1mFbRq8
         /B/bhB8f6z+1s3JL08uU2ZgEJGq0UQpMcA2Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=CDC90ZgemFQfCKRdQ1kW4RS3fwIE5S0ht10HdU83CyytfLs4nKWH/aYMG7e6L4/uEI
         6F1NI5IoIbz0eY8usslrpASGnQAXrvnwNnG/5jgEcna/KS1p6KcZiHkc8W5iKmr5lnKL
         vwdn72+IkLuVx657hbXR2F+nzibIgCT2YNQq8=
Received: by 10.231.191.74 with SMTP id dl10mr12789166ibb.157.1278822069743;
        Sat, 10 Jul 2010 21:21:09 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm12509110ibh.10.2010.07.10.21.21.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 21:21:09 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150742>

This script is part of the second batch of tests, from the same day
the test infrastructure was added to git.  Update it to use a more
modern style in the spirit of v1.6.4-rc0~45^2~2 (2009-05-22).
In particular:

 - Put setup code inside test assertions, to avoid unexpected
   breakages and avoid stray output without -v (as t/README
   recommends); and

 - Put the test title on the same line as the "test_expect_success",
   and end the line with a single-quote to begin the body of the test
   which is one multi-line string.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3000-ls-files-others.sh |   99 +++++++++++++++++++++-----------------------
 1 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 86291e8..2eec011 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -17,57 +17,52 @@ filesystem.
 '
 . ./test-lib.sh
 
-date >path0
-if test_have_prereq SYMLINKS
-then
-	ln -s xyzzy path1
-else
-	date > path1
-fi
-mkdir path2 path3 path4
-date >path2/file2
-date >path2-junk
-date >path3/file3
-date >path3-junk
-git update-index --add path3-junk path3/file3
-
+test_expect_success 'setup ' '
+	date >path0 &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s xyzzy path1
+	else
+		date >path1
+	fi &&
+	mkdir path2 path3 path4 &&
+	date >path2/file2 &&
+	date >path2-junk &&
+	date >path3/file3 &&
+	date >path3-junk &&
+	git update-index --add path3-junk path3/file3
+'
+
-cat >expected1 <<EOF
-expected1
-expected2
-expected3
-output
-path0
-path1
-path2-junk
-path2/file2
-EOF
-sed -e 's|path2/file2|path2/|' <expected1 >expected2
-cat <expected2 >expected3
-echo path4/ >>expected2
-
+test_expect_success 'setup: expected output' '
+	cat >expected1 <<-\EOF &&
+	expected1
+	expected2
+	expected3
+	output
+	path0
+	path1
+	path2-junk
+	path2/file2
+	EOF
+
+	sed -e "s|path2/file2|path2/|" <expected1 >expected2 &&
+	cp expected2 expected3 &&
+	echo path4/ >>expected2
+'
+
-test_expect_success \
-    'git ls-files --others to show output.' \
-    'git ls-files --others >output'
-
-test_expect_success \
-    'git ls-files --others should pick up symlinks.' \
-    'test_cmp expected1 output'
-
+test_expect_success 'ls-files --others' '
+	git ls-files --others >output &&
+	test_cmp expected1 output
+'
+
-test_expect_success \
-    'git ls-files --others --directory to show output.' \
-    'git ls-files --others --directory >output'
-
-
-test_expect_success \
-    'git ls-files --others --directory should not get confused.' \
-    'test_cmp expected2 output'
-
+test_expect_success 'ls-files --others --directory' '
+	git ls-files --others --directory >output &&
+	test_cmp expected2 output
+'
+
-test_expect_success \
-    'git ls-files --others --directory --no-empty-directory to show output.' \
-    'git ls-files --others --directory --no-empty-directory >output'
-
-test_expect_success \
-    '--no-empty-directory hides empty directory' \
-    'test_cmp expected3 output'
+test_expect_success '--no-empty-directory hides empty directory' '
+	git ls-files --others --directory --no-empty-directory >output &&
+	test_cmp expected3 output
+'
 
 test_done
-- 
1.7.2.rc2
