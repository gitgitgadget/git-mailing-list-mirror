From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/48] remote-hg: load all extensions
Date: Fri, 24 May 2013 21:29:24 -0500
Message-ID: <1369449004-17981-9-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HJ-0001c7-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab3EYCcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:10 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:46681 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3EYCcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:07 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so6977393oag.16
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Sia/y53Aj+764bFiRIER1pTJqTe7WwYg7tcXsOE/6nQ=;
        b=hWoDfnXPhOqgzzA/UXq+LUM/yHig0BT7009d03uauvvZR2wSd/yCaMLSKV9bPtqorp
         v86oEKrRUg+JpwHTyfHc6YuYOWkLuDCgsjEeKBMTeoxDrM0g5P99FEpy/5MNb/bFNu8j
         lHTsVp9O7qvUlc+t1pHAk9/GSbID3BQpc06T4p0/HDKYcy2ZTVXV6J4IewMjQHPDdMN3
         xOduek1FkumdIj/Ku1ByQHP7I705I8tS5xLwbtVJovjL89ZBaDKAqfoFwaTBYfW90FMD
         xSx83R4n/WQtz1NWcoxAMYhBbPZVO5qyEiOcjs3mEo8G5R6Lcu0kbYHknXtpcBdDfJXf
         k07Q==
X-Received: by 10.60.51.234 with SMTP id n10mr9583144oeo.103.1369449126760;
        Fri, 24 May 2013 19:32:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm20584301oel.2.2013.05.24.19.32.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225422>

The user might have then configured differently, plus, all of them will
be loaded anyway later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 426c1fc..21f8acd 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -339,11 +339,7 @@ def get_repo(url, alias):
     if get_config_bool('remote-hg.insecure'):
         myui.setconfig('web', 'cacerts', '')
 
-    try:
-        mod = extensions.load(myui, 'hgext.schemes', None)
-        mod.extsetup(myui)
-    except ImportError:
-        pass
+    extensions.loadall(myui)
 
     if hg.islocal(url):
         repo = hg.repository(myui, url)
-- 
1.8.3.rc3.312.g47657de
