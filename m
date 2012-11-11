From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] contrib/remote-helpers: setup ui.username in test-hg.sh
Date: Sun, 11 Nov 2012 16:11:32 +0530
Message-ID: <CALkWK0kguFpA3ExSt7YKtugWq-0FvNQ=QFaKUo6uUjt8+=5mfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 11:42:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUzV-0004R4-Nq
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab2KKKlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 05:41:55 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42149 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2KKKly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:41:54 -0500
Received: by mail-wg0-f42.google.com with SMTP id fm10so1129210wgb.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=IDVyzbPvYwWAxee4+s95GDuWnx6oaWnUZnw0K059bUQ=;
        b=rsfCnTEzkRXQ3FHA2xSEBTfWnKwffdijmGypxCYn6S8VWER3GAuYYgUCRp4U/lqGro
         pxupGe8/wHEZlNtqTBDwgGhS3OuzwpGX+pYXe0FaW+yGED6OFNGmkS+HAi48UVPEBaGv
         Kq8Cs/OGS6BvS4M2VkcmM0fkjgnZmsCYQdhAxtQLP8nL9X2XZSXsFGg0pl0ND44iPdWA
         y3cGI55wMyf3hyVLW4MNaTPDO2SS8uoqj3Z3LuEjShMGlA9hVcpHN2y4muFHgI6VkfbK
         aFNp7DlXjFGVgl2fcXadOUAwUjf1tc1QP+0c+uq1EVNy2+pH53GtkQ62oMRXDzi3FCcV
         bcwg==
Received: by 10.216.193.65 with SMTP id j43mr6374877wen.141.1352630513128;
 Sun, 11 Nov 2012 02:41:53 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 02:41:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209334>

test-hg.sh forgets to set ui.username, which is required for `hg
commit`.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Squash this into fc/remote-hg in pu?

 contrib/remote-helpers/test-hg.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh
b/contrib/remote-helpers/test-hg.sh
index 40e6e3c..031dcbd 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -29,6 +29,15 @@ check () {
        test_cmp expected actual
 }

+setup () {
+       (
+       echo "[ui]"
+       echo "username = A U Thor <author@example.com>"
+       ) >> "$HOME"/.hgrc
+}
+
+setup
+
 test_expect_success 'cloning' '
   test_when_finished "rm -rf gitrepo*" &&

-- 
1.7.12.1.428.g652398a.dirty
