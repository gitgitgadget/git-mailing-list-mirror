From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Test renaming a branch to itself
Date: Fri, 25 Nov 2011 22:52:44 -0800
Message-ID: <1322290364-16207-1-git-send-email-conrad.irwin@gmail.com>
References: <20111126023002.GA17652@elie.hsd1.il.comcast.net>
Cc: git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>,
	=?UTF-8?q?=E2=98=82Josh=20Chia=20=28=E8=B0=A2=E4=BB=BB=E4=B8=AD=29?= 
	<joshchia@gmail.com>, Conrad Irwin <conrad.irwin@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 07:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUC8V-0004K2-Ra
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 07:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569Ab1KZGxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 01:53:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48971 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab1KZGxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 01:53:13 -0500
Received: by iage36 with SMTP id e36so5626758iag.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 22:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f+WYN6XZk48MPn6TPE3vJDUVW1iTfnOhc67QnYZ9abI=;
        b=b9NQ+MoRUon5SOFh0dmDg0d9sObUg0BpAOXEaCN3Ub0iqyaFiqWbNRabv3q5Sbmo7E
         mkcHcBJoiEhwK1eKBSifwvc20zTj7GCOcxyTWx/aicaEdp8jWok2kjRzm8/FvitMJWLy
         SmfG59j9yRy+zoRJhPjOMt3f4ut2++lZ1m1M0=
Received: by 10.231.27.209 with SMTP id j17mr816278ibc.7.1322290393379;
        Fri, 25 Nov 2011 22:53:13 -0800 (PST)
Received: from monteverdi.hsd1.ca.comcast.net. (c-69-181-44-79.hsd1.ca.comcast.net. [69.181.44.79])
        by mx.google.com with ESMTPS id dm1sm54323851igb.6.2011.11.25.22.53.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Nov 2011 22:53:12 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.433.ga2d04a
In-Reply-To: <20111126023002.GA17652@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185946>

Test for a regression introduced in v1.7.7-rc2~1^2~2.

Requested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 t/t3200-branch.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index bc73c20..7690332 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -115,6 +115,22 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	git branch -M baz bam
 '
 
+test_expect_success 'git branch -M master should work when master is checked out' '
+	git checkout master &&
+	git branch -M master
+'
+
+test_expect_success 'git branch -M master master should work when master is checked out' '
+	git checkout master &&
+	git branch -M master master
+'
+
+test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
+	git checkout master &&
+	git branch master2 &&
+	git branch -M master2 master2
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	test_path_is_file .git/refs/heads/t &&
-- 
1.7.7.1.433.ga2d04a
