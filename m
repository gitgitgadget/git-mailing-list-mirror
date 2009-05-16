From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 01/11] t5550-http-fetch: test fetching of packed objects
Date: Sat, 16 May 2009 11:51:06 +0800
Message-ID: <20090516115106.2f28dfd8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Azh-0005Yq-Jn
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbZEPDzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbZEPDzT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:16840 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbZEPDzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:13 -0400
Received: by wa-out-1112.google.com with SMTP id j5so808043wah.21
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=tWGdhIUo2qDOZ+CDOFgWbxBajVerKWvdx0jpA+PHLKQ=;
        b=EXoeyNe6LeNS5Ay6BshllaZPsKgIc5AcqmlbYmTOt4tXQ1lnqKmMjows7ac90sWUKF
         ZlAC02J48Ak9zfULMi+LqVcBnNQLCCS50FkRyVQUh7jkiLw1B3YBlDBc+5Acs4iHHS0F
         8Ws6c4Rw2q2FzWn/67hKMYjX019YGa8pntAuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=aRLWhNDi6mc65WTSxWxBOaHbgTC+H6nzjkdBI+h6D2nWQN8PFDgcWporLoKdIRFl+d
         TRWQFNm0/cyDDVkx7uvhApR2B2/Wpg0jej+kBN0DRb2e9Adi0Cb9xSnEG+a9joyWi1K8
         6BJ3FXlZLm5a9/0zzfYGXvIT7TxXMrKHWeHVA=
Received: by 10.115.18.3 with SMTP id v3mr6042861wai.178.1242446114376;
        Fri, 15 May 2009 20:55:14 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id n33sm2157995wag.56.2009.05.15.20.55.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:14 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119324>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5550-http-fetch.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 05b1b62..0e69324 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -53,5 +53,13 @@ test_expect_success 'http remote detects correct HEAD' '
 	)
 '
 
+test_expect_success 'fetch packed objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	git --bare repack &&
+	git --bare prune-packed &&
+	git clone $HTTPD_URL/repo_pack.git
+'
+
 stop_httpd
 test_done
-- 
1.6.3.rc0
