From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/2] mergetool: don't require a work tree for --tool-help
Date: Fri, 10 Oct 2014 01:51:43 -0700
Message-ID: <1412931104-74648-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:51:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcVvS-0006xL-MF
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 10:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaJJIvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 04:51:46 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59176 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaJJIvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 04:51:44 -0400
Received: by mail-pd0-f173.google.com with SMTP id g10so1291073pdj.4
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kfBx5AkUtTiMkKAZ4ri6NQrbUBhFPEyhaGzl7eKcoaE=;
        b=K4SEnwzmKtJxZ6wQvZtBfFdMwWOSAlK8DBCEW3ZzJYTwZY11ucdYokg5K8Blk/sKUv
         bIOXtKX1WTBrmNI0fr1mwwTnho4h0WyykOtkYJpg3VIHQPQaHYrEklX+wumwhLfWmNf2
         N08XQFaaV5HjxjVy8bY+y0+Bqw92bBi3iRnNVaz0998UsH17ZreaSgsw88MaZ6YjydBU
         a/FaYH/YW4ue4LFHdId4/5VQvhfRTc5lMclZ3dmc/IwIxGmP6vTFW1LaI+DmdPysuXGp
         /W5pppj81HAdefWRp6RYKH5Ti5gBB0B9UQkzX3LW9BEuu8+SxXAU9dmhYEKILlPck/S7
         4U7A==
X-Received: by 10.68.132.225 with SMTP id ox1mr3668088pbb.71.1412931104215;
        Fri, 10 Oct 2014 01:51:44 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id l6sm2754550pdr.39.2014.10.10.01.51.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 01:51:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.377.g0e18f12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:

NONGIT_OK=Yes was added to make it actually work outside of a git repo.

 git-mergetool.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 96a61ba..a502430 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -10,11 +10,11 @@
 
 USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
+NONGIT_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
 . git-sh-setup
 . git-mergetool--lib
-require_work_tree
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -378,6 +378,8 @@ prompt_after_failed_merge () {
 	done
 }
 
+require_work_tree
+
 if test -z "$merge_tool"
 then
 	# Check if a merge tool has been configured
-- 
2.1.2.377.g0e18f12
