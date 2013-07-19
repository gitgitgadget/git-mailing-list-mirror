From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 2/4] Cygwin 1.7 needs compat/regex
Date: Fri, 19 Jul 2013 19:08:28 -0400
Message-ID: <1374275310-22388-2-git-send-email-mlevedahl@gmail.com>
References: <51E9C69F.7080309@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 20 01:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jmz-0004aS-Os
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab3GSXIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:08:38 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:64709 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3GSXIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:08:37 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so185308qak.9
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7OOo2m5Ed730dv0e0qrwktOExUQKesG0WLxk2IdusVM=;
        b=L9CeFYrG+HzAUy5IkuzvOPFUhSar/cO3UlHkANG2fULtHgzQx6AyMNMQMJf8CJXGD4
         il7XSXDDpf1zjRLrkhW7gXm4ou3fvkZfDLkKOC1CAfPfH/B6liKrDfigsPduS61Igd6S
         EqE7vIOQbum0828HaXTx5i6pCB2lTH4WX04KGknsBchQ8+4fxLRHEY/BfId44dBAMbjt
         doNLJfs/c9XJz74zIHxZ3osUySdwzCYPWa/GR0fdA8kncd9Z1CZlquP67yR+46fA9+NO
         hDx+RhpDO4tQMgKcPKFDhaigHp87zK3sbKGSbAaB0f0rc4OHIAiAi/Q1d/rYs580KWvG
         Y4Hg==
X-Received: by 10.49.0.140 with SMTP id 12mr19810507qee.26.1374275317131;
        Fri, 19 Jul 2013 16:08:37 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s9sm22498999qeo.3.2013.07.19.16.08.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:08:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <51E9C69F.7080309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230860>

Cygwin v1.7 uses the regex library from newlib which does not pass git's
tests, so don't use it. This fixes failures in t4018 and t4034.

Continue to use the platform supplied regex library for earlier versions.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 104dc44..8652da9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -160,6 +160,8 @@ ifeq ($(uname_O),Cygwin)
 		NO_IPV6 = YesPlease
 		NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 		OLD_ICONV = UnfortunatelyYes
+	else
+		NO_REGEX = UnfortunatelyYes
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
-- 
1.8.3.2.0.13
