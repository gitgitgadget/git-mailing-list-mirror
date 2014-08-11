From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] mailsplit.c: remove dead code
Date: Mon, 11 Aug 2014 23:11:21 +0200
Message-ID: <1407791481-17410-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 23:11:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGwsL-0004NK-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 23:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbaHKVLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 17:11:25 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:34348 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbaHKVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 17:11:25 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so9217481wev.12
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KTRINuvyozTYAfrjtUz+aMgItgZCRL+NIawe9TrpjuQ=;
        b=lfUS2aeBiDmSd4+qZLo8HQ4XQsaZj/WpmOR/zUuPaMC78yXdKzARSR5tE3AkkIymp9
         49nXX75yoRpHvbMqzQ3XovIhWMg1QqfofF5tQeD9Jhw/PIkaWwM8dAjb/QATF7yUx90Z
         lcwGKc+V5acsXzbzF+CaIsB1/07qQuvb3JFZdyyp8aPh9Z5bHzEkpORdfJxT/R4GQ7zF
         d9QmCAPYkK5JsMH1ZKb80JWcHrHYnscLLjD66w6YxgykD6FqYD6chJxZCIpMiwCfSxv3
         24KrTF6i+l9tP12wJSz4RHqdYzwWYtGPVkYQJSBbOK+tsOVkaoRVM6tzRfVRdrLt3kjx
         au+A==
X-Received: by 10.194.95.66 with SMTP id di2mr333161wjb.47.1407791483884;
        Mon, 11 Aug 2014 14:11:23 -0700 (PDT)
Received: from localhost (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id fr4sm48051227wic.16.2014.08.11.14.11.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 14:11:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255140>

This was found by coverity. (Id: 290001)

the variable 'output' is only assigned to a value inequal to NUL,
after all gotos to the corrupt label.
Therefore we can conclude the two removed lines are actually dead code.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 builtin/mailsplit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 06296d4..b499014 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -93,8 +93,6 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	return status;
 
  corrupt:
-	if (output)
-		fclose(output);
 	unlink(name);
 	fprintf(stderr, "corrupt mailbox\n");
 	exit(1);
-- 
2.1.0.rc2
