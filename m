From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 4/8] rebase: cherry-pick: fix abort of cherry mode
Date: Tue, 28 May 2013 23:16:36 -0500
Message-ID: <1369801000-3705-5-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqS-0002Lk-SK
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934197Ab3E2ESe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65507 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2ESd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so3761884obb.33
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wy+uzDbdfPqwejZBmvUYdfxdEBkIQu5SFvcmqp2+FHI=;
        b=AHGXdF3QaKYe/jwuGvIGcKwoMFo6byrsokI9JePvb22fJsayjMBzekwkLFrD/d+UxN
         XkKz/IhKMI4cAzFwG6GlkhHkjCu1OYvq4cX9/F/hCjIJxZ0Y6Hzy8xG7xUthh09t1zhe
         FfqpFDOMUgoUqG1idhFrpcTIPiF1eLtZRtOkEuzKHz9lDy9OhsrPW7xwRBWPSnmfrJ8w
         gpyOUYpbnqnB9Ex0MwCHLAQ4tkVMHNeCMVlLFgoueSXJ+pFRDBaKyaxs9Mji6A3HXEMI
         R3bk1yggt7LTVOvsd6KhE0AOa/4KiwhdiU2aQDBc5dltDPHmV8WLTr3gHiQatO9SjH25
         P1Bw==
X-Received: by 10.60.133.113 with SMTP id pb17mr483411oeb.127.1369801112685;
        Tue, 28 May 2013 21:18:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm38340332obc.10.2013.05.28.21.18.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225727>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 76900a0..9b5d78b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -335,6 +335,7 @@ skip)
 	run_specific_rebase
 	;;
 abort)
+	test "$type" == "cherrypick" && git cherry-pick --abort
 	git rerere clear
 	read_basic_state
 	case "$head_name" in
-- 
1.8.3.rc3.312.g47657de
