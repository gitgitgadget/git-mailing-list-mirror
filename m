Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF13205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 18:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbdABSq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 13:46:59 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34891 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbdABSqP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 13:46:15 -0500
Received: by mail-pg0-f65.google.com with SMTP id i5so31114125pgh.2
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lIskrIQ/ycO892egjfAidv492aK/mm1rJrJYP9jnDVk=;
        b=RP1fCKfhADEd7aNcA9irAHDWzBbP37uSyyngFIXN5rylKBBtIZwrdSJQcOqU8LMpKt
         fSfHU9GsEfT5eRMNVvFo12m6dz2dEZlgs3QraF3+kcQlbrf9OAYpqOkPClP3qRs4t2iW
         q/WP2wu08+ntrlMjuXZPXtpKBcy3jems235gZwgAOdrn4xy+0xp4NyiZot0djJQmkXOA
         CPxnEy7g5akrofYaVxNc5axxitXZAgOZQbaJ7+maA8vGP6tImNfS+SavbY0umYDnEOuZ
         zIGwpYP4hhtHDIyOmiUJjioWnjRjdcfKSD1Ujv3Zu6YgxCESJhZiaXKmBGvCjOv1Re+5
         xOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lIskrIQ/ycO892egjfAidv492aK/mm1rJrJYP9jnDVk=;
        b=Bt3yA/XOV+lb+HiKjuOJbN8BVqVUclex6VuIm1bfbeVhhIo1U6inJcZ9cbKKiobue6
         JsyywvY5+rgmK1avWTYBRkx2u8drVIG0r0cPTMXbOTr3S9V5B5jEh86OmR5ekqb7SMOb
         XExMCiHstlHvdRvL91IiofNq7CsE9KWBbBnl/3q89YWw26GOyfU+AuzurRRkHOm/vfMh
         0V6z8Zf8YqhyOhvGXhPShrOcSa2EVNbsv3dqK0cDCmnh8OXZ20OU/Ph74VPr7Ivhahhk
         v7C0nb15NlCZk5hdCIGP429+8UtAX52gQNw1nEmDHsiBYCyJvu8BDGkNMA23jHpuHbHX
         Pg/A==
X-Gm-Message-State: AIkVDXJpqJMfjduFW7n6mVYzalrup14QdHquQDENKCjtvRS7TBVGUtuZpKXGb6bQYwYdJQ==
X-Received: by 10.84.209.172 with SMTP id y41mr119537160plh.96.1483382774513;
        Mon, 02 Jan 2017 10:46:14 -0800 (PST)
Received: from localhost.localdomain ([103.57.70.91])
        by smtp.gmail.com with ESMTPSA id y6sm135020535pge.16.2017.01.02.10.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jan 2017 10:46:14 -0800 (PST)
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, luke@diamond.org, j6t@kdbg.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 2/2] t9813: avoid using pipes
Date:   Tue,  3 Jan 2017 00:15:36 +0530
Message-Id: <20170102184536.10488-2-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170102184536.10488-1-pranit.bauva@gmail.com>
References: <20170102184536.10488-1-pranit.bauva@gmail.com>
In-Reply-To: <20161231114412.23439-1-pranit.bauva@gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t9813-git-p4-preserve-users.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 798bf2b67..9d7550ff3 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
 		make_change_by_user usernamefile3 Derek derek@example.com &&
 		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
-		git p4 commit |\
-		grep "git author derek@example.com does not match" &&
+		git p4 commit >actual 2>&1 &&
+		grep "git author derek@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
-		git p4 commit |\
-		grep "git author charlie@example.com does not match" &&
+		git p4 commit >actual 2>&1 &&
+		grep "git author charlie@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
 		git p4 commit >actual 2>&1 &&
-- 
2.11.0

