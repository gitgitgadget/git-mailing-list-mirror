From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] rebase-i: print an abbreviated hash when stop for editing
Date: Mon, 28 Mar 2016 18:00:00 +0200
Message-ID: <1459180800-5744-1-git-send-email-ralf.thielow@gmail.com>
References: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 18:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akZaa-0002hV-2v
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 18:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbcC1QAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 12:00:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35807 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbcC1QAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 12:00:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so16275914wmn.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iUHCd0WK6QlBBWyrQybU+H6HKMLrsSRmh3N1nUJo0i0=;
        b=uS4FCbdhgD8J7LhtOT6OYs861q7U6rHdzIhSswXG5z3ZMFJYIqYbrEcuSWuS2x7IsA
         yg29v1W7LtUr1AwLX/N+ReUnhIYZIrC8EyO7tiDRELV7rYR6dG+iytTzsKh0ZjlEH400
         jEPGE/WaiBlcsgwvfzIJJj8r6XQmznPYZz+kV6GTf0Q0YLwMc+W3dTGGEY/wituX+Ws2
         F5jXcchasAd3YE7LOaSqk44YWJ9tpoNy2OKvNNxsvqImpdZAQ7NsfC0IhRlgcKaOZl13
         bKhLy4nnwNlRc6kW30OUDO5dM5PgcwRau3rDYQncuHMSmgr0eFDRscIBK81f3vH4chOq
         Pwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iUHCd0WK6QlBBWyrQybU+H6HKMLrsSRmh3N1nUJo0i0=;
        b=ME3pizVqXSPuotAgmN3i6iN7F1m6PD4ekDXtxGGxdcaeGXUZ82ZSu2j+1m67YMr916
         EfbstMmZXPw8SFobocK73TSGOVH50cmEVgLOWENK1Lr7RIjTDOk6XlF3YLTAafP4Bkrl
         tNZsrm3FNznCOEQZddMteraMm6JuvBd2PebiWHHLna+SjeruTX5/JX4RDCAppYQmII4A
         sFPgPUfLddkNXnl36uxtcGXlzFtvHNA0oaNnlupHsz1ZF42uQuEVriAMlzoincMJ8L80
         et0Lcc9vlFhE/NLb/obHt+9qM0TPXDWKgp6DC/ZdBjE362r89vEGSCOqypyWOK545EVJ
         nOBA==
X-Gm-Message-State: AD7BkJIFiT0rTn5LGQ1d3s0IrNkFfl5n+K5NR6Qdp01MHB15z6aX2H7ZCB9DhgBqWdL82g==
X-Received: by 10.28.14.77 with SMTP id 74mr11015451wmo.15.1459180817219;
        Mon, 28 Mar 2016 09:00:17 -0700 (PDT)
Received: from localhost (cable-86-56-20-25.cust.telecolumbus.net. [86.56.20.25])
        by smtp.gmail.com with ESMTPSA id v2sm10721627wmd.24.2016.03.28.09.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 09:00:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.285.gc3ac548
In-Reply-To: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290045>

The message that is shown when rebase-i stops for editing prints
the full hash of the commit where it stopped which makes the message
overflow to the next line on smaller terminal windows.  Print an
abbreviated hash instead.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4cde685..9ea3075 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -548,7 +548,8 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		warn "Stopped at $sha1... $rest"
+		sha1_abbrev=$(git rev-parse --short $sha1)
+		warn "Stopped at $sha1_abbrev... $rest"
 		exit_with_patch $sha1 0
 		;;
 	squash|s|fixup|f)
-- 
2.8.0.rc4.285.gc3ac548
