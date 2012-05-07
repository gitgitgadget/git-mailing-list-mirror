From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 3/6] completion: simplify _git_bundle
Date: Mon,  7 May 2012 03:23:17 +0200
Message-ID: <1336353800-17323-4-git-send-email-felipe.contreras@gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCft-0004IR-He
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab2EGBXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:37 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42182 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2EGBXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:36 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so959659wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rIzcs39fE/YCkUS69cGF5rkMy/InbpfVU6VLZW6ZKCs=;
        b=sOfToFuivpAPjyjyUPzMg9pQJm+6MYs82Eim2gFs9FbqDwTnUb51JCKOVZkfx2G7Ec
         g/m/lb1S147rzU+4ntkB9PQo5vYCnT+CipG/IQmZC17dUHEXT5VBQSVcEDqmPYbzXcm9
         cAVvzHVnV46wP8hNSSBSubQVFwP8VlThDeTclNfEjW2lDo4JUdPUtS/6U4Xa9eBSoORx
         dAOfuWWjGxL+tFD2eC7Cf47VlzxY3jEv24jaPU8GeWULo/Z8ZEIkKb8vHr0psLkZWW0V
         NGGjYRA0RJJqS2HK4f6PbA/ZHIdJXAOeUHeXtQdPprdbZYjYhkn5GQ6esu6KgqEt7Y9x
         hYjQ==
Received: by 10.180.100.2 with SMTP id eu2mr22220342wib.1.1336353815541;
        Sun, 06 May 2012 18:23:35 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id u9sm18266581wix.0.2012.05.06.18.23.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197229>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4098902..8de0358 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1142,16 +1142,18 @@ _git_branch ()
 
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
1.7.10
