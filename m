From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 20/19] mingw: skip a test in t9130 that cannot pass on
 Windows
Date: Tue, 26 Jan 2016 15:54:15 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601261551550.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO50l-0005q4-Du
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966267AbcAZOyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:54:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:55404 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965268AbcAZOyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:54:21 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LeuUB-1Zkfag07uJ-00qioO; Tue, 26 Jan 2016 15:54:17
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:OrUKXJTPShtKI4DnIWPFXPvS18xQvkUumwizii57s8whc1WxTP2
 vGHs8kA/bejpN0KYAH16e9hDdBq2rLvbThp9zlgSPt5PhsnINiHbMjLJ0X425StfCif+xke
 YqJQwGxdLd1NQ66czh5DeCrEmRzga8bM7QHIik5HtOWcehC1UyGTROJE6yXbZ6TA77FraxP
 CtIr2H3F+tJf+6YwdhbUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qLBlMZnFi8w=:rdVD55odthUoavE5Cl64D3
 bYrEgPsyKoJomkwafeI9TmEuNh9qhqErC8LMOCMLnvmyrPCEQHQEDFg6ILxFFO1sz7YGqLCIE
 hRJdiFicu9uPkw5Ntbplbsu/aSzhnPUcqcxdEFhffhaqYKHrQwCWkp+3thgdH/Vp5gUMJvxuc
 XOPVVnjHSLDc3SPYSQ9vPer7IOkV1ud/X+KCMHybfwFmIJIiB+0EBEGNAVVhjKSmPN+nSVDMe
 mdLr27Nge22Tl2f81SWq/WBp00VX44OQ70719qikVB/lrVz5+8QQ9kA7e9dmAr5M/3vYaKay3
 S3nj8ULaDJC8P2n+BQQqCU8XgBbnVQ5T4a1kU2FpsVo4Dridlw/GsVei71DYdyW0Hq+6d68a6
 Sd3nq68l75p9115e+njIUEzrKK8pY/l2K8nSXSaPY9oP19T0thqAQrdGjkPs6gfwmJmmeC3bu
 W/iX2C/EpZC9IurYBSoar/gcXd7rXqdVJ/E+q5K88it4xOXzINCxgtZgvIE5fIEPs2Br1BYzi
 PprKgYeJouYEw896O9CJ3hCU09ehmJK1/t06jebKrkw/IuDe5412zSPWeXyC6vyjQsatf0yzZ
 Yyl5ICvb6rZNXh8ccL07J5ns39dYXBmjW8DsedaeeWByfCQTYh6DY5C1ETnBjJ8QjVvP0Kie/
 U+AAt5Iv88A7mOrd9DC0xKTW5vk1lSqN/v2WcMvwCbRyoT63QKeE4QcM8EGuD3v5KVxlRX5Ia
 LaZjTFevTOBs9UPVbWjPXruQQ69qrzPDSY+4DOUlQsiLuV37sAsJk/q1qkrT/CJUeuOt3uH/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284839>

On Windows, Git itself has no clue about POSIX paths, but its shell
scripts do. In this instance, we get mixed paths as a result, and when
comparing the path of the author file, we get a mismatch that is
entirely due to the POSIX path vs Windows path clash.

Let's just skip this test so that t9130-git-svn-authors-file.sh passes
in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Oh crap. Of course I forgot this one... Ideally, this would have
	been the second-to-last patch, i.e. between "mingw: handle the
	missing POSIXPERM prereq in t9124" and "mingw: skip a test in
	t9130 that cannot pass on Windows".

 t/t9130-git-svn-authors-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
