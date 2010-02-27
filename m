From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH] Makefile: fix compilation of test programs under MinGW environment
Date: Sat, 27 Feb 2010 21:09:29 +0000
Message-ID: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 22:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTv1-0002TL-2c
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881Ab0B0VJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:09:42 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40126 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030875Ab0B0VJm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:09:42 -0500
Received: by bwz1 with SMTP id 1so418976bwz.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 13:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OzCamLUSkbKryhnGrtVfbxeCy63jSW4YxLuA7/5T1ac=;
        b=i+HlxXDkp3XzOji+D3cUQgs/ucstoFEoE2URa84ZYAC1DMip9zHN0mTAt21S0wx/AI
         cX4J71wYfdkGB+SV+irHfihOnWWXaCzIYJgI9KfufRgjT+E5oouHcIc+gPKzfscSVal8
         cGDuOqGdfOCmOJ7pUUxTjITokav5eXP1068wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JcRZ0orw0vtutjy/CWvms7DL4lafej9HVBVDsHhqkm+DdHjev23kNITOPKeDOB19IA
         9hfD6vL3w4dj6Wqvv+fO4H4jw6Lc2WlpAATlezvEP00WAVVosu0uhJRYbaKVACrx/wkN
         sLrSYyUgl111yYaA5ZwhITB3AEk0XBPMxdk9A=
Received: by 10.204.5.91 with SMTP id 27mr1612944bku.14.1267304979743;
        Sat, 27 Feb 2010 13:09:39 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 15sm954279bwz.4.2010.02.27.13.09.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 13:09:39 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1556.g5a328
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141226>

Commit 225f78c8 (Merge branch 'master' of git://repo.or.cz/alt-git
into jn/autodep, 2010-01-26) changed Makefile in such a way that
the following error occurs when trying to compile Git under MinGW environment:

  make: *** No rule to make target `test-chmtime', needed by `all'.  Stop.

Under Linux it seems there's no difference between two variants.

This patch applies on top of branch 'next' of git.git repository.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b6f097e..498e5e7 100644
--- a/Makefile
+++ b/Makefile
@@ -393,7 +393,7 @@ TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-index-version
 
-TEST_PROGRAMS := $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
-- 
1.7.0.1556.g5a328
