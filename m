Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC451FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758956AbdACT5h (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:57:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36510 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbdACT5g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:57:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id n5so34476272pgh.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CqD1Z9gnojEjHYIgrXANlfL0QUKKWINCne7ZBM/G5cc=;
        b=uAPJUgkfj1Km5MvRQB+2ZBdG31rG1oXUxAY/Ta8kuIVBRV5B7XibVtp7LqRTt8IbK+
         eBVhr8UIOIQDzFN+ICqWSolsIFpGUB9ga0d8zzjqBVjnfON/jk+otJeHBiLMrZfOgM8+
         QhM565VxuGxIUqcROUK+/NGJOixH+4v4ZseK4CrE57LnQnde1H/2wR/U+jhNMd0ONuBi
         eyHrtAgaE/zKvEY/WJ36AKFYfCCcTZo1/Uhw3uBTaw5SsY/msiibilD6Tz4toAz8A/KM
         mm6OHRdNix1eHJyldknlskJJIp2SyBINDfRG5caa/37bEbyNrIZDmNu5++5fKqk7y1K7
         GwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CqD1Z9gnojEjHYIgrXANlfL0QUKKWINCne7ZBM/G5cc=;
        b=osQUo6tWXfNgrv1U2Qb+2MkYAYetTcoPzkrE2W4xyl7M1hVHpNqZrqXXT8wakOYmyN
         38AaeA6vqIUiDE6oWaZjn5gMVcNxAfHApxHsnHkCxcdh+H71AFMC/yvE3WyBJ6CK2iYy
         Y0Qxw5HRWHY0JgatV16mbC9Ee5FyzqwxkP/Ep9QijpbJQpiwNZ2A3q6saF+fM86WNR+j
         w08W4DMKl2Rk6B040BJwpplLNMjHXHEGEkEFkmuAF1tFffwUd5wZTtE9HNUHWsQMDnx0
         eBimUqPM+dgW0DzBvJxocJUQvr2Si5XwqXQptka98fLyMS3YjDCvUzSD6A5kHQwjLpKH
         bVrw==
X-Gm-Message-State: AIkVDXK3mL/Jy9lxPpEVo9x/bkF8H0vipcgiPjneQDkaeN7zO5XyikVihvtHc+7u+KPYcA==
X-Received: by 10.84.195.1 with SMTP id i1mr137643849pld.84.1483473455525;
        Tue, 03 Jan 2017 11:57:35 -0800 (PST)
Received: from localhost.localdomain ([103.57.70.69])
        by smtp.gmail.com with ESMTPSA id d1sm141708387pfb.76.2017.01.03.11.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:57:34 -0800 (PST)
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Cc:     luke@diamand.org, sbeller@google.com, j6t@kdbg.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v3 2/2] t9813: avoid using pipes
Date:   Wed,  4 Jan 2017 01:27:08 +0530
Message-Id: <20170103195708.15157-2-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170103195708.15157-1-pranit.bauva@gmail.com>
References: <20170103195708.15157-1-pranit.bauva@gmail.com>
In-Reply-To: <20170102184536.10488-1-pranit.bauva@gmail.com>
References: <20170102184536.10488-1-pranit.bauva@gmail.com>
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
index 798bf2b67..2133b21ae 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -118,12 +118,12 @@ test_expect_success 'not preserving user with mixed authorship' '
 		make_change_by_user usernamefile3 Derek derek@example.com &&
 		P4EDITOR=cat P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
-		git p4 commit |\
-		grep "git author derek@example.com does not match" &&
+		git p4 commit >actual &&
+		grep "git author derek@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 Charlie charlie@example.com &&
-		git p4 commit |\
-		grep "git author charlie@example.com does not match" &&
+		git p4 commit >actual &&
+		grep "git author charlie@example.com does not match" actual &&
 
 		make_change_by_user usernamefile3 alice alice@example.com &&
 		git p4 commit >actual 2>&1 &&
-- 
2.11.0

