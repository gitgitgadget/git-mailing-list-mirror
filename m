From: cody.taylor@maternityneighborhood.com
Subject: (unknown)
Date: Thu, 12 Mar 2015 18:34:37 -0700 (PDT)
Message-ID: <20150313012620.11094.40096@catuvm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de, felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 02:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWEUv-0005j9-0f
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 02:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbbCMBek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 21:34:40 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:44717 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbCMBej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 21:34:39 -0400
Received: by qgfl89 with SMTP id l89so22736530qgf.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 18:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:content-type:mime-version
         :content-transfer-encoding:to:cc:message-id;
        bh=nSDCHRDvTpejxsbTx/0gAnY8QHBR8PdLz9jZPLGs6hA=;
        b=EQtd09bRg0H8NHolWuEaT2vWJe9GH3Ir5/1dBwC1WKk7o2Fv7iNz/nNb/ni7m6u+1P
         /ODn4uSe9IUnm/hWe3v5aDkpaciysAi5xm2gRd6B4T/BTFUK5EBlRy01BBO6W2ccjp1x
         RAAWEJJmjPAzQth7DjtaivjQkbkRpp3PNSFSx/9vi1P3UoHvweP/9wrz0EhLQXBaTAuO
         6kUeZ+crzVbgI1TcKn9wV2zJtyyFavMcBOrYYY2acAkf5XHX86GObXjppSZRxVnez39/
         4d9KqILOy4/1fNSTGbY5IKOuKOZX/5w+gCObv3ZODe111perQT/t/bNN57OikMUZkJGd
         Re9w==
X-Gm-Message-State: ALoCoQn72WIG2almiV733UbC9WDspHorXL9vQwo3slO4rXPMNHCjP4ZBZXGLrXj2HBU4FBP0YYvh
X-Received: by 10.140.130.71 with SMTP id 68mr59144574qhc.12.1426210478219;
        Thu, 12 Mar 2015 18:34:38 -0700 (PDT)
Received: from [127.0.1.1] ([216.197.66.13])
        by mx.google.com with ESMTPSA id 17sm440821qhq.23.2015.03.12.18.34.37
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 18:34:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265386>

>From 3e4e22e93bf07355b40ba0abcb3a15c4941cfee7 Mon Sep 17 00:00:00 2001
From: Cody A Taylor <codemister99@yahoo.com>
Date: Thu, 12 Mar 2015 20:36:44 -0400
Subject: [PATCH] git prompt: Use toplevel to find untracked files.

The __git_ps1() prompt function would not show an untracked
state when the current working directory was not a parent of
the untracked file.

Signed-off-by: Cody A Taylor <codemister99@yahoo.com>
---
 contrib/completion/git-prompt.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 214e859f99e7..f0d8a2669236 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -487,7 +487,8 @@ __git_ps1 ()
 
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
-		   git ls-files --others --exclude-standard --error-unmatch -- '*' >/dev/null 2>/dev/null
+		   git ls-files --others --exclude-standard --error-unmatch -- \
+		     "$(git rev-parse --show-toplevel)/*" >/dev/null 2>/dev/null
 		then
 			u="%${ZSH_VERSION+%}"
 		fi
-- 
2.3.2
