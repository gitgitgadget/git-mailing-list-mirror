From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 02/23] refs-common.c: create a file to host all common refs code
Date: Wed, 13 Aug 2014 13:14:46 -0700
Message-ID: <1407960907-18189-3-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHex4-0008El-JB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbaHMUPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:14 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:63629 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbaHMUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:10 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so83660pde.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hn09ithBa6AJsoWhhRGWGzPRa7JT/c1tXvINgNVns98=;
        b=RjWif1Mnhyu3bggJU1ypNidZFWJ2MSaDUUPC5Ak9bTUvL8GWJT43ZJxQcFijkYfQ/z
         Vj0CUWtfvAqHXNMFLOjyvdPj/BjDXg59b/a6Y+zI9k74cVPt84nPZiLIahpF2ygtkuor
         gDqN664dpMpXquHEDUAK5aVmMBzaSp56jEZHXQqNGetm4HUeHy+Zhx3BQMVH/fEWFxKG
         Plx1cxyqvS84qVHMRahPQhkXeoxwZzrWZauh42PwL4PJ9rxPaqJG0owBVMB7RLWGd60p
         v80W9vsmzZzrFFJdv4Rx2LdNf8nTk71uy7RnWsSaDPQkYdEvP4mbLS818Eg3N8tx/6D4
         Twdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hn09ithBa6AJsoWhhRGWGzPRa7JT/c1tXvINgNVns98=;
        b=m7gFYx0vqDpbNc65R7rO5qEpUMIMCQA5BmhWVC5Accwim/fExOA1pyJdr6uPG4Kfq6
         UFt7yx2LjdKbAHOMdIxZKvzNWGXdVAYCRML2ROfMMepwGJJ491nn/xGm2p3uB4PTNDjO
         8u+0rdODT9XD7v1D7Umo73l1Di3MbxK2VvcobOoDthvr1E4fFkGz4f9U3aGPTgO0r1EQ
         0eZkrdWV9ARiA68ACIuPp4ZN/ND7s2N4exAjZ5VqJjnQAKMFEhZM+GDNNOggLPZoQzqf
         IM6nxkx1wUtJl3L+17L6XR5FPYjeVMD1cTQ/y70Di+a6TFsAEd5hEkYzXBQmWu/pKoXM
         CICA==
X-Gm-Message-State: ALoCoQmf4PNOkFouvqtB6DUSUNBCCfNKpxEvEXdcNHWK6tmm9GbGVRcRXNn63+endtLHzgobYafE
X-Received: by 10.66.160.164 with SMTP id xl4mr969206pab.48.1407960910245;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si207149yhg.7.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 13A0931C3DB;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 99CFCE0AD1; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255229>

Create refs-common.c which will hold all backend agnostic refs code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Makefile      | 1 +
 refs-common.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 refs-common.c

diff --git a/Makefile b/Makefile
index 07ea105..7705136 100644
--- a/Makefile
+++ b/Makefile
@@ -858,6 +858,7 @@ LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += refs-common.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/refs-common.c b/refs-common.c
new file mode 100644
index 0000000..44d96d2
--- /dev/null
+++ b/refs-common.c
@@ -0,0 +1,2 @@
+/* common code for all ref backends */
+
-- 
2.0.1.556.g3edca4c
