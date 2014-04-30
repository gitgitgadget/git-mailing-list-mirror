From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] completion: zsh: trivial cleanups
Date: Wed, 30 Apr 2014 06:07:44 -0500
Message-ID: <1398856065-2982-6-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSXH-0003bx-67
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbaD3LSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:38 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34282 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbaD3LSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:37 -0400
Received: by mail-yk0-f170.google.com with SMTP id 79so1319479ykr.15
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iy7jiCB5mexkpv2/sv/+BNwxklKTcqefRDVsHJzle/Q=;
        b=l5RjhXJT8/JezIFy2TbfqEXyG7QOswth3lNVK0ylELMHyw8ll4BGV0+uZ4oCzpuDJ5
         9WA6HNrW7Y4XOUv+FJhXOTFwcCFjcAuCt4l5p/XvtqsuV9EkOE6D6smH0qM9sOQsqgIf
         pH63vR3FwHePgwjJp0j6D7vzV7axqGfmJ8Z7/sBQyTSzeb7czFwXiUiCO2YbHOiJRana
         3bdUsC2iwow0yD/51BKAtf6qSBar0JiY1uqi+MNRNWt6DFIL07sGKuLDz7T8/zlOjFjQ
         4eT2rTP2d/5eT0Z4Q7JQj34CLsHgWPeizopifkUa1lRrpPcgnwahgUuWVc9arJvSZg1+
         smqg==
X-Received: by 10.236.130.241 with SMTP id k77mr4519459yhi.159.1398856717096;
        Wed, 30 Apr 2014 04:18:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t9sm42278092yhg.18.2014.04.30.04.18.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247703>

We don't need to override IFS, zsh has a native way of splitting by new
lines: the expansion flag (f).

Also, we don't need to split files by ':' or '='; that's only for words.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e71896a..f72f71c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -65,26 +65,22 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_nl_append ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compset -P '*[=:]'
-	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -Q -p "${2-}" -f -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
1.9.2+fc1.11.g71fb719
