From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/11] completion: bash: cleanup cygwin check
Date: Thu, 19 May 2016 23:58:41 -0500
Message-ID: <1463720325-8853-8-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWe-0001bo-ND
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcETE66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35800 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbcETE6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id w198so21095945oiw.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IR08PhyvjpjT5iweNiMZILPnC8OsHkFPMv2Nl4VmXY=;
        b=Xd1kO4pOh5Q3kbT8rFsBAbX2CcMQq0Nyt147Q5asMwqF+RTFS4ZnDBhueTUknzFjTo
         Gl/pjF1qcT36s6YYUX3UgsJpvIt7cdCs3JEMDquzo7Se2xp3yDiSKnzpiLbapSSC13M+
         ISDeiXKNThXIWaZjtU1G0WGtBuPiPTQSAmBgWxzlG8eQLgROZC02PhKtX7odVeqAtiXE
         gLjic2G4p0Fw2gZZd+AlNKKFDHnPtx3SZNIwmqE4LzfAoB1HulASIcqsrquZq7ZUtCKy
         lsrcIpaeYOXZ3NCDXyYe7TUvSteTDOru1B0PbDCniOstfjlNLqtDFX2AZXa0ssGrplnP
         NZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IR08PhyvjpjT5iweNiMZILPnC8OsHkFPMv2Nl4VmXY=;
        b=W6sqqn9k4W1pTZivQi5OH/wh82QSzfcHgqw/GqOW43pemKFLehZpshcYxysTBXm59o
         3vy+z85ZBjlXcXw1O2/uUaDvnYz7DdJg3snuK4ZvU9vOf0BTcd8aor1pYlGTa84tXiWp
         FmR+RYz5eJ2I4MTQSVX2X2d2CtU7KC3kRt1G2E+L7wy/ibpMOXf2mAVVYTrH6Cw536FE
         ZPdaNWgXH4L9CBIS81BjU46+vGRu1Na/MlxtGOv/cIF6OpcQ07C6pHJEs7D1o3lpHddz
         4+kt5GZOiYEkfnZ4HZkmbMsIggK3EiSsPEcnEF55fo1ocp/AVdoCNiv1tr5REr62ypWe
         CDHg==
X-Gm-Message-State: AOPr4FU6EHtFLbgLR0krXbcHimLOQu23iUHBgi8jl8LtRLPkOf5sWt8FvkVQrB78QhGYnA==
X-Received: by 10.157.26.24 with SMTP id a24mr551308ote.54.1463720333280;
        Thu, 19 May 2016 21:58:53 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id em1sm5001786oeb.16.2016.05.19.21.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295140>

Avoid Yoda conditions, use test, and cleaner statement.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c338ae..398f3a7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2698,6 +2698,5 @@ __git_complete gitk __gitk_main
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
+test "$(uname -o 2>/dev/null)" = "Cygwin" &&
 __git_complete git.exe __git_main
-fi
-- 
2.8.0+fc1
