From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/21] remote-hg: properly report errors on bookmark pushes
Date: Thu, 11 Apr 2013 07:22:59 -0500
Message-ID: <1365682997-11329-4-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYU-00071t-On
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169Ab3DKMYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:33 -0400
Received: from mail-qe0-f41.google.com ([209.85.128.41]:47669 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161139Ab3DKMYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:32 -0400
Received: by mail-qe0-f41.google.com with SMTP id b10so853791qen.28
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0dOtJHUlb25aqaI8qxs/hYTo675/OAGrIv/gu0dXWOA=;
        b=jTOT6G7kCvy4aB6CXmZavir33O52ZFn9TMP0MY6o8F4aZ0gwz+5ARfb2pgu5DvdGlr
         tmpwvcZYTv2lLPgrxNtDOPFHQyvwPGTi7WtK+qJva01DZdgQU1Pdo1OcvJUgY31g9HsQ
         Fo04oHYPM1t6ryawcNBWs7QmV0pzE1/pEiDAV4MAcTFK5UDxAwIhmSpTRj7pyjct7cZO
         l9kv8OXJSor/ucjazfySDB03/maEmbNz1b/qyEWqeh1Ov7/HW5F3yiJLW0e994YUYjrs
         8H9Ajp9RpizGnzECAv1zgftfIAhzSEhelT00c3H4ve99e6uvSnQNh6CX1kxUqpfuVqAB
         3O6Q==
X-Received: by 10.224.157.7 with SMTP id z7mr6732683qaw.70.1365683071690;
        Thu, 11 Apr 2013 05:24:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ed8sm6269347qeb.7.2013.04.11.05.24.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220856>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 844ec50..19eb4db 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -710,6 +710,7 @@ def do_export(parser):
             else:
                 old = ''
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+                print "error %s" % ref
                 continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-- 
1.8.2.1
