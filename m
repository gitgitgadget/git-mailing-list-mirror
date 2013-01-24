From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 2/3] mergetool--lib: Add diffuse as a tool
Date: Thu, 24 Jan 2013 11:16:07 +0400
Message-ID: <1359011768-7665-2-git-send-email-Alex.Crezoff@gmail.com>
References: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 08:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyH3r-0002nF-B6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 08:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab3AXHRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 02:17:02 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:53451 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab3AXHRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 02:17:00 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so4449031lba.9
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 23:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6ZbkAe250ZfjG5tFUYzmE/Vk8EbydduQwW7JuceKFyA=;
        b=VyzXh3jtLKQ4j/0qMYar6JdoTAY2LAKXPNy+B/s6cSWtoBQQm0DfDFg6icIJf4zXa0
         bi911JNyHGQevnwIXRopY0gMTcDl1/5eojYHDekCd3I2OFG6cZg5nWUUBWnLF4GUtSGq
         A3kug/mgCcN6lB1BgNp1LW6tuF3Skch3qDKTtsn0A0W7bAvGpUav+27XCSFm54/68UAr
         D/yVNwkVdMyseL9qB9eb772jOFbxJ/2oJpHVOgg/q4DVnjs2JKLPNvRoP1kaccmuY1Nw
         NwuXlBDcy12Pu6+VZj6Un4eSx+H+DY3aDuVqCdnPtDcNDs2oYNWHW+vg/HfgaATghiMe
         bl3w==
X-Received: by 10.112.28.133 with SMTP id b5mr370399lbh.79.1359011819492;
        Wed, 23 Jan 2013 23:16:59 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id gt13sm2377394lab.14.2013.01.23.23.16.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 23:16:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 1D9B260173;
	Thu, 24 Jan 2013 11:17:29 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214406>

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 git-gui/lib/mergetool.tcl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 4fc1cab..837ce17 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -194,6 +194,15 @@ proc merge_resolve_tool2 {} {
 			set cmdline [list "$merge_tool_path" "$LOCAL" "$REMOTE" -mergeoutput="$MERGED"]
 		}
 	}
+	diffuse {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" \
+				"$LOCAL" "$MERGED" "$REMOTE" "$BASE"]
+		} else {
+			set cmdline [list "$merge_tool_path" \
+				"$LOCAL" "$MERGED" "$REMOTE"]
+		}
+	}
 	ecmerge {
 		if {$base_stage ne {}} {
 			set cmdline [list "$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --default --mode=merge3 --to="$MERGED"]
-- 
1.8.1.1.10.g9255f3f
