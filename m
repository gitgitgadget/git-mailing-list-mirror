From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/3] git-sh-setup: move GIT_DIR initialization into a function
Date: Sat, 11 Oct 2014 01:39:36 -0700
Message-ID: <1413016778-94829-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 10:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcsDI-00089U-HH
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 10:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaJKIjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 04:39:40 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56694 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbaJKIjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 04:39:39 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so3060571pad.22
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0r9TrqWfzCVvgrNs2gWQIL02c3tygLN5wtoSsoNNll4=;
        b=DXvxADcXF9MxsDqfpACRuqWNJgdMXVRan1hOMedCdofET3XpqRq5exaL9hC9Iu7X6t
         pEwBRBJ0Tp3qikMQDfnOK+e8lMlGCU+jcU+vvrMgP8srcYEVwS/AAKiQFz9BhP4G9TmN
         ZrnVzcrNwFNiE6aguJOlMbMPzh57oHk0yZvfR9YD05haOX2vd3tinLg7QmML7m/Coc2w
         tPZl7gUkioDFIXZg5Ep0LfjTcnymV8rc4nl/EKK5YulizsYdIpXfNpETlgfq9l2CmD3d
         ejpVhe7we+TXAtKQV5u7U2omZWLrc5Ee35nVuvdKvugErK4aBuCckmCBTrimJC2zxVT9
         sXVg==
X-Received: by 10.70.61.229 with SMTP id t5mr133917pdr.148.1413016779008;
        Sat, 11 Oct 2014 01:39:39 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id gz1sm5558417pbb.8.2014.10.11.01.39.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 Oct 2014 01:39:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.378.g89c0b73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a new patch since the last round, prep for 2/3

 git-sh-setup.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9447980..d968760 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -330,8 +330,7 @@ esac
 
 # Make sure we are in a valid repository of a vintage we understand,
 # if we require to be in a git repository.
-if test -z "$NONGIT_OK"
-then
+git_dir_init () {
 	GIT_DIR=$(git rev-parse --git-dir) || exit
 	if [ -z "$SUBDIRECTORY_OK" ]
 	then
@@ -346,6 +345,11 @@ then
 		exit 1
 	}
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
+}
+
+if test -z "$NONGIT_OK"
+then
+	git_dir_init
 fi
 
 peel_committish () {
-- 
2.1.2.378.g89c0b73
