Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C84C4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 14:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiK0Ovy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK0Ovu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 09:51:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF28F5B4
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mv18so7321413pjb.0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s73inz+hL/qzrdnJIjod5Cw4978ryXX2X0AepTvKRZU=;
        b=YZDNlus3i6TQeBOMeVRdAT6PLlvdjJKraYgYhheg7DcxKT8MGrXUmm+Wz3j+hijUaK
         e9XwIdsTR0H0SjqL7VkzkhW8HvuOnPDCmpDACYNe6C1SIlg7jacB54BYQsIgB51sj9PZ
         oOyOHfdU0Tz8AI6yCA1FSIy0OYBKGG7g4zPnZIqBwInQBJMk5xQ3O1vK5OueRPSGZj4t
         V3yDDQByinS2so6C4l+YmtwgbzhBAWGvZ4mpGTXY8a1OVMYM37BtkJ46u+eeUUolclO0
         JKsgQalgbMSMf1XYrCeJtKSnb+4ccHfqtwpWaM7nTxbZMOUfVgE6dnRK1BzoaZwbVNEL
         +Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s73inz+hL/qzrdnJIjod5Cw4978ryXX2X0AepTvKRZU=;
        b=oIZF2y8Br+AaLgxm4psWYMp5os34Wb6Tkglcjw7Pw88W8JUZmwP25Zn/LbLsoerfgo
         La7wAp/eLGfdRTqS1dvmetzWCcrbfyCWTV0iNUvneYsMplF580BxAJPOyoThE0FlDtDJ
         UTJN7pnma1AJx3w1zkHaCCGRoVxbnhIxH+sGcLJYbKeaQU/6YI5Vso6LKoVmE9oV/Ly/
         SFcRm0T8FgbscibTlHvSH4awly5aprjBF1iWXCzUFjjNy8v504iNlYw/jjt5EHzTyXw5
         tjDU5yh17Xi3ATLgHwaEI8QXp7lineNQkoHHzMG6nD6Bi98afyez1vP2MoIvvUyvgI6K
         zphA==
X-Gm-Message-State: ANoB5pnKN9Z8Q9ut5GhHoe3ajmsvbuRvQNUQ3GyifO6eQsxSNoY41BQy
        6mVw4bwisWWsGSIzXekYN8xBhUgAOBM=
X-Google-Smtp-Source: AA0mqf6pRHXtbzm893Nqw+tlyh+Q33B7ABd38tHtLWkRCNiXIA7eX9ALtrHwBA1w77Dfjr+XH1Weog==
X-Received: by 2002:a17:902:bd83:b0:180:87d7:9be8 with SMTP id q3-20020a170902bd8300b0018087d79be8mr40406456pls.85.1669560709496;
        Sun, 27 Nov 2022 06:51:49 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a058800b002137d3da760sm7915050pji.39.2022.11.27.06.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:51:48 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Heikki Orsila <heikki.orsila@iki.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v1 3/4] t1301: wrap the statements in the for loop
Date:   Sun, 27 Nov 2022 22:51:29 +0800
Message-Id: <20221127145130.16155-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221127145130.16155-1-worldhello.net@gmail.com>
References: <20221127145130.16155-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Wrap the statements which were introduced in commit 06cbe85503 (Make
core.sharedRepository more generic, 2008-04-16)) in the for loop in a
new test case, so if we want to skip some of the test cases, these
unwrapped statements won't affect the test cases we choose to run.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t1301-shared-repo.sh | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1225abbb6d..3ca91bf504 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -78,31 +78,28 @@ for u in	0660:rw-rw---- \
 		0666:rw-rw-rw- \
 		0664:rw-rw-r--
 do
-	x=$(expr "$u" : ".*:\([rw-]*\)") &&
-	y=$(echo "$x" | sed -e "s/w/-/g") &&
-	u=$(expr "$u" : "\([0-7]*\)") &&
-	git config core.sharedrepository "$u" &&
-	umask 0277 &&
+	test_expect_success POSIXPERM "set variables from $u" '
+		x=$(expr "$u" : ".*:\([rw-]*\)") &&
+		y=$(echo "$x" | sed -e "s/w/-/g") &&
+		u=$(expr "$u" : "\([0-7]*\)") &&
+		git config core.sharedrepository "$u"
+	'
 
 	test_expect_success POSIXPERM "shared = $u ($y) ro" '
-
+		umask 0277 &&
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$y"
-
 	'
 
-	umask 077 &&
 	test_expect_success POSIXPERM "shared = $u ($x) rw" '
-
+		umask 077 &&
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(test_modebits .git/info/refs)" &&
 		verbose test "x$actual" = "x-$x"
-
 	'
-
 done
 
 test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
-- 
2.39.0.rc0

