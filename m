From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Thu, 21 Feb 2013 15:32:52 -0800
Message-ID: <1361489572-25403-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:33:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fdh-0002Vk-9c
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3BUXc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:32:57 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35967 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3BUXc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:32:56 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so106490pad.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=M9/3NXZRZcnz/zpzy2lmTklFOPtwvzaag4OZOV2vEec=;
        b=K8ud4fErCFckm9daSypQWp6wXYH1wxxrzgZA2HG/0ExIfUs0HJuPzk4q7B+4KUnAHS
         yo5YH/N5N35+wg5jYU0zIdJgHIAp5CYk9GLzUCBYgE3XYe8YcjowHAPwO+2mr75uEMHW
         vmT6GCPsIzYjsQHLRG7fnw6A70ms8knJAFpztsqZJ9p6HhJvUj8n2hSFhMC6280i0IHY
         yJY9BzdPACg0FQJISJfJFjWlWHTzUv1Ghcu1rROl9nuQlXJMp2V5gf3kAEmoXcWXXgB8
         rKpq7NvEwtw5oJk9meAPn9L7vqcejp7sHGmBLPSwdr4OPiFAXhu3vmj/dU/ipg1jxYA0
         7Ypg==
X-Received: by 10.68.241.102 with SMTP id wh6mr17244489pbc.150.1361489576506;
        Thu, 21 Feb 2013 15:32:56 -0800 (PST)
Received: from lustrous.local.fas.fa.disney.com (i.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPS id w2sm597765pax.22.2013.02.21.15.32.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Feb 2013 15:32:55 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216809>

073678b8e6324a155fa99f40eee0637941a70a34 reworked the
mergetools/ directory so that every file corresponds to a
difftool-supported tool.  When this happened the "defaults"
file went away as it was no longer needed by mergetool--lib.

t7800 tests that configured commands can override builtins,
but this test was not adjusted when the "defaults" file was
removed because the test continued to pass.

Adjust the test to use the everlasting "vimdiff" tool name
instead of "defaults" so that it correctly tests against a tool
that is known by mergetool--lib.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Replacement patch to fix my botched rebase.

 t/t7800-difftool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index fb00273..3aab6e1 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -60,9 +60,9 @@ test_expect_success PERL 'custom commands' '
 '
 
 test_expect_success PERL 'custom tool commands override built-ins' '
-	test_config difftool.defaults.cmd "cat \"\$REMOTE\"" &&
+	test_config difftool.vimdiff.cmd "cat \"\$REMOTE\"" &&
 	echo master >expect &&
-	git difftool --tool defaults --no-prompt branch >actual &&
+	git difftool --tool vimdiff --no-prompt branch >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.2.rc0.20.gf548dd7
