From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/8] remote-bzr: fix for files with spaces
Date: Fri, 24 May 2013 21:24:20 -0500
Message-ID: <1369448666-17515-3-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4BZ-0006Rq-7W
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3EYC0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:13 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46401 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EYC0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:10 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so7062866oag.14
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HXL1vXLJX+2a7c45mDFSotpBKdUxrLNlYimkvclAQOE=;
        b=g3ahhsnodpyMSlnKcJ7gfomX3ke+TmMNThuABrD6pPxfgllouZUg761Xo8dyUhkVXV
         cBkdiZsIqVkK0ynh/GxQWx9T64mfNCbd6KtD+19G1sXuzWkUA+9OM5XGhwXQsxa7SrZg
         DwNVoMg60jsGHpizgwBdR92aYbRsm2u0M0ljW1txguETzpgLJH8gWYnAnEKt5RyTSnoT
         ZNgYk82psy31oTI6TU8mj7wyW5deQZQm95oDf8rKalQp0+O5cCM7kjz+iZq9EY2k8XGd
         6sprjRSbHar82jSId4rQNq7XmIOI1MMy960CJ1hlP1FW4qvqjQ8ovBkhwvnR0YK7+atP
         dm6Q==
X-Received: by 10.182.226.225 with SMTP id rv1mr13353985obc.61.1369448770304;
        Fri, 24 May 2013 19:26:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20545832oez.4.2013.05.24.19.26.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225408>

Set the maximum number of splits to make when dividing the diff stat
lines based on space characters.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 8a4df51..35664c6 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -621,7 +621,7 @@ def parse_commit(parser):
             mark = int(mark_ref[1:])
             f = { 'mode' : m, 'mark' : mark }
         elif parser.check('D'):
-            t, path = line.split(' ')
+            t, path = line.split(' ', 1)
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
-- 
1.8.3.rc3.312.g47657de
