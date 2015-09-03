From: garga@FreeBSD.org
Subject: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu,  3 Sep 2015 16:46:44 -0300
Message-ID: <1441309604-91875-1-git-send-email-garga@FreeBSD.org>
Cc: Renato Botelho <garga@FreeBSD.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 21:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXaTM-0008Fc-8I
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbbICTq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 15:46:56 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33061 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965AbbICTqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:46:54 -0400
Received: by qkdv1 with SMTP id v1so42494qkd.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=beJGTgkMo6gMJ6Xs2iii6JXWKli9Qy1ZOGBVpWJs4v4=;
        b=pb+TsHJhzahmJS/27dVy9ChNQN8sAeROKhCzAVff7cRRz2NO/CsroooJQMi3sAFe2t
         EyJIVke1CnExVQwsxyzlquBmCkKjJDb9VKFBL1HlpcGfmamZXKPfrSMc6Tc/p5nfH9cg
         mNcAreIOmzHGvUqd9v0WW/pbUshcnnKcrNH6ReqAYukn2PNy3dydc1ByT4FkoxfVgi9M
         K5XJDelDbrGg2eaEYx0FIS6NvfTf5nH1jozP6DZpq2rm+AFZ0WDNdr1SFKDoEim8gh/j
         3uQtGGOMzYpZOePM+Ya3ckojyy0lwwsIBckf1mx+39JtNkFFc8WtO3KGqbxgpGJqxuVq
         8Iyg==
X-Received: by 10.55.27.203 with SMTP id m72mr41318662qkh.39.1441309613298;
        Thu, 03 Sep 2015 12:46:53 -0700 (PDT)
Received: from mbp.home ([177.131.95.241])
        by smtp.gmail.com with ESMTPSA id x16sm10741753qkx.32.2015.09.03.12.46.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 12:46:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277244>

From: Renato Botelho <garga@FreeBSD.org>

git-submodule and git-request-pull are written in sh but use perl
internally. Add them to be replaced by unimplemented.sh when NO_PERL
flag is set

Signed-off-by: Renato Botelho <garga@FreeBSD.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e326fa0..4dae0ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1795,7 +1795,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
+$(SCRIPT_PERL_GEN) git-instaweb git-submodule git-request-pull: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
-- 
2.5.1
