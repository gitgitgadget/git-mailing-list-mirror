From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] remote-helpers: fix the run of all tests
Date: Thu,  4 Apr 2013 09:36:17 -0600
Message-ID: <1365089779-9726-3-git-send-email-felipe.contreras@gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:38:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmEn-0000m1-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760787Ab3DDPh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:37:27 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:59946 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391Ab3DDPhX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:37:23 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so2929434oah.10
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Orhytj+N2cfGOEoOs5VUtmOiWLePUE+3NGe/fwKXHek=;
        b=lPEX1eEEAk0OfOSs79QiBPVM+d/QMZnUXtiukP1SfgJacZM6O4c4dQ5uWLq4jyipNh
         mMSf05pGoW7tVM1PCLgvQiMufqnVWURa2vso0OSOVrpgylMXT6Tx9f2lOOfYE9FzxK5Z
         KJzUi+FDyiPZ/ypJPEh1Dlx59Dv7RhRXaQ4PpHQf8XmEqSUUjpkCQsgACVLgB7Yqbs1t
         pnGRJBb9R+ij4Kxo+rmSleo18Blo0Qaze/Q7ShVfLNU0KxQiT/s4FFDXUZBKAKRGWXpM
         ZUFDfEE2Vsg6AkHDSpw7PgHARymSUrP7Akd2YyDasmLY4P1S/IPHT1IspNyS8npG6Vwh
         zQ/w==
X-Received: by 10.182.2.132 with SMTP id 4mr4710793obu.42.1365089843210;
        Thu, 04 Apr 2013 08:37:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 4sm6815323obj.7.2013.04.04.08.37.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:37:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220020>

We don't need to check for duplicate test numbers, we don't have them,
and either way test-lint-duplicates doesn't work in this situation.

Also, while we are on it, enable test-lint-shell-syntax to check for sh
errors.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 9a76575..239161d 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -3,6 +3,7 @@ TESTS := $(wildcard test*.sh)
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
+export TEST_LINT := test-lint-executable test-lint-shell-syntax
 
 test:
 	$(MAKE) -C ../../t $@
-- 
1.8.2
