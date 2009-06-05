From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/23] t5550-http-fetch: test fetching of packed objects
Date: Sat, 6 Jun 2009 00:04:40 +0800
Message-ID: <20090606000440.7eafb4f5.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzC-00053w-6Q
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbZFEQI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbZFEQI2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbZFEQI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:28 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=h+xQ7yjK8rqqXOQDqfcHISCXZzyqq4ElmczYQxNNqKA=;
        b=fLQRDFkEd4mqWb9LhhkRcrXOD+M5mai7wnG4MYXHJ7WiXjqRIB51ZKQM7n1vKSr0PT
         9AYgb7snxdArgLFowWt7tV2XjTh5K00ky30QEY/oyoJ3farH/703eGJQVYt8/8hq/mZa
         5vNc+Us3PI355WYM7izY0JYtFgLqBImQuMB+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jBVzovO+7a8ZeQzRr9LrWRFLRJtyppPfV1CniSP0cqtJECasHbbf5z8LZ9K2ClxnFr
         PeoFkheKvx+PszEqOWFQRkvY4BEPAcT4WSZVCsPw/XGVxsGAEGFdOynvl03NqXLKKDaH
         TWbqh8+EPlfHtFIZIFbSBMjPP2yeAMAU1SV8k=
Received: by 10.142.114.15 with SMTP id m15mr1243398wfc.58.1244218110657;
        Fri, 05 Jun 2009 09:08:30 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm383703wfg.25.2009.06.05.09.08.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:29 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120784>


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
1.6.3.1
