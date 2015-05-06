From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 4/7] credential-store.c: replace home_config_paths() with xdg_config_home()
Date: Wed,  6 May 2015 16:01:01 +0800
Message-ID: <1430899264-18447-3-git-send-email-pyokagan@gmail.com>
References: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 10:02:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpuHX-0007yn-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 10:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbbEFICK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 04:02:10 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33000 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbEFICE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 04:02:04 -0400
Received: by pdbnk13 with SMTP id nk13so2595071pdb.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iQLfhlr2+u+V2L1sxriRiLZCWYsfepvp/dJ3+1asnR4=;
        b=LBx2Pw59bveeYJM4sIMhDXUO6tG+oKkgJ+g20F0tljHv0ok5JWC3e7ptTgm0UC51rw
         P0znBQFvMOXi5Ga+neptGtITqFGWXhHJe7g7eobgRhyMNMZsMxaHmQvh+y/z+JMBXUoF
         XnIgW/OHxgh/8wUGevVUj5I70BCvGZ2NBJZJH7U8MM3D/FHD/HxQD660Lca+q3YlT1CY
         mfRBpSex3+2BkpRhvc2GhSdHdnxzyCE9uGzBiV+yMq48i+8uekLZBDBV6idb9kTd3do3
         cEHRDqbjOK6mp8UJr37dwca9u4yXO5L9AwG2e6BwqPsITWI+KRl8Zy+h6pe1P7kMf4Ar
         p4Lg==
X-Received: by 10.70.128.68 with SMTP id nm4mr59395190pdb.74.1430899323043;
        Wed, 06 May 2015 01:02:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id cy5sm1074571pdb.85.2015.05.06.01.02.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 May 2015 01:02:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430899264-18447-1-git-send-email-pyokagan@gmail.com>
In-Reply-To: <20150421040627.GA5415@yoshi.chippynet.com>
References: <20150421040627.GA5415@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268458>

Since only the xdg credentials file path is required, and
home_config_paths() is unable to construct the path ~/.git-credentials,
simplify the code by replacing home_config_paths() with
xdg_config_home().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Re-sending the patch series. There are no changes.

 credential-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-store.c b/credential-store.c
index 8b22251..f692509 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -170,7 +170,7 @@ int main(int argc, char **argv)
 	} else {
 		if ((file = expand_user_path("~/.git-credentials")))
 			string_list_append_nodup(&fns, file);
-		home_config_paths(NULL, &file, "credentials");
+		file = xdg_config_home("credentials");
 		if (file)
 			string_list_append_nodup(&fns, file);
 	}
-- 
2.1.4
