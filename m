From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] rev-parse test: modernize quoting and whitespace
Date: Tue, 3 Sep 2013 10:05:32 -0700
Message-ID: <20130903170532.GB29921@google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu33-0005Cy-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab3ICRFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:05:45 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:63252 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3ICRFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:05:44 -0400
Received: by mail-yh0-f53.google.com with SMTP id b12so1648198yha.12
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cohuRuRUXuM14yzkRSEhvZM36SCA76vW3GB3G5M1AUs=;
        b=bvR4N3i7NXWpFM2bbdFm2+vDDuVVku09M4YREpu4Z1cCuW9T3zO/Y4lUNWaZW2nco1
         i2CP1EJ8a71h5wwk2NH8w3xNcaIXx9VTXnmCsWz0APtBzNJOajwHF79hNPARvQMKpeg9
         r6VIr6pRv+G1nw5HJd83Jo4xumf1cGXQ28oUvgBGFLthy5bGJH7i5o3LtRGztj2tuGiE
         2+DmbEehduQnPhE4+Dkzr3UBBXO/yWCG23YoprXQy/wuiJLls4I65O6MukebR2VDAKyq
         eu/yhGv5jh3HruuOWUleWH91anDO/YfeRWnDkTm4kElSuD/iv+A4qwMN3m5Y0miYnzGl
         TJuw==
X-Received: by 10.236.166.200 with SMTP id g48mr14981yhl.144.1378227943029;
        Tue, 03 Sep 2013 10:05:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c6sm23663815yhl.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:05:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903170419.GA29921@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233737>

From: Felipe Contreras <felipe.contreras@gmail.com>

Instead of cramming everything in one line, put the test body in an
indented block after the opening test_expect_success line and quote
and put the closing quote on a line by itself.

Use single-quote instead of double-quote to quote the test body
for more useful --verbose output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 74 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index e673c25..c47b869 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -17,21 +17,62 @@ hide_error save_tag start2 unique_commit "start2" tree
 save_tag two_parents unique_commit "next" tree -p second -p start2
 save_tag final unique_commit "final" tree -p two_parents
 
-test_expect_success 'start is valid' 'git rev-parse start | grep "^[0-9a-f]\{40\}$"'
-test_expect_success 'start^0' "test $(cat .git/refs/tags/start) = $(git rev-parse start^0)"
-test_expect_success 'start^1 not valid' "if git rev-parse --verify start^1; then false; else :; fi"
-test_expect_success 'second^1 = second^' "test $(git rev-parse second^1) = $(git rev-parse second^)"
-test_expect_success 'final^1^1^1' "test $(git rev-parse start) = $(git rev-parse final^1^1^1)"
-test_expect_success 'final^1^1^1 = final^^^' "test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)"
-test_expect_success 'final^1^2' "test $(git rev-parse start2) = $(git rev-parse final^1^2)"
-test_expect_success 'final^1^2 != final^1^1' "test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)"
-test_expect_success 'final^1^3 not valid' "if git rev-parse --verify final^1^3; then false; else :; fi"
-test_expect_success '--verify start2^1' 'test_must_fail git rev-parse --verify start2^1'
-test_expect_success '--verify start2^0' 'git rev-parse --verify start2^0'
-test_expect_success 'final^1^@ = final^1^1 final^1^2' "test \"$(git rev-parse final^1^@)\" = \"$(git rev-parse final^1^1 final^1^2)\""
-test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' "test \"$(git rev-parse final^1^\!)\" = \"$(git rev-parse final^1 ^final^1^1 ^final^1^2)\""
-
-test_expect_success 'repack for next test' 'git repack -a -d'
+test_expect_success 'start is valid' '
+	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+'
+
+test_expect_success 'start^0' '
+	test $(cat .git/refs/tags/start) = $(git rev-parse start^0)
+'
+
+test_expect_success 'start^1 not valid' '
+	if git rev-parse --verify start^1; then false; else :; fi
+'
+
+test_expect_success 'second^1 = second^' '
+	test $(git rev-parse second^1) = $(git rev-parse second^)
+'
+
+test_expect_success 'final^1^1^1' '
+	test $(git rev-parse start) = $(git rev-parse final^1^1^1)
+'
+
+test_expect_success 'final^1^1^1 = final^^^' '
+	test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)
+'
+
+test_expect_success 'final^1^2' '
+	test $(git rev-parse start2) = $(git rev-parse final^1^2)
+'
+
+test_expect_success 'final^1^2 != final^1^1' '
+	test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)
+'
+
+test_expect_success 'final^1^3 not valid' '
+	if git rev-parse --verify final^1^3; then false; else :; fi
+'
+
+test_expect_success '--verify start2^1' '
+	test_must_fail git rev-parse --verify start2^1
+'
+
+test_expect_success '--verify start2^0' '
+	git rev-parse --verify start2^0
+'
+
+test_expect_success 'final^1^@ = final^1^1 final^1^2' '
+	test "$(git rev-parse final^1^@)" = "$(git rev-parse final^1^1 final^1^2)"
+'
+
+test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
+	test "$(git rev-parse final^1^!)" = "$(git rev-parse final^1 ^final^1^1 ^final^1^2)"
+'
+
+test_expect_success 'repack for next test' '
+	git repack -a -d
+'
+
 test_expect_success 'short SHA-1 works' '
 	start=`git rev-parse --verify start` &&
 	echo $start &&
@@ -39,6 +80,7 @@ test_expect_success 'short SHA-1 works' '
 	echo $abbrv &&
 	abbrv=`git rev-parse --verify $abbrv` &&
 	echo $abbrv &&
-	test $start = $abbrv'
+	test $start = $abbrv
+'
 
 test_done
-- 
1.8.4
