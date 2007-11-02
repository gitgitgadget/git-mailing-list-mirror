From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/4] Add testcase for ammending and fixing author in git commit.
Date: Fri,  2 Nov 2007 11:33:06 -0400
Message-ID: <1194017589-4669-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyWr-00034W-6m
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbXKBPde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXKBPde
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:33:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbXKBPdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:33:33 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2FXG1G007557;
	Fri, 2 Nov 2007 11:33:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXFNZ020008;
	Fri, 2 Nov 2007 11:33:15 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXEII006415;
	Fri, 2 Nov 2007 11:33:14 -0400
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63132>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 t/t7501-commit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b151b51..3f2112a 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -163,4 +163,14 @@ test_expect_success 'partial commit that involves =
removal (3)' '
=20
 '
=20
+author=3D"The Real Author <someguy@his.email.org>"
+test_expect_success 'amend commit to fix author' '
+
+	git reset --hard
+	git cat-file -p HEAD | sed -e "s/author.*>/author $author/" > expecte=
d &&
+	git commit --amend --author=3D"$author" &&
+	git cat-file -p HEAD > current &&
+	diff expected current
+=09
+'
 test_done
--=20
1.5.3.4.206.g58ba4
