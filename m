From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH 2/2] gitview: run blame with -M and -C
Date: Tue, 12 Jun 2007 23:05:21 +0530
Message-ID: <1181669728642-git-send-email-aneesh.kumar@gmail.com>
References: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 19:35:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAHS-00012Y-6N
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbXFLRfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbXFLRfi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:35:38 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:62793 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbXFLRfh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:35:37 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1200479hue
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 10:35:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:in-reply-to:references;
        b=IjZ6VgnUfrDAvMAhgau84nEVFp4ExpZBoEOGPvPbSzc+NLgje1jPKFhfDJWQIvvLSWmI2PvIjNVFLJ7CLtTNSS6GIg+I+v9cX/JReUBqyqO/Z8LCgEz8f7b4ieX8XxJas0r0MrOV734mRoVNQBjYO2zDtEVSVOELQwmZ2MRxxMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mlMTqn0tNVUmkXfi/I32k3+Ji8EY5NQPJ7hZggQduA8+GXqNH0Wnl7h4ri4iWDstqtbjdtdQBv1JiOOctdpOpqbWmcRNmkt03GmRe9CIbURzAZ6x1/j/eQLEvZlmMeFiD8EU1vFj5O/Qe+97TKcXftmbcz6tcLvK3hy1Uvn1kK8=
Received: by 10.114.24.1 with SMTP id 1mr6864308wax.1181669735112;
        Tue, 12 Jun 2007 10:35:35 -0700 (PDT)
Received: from localhost ( [122.167.206.108])
        by mx.google.com with ESMTP id m27sm11323812pof.2007.06.12.10.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 10:35:34 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.239.g75d8-dirty
In-Reply-To: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
Message-Id: <62df20bd1b31a7dc088f4ac7c00a732d498cadbb.1181669428.git.aneesh.kumar@gmail.com>
In-Reply-To: <392459374618773353ea560d021dd3211d143d86.1181669428.git.aneesh.kumar@gmail.com>
References: <392459374618773353ea560d021dd3211d143d86.1181669428.git.aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

pass -M  and -C option to git-blame so that blame browsing
works when the data is copied over from other files.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 286e974..01128f4 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -530,7 +530,7 @@ class AnnotateWindow(object):
 
 		self.add_file_data(filename, commit_sha1, line_num)
 
-		fp = os.popen("git blame --incremental -- " + filename + " " + commit_sha1)
+		fp = os.popen("git blame --incremental -M -C -C -- " + filename + " " + commit_sha1)
 		flags = fcntl.fcntl(fp.fileno(), fcntl.F_GETFL)
 		fcntl.fcntl(fp.fileno(), fcntl.F_SETFL, flags | os.O_NONBLOCK)
 		self.io_watch_tag = gobject.io_add_watch(fp, gobject.IO_IN, self.data_ready)
-- 
1.5.2.1.239.g75d8-dirty
