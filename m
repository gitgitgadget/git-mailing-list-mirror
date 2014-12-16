From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] receive-pack: refuse all commands if one fails in atomic mode
Date: Tue, 16 Dec 2014 11:14:40 -0800
Message-ID: <1418757280-32412-1-git-send-email-sbeller@google.com>
References: <1418755747-22506-6-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 16 20:14:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xaC-0004MO-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbaLPTOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:14:52 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:50600 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLPTOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:14:51 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so7594316igj.4
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5S3jUkTAxqyAQSGCwDM9N112gv33XFRq5zRkd70KYnk=;
        b=TRZzU92jyprzeDtM7oZRxwWvXjyaSml7LCI4rzgc4W2B0NjJ+UMMp4aUMGom5le4R+
         ZeJcACfWrGc5/aWqV7FtpIaWUj2fkZAxDYZCSdRTMF7xOVWSVem/EhTQ/zbn438gtq0Y
         RX0roAsyIwUgrh/aDt1CkmC/M2K0MpMHywqSnA21uf7Rh/BY4t9cao/UqTQsceBFfCOy
         BfjGgTIDizgSujwggYXh+0F1bl8saA39aFYvJnh4j08yCgL3LQzftqU2BvBBsbdGJMCO
         H7T7rmtzB1h3sc8+uS1YT2IN8Eh+8YAgYwCgBEgDXTaQX+VovdMT4+/m99s2K6kyeEV0
         zhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5S3jUkTAxqyAQSGCwDM9N112gv33XFRq5zRkd70KYnk=;
        b=dATl6Pr+y/n3tBE2UyVkyKYueeVeuPeeWREyFOO9fngIU3wRs11TXh+r+ALvXsGedv
         quVD/y6stIRLqohQYxZ57QwT2sHR8FwpIwLn6/DNlHXTK5OlhWTJAPPm0U44k9wOm4K0
         E9iwfRPjol3ZHBkIXA1FuCfsJ8JKImuUrsehnpIfAlbvseB6H49xnfLwwlYggvRZrrk4
         USUvA+8NgqUAdKuJYGs54h7ITdfWOrKzS+Vr40F6J6KeylE7bIFlHxbfL8Qr6V3JNaXc
         nTgNNrCg7GfCLmqeo+8ITKMOtPc3IAvfa6Z1FvgrAx9jeGSdGZGS8j1SKyF+ZbUNLGAi
         QKIQ==
X-Gm-Message-State: ALoCoQlIEyveGiN1/RVpOMwvFqYaxTcEahxZ9WCrfbt+Sqm48IfcsdmwXjcakzo5IvBlj44lbTv4
X-Received: by 10.107.137.92 with SMTP id l89mr35354608iod.22.1418757290959;
        Tue, 16 Dec 2014 11:14:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4db1:657a:aafa:5d88])
        by mx.google.com with ESMTPSA id gd1sm3205576igd.8.2014.12.16.11.14.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 11:14:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418755747-22506-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261453>

This patch will be incorporated into the right places in v3 of the series.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    I don't want to resend the patch series today to accumulate comments,
    but this makes the last test pass, which is the whole point of the series.
    
    I'll put it into the right places in a reroll.

 builtin/receive-pack.c | 13 ++++++++++++-
 t/t5543-atomic-push.sh |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0803fd2..3477f7c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1122,7 +1122,18 @@ static void execute_commands(struct command *commands,
 	}
 
 	if (use_atomic) {
-		if (ref_transaction_commit(transaction, &err)) {
+		/* update(...) may abort early (i.e. because the hook refused to
+		 * update that ref), which then doesn't even record a transaction
+		 * regarding that ref. Make sure all commands are without error
+		 * and then commit atomically. */
+		for (cmd = commands; cmd; cmd = cmd->next)
+			if (cmd->error_string)
+				break;
+		if (cmd) {
+			for (cmd = commands; cmd; cmd = cmd->next)
+				if (!cmd->error_string)
+					cmd->error_string = "atomic push failure";
+		} else if (ref_transaction_commit(transaction, &err)) {
 			rp_error("%s", err.buf);
 			for (cmd = commands; cmd; cmd = cmd->next)
 				cmd->error_string = err.buf;
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 6354fc0..f0e54d9 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -142,7 +142,7 @@ test_expect_success 'atomic push fails if one tag fails remotely' '
 	test_ref_upstream second $(git -C workbench rev-parse --verify HEAD@{1})
 '
 
-test_expect_failure 'atomic push obeys update hook preventing a branch to be pushed' '
+test_expect_success 'atomic push obeys update hook preventing a branch to be pushed' '
 	mk_repo_pair &&
 	(
 		cd workbench &&
-- 
2.2.0.31.gad78000.dirty
