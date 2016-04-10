From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/6] Remove duplicate code
Date: Sat,  9 Apr 2016 23:13:35 -0700
Message-ID: <1460268820-8308-2-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dI-00049x-RO
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbcDJGNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:52 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34614 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbcDJGNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:50 -0400
Received: by mail-pa0-f67.google.com with SMTP id hb4so11993760pac.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NUnISwB4KyQmFtDEy3xhdbeGSM0BO+ZCY0hbb4APp3M=;
        b=q09Q0e5HJub6jsotdJMcH6nmSciJXQ7lOWm1w4/6V1NY9bcDw51cJiRrqkM54q50fr
         O2IflhQKHlD93VBlI//8fb5Ubtto5BQej+zcvmL9T/u5nd1aoCpssH430aUGw4KsWMUN
         rhziVY95DA6iE2vV4wI6UH/bLwtnyPGRxSjKmt90zvnM0i+XYjj0sjeWMDblAaB1PJrb
         2Rh4QSTgmQG3tmHyUCL83y4IpTWn/qFyyROVj+YrEgdo9eeohcRMe7RRpuMIu1+lgc48
         Q2xsQy37lhZdCF/ErnQSOwysdRppZYJgXWNXG6i+4LdTFsyfLwRHEeRrqrKyGIemYNhK
         LxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NUnISwB4KyQmFtDEy3xhdbeGSM0BO+ZCY0hbb4APp3M=;
        b=c2XtUZFDV2oxlEjQ2Nk8e9Rv6Kgdpm+7ZU95e7eMMPAE+tpb6o0O/GjMwSqlN6xZmB
         qdo0+ZQkEAfkIdBrDDurcvQg6nL8a3Bmf/MroDFSpZaXwHnK5zE0Sss9Drqvm7Wc6ZLN
         qPNoOBmx3hZCUKt5MzyF0ey9aeO3qydtJqPNMKyfKXaIuR6Q2uHCPExdCqVJmMIqEBqB
         o4oJxroaU224gQt66hdN4WcJ5MgnFnYpd82HmQ4dJzj8PT0/7b7PJMxgHowVoitEObFf
         Q6yThCWjROohA9AxABbPBXPKUoVaNmn58EYFPdE5/Od+6nw/dk9tj4iEattDSAWhAD/3
         7XVQ==
X-Gm-Message-State: AD7BkJJbqA7ld+SdsLY4tMMFT7ESdEUHWjU5lxnSNW6F7ODj9+YBPcZVTTGIflzJSu7nvQ==
X-Received: by 10.67.1.65 with SMTP id be1mr24136087pad.46.1460268829833;
        Sat, 09 Apr 2016 23:13:49 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291140>

In commit 51931bf (merge-recursive: Improve handling of rename target vs.
directory addition, 2011-08-11) I apparently added two lines of code that
were immediately duplicated a few lines later.  No idea why, other than
it seems pretty clear this was a mistake: there is no need to remove the
same file twice; removing it once is sufficient...especially since the
intervening line was working with a different file entirely.

Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae5..d4292de 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1773,8 +1773,6 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			if (o->call_depth)
-				remove_file_from_cache(path);
 			update_file(o, 0, sha, mode, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
-- 
2.8.0.21.g229f62a
