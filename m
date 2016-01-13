From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] Makefile: describe XMALLOC_POISON
Date: Wed, 13 Jan 2016 17:57:35 +0600
Message-ID: <1452686255-8757-1-git-send-email-kuleshovmail@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:01:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJK70-00014e-HE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbcAMMBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:01:04 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36266 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbcAMMBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:01:03 -0500
Received: by mail-lb0-f180.google.com with SMTP id oh2so289800771lbb.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 04:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Xj+T79JWqKxLvqQf0foZfnx3hcoU4oSOKFVId/h+aRo=;
        b=fMWz5C9Bu8ge+KCQChiZLK7PR/EyLnwx3ZQWrvS/TmD+69dypkOyWlFB1cWDTAjhWg
         s88V97qoSlHXJSnay1ZGysWkLkWH7TgjWnkmSFJuBg35kjlB6USnlLEt9/iey6NF+3co
         /LC1mNec4CfVEXXUQNFb+xu9rzqTC5cBMDwWCUICOBjrjdzAydgWDK2g3/20fQ2zqspK
         StMo9HWbSlsElwHHv4h+TmJJvfqiknRG7fRZEOswTCltcsAEG47Ca+32dw0RT4abLQw6
         1tHO+6vrAGlCCaeC6V4XrERyK2tBVepeUo6zp7YBPTPXSZoUiPQ7YwHcT4Smx3ivwhRt
         RmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xj+T79JWqKxLvqQf0foZfnx3hcoU4oSOKFVId/h+aRo=;
        b=b+IhXSZhHm+mde0hoi0WpmTbobiYCcyN9nRCb7rol0flFTyakqA8zgI5EF3XKOjHKH
         ItTIn1qtY6eKa95aWZObUWwrx55hSX12vur7FJaW9zM9guOErxbxXbb3VpJtUbdVQr9Q
         APu9UDCp/rlVrN5NyqNCjLbX0CwwTY4HavdESvIFDoSHe3p+7L5YfqfpLHylw/R9Gxyb
         F2c7XnLA2JFLC53Dx5+xiDCgcA6kjPeXyZ/ODkhRm6SR6IpA9xxCLHpyq/ikaqa58CFp
         g1Il+PCqGlmrSUOfPLY38t/9pInlPIyKuUibPRwBCIbpCDjayd5d6XXEpFphsGKFQs1W
         hS+g==
X-Gm-Message-State: ALoCoQmvsIXmwsps3PaFwohGNEKO1vDe0QM41iOn7oQUBc7Fgwn1+kJzE2t3QPuqqZsibjZyw/yhnMhpaNr2Rl4rP962ytps/w==
X-Received: by 10.112.147.1 with SMTP id tg1mr200075lbb.119.1452686459635;
        Wed, 13 Jan 2016 04:00:59 -0800 (PST)
Received: from localhost.localhost ([2.133.27.66])
        by smtp.gmail.com with ESMTPSA id k189sm138069lfd.12.2016.01.13.04.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 04:00:58 -0800 (PST)
X-Mailer: git-send-email 2.7.0.302.g68e1027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283901>

The do_xmalloc() functions may fill an allocated buffer with the
known value (0xA5) for debugging if we will pass the XMALLOC_POISON
option during build.

This patch adds description of this option to the Makefile.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f3325de..673c244 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,10 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define XMALLOC_POISON if you are debugging the xmalloc(). In a XMALLOC_POISON
+# build, each allocated buffer by the xmalloc() will be in known state. After
+# memory allocation, a buffer will be filled with '0xA5' values.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
-- 
2.7.0.25.gfc10eb5.dirty
