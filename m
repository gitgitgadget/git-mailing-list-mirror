From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/4] mergetool--lib: Improve the help text in guess_merge_tool()
Date: Sun, 27 Jan 2013 16:52:24 -0800
Message-ID: <1359334346-5879-3-git-send-email-davvid@gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzcyF-00013K-Db
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab3A1Awk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:52:40 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:49869 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab3A1Awe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:52:34 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so148609ieb.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BMY4DSMwWxCd9ME1NvESrB6A2qznjGJDdYdF1JbHh6o=;
        b=l87XgOxQvEoqRAHTndDkuzN2GHMxe67+Yp+fcETIx1WsOLKU3nvP/GJ03FQ8yDW13A
         iwv78QPTS78gv6muiaueih9qBLEeSp0j+46hWfDFJ7jsZfWzvMiTS/1Er0sfxRSvRqpu
         tXZJjy3T+M2F4A/By7/eBXW0aX2BZVKJieNp1RsqTzpHuQEMjv4ESoYc5MfNe2kQWvwA
         tOZ3JzmO5znvjVu0mL6XNjxmLpu/ORjYAqO+fBGnZtnxfiYVFPko+3VPXgXKMOFR37qy
         2F+Y219YhufYxlG0GoLLB7lB672E3VLt+1qb/2zewpUrvOL1JF1O9AvxnQH71qNsQiIJ
         OiGA==
X-Received: by 10.50.170.36 with SMTP id aj4mr3895294igc.92.1359334354373;
        Sun, 27 Jan 2013 16:52:34 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ke8sm1868421igc.17.2013.01.27.16.52.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 16:52:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.g3ff16bb
In-Reply-To: <1359334346-5879-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214761>

This code path is only activated when the user does not have a valid
configured tool.  Add a message to guide new users towards configuring a
default tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This now uses a cat << here-doc.

 git-mergetool--lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9a5aae9..db3eb58 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -240,8 +240,13 @@ show_tool_help () {
 
 guess_merge_tool () {
 	list_merge_tool_candidates
-	echo >&2 "merge tool candidates: $tools"
+	cat >&2 <<-EOF
 
+This message is displayed because '$TOOL_MODE.tool' is not configured.
+See 'git ${TOOL_MODE}tool --tool-help' or 'git help config' for more details.
+'git ${TOOL_MODE}tool' will now attempt to use one of the following tools:
+$tools
+EOF
 	# Loop over each candidate and stop when a valid merge tool is found.
 	for i in $tools
 	do
-- 
1.8.0.13.g3ff16bb
