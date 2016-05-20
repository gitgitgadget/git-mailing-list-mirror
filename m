From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/11] completion: zsh: fix for directories with spaces
Date: Thu, 19 May 2016 23:58:43 -0500
Message-ID: <1463720325-8853-10-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWf-0001bo-Su
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbcETE67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35808 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbcETE64 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id w198so21095997oiw.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VzAqR7BAnqr6dDm3MGGFRIJKsdxEUbZFvD4URZZp17U=;
        b=RqGQhv7iZUQxC14omElS5czC79ChLUveAsFaJUvc3sYlVFNgSb7uzgKdxOBe2FrDQi
         bobgeIRTcQyLwsRW3m7CSaFuAIljbp5X+oQiGmZ1ZpS/axf4grLGq+omU+/+a+JtXFtT
         cAnijWaxFonVPRYKwMZBjxZthe48lxMZLxxH7YKpKndcbk+a7IBKigJHGOFXR1QEPbFn
         jz8vhkP4KNUL1dpvx0u5AvqvERvSF2XkzFqp1mSx6Tr0eIW6ruEue46sGOPYx6Q1RHf3
         tECTB5H4ubB6JaHySX3DT/eGQ/TSVpEr/ld3e75PSZb99rdUO6q8Y800C5bOYhh1A28q
         xLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VzAqR7BAnqr6dDm3MGGFRIJKsdxEUbZFvD4URZZp17U=;
        b=T9IWkZUdVdKuvvFU4hZi7/uX31BfEsC25Vyw1kgFL/NcVbwDy6wGFRkMYZc9TAvZnD
         z2pVBe/qs+ahPKJ6ArpdN7DxE+06RqvS15OZt7GIxVPAvOKpON5lJ7+/rCM2daFefg+N
         guF071EoLYlBkw9qz4rOh8zT5MAFclzlVmxHsvGSlDIilf2mWYYtZN6zVMjjpM06Zt4F
         HJx+KF7KPTeL1Solk4m4AvuBHkS29DXSvrw5rRPfE4S+/NRSdFe87ly/Xgnhj6Hz2/uQ
         AyH2LBTcpD2hgN04MUE49ghTV9oD9F7dlszwPEFHvLNzV0kIOEUPNxhfQIlWpjLfxVxi
         UUaA==
X-Gm-Message-State: AOPr4FVPe2thTzN6vFSvKv+1p+rhBipAYL71iZuvONrQw1RahPaQl/M9xXWcvI2CAwxA/w==
X-Received: by 10.202.235.131 with SMTP id j125mr581134oih.13.1463720335352;
        Thu, 19 May 2016 21:58:55 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id a9sm4823980oet.13.2016.05.19.21.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295143>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1f786cc..28eaaed 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -24,7 +24,7 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
+		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
 		'/usr/share/bash-completion/git' # gentoo
-- 
2.8.0+fc1
