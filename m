From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/6] Try uncommitting a commit with not exactly one
	parent
Date: Thu, 20 Mar 2008 01:31:45 +0100
Message-ID: <20080320003145.13102.12700.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iC-0006sd-0a
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763003AbYCTAby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936933AbYCTAbx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:31:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2855 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763003AbYCTAbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:31:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8h7-0004sO-00; Thu, 20 Mar 2008 00:31:45 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77601>

This should fail cleanly -- and in fact it does. Except for printing
an assertion backtrace instead of a nice error message. (This is a
regression introduced by the conversion of "stg uncommit" to the new
infrastructure.)

=46ound by Erik Sandberg <mandolaerik@gmail.com>.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1300-uncommit.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)


diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index d86e579..0d952a7 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -78,4 +78,9 @@ test_expect_success \
     stg commit --all
 '
=20
+test_expect_failure 'Uncommit a commit with not precisely one parent' =
'
+    stg uncommit -n 5 ; [ $? =3D 2 ] &&
+    [ "$(echo $(stg series))" =3D "" ]
+'
+
 test_done
