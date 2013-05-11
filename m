From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Sat, 11 May 2013 21:55:12 +0530
Message-ID: <1368289513-8700-2-git-send-email-artagnon@gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 18:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCbN-0001SU-Df
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab3EKQYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:24:44 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:36484 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3EKQYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:24:43 -0400
Received: by mail-da0-f45.google.com with SMTP id w3so2805522dad.32
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xEmB3rVCopr1h4B+0whCkDuRnA8K1G7NvX6oz/KUq9U=;
        b=rwULh3qqUHqTlq1H0WZ72nZJ+m24dkIKNak3yqDJRkPc36XMB1a2O4qCubPA9I1ERO
         4LoqvRCcbXO2pvrvlACO/m0yAqEUD/M+LYD87NvNkAfeYFtrQYAFH09Z98hL5aAY5HI8
         wgcJQLeMBvHM5GP2YdFIr+VECbT1+pgcOptOpJRcHy4k7JX00s1VT+Td+Xg9zJfEYMha
         Z/ylmtAdeurZHwq8URt2hXUCCW4ywx473VBFOKBSyFoxSECNPWZGwYffAG3LOR+GBSJw
         oah+mKQqoUCjL7vzJtoMZ5SyMsT3pja/IuYMwNkrI5Zs2VkSPdZKONoCihJFUlXkgw2A
         WDWA==
X-Received: by 10.66.26.143 with SMTP id l15mr22450258pag.207.1368289482784;
        Sat, 11 May 2013 09:24:42 -0700 (PDT)
Received: from localhost.localdomain ([122.164.109.165])
        by mx.google.com with ESMTPSA id fn2sm7096965pbc.15.2013.05.11.09.24.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:24:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.g4537cf1
In-Reply-To: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223993>

Nobody has branch names that end with + or *.  Then why put a space
after the branch name and before [*|+][=|<|>] in the prompt string?

Before this, your prompt might have looked like:

    artagnon|master *=:~/src/git$

Now, it will look like:

    artagnon|master*=:~/src/git$

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..08c9b22 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -383,9 +383,6 @@ __git_ps1 ()
 				# is necessary to prevent wrapping issues!
 				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
 
-				if [ -n "$w$i$s$u$r$p" ]; then
-					gitstring="$gitstring "
-				fi
 				if [ "$w" = "*" ]; then
 					gitstring="$gitstring\[$bad_color\]$w"
 				fi
@@ -400,13 +397,13 @@ __git_ps1 ()
 				fi
 				gitstring="$gitstring\[$c_clear\]$r$p"
 			else
-				gitstring="$c${b##refs/heads/}${f:+ $f}$r$p"
+				gitstring="$c${b##refs/heads/}${f:+$f}$r$p"
 			fi
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
 		else
 			# NO color option unless in PROMPT_COMMAND mode
-			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"
+			printf -- "$printf_format" "$c${b##refs/heads/}${f:+$f}$r$p"
 		fi
 	fi
 }
-- 
1.8.3.rc1.52.g4537cf1
