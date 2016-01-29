From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] stripspace: Call U+0020 a "space" instead of a "blank"
Date: Thu, 28 Jan 2016 20:10:56 -0700
Message-ID: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: tklauser@distanz.ch, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 04:11:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOzSp-0001a0-6u
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbcA2DLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:11:07 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33475 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcA2DLF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:11:05 -0500
Received: by mail-ob0-f172.google.com with SMTP id is5so52926454obc.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 19:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=17K4d6tisPvsCVUURr47s+94OJfBrE20wezeY1MJG4g=;
        b=eCCa2JZx1mXfhYdsZDa9HFeLs7iB7v58kAaE8BBOXEQekBKYNio6fDj3rznLbKP0Z3
         Gv1dMXx7zLrq1pKGNx87mJS08YmBqMBwnQDwXEhvrRVkt8ZwSyOhZmbdnA5HrU/CEfgX
         jgWR8VXdaI7Zf8BtLDiG08197LtrAxZHa+IqXMcvnrHs4pTW0wrk+xskPfwMKidVx0rB
         R5vQx/V9fzI5kzY5fPkCxB2QjXsv9obakYTEhwuq1ld52nduMNSvZyVb8tyII8SUVTjy
         rZivv+VWy3JlckbGi0fcTX+ZOC2MBgllvkr3UACole0f484zJWBzS6FVh6McheiHxxQc
         rP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=17K4d6tisPvsCVUURr47s+94OJfBrE20wezeY1MJG4g=;
        b=jI4Y2p+LLSWhWu82JPcEJUl51R4pQ7SY5odNxLNLdMUOTrrSrR8i/zMXyFo2upb4H1
         NldPjwzntOmtq7HJHyiVaMSAsZ2/NsItpnrnJDHE/ApW48YZq12PdSaBXtc+agvdL316
         dOwp1DUMuw+KgZHAiw7yf8hwtJT5puoLzJz9kQ24TGO0gvWUoNTZlx3izHAKd2/h9JLv
         nAzi0Olmz3dgy2WQzqwRiVAbyyYfWWc8L0GVsASWxoIRJYmQVMD7fTTCgeiL27yavjUa
         QwNDXqm2P7JS9ioNivbCdwivg63dQQKu9oCpenFG5g5a+/k+odAPAY6HFrZL5qRmQdAj
         gUiA==
X-Gm-Message-State: AG10YOQ0CiN9eRBmSuiOpdxe+MSGPJSOlknQ9Z8bFRYth3eWtDE0GDe6/9UGCDiQY+QLHA==
X-Received: by 10.60.178.70 with SMTP id cw6mr4925305oec.46.1454037065277;
        Thu, 28 Jan 2016 19:11:05 -0800 (PST)
Received: from alex-wolverine.localdomain ([50.141.67.5])
        by smtp.gmail.com with ESMTPSA id rh8sm7038881oeb.14.2016.01.28.19.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 19:11:04 -0800 (PST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285057>

I couldn't find any other examples of people referring to this character
as a "blank".

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/stripspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7ff8434..15e716e 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -35,7 +35,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 			    N_("skip and remove all lines starting with comment character"),
 			    STRIP_COMMENTS),
 		OPT_CMDMODE('c', "comment-lines", &mode,
-			    N_("prepend comment character and blank to each line"),
+			    N_("prepend comment character and space to each line"),
 			    COMMENT_LINES),
 		OPT_END()
 	};
-- 
2.7.0
