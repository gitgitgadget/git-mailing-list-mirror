From: larsxschneider@gmail.com
Subject: [PATCH v2 2/4] Add prereq to detect OS X
Date: Sun,  4 Oct 2015 11:06:15 -0700
Message-ID: <1443981977-64604-3-git-send-email-larsxschneider@gmail.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 04 20:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZingA-0000bK-0B
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbJDSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:06:29 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38498 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbJDSG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:06:27 -0400
Received: by wiclk2 with SMTP id lk2so87098697wic.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYCDlgkW02ISQ6Z4mlLP6meGBuHdTHjkkOzJWV8bqkU=;
        b=XxKWT4gUnmv4OdsHoLIafx5MUAQbQaGrc2SPvpVQFmCOsDTFCT+PtdznQgOmkYQkSs
         s59hGlIxRZxNLMbUZeM6Aia6IsT/4R1czMCmk2eo+WcXvzoInwIS9Wa8wJX2nJkK+zWs
         2EwYupp7HGYzK7nkKCzJQK9WnrL09wqHoETG2kDpPrpm8aR3yBaKMT3u/c0m4s8IGmNc
         FjQ0EiDFa9QSX0PSuZryY+fKygk8H05k+sGNUXqqy/3pILqYVQBPtbovkS0w3nodzFPQ
         fZO13AD2smJuGPGJds4GlVUujlXfTXVJZ9T51SOlE2rFfr/mksd/KMXKMFLdmh9G5aRD
         dYYw==
X-Received: by 10.180.105.135 with SMTP id gm7mr7053329wib.18.1443981985650;
        Sun, 04 Oct 2015 11:06:25 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsk-nat-ip3.autodesk.com. [132.188.71.3])
        by smtp.gmail.com with ESMTPSA id o3sm10378607wif.22.2015.10.04.11.06.24
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Oct 2015 11:06:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279012>

From: Lars Schneider <larsxschneider@gmail.com>

Some Unix tools differ between Linux and Mac OS X. Add this prereq to
detect OS X and handle it appropriately.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/test-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 16c4d7b..726af40 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -913,7 +913,7 @@ yes () {
 	done
 }
 
-# Fix some commands on Windows
+# Fix some commands on Windows and OS X
 case $(uname -s) in
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
@@ -946,6 +946,9 @@ case $(uname -s) in
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	;;
+*Darwin*)
+	test_set_prereq DARWIN
+	;;
 *)
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
-- 
2.5.1
