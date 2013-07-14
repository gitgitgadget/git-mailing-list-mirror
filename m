From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 4/4] diff.c: Do not initialize a variable, which gets reassigned anyway.
Date: Sun, 14 Jul 2013 23:35:49 +0200
Message-ID: <1373837749-14402-4-git-send-email-stefanbeller@googlemail.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 23:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTxa-0001VY-9v
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab3GNVf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:35:56 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:50117 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab3GNVfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:35:55 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so7220056eek.32
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0v3w+xedRXG/S27B8eZQvwJSJTALT8Sy4VGGgwLGIUE=;
        b=of1AmqPEkiIs7gCM9cMvJz4603FdvoMUOhwmpogHYv2QfLzsymzXsSrTigEck9jy94
         6I45aON0DBS2S2aWcc3vJoj+jhqEkeGwWELvuE5c3Lmz73EO674EDTccd2zM6g0fJcGi
         EV7g1ABWv13w83BNpAZ33+SyaWZgvlt9XpIZDjP3tJ/liO5oPGUWKFGnJOTdsy7oP668
         26jWIqufU5FiihWNzM5YI9d+5QbFCvw0UbAajb3BQ/UCJmC0XVMLcjSeJdkXq3pxOTF1
         IMdVEVqKwHtbFDY062KpR0I3Yvod3buL9Hn6Ai2UcVlJDGYK6dR690+R74nKt/xDBJ9q
         wfxg==
X-Received: by 10.14.183.135 with SMTP id q7mr54750687eem.97.1373837754151;
        Sun, 14 Jul 2013 14:35:54 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i2sm97578659eeu.4.2013.07.14.14.35.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:35:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.806.gdee5b9b
In-Reply-To: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230396>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e53ddad..24382d7 100644
--- a/diff.c
+++ b/diff.c
@@ -1677,21 +1677,19 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		/*
 		 * scale the add/delete
 		 */
 		add = added;
 		del = deleted;
 
 		if (graph_width <= max_change) {
-			int total = add + del;
-
-			total = scale_linear(add + del, graph_width, max_change);
+			int total = scale_linear(add + del, graph_width, max_change);
 			if (total < 2 && add && del)
 				/* width >= 2 due to the sanity check */
 				total = 2;
 			if (add < del) {
 				add = scale_linear(add, graph_width, max_change);
 				del = total - add;
 			} else {
 				del = scale_linear(del, graph_width, max_change);
 				add = total - del;
-- 
1.8.3.2.806.gdee5b9b
