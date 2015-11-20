From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/2] test: factor out helper function test_must_contain
Date: Fri, 20 Nov 2015 21:50:09 +0100
Message-ID: <564F8781.1080902@web.de>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de> <20151120111454.GB11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzsde-0001Lk-MG
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760973AbbKTUua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 15:50:30 -0500
Received: from mout.web.de ([212.227.17.11]:64369 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760573AbbKTUu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:50:29 -0500
Received: from [192.168.178.36] ([79.253.144.111]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MYO45-1ZvKDy0QOv-00VAWT; Fri, 20 Nov 2015 21:50:19
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120111454.GB11198@sigill.intra.peff.net>
X-Provags-ID: V03:K0:sOl42zVOMjavla47NBqW6nJAHnttLkiyS2pWCw4rxdm6E+ORcv4
 7zterylxYN3J9vWz424lrIxIo4KvQ2W6wTwedVdIQu0+Xp4kf9jP/om4PxBHFkskMbIN8Uo
 pZ77RytDS+BcBvGblRhzpEhQ3Vn3KZwGhJL8QpsBBw1v4Ja/saSLchUbt9t0XEo5WAeehjc
 IdtW7Sb7G/1Jr4jEYDW5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r8wnfaWOlrM=:7Ip83Mhw3Jof+NTJxCj0JX
 htEDOnPVXlpCKpq7OPs5PQjSv8Qz42C4MkziQhnrdo14uTdscrnyejsE4mEqWe3Sud75UfRfM
 CVCstDZhzlBV2+81OW2YG1Ww+fpBDvFDpjo6MxcVO24Esk/YWzw1qth6AlILf8XuehaG7C4h9
 1aTOxYn568iY+dC+pbl4Dq6ZdIAVlcWhlUZy4RMV2ebymAOO5ljQ/LFRwwMc4nYL8UINcb6n8
 Ns9LQggBfMiWJf4NLrpWUnOgKP5J3pHP2e4Z5zNS5PUKUMGveXoBTYXlL8mvUXxuzQGU4HZXp
 ZiCK4B5s2SN+doBzGklF0Npbf89CiH61bfMYn4jCZliiyEMpp8RAFVPSjRhEymIQ0P/AhkFir
 ta1eRwyQ7CQCXFcRlV7dR4ATz2fbe+QH2yB+OgTR1cHkptbm/5JS8q2hICXpn2Jiliqie2tXb
 LwCan4quTV66LtK3Pp28pKPC9/7w7BlSMrrGRull73dCegwuc9vG2ckxr810We6SVylP5owQd
 vunaeIKFzRbCTWEJ2DPD3hgEpNBk/8vM2A5HPlnmbMcGAitb72+c2KnQrX3eQVWI+i8QqgROY
 K5V8N7bXBqwWWpi5y2qupYD00WLp+uW2fyzGn1eLiVeBVBuZ3qdTXtjXxGtJFnR45CXZieC3F
 +XAAq/2VsffWTVPV9UwZMf5tQIOpgaOW5bg5z4uJagJ1vxp7XO8o4iG8XExYq25tmTw/0L6ta
 4+3Xth8+UVc0PoqdUotJrEcyMjycwmu0vRb5oTWQviNbJ7iUYO7pxFJ4zZ3uxYFYmj4IZL/D 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281533>

Extract a helper function for searching for a pattern in a file and
printing the whole file if the pattern is not found.  It is useful
when starting tests with --verbose for debugging purposes.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t0008-ignores.sh      | 10 +---------
 t/test-lib-functions.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 4ef5ed4..0414c01 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -46,15 +46,7 @@ broken_c_unquote_verbose () {
 }
 
 stderr_contains () {
-	regexp="$1"
-	if grep "$regexp" "$HOME/stderr"
-	then
-		return 0
-	else
-		echo "didn't find /$regexp/ in $HOME/stderr"
-		cat "$HOME/stderr"
-		return 1
-	fi
+	test_must_contain "$1" "$HOME/stderr"
 }
 
 stderr_empty_on_success () {
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 73e37a1..eb44cb4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -689,6 +689,18 @@ test_must_be_empty () {
 	fi
 }
 
+# Check if a file contains an expected pattern.
+test_must_contain () {
+	if grep "$1" "$2"
+	then
+		return 0
+	else
+		echo "didn't find /$1/ in '$2', it contains:"
+		cat "$2"
+		return 1
+	fi
+}
+
 # Tests that its two parameters refer to the same revision
 test_cmp_rev () {
 	git rev-parse --verify "$1" >expect.rev &&
-- 
2.6.3
