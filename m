From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/47] remote-hg: load all extensions
Date: Mon, 13 May 2013 23:36:39 -0500
Message-ID: <1368506230-19614-17-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73X-0005Ki-2i
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3ENEje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:34 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33048 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab3ENEjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:31 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so104443oah.12
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Eq2N3yid8aUWMPagVPpGtafMmCkzQz7rUIsPgiiD7Rw=;
        b=CYBOoka4sONKq4j9ptOpZEADMRV4khfkckrBAXtd+igIBAAMx3Ij+R104xp6NVREU9
         +t0M8WDfna0mAHVasrPwLCj9AhiYa4wsdRsdzwj5Xsq9Wbu5k5AKH8pLgJ1r9qTvxgKT
         L/oA66KqD4KIPJto7mcWjzACCXEBeJmkI6oMuNBOeDrtg+lyxrBLGp7zuBY4q15FWv75
         lpbW8SmyhHBCiq7SwksZU5eTsmAHf0JdI3ZpUfK8sCJWomeeyp7axRHjYP+XHbe9K9OV
         fl9yevPEjq9Pt0EgA17LgO94ljYtyPO2B9X/kQYfYd5RQaTGJbLuqnVmrnVAZtDHPNo2
         +JEw==
X-Received: by 10.60.42.104 with SMTP id n8mr15657013oel.94.1368506371404;
        Mon, 13 May 2013 21:39:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm19969618obk.10.2013.05.13.21.39.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224281>

The user might have then configured differently, plus, all of them will
be loaded anyway later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 96bed8d..60e875d 100755
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
1.8.3.rc1.579.g184e698
