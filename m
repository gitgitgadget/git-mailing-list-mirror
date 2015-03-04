From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] rebase-interactive: re-word "item count" comment
Date: Wed,  4 Mar 2015 02:53:05 -0500
Message-ID: <1425455585-30186-2-git-send-email-sunshine@sunshineco.com>
References: <1425455585-30186-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Onno Kortmann <onno@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 08:53:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT47i-0007et-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933743AbbCDHxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:53:38 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33917 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933314AbbCDHxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:53:30 -0500
Received: by igal13 with SMTP id l13so31804345iga.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QNQA/KRJF52M7+9DT5qZ2o7IWeOihPnEcsbbuxRTZr8=;
        b=oJPWhOM2KKUIRU//PjG4QgGkeLIREb8su9Bz8DIEPe9MCdQ6kMrSqHMEGVe3BY7oQC
         O9oAzYEBM4tj0FAfIzRdXEeiLD0qi9zeNKrPn0XkxTAzvR6ztMxD2MY6tFgLmAHTGH/F
         xm/5/vxr6Tia2uKPAKMKowxXPwDk4Lnd54qB2G85DNfZSn/3JZt1ra3kxrAcvLLnPwPV
         lY2IlQhviiog+VhdJEYE7BOtlcYGSl4iF+cipboR7oIqeS2tugHH249sBvBwMLINUEk1
         O5J0csuQfwlOXV26r//GSb2mpfPXzx5yZvXf2lNRJ6CwOK87hA+hvHpKMvo7w/LpQMxo
         +q9A==
X-Received: by 10.50.111.10 with SMTP id ie10mr34917791igb.15.1425455609561;
        Tue, 03 Mar 2015 23:53:29 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id n12sm2488999igi.3.2015.03.03.23.53.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 23:53:29 -0800 (PST)
X-Mailer: git-send-email 2.3.1.340.gf490742
In-Reply-To: <1425455585-30186-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264731>

97f05f43 (Show number of TODO items for interactive rebase, 2014-12-10)
taught rebase-interactive to display an item count in the instruction
list comments:

    # Rebase 46640c6..5568fd5 onto 46640c6 (4 TODO item(s))
    #
    # Commands:
    # p, pick = use commit
    # ...

However, with the exception of the --edit-todo option, "TODO" is a
one-off term, never presented to the user by rebase-interactive in
any other context. The item count is in fact the number of commands
("pick", "edit", etc.) remaining on the instruction sheet, and the
comment immediately following it talks about "Commands". Consequently,
replace "(# TODO item(s))" with the more accurate and meaningful
"(# command(s))".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Junio suggested[1] the wording "# todo items" in place of "# commits"
from the original submission, however, I find "(# TODO items)" quite
clunky to read. "(# commands)" feels more natural and streamlined, but
is also a case of bike-shedding and personal preference, so this patch
could easily be dropped.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/259365/focus=261143

 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ab98b13..f7deeb0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1034,7 +1034,7 @@ todocount=${todocount##* }
 
 cat >>"$todo" <<EOF
 
-$comment_char Rebase $shortrevisions onto $shortonto ($todocount TODO item(s))
+$comment_char Rebase $shortrevisions onto $shortonto ($todocount command(s))
 EOF
 append_todo_help
 git stripspace --comment-lines >>"$todo" <<\EOF
-- 
2.3.1.340.gf490742
