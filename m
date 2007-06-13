From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH 2/2] gitview: run blame with -C -C
Date: Wed, 13 Jun 2007 14:16:16 +0530
Message-ID: <11817244541467-git-send-email-aneesh.kumar@gmail.com>
References: <1181724376650-git-send-email-aneesh.kumar@gmail.com>
Cc: gitster@pobox.com, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 10:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyOYp-0000K8-QF
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 10:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbXFMIuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbXFMIuH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 04:50:07 -0400
Received: from ag-out-0708.google.com ([72.14.246.248]:60148 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624AbXFMIuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 04:50:04 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1975122aga
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 01:50:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=naX0krwaj5ZMiRUgNuVtAJ2CEr6bdpeghECxF6g7pVBkIcF86w5lep+9O2rKNKCo9GyIhsV3VZ5OmLa3WxoY71XGL/UslYViGVDc5iFFbsnl9hU5TGFQ0Fat2Mcjm0P/sssZOITxrCp8Ouf/67FcDwyBmFAx25Xeb7joLIRTWLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NqNBSQFoqJp1tnMZRNeG8ITC48JsMq6CNEvjSPuQsymblnWiGBQ9d0whNhGbdCdR9ftsJ7si6Lh+xvWYQKGw824BijgNgG35ak97ecP8E/b9VBYDCsoDlo0XRQx6kUtg/lCbxoWu0f71Me3tYq0ADDO9a+RgboreGkfltHlpipQ=
Received: by 10.114.60.19 with SMTP id i19mr365965waa.1181724603336;
        Wed, 13 Jun 2007 01:50:03 -0700 (PDT)
Received: from localhost ( [59.145.136.1])
        by mx.google.com with ESMTP id j26sm145929waf.2007.06.13.01.47.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2007 01:50:02 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.255.gca6c0-dirty
In-Reply-To: <1181724376650-git-send-email-aneesh.kumar@gmail.com>
Message-Id: <6973094c1fe2fda471e09cac231457da8802a392.1181724308.git.aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <142a3f15cd43680e0d7a02f09ffdd93864d13871.1181724308.git.aneesh.kumar@linux.vnet.ibm.com>
References: <142a3f15cd43680e0d7a02f09ffdd93864d13871.1181724308.git.aneesh.kumar@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

pass -C -C option to git-blame so that blame browsing
works when the data is copied over from other files.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 93ecfc1..5931766 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -533,7 +533,7 @@ class AnnotateWindow(object):
 
 		self.add_file_data(filename, commit_sha1, line_num)
 
-		fp = os.popen("git blame --incremental -- " + filename + " " + commit_sha1)
+		fp = os.popen("git blame --incremental -C -C -- " + filename + " " + commit_sha1)
 		flags = fcntl.fcntl(fp.fileno(), fcntl.F_GETFL)
 		fcntl.fcntl(fp.fileno(), fcntl.F_SETFL, flags | os.O_NONBLOCK)
 		self.io_watch_tag = gobject.io_add_watch(fp, gobject.IO_IN, self.data_ready)
-- 
1.5.2.1.255.gca6c0-dirty
