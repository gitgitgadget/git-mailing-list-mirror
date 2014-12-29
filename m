From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] git-rebase documentation: explain the exit code of custom commands
Date: Mon, 29 Dec 2014 14:30:07 -0800
Message-ID: <1419892207-26687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 23:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5ipP-0003TD-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 23:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaL2WaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 17:30:11 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:60237 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaL2WaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 17:30:10 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so10817927iec.23
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JvlGH6hw/oy1fxfD8HSiqFzmv2xOjyj7y0/AILWZLSA=;
        b=gzN0b9848HPVsnI40xootL/iBU+7tS7I+n94qBZjkCKKheB8t5YE5twP1+W06N9rUj
         PWr4kwOE1pXx1OgStA9avkLh0hQ1gV48ezkQszkyCXi3wLB2MS7S0m88Iess3SYmiHNq
         Mdi/bHPJRHCKGdwsn/lbuQrUW//+DqWM/GbIolnQWI+lvtMq0my9MXC5HJV9f0c9qvTP
         L90YYkGcN4hmrzaPw2lLlDGDoI+6wNTj76mwXdoeBhXrwJfdTDuXxPcPOfrcqVWB+aUt
         6uGFVBxvpDivs92LEWmOGSxlao32xQSr0ol9WboYayGNz9SyGqQolMLoKZ2VdbkRcmI9
         1OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JvlGH6hw/oy1fxfD8HSiqFzmv2xOjyj7y0/AILWZLSA=;
        b=IwACYxhPfi0w0RA33VDF4RGR/8WpQXjfRzhcyyDioa/FhNZ1CZja9T1iaiggOcAHPV
         QogmB+1Zh7Vvz10jCn5i+hONVimZPhxHmP5J6TK4Lg3ympeUgrNh1a9hVHL+BHIw2NcY
         Kh8xIc6XnSaPzl1PuBgWCnrA4z61GGGLrMOfehZ/ufAMT21bvvM84vlx4xbs3ZLhctPe
         f/wzsFfzWpQik/GvfxH3yueRu0OMMMHVSXfnd9+mQxQaWYPgaxVNcjYCZqTKYjf67+MU
         mgfJdc37Cof4aZP2dAhkzaPJ4N0lX4zl2gAi+ztF3/xZT3od/bGaWm47vJX5fAun9t3v
         DQRg==
X-Gm-Message-State: ALoCoQlgGKu3wyJUMd81fnCRHj9tykBhiBA9+XipYPNn5Ew9SRZo3/ohuLsdEOWiMUP3RtR2nXXw
X-Received: by 10.107.38.76 with SMTP id m73mr47427461iom.40.1419892209929;
        Mon, 29 Dec 2014 14:30:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id b194sm18248729iob.38.2014.12.29.14.30.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 14:30:09 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261893>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 924827d..ffadb0b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -372,7 +372,8 @@ idea unless you know what you are doing (see BUGS below).
 --exec <cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
-	commands.
+	commands. Rebasing will stop for manual inspection if the command
+	returns a non zero exit code.
 +
 This option can only be used with the `--interactive` option
 (see INTERACTIVE MODE below).
-- 
2.2.1.62.g3f15098
