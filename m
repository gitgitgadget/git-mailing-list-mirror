From: "=?UTF-8?q?M=C3=A1rcio=20Almada?=" <marcio.web2@gmail.com>
Subject: [PATCH] fix global bash variable leak on __gitcompappend
Date: Wed,  8 Apr 2015 02:45:58 -0300
Message-ID: <1428471958-12339-2-git-send-email-marcio3w@gmail.com>
References: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 07:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfiob-0004RW-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 07:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbbDHFqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 01:46:09 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36519 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbDHFqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 01:46:07 -0400
Received: by qku63 with SMTP id 63so73243811qku.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mkmS9MutAzoxslBaXBw93lZ7kTfeyFaxWtVaWyccHak=;
        b=JecnWxxDMgbCQnJTkKfHzcTkcXqX7ePxDMcI4DvwSH/eSIZzESdat9tYCDHoOtiADv
         Kg4RXL8uiGkLwfbbotueL0/g1TSB0P9cPfUysWrTqNyq50NqbTYdaWd6E4pPf1HIOuD0
         vkuDENUDyQrtCXk/LKzSa+sP/mUqGCa4gPRQ+MfhiZk/E2R0QpvFxqeRCoioNiCVJxFv
         6pfwyAF+gGLUU2EpbZ2QrBsOxgJaMeteDSd9zlShNuBlll7ooz93A/3YW3e/QJR2F3fa
         qz4WitmbOKkOhTlFaYxVcJU4Tk4TLdyUDAsihOw8qagRu18g4tqf/VMB9NirPfz60qYi
         fVDQ==
X-Received: by 10.55.49.143 with SMTP id x137mr45802026qkx.72.1428471966401;
        Tue, 07 Apr 2015 22:46:06 -0700 (PDT)
Received: from localhost.localdomain ([191.6.114.155])
        by mx.google.com with ESMTPSA id b141sm2717093qka.11.2015.04.07.22.46.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 22:46:05 -0700 (PDT)
X-Google-Original-From: =?UTF-8?q?M=C3=A1rcio=20Almada?= <marcio3w@gmail.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266950>

---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 661a829..1620546 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -186,7 +186,7 @@ fi
 
 __gitcompappend ()
 {
-	local i=${#COMPREPLY[@]}
+	local x i=${#COMPREPLY[@]}
 	for x in $1; do
 		if [[ "$x" == "$3"* ]]; then
 			COMPREPLY[i++]="$2$x$4"
-- 
1.9.3
