From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/11] completion: prompt: fix for Zsh
Date: Thu, 19 May 2016 23:58:44 -0500
Message-ID: <1463720325-8853-11-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWo-0001iW-Hx
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbcETE7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:59:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36046 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbcETE65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:57 -0400
Received: by mail-oi0-f66.google.com with SMTP id g16so7294724oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oelGOvLbHgAq7rhrmWvQjg2abqf1Mku3SZ7fBpPI/CE=;
        b=W23IrAEVClH9qQxKojd2376SrFMtPn3Erq/pbILdvmD/2Ja+WbTew1aWGr+G//IYMD
         efC0dN5qulEpn2Oc1VVZSLeLIEs7KXF5Q/QCefY1AwTZjkKurwhDAW+j2ZrqJbppOaV7
         NpbFN7V0nL60KKnVblAkWxL+C9zSriEFHtALCJbqjwIkqv4+F2mMAVRYc/2UHs/ZPGLr
         0SnEhvrKDDRXudWEh42S1MmY482wbE6do+7RwZXUWpsmkPA1+rZHmuMdXCdK43mmapIS
         cHlwCd4ooviqZBH+vqieA69gwPzioAarqxQS8Jt79/BWVV8ChXqNfQpKAqTXgJ8KKoN/
         HPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oelGOvLbHgAq7rhrmWvQjg2abqf1Mku3SZ7fBpPI/CE=;
        b=aXmk6CoFb6Fp0zW8NQRUKVYkPZ+DPAfSwHrTUcOsnb8aiw52Xdwmo/m8jZd+nYBOo2
         asum1AsJZFXCRpTS3YX3IB4lbnVCP3PvyJ5+1Nxe6NapETXtZLT2Ull1TsE1dNxoDs8x
         6sDv1vWM7EsM/N+S3cQpQiFWEhgbYU1FSWCO26H5XHItdVd1gAtWTavtDjrlGWaSbvEc
         ynPLKr/OLKAIutEvuXKBZijpYwo/NwLD5xpd14NRpZ5uo+RNz4ooGW4DG7ZhiotDNnUG
         eszGVD10Aovc14P5qXVKJVNY2LaPV5JmlbqRbSCane0Sdj1JBjTFxvuT7LHs0a98H0el
         2mug==
X-Gm-Message-State: AOPr4FW0BakqfbLI+bRGTvYtz9H8arCC+NtLnIVsozD+Z1lEy5ca/s9Rp9/2O8S8wSAdGg==
X-Received: by 10.202.205.148 with SMTP id d142mr593889oig.119.1463720336324;
        Thu, 19 May 2016 21:58:56 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id 39sm3324798otm.33.2016.05.19.21.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295145>

We can add colour in Zsh without the need of pcmode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 64219e6..0da14ee 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -502,9 +502,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.8.0+fc1
