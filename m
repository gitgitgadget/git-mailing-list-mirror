From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Wed, 20 Feb 2013 20:03:48 -0800
Message-ID: <1361419428-22410-4-git-send-email-davvid@gmail.com>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
 <1361419428-22410-2-git-send-email-davvid@gmail.com>
 <1361419428-22410-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 05:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8NOd-0000du-DH
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 05:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3BUEEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 23:04:06 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:55797 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3BUEEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 23:04:04 -0500
Received: by mail-da0-f48.google.com with SMTP id w4so379804dam.35
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Gqi4P/Dq0qfdjvMqZA9+6ioe4AZRVDrGIbb1n3MqC2A=;
        b=uFM9XgFgURx4OKHWV+yZmmx7UQn1SsTmOFsdS2M+rktVcCJkqjyOfhCx92mEaC++za
         PhDDM+Mr1QIgCJMcQZqru1PSx1vSqNFIm5YOMNr5HcoMfur4Nv9s9Mj5AcjcvfRRACTj
         1ZZ3Q6682zxiNIvV+iZxnrvS7FzLtAchBCEpiOpyC05Ayix4QFMTN+17XlUA34JtsuJq
         oSWz0tND2HJP4jx6nsI0jYRftt7CD7n8BrCitCe1JW3FCLri6F34SSwNtuwBxMW2ZNMf
         MDja9X+d8Qkj5dxVhUBAj5WmbwG+xTOXegainYgCXBB+Qu83gJDRkto2rN+5bAVLMb+r
         XZBg==
X-Received: by 10.68.136.99 with SMTP id pz3mr6078338pbb.205.1361419443840;
        Wed, 20 Feb 2013 20:04:03 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id qp13sm23808911pbb.3.2013.02.20.20.04.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 20:04:03 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
In-Reply-To: <1361419428-22410-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216749>

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
Rebased against PATCH v3 3/4.

 t/t7800-difftool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index fb00273..21fbba9 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -60,9 +60,9 @@ test_expect_success PERL 'custom commands' '
 '
 
 test_expect_success PERL 'custom tool commands override built-ins' '
-	test_config difftool.defaults.cmd "cat \"\$REMOTE\"" &&
+	test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
 	echo master >expect &&
-	git difftool --tool defaults --no-prompt branch >actual &&
+	git difftool --tool vimdiff --no-prompt branch >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.2.rc0.20.gf548dd7
