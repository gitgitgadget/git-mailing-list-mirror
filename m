From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/13] remote-hg: don't update bookmarks unnecessarily
Date: Tue,  2 Apr 2013 13:03:01 -0600
Message-ID: <1364929382-1399-13-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WC-0007LU-2w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947Ab3DBTEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:45 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45113 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762144Ab3DBTEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:43 -0400
Received: by mail-gh0-f174.google.com with SMTP id g10so117503ghb.5
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=o/8okFDv4r8PyFE6oeLaADY+HZBHdjrQPghfpWHjkxA=;
        b=tQtqrFrIi9tk+A0V4ZhOOA5DwIvFuZqiT1bp8fYbRqg8DeY6yaDLjpshpaAslTKP9C
         gykLxOpg60QcWJGszS7k7Shc6Wq2mmNBtITZeyMG0+xnoujyr+fyw/1Nju6KD161X3OH
         C/JSBDcuep0+dbTcyiUY3J0FNSdLSdrPXce5PquEIdplBQcw1NmxFf1oAqnvEVysrajC
         KLG9OZJ22Y78DkLEQUdvxthjrKdeSPVGJSCZ2gg0PQ60VJSgtrX59ufJ9+qsXYqnNehq
         vB3ZvF/HTlgbFac0eTjykeArrPx65z6ydeY1L1jvIvv+fo2vg5maGXqoKfxaqM5HjEuW
         ZC+Q==
X-Received: by 10.236.139.6 with SMTP id b6mr16384784yhj.93.1364929483105;
        Tue, 02 Apr 2013 12:04:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s45sm4790838yhk.22.2013.04.02.12.04.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219845>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a1b7e44..3130b23 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -733,6 +733,9 @@ def do_export(parser):
         else:
             old = ''
 
+        if old == new:
+            continue
+
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
             pass
-- 
1.8.2
