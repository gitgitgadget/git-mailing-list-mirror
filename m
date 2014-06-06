From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/20] t/t4102-apply-rename.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:57 -0700
Message-ID: <1402066563-28519-15-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZY-000227-2H
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbaFFO4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:42 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64327 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaFFO4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:21 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so2516895pdi.30
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crH2HT7p9z9W/1K2NYDqeDzjp9TTKftbP8gglJDIGsA=;
        b=ivDGRcqX6FXH9MuxJxN6UKeAupcxFHhOnFA2nIkOtc9v6n16351XwEIjU5KoukuxrJ
         f8dC0ni1uEnDcCKxI40ITYmGuDnnueFRcg/H8vOfE+ChBM5i16SW914Mp0aa9Qus9n+M
         PX1VTeowC4A1r4BItg0qDN7OHpupyVuqPwOEYMU8bVugk1NCBUa8VJbuV+CcKWzJeNc2
         bUEIbnItLw8F/BaTn+qpV02hLPDffQKctnntkeNaqrYLQCnuM31wLPDUqm5LltVJe4RV
         m77HIggOcy75wrqzDI5p1IPo5NYDcRGzi9QfiBlIAWlBvI5lU7tQB4BOdIRSqNdlC/E+
         dcMQ==
X-Received: by 10.68.253.73 with SMTP id zy9mr1590799pbc.114.1402066580914;
        Fri, 06 Jun 2014 07:56:20 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250931>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t4102-apply-rename.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index 49e2d6c..fae3059 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -52,6 +52,6 @@ EOF
 
 test_expect_success 'apply copy' \
     'git apply --index --stat --summary --apply test-patch &&
-     test "$(cat bar)" = "This is bar" -a "$(cat foo)" = "This is foo"'
+     test "$(cat bar)" = "This is bar" && test "$(cat foo)" = "This is foo"'
 
 test_done
-- 
1.7.10.4
