From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [PATCH] Unset TZ in t5000
Date: Tue, 14 Jun 2005 10:09:39 -0700 (PDT)
Message-ID: <20050614170939.69223.qmail@web41206.mail.yahoo.com>
References: <42AEF512.5040107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1503095403-1118768979=:67284"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 19:05:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiEqK-0005or-IS
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFNRJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 13:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFNRJq
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 13:09:46 -0400
Received: from web41206.mail.yahoo.com ([66.218.93.39]:3937 "HELO
	web41206.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261255AbVFNRJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 13:09:43 -0400
Received: (qmail 69225 invoked by uid 60001); 14 Jun 2005 17:09:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Tx4BK2Vd1INd8t23Zno0eiNO0mwkUqpOvbjzlZar0npU7xg3etTb56NwGIId9mUAvax5bmHBDhDjkkrkukftIUzyVRuUdfKWTYbQUhviv0Yrh/a1ViW1zmvwQVDa1nxjvWKeBZQlwN1YtKYy+bfXY9yTVGcz2mbl0rU0G5jJlk4=  ;
Received: from [65.173.207.2] by web41206.mail.yahoo.com via HTTP; Tue, 14 Jun 2005 10:09:39 PDT
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, torvalds@osdl.org
In-Reply-To: <42AEF512.5040107@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-1503095403-1118768979=:67284
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Linus,

Please apply this patch to make t5000 more portable.

Thanks,

--Mark

---

Unset TZ to force GMT in test #4 and add a set of parens around
the length function in the awk script.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>
Acked-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
 

--0-1503095403-1118768979=:67284
Content-Type: text/plain; name="t5000-portability.patch.txt"
Content-Description: 560000162-t5000-portability.patch.txt
Content-Disposition: inline; filename="t5000-portability.patch.txt"

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,8 +50,9 @@ test_expect_success \
 
 test_expect_success \
     'validate file modification time' \
-    'tar tvf b.tar a/a |
-     awk \{print\ \$4,\ length\(\$5\)\<7\ ?\ \$5\":00\"\ :\ \$5\} >b.mtime &&
+    'TZ= tar tvf b.tar a/a |
+     awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
+     >b.mtime &&
      echo "2005-05-27 22:00:00" >expected.mtime &&
      diff expected.mtime b.mtime'
 

--0-1503095403-1118768979=:67284--
