From: Cody A Taylor <cody.taylor@maternityneighborhood.com>
Subject: [PATCH v2] git prompt: Use toplevel to find untracked files.
Date: Thu, 12 Mar 2015 19:24:50 -0700 (PDT)
Message-ID: <20150313021910.11996.54041@catuvm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWFHU-00035l-3U
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 03:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbbCMCYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 22:24:51 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35563 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbCMCYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 22:24:51 -0400
Received: by qcwr17 with SMTP id r17so23632317qcw.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 19:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:content-type:mime-version
         :content-transfer-encoding:to:cc:subject:message-id;
        bh=HZYn+61FQgeXwLbIC/lf5nr8Ng5iaCEntwtTEleZNrc=;
        b=eAIX5Oi7zhaiOswD3m7Z5J/O+roMWmI4W4MwgaNjiuUsB4rEztw1SMdAFY7rK8AGfx
         P/Zt2NHDOfu/rQTA2Vd107GYqDam2KluC4/q5TCrf2adlz6ELvRkjNvfQ1MLedKdDlzV
         utCqVyKCOIV3VY74eTIdvLrBKdpxUUeG8j7TB54O4c7f4+eD7jK01CRAaba4CUasgVUO
         ciVLr2754mteO6qjrtpJhmPSJWXBET9WAnJUHwPP6VJUTA/oP/Cep1TNl/Bs48MizwH7
         I9Tk76v0tHpdoOPrmKSyg2h8Qjb3F0OoSXRyhqjkU5Jq9E3peZ9wrqOZZ7CSfOoIRieU
         EnTA==
X-Gm-Message-State: ALoCoQnbhfHhMrjRXutQIcp+J3oUMDSbpYVluur+PtHyiIkVjLom0qCAjdX7PrHtIafRFSft2X4G
X-Received: by 10.140.239.150 with SMTP id k144mr59496511qhc.77.1426213490437;
        Thu, 12 Mar 2015 19:24:50 -0700 (PDT)
Received: from [127.0.1.1] ([216.197.66.13])
        by mx.google.com with ESMTPSA id 4sm525216qky.7.2015.03.12.19.24.49
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 19:24:50 -0700 (PDT)
X-Google-Original-From: Cody A Taylor <codemister99@yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265390>

>From c861d5cb401110ce7d86b76c1eaa8e89e80f484e Mon Sep 17 00:00:00 2001
From: Cody A Taylor <codemister99@yahoo.com>
Date: Thu, 12 Mar 2015 20:36:44 -0400
Subject: [PATCH] git prompt: Use toplevel to find untracked files.

The __git_ps1() prompt function would not show an untracked
state when the current working directory was not a parent of
the untracked file.

Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 214e859f99e7..f18aedc73be9 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -487,7 +487,7 @@ __git_ps1 ()
 
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
-		   git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
+		   git ls-files --others --exclude-standard --error-unmatch -- ':/*' >/dev/null 2>/dev/null
 		then
 			u="%${ZSH_VERSION+%}"
 		fi
-- 
2.3.2
