From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/12] completion: simplify _git_bundle
Date: Sun,  8 Apr 2012 06:07:55 +0300
Message-ID: <1333854479-23260-9-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiV9-0007HT-QM
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab2DHDI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:56 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab2DHDId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:33 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wF7VSesmeymKOZ9a1vjhjRNI/r5BRAsrq0ugRPqJZkY=;
        b=BYPMPBskaRVkPsQuq5REGb9oBKNc75FMUoueGlEUfIFc7415ZNzIW1tKhhvI7L3+rv
         5L+N//7qqe2u6o6M4jdeeGo1+vv/gb1T5ODH71n5oZ4g/VCiFDrqxf2aa9Wf4Bk9BZqJ
         WXK+ROKZGxiDuE+GeQNtNTpgqv1yilTW50HwydZ0RPkKuPeydi+jCvvlqo/SattqEAx+
         ojFYi1Bao0h+/b89J7Uf81wx6BlLpOZfVFtxkXtEwqbt4f7KP4GJTfFCMJy+6fpZf8HE
         jtL4zxfvNLF7p30HF2FWGSOGU+s4ugFu5Hc95a9GGV2Q6pOSaA5/X+zi48mahuEiK2MY
         BgvQ==
Received: by 10.152.114.35 with SMTP id jd3mr4765750lab.18.1333854512930;
        Sat, 07 Apr 2012 20:08:32 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id uc6sm15519594lbb.3.2012.04.07.20.08.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194961>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1fe11f4..c26f96c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1140,16 +1140,18 @@ _git_branch ()
 
 _git_bundle ()
 {
-	local cmd="${words[2]}"
+	local subcommands='create list-heads verify unbundle'
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+
 	case "$cword" in
 	2)
-		__gitcomp "create list-heads verify unbundle"
+		__gitcomp "$subcommands"
 		;;
 	3)
 		# looking for a file
 		;;
 	*)
-		case "$cmd" in
+		case "$subcommand" in
 			create)
 				__git_complete_revlist
 			;;
-- 
1.7.10.3.g5a738d
