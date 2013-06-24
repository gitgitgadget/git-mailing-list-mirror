From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] completion: add completer for status
Date: Mon, 24 Jun 2013 22:52:55 +0530
Message-ID: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrAXC-0003MO-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab3FXR03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:26:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45372 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab3FXR02 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:26:28 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so11425678pad.28
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZAlTqMalK40sLs73m5XlhAAWmENF2K2rUzb4nSpY7bI=;
        b=wmaOOil66F1ZewvqYJFkB+7JCY84b3q/3K3maAhGd+OWKL2ZvF1UgfSwyJOH4XWfn2
         SfvivyCWdYRU7nbk6z8tcp+5kjeyz5nxDlkTqLT1sxvd3QA1WhOa6WYJpTp94eMX96yH
         Dd+lxvldxzXohkWadZV37H8Vr6180cfsJt+a8GrMnZDA6+Spc+dsljb8OuBpl6NB7NlJ
         8GGUTG5eUOqK/4LjlroOYTgAyU34pykg5e68E1sOU06sd3Ab3/We8u1yjRhR/wZ+R/Du
         nLnOCyAyPui2Tz1fNK23WvTtfTES6SEheAjAuhBCVpD/xYmi80aL/QsTyIa83IfrgJRx
         5Q4g==
X-Received: by 10.68.11.232 with SMTP id t8mr24401387pbb.128.1372094780942;
        Mon, 24 Jun 2013 10:26:20 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id fp2sm19017486pbb.36.2013.06.24.10.26.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 10:26:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.550.gd96f26e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228882>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c3bafe..912fb98 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1695,6 +1695,32 @@ _git_stage ()
 	_git_add
 }
 
+_git_status ()
+{
+	case "$cur" in
+	--untracked-files=*)
+		__gitcomp "no normal all" "" "${cur##--untracked-files=}"
+		return
+		;;
+	--ignore-submodules=*)
+		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
+		return
+		;;
+	--column=*)
+		__gitcomp "always never auto column row plain dense nodense" "" "${cur##--column=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--short --branch --long --porcelain
+			--untracked-files= --ignore-submodules= --ignored --column=
+			"
+		return
+		;;
+	esac
+	__git_complete_index_file
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
1.8.3.1.550.gd96f26e.dirty
