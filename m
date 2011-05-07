From: Boris Faure <billiob@gmail.com>
Subject: [PATCH 1/2] commit: do not cleanup template
Date: Sat,  7 May 2011 17:53:43 +0200
Message-ID: <1304783624-9919-1-git-send-email-billiob@gmail.com>
Cc: Boris Faure <billiob@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 17:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIjpi-0003Ha-RP
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 17:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab1EGPyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 11:54:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64614 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab1EGPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 11:54:07 -0400
Received: by wya21 with SMTP id 21so3019865wya.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ae+hZyarDLT9eb1jiUP0+KCdx8nm0WBq4PDYAoBO/yE=;
        b=jyARdduf0IaPpoDt8TIkJrklDAU0SUoiG6EPf/hdWg4AsHnjYA6HuezRGQUdXSYxOS
         CaFaCbzwB9Gf+foXfgnZ95nyCrwtqTGOJYefYeghy0lvCqouDjDtG5HBiq/kcRxDWQPL
         /RDeypWSIxqvrjeZ7FGjcXCCMDshgA9ep0MJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AZ6Oxb0Fl5ezb7BeaBXMnTvwu0moQJCl/vv3O08rK8QmDqO9q59NRca8v5trqSZTvZ
         hFaXB6Ft6UJn+WffNN++Xv0CIehBSMcGFvpHqNUUdafF6yf/p4FpIuqxrqJ7qQrR7dBi
         4BP6g2eBrWEKMJeXT9CJLrFw5A/U8rTIn3K1k=
Received: by 10.216.68.18 with SMTP id k18mr783188wed.109.1304783645066;
        Sat, 07 May 2011 08:54:05 -0700 (PDT)
Received: from localhost.localdomain (ADijon-259-1-88-55.w90-33.abo.wanadoo.fr [90.33.231.55])
        by mx.google.com with ESMTPS id t5sm2149539wes.9.2011.05.07.08.54.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173054>

The template can begin with a new line (to insert commit title) that
should not be cleaned up.

Signed-off-by: Boris Faure <billiob@gmail.com>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 67757e9..f0e880b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -708,7 +708,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (s->fp == NULL)
 		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
 
-	if (cleanup_mode != CLEANUP_NONE)
+	if (!template_file && cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, 0);
 
 	if (signoff) {
-- 
1.7.5.1
