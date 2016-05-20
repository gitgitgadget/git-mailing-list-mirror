From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/11] completion: zsh: trivial cleanups
Date: Thu, 19 May 2016 23:58:40 -0500
Message-ID: <1463720325-8853-7-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWf-0001bo-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbcETE7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:59:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36025 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcETE6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id g16so7294594oib.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VHA5d3tleQe8bgBpJqk3QmXiluLviOXT7zAc/UPywI=;
        b=hSltos0jdGxP6jjFlMzL8SBwIQ3OlbSARBhccB68QynArOSp+aCaK+Vs3QZf/aBnGl
         TMOgZ0sFTowQa77Bj/8Aee9bJp9fj4BlDujDFkdswoOM9puvytxR10rcwvOUlRe3FQ6M
         1IKqg35kGHWJUl9mXnWgrEAFj74AtbrZJ3IJdtleFJi6wLEael8gzMQaKC5ikCdkjax3
         PO7m/YU2eZuofBHdyn8so7d+C33fWSMKgKzy2H1ywWN/MCauwoqrFwNzEhFAzAXUDGi6
         xMoHNbZt8Re9+bozVHHNHMy8XfxHavEjKd0PPd95ZV5R76qBGSyDeSy8wQAq4MJEZj/w
         LgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VHA5d3tleQe8bgBpJqk3QmXiluLviOXT7zAc/UPywI=;
        b=dFRMac6a8kZeQSUBSeZR23tW67H/vn5QUhPozQbiy0m4+wRFiLR50fqNCh0KrhL2gc
         qAyufDCVfN+X3l+xvmap7XIFb5S9aGTaeg4WkMkw3t6+ZD/d27xOt/rErPQzurguM4fJ
         skLWVr5B58xb0H2U+YL1xOTqVtkKZHbuLExv3WUY87n7RXwB8K5ntPxWoDhHURVzaBiU
         6VI5tfU55kWvRCbMWswAPvsKy+C8QT7eHUBPsp6BUrHjwF0EhYxEQwTko4RPKLTzp1ds
         UEJkFsoY9Ox1Nw/a8E+J1hVUaW8qmQcdyWTeuyrOa13kqGWcHs4lujopqDLBoRcDGXUq
         7j1w==
X-Gm-Message-State: AOPr4FVkOn3Pfhgdwva4/+EqkqtP7xHjvThSp9H5LUaVISrMU4cDLzKRPdY8HyWVUkvBqw==
X-Received: by 10.202.225.6 with SMTP id y6mr585500oig.186.1463720332275;
        Thu, 19 May 2016 21:58:52 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id fo3sm5003721obb.1.2016.05.19.21.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295142>

We don't need to override IFS, zsh has a native way of splitting by new
lines: the expansion flag (f).

Also, we don't need to split files by ':' or '='; that's only for words.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e10df7d..317b8eb 100644
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
2.8.0+fc1
