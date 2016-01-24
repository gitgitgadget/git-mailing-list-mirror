From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 18/19] mingw: skip a couple of git-svn tests that cannot pass
 on Windows
Date: Sun, 24 Jan 2016 16:45:52 +0100 (CET)
Message-ID: <ff13c4125f268905baaa10a097ffdafe07eafb25.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMrY-0001iz-5s
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbcAXPp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:61311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967AbcAXPpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIuSH-1aPqlk0Zxp-002UAZ; Sun, 24 Jan 2016 16:45:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Of7zXaIuD4JwJxM0CY7rY/seorCtVVAkohp+eAs3tHOhGhr/Mak
 6VoHnJFpjgwZ6BGOVulaOVv7uGsJa/qm/+vMcIz6AfpwaKArt82EW7H4LosbYKfhYWcoQNT
 OPMGsbpbq7JxidUGl72iPZFpWS62YTfZ7pf6qOcEQ1EO0yB0JcfYSvAXsGk9f5WWacPL6GP
 B4P+hY6BAQEuBi3Sq8K7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F3C2j/JhMiw=:9bqrYTl3AIG9xUGSyE/59H
 wcekop2H5TkAK8MdMsdumGxtsrgnSFqSUJLqV33k0Ia+/ajSYWOK4Gkn1zwnvna+RgoH7qaxJ
 2ZXiybo6/5tjlAwlT/oF/LnNhAk0hsxXWeJhw36h4d9JWYeEyYkksv3I3+pE6+Jk3656pbnRc
 ZvlPoxrXK+FiW/QeXPmqChkhJmS4yDMDDNzj+5JsmMay3uKUAxlHkNJNIHJkj+Zf4UMK/U9Hn
 mFHr/ghCCJhbcdq5j6Ot8DRRoOxpVOeIO8QslHXwLIm4+Oqf4bsIfcXDPAJv44eYVvHTI1GkV
 2PEBUo8agQqyNQkG6Wr7u/6ePO3K8pTcBMY/RCC1qTj6xaPvHFLANMjKD/SU1dc294pkATa0A
 kFH2h4VRCai+aK8suKDEmjZ9Vu+tYR8YmQ9VEhLT8rkKI1M8zvzcTLbKA8FCtG68tIZQaCtCM
 flZSgeFx1beaX70RAEAIzQCOoYbVhJlidTHcCH27asrYkewuwhEBnYSpbtz2edACeS3rY5Rc/
 GDVBuGoDlnYu/JCIJxuBNr4tVtcTQyduWgRVzAcwOW2VHsEK8ChwNqG3Hozjb804A9bCGHlM1
 CHKn4U6m2jLjN1FWP8+uHbDTpN1rTIz6xplMJiOiwIltVusmfoGIw8ZTa91zj3+KWeCyZEcBb
 Gko9CaHE9auCUwqx49EaC/uL3m4VqXhbpqp0yKUDXY1297pqle4P6GIqJlZxcRAiVM+UrQtcF
 hlgTjTzAx7lAN5M0VF3G/khSib/5/t47CrNFfH/pF17bReoCTuZB3qq+ouFvgv/2kz51Dl3t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284682>

Some of the tests expect that executable bits can be toggled, others
expect that paths are POSIX paths (but when they come through git.exe,
they are converted into Windows paths and necessarily differ), yet
others expect symbolic links to be available.

This lets t9100-git-svn-basic.sh and t9130-git-svn-authors-file.sh pass
in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9100-git-svn-basic.sh        | 15 +++++++--------
 t/t9130-git-svn-authors-file.sh |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index bca7ec8..8c74ffa 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -127,7 +127,7 @@ test_expect_success "$name" '
 
 
 name='remove executable bit from a file'
-test_expect_success "$name" '
+test_expect_success !MINGW "$name" '
 	rm -f "$GIT_DIR"/index &&
 	git checkout -f -b mybranch5 ${remotes_git_svn} &&
 	chmod -x exec.sh &&
@@ -140,7 +140,7 @@ test_expect_success "$name" '
 
 
 name='add executable bit back file'
-test_expect_success "$name" '
+test_expect_success !MINGW "$name" '
 	chmod +x exec.sh &&
 	git update-index exec.sh &&
 	git commit -m "$name" &&
@@ -151,7 +151,7 @@ test_expect_success "$name" '
 
 
 name='executable file becomes a symlink to file'
-test_expect_success "$name" '
+test_expect_success !MINGW "$name" '
 	rm exec.sh &&
 	ln -s file exec.sh &&
 	git update-index exec.sh &&
@@ -163,8 +163,7 @@ test_expect_success "$name" '
 
 name='new symlink is added to a file that was also just made executable'
 
-test_expect_success "$name" '
-	chmod +x file &&
+test_expect_success !MINGW "$name" '
 	ln -s file exec-2.sh &&
 	git update-index --add file exec-2.sh &&
 	git commit -m "$name" &&
@@ -175,7 +174,7 @@ test_expect_success "$name" '
 	test -h "$SVN_TREE"/exec-2.sh'
 
 name='modify a symlink to become a file'
-test_expect_success "$name" '
+test_expect_success !MINGW "$name" '
 	echo git help >help &&
 	rm exec-2.sh &&
 	cp help exec-2.sh &&
@@ -191,7 +190,7 @@ test_expect_success "$name" '
 name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
 LC_ALL="$GIT_SVN_LC_ALL"
 export LC_ALL
-test_expect_success UTF8 "$name" "
+test_expect_success !MINGW,UTF8 "$name" "
 	echo '# hello' >> exec-2.sh &&
 	git update-index exec-2.sh &&
 	git commit -m '???????' &&
@@ -224,7 +223,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-test_expect_success "$name" "test_cmp a expected"
+test_expect_success !MINGW "$name" "test_cmp a expected"
 
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index d306b77..4126481 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -91,7 +91,7 @@ test_expect_success 'fetch continues after authors-file is fixed' '
 	)
 	'
 
-test_expect_success 'fresh clone with svn.authors-file in config' '
+test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
 	(
 		rm -r "$GIT_DIR" &&
 		test x = x"$(git config svn.authorsfile)" &&
-- 
2.7.0.windows.1.7.g55a05c8
