Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEF120958
	for <e@80x24.org>; Sun, 26 Mar 2017 12:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdCZMRI (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 08:17:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35752 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZMRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 08:17:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so1962372wrc.2
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+zt/L8uiYmYuon9eZm6u/S53MeUaidWKjuQSASPDpEI=;
        b=lViD9fChiUq3cCd4Kk1fVsqxior+IKrtcWSGanzTRwktrp2TVp481AONN6/mRrmKlW
         WU9RM2zH7VQelvP7ohsx6TDxhZnodmhldYakR9endxA+6VExv6bvD10MAZKBlte3z0zh
         ngeHF5NCtzjRXCfAXXNpeUUH7IlLq6WF1osU7GVH6zwL2JkdVWCmKfJni3lPRh6/hwHo
         C5eZy18I7ybvoO1hTlRujh/PDnk9Af52Hr1AKKV9phrDXq3oLaTb9/hCvgbb77FAWikO
         ZsqQVlk4gNamq1LjY6PX6yFnJqGfYT6e25N0RAsMhOEoGlXhG2genPd+KvFoiZhES5uq
         TmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+zt/L8uiYmYuon9eZm6u/S53MeUaidWKjuQSASPDpEI=;
        b=Q97nL9c/HjeZPQd7AXwYZpMtBqzFVY4vbB04CIQpuvgPEvEM0eAmYQstADqcaUAdfJ
         +AgADrP3HJTHaU3dQK4uWkru4//YMoCtak+ofpv0dfKz8A5rtJivyI+ByY44nz9BFGXq
         V9G6zAhemck818wNWZ5aPg/rzKN1sQnBsh+DH38Tk3SR567WXFSYr7hSKl/1Z7wa+hld
         3fou1i9jsQD95SBMp3dhic+SP0WUJ6Avn2DvWWIpX0QxYcENPwo4McwzCkq1+Ygo/0zS
         rMseLmNjiEbryzj6DHBAtUfzwAJWTL8jCpKdrsnMoXMl6V6pdO53jwzjKQjb0phBrG1F
         Oaow==
X-Gm-Message-State: AFeK/H1lMHoHxEPK73JvvEEzfZmk399eHH+s3n24CIx/lOF6qEokmJuS2xnyh//sEvyFOA==
X-Received: by 10.28.194.7 with SMTP id s7mr5173460wmf.136.1490530625425;
        Sun, 26 Mar 2017 05:17:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 134sm10167638wmj.6.2017.03.26.05.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Mar 2017 05:17:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] rev-parse: add @{p} as a synonym for @{push}
Date:   Sun, 26 Mar 2017 12:16:53 +0000
Message-Id: <20170326121654.22035-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326121654.22035-1-avarab@gmail.com>
References: <20170326121654.22035-1-avarab@gmail.com>
In-Reply-To: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
References: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add @{p} as a shorthand for @{push} for consistency with the @{u}
shorthand for @{upstream}.

This wasn't added when @{push} was introduced in commit
adfe5d0434 ("sha1_name: implement @{push} shorthand", 2015-05-21), but
it can be added without any ambiguity and saves the user some typing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/revisions.txt | 8 ++++----
 sha1_name.c                 | 2 +-
 t/t1514-rev-parse-push.sh   | 2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 09e0d51b9e..5fe90e411d 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -99,8 +99,8 @@ some output processing may assume ref names in UTF-8.
   current one. These suffixes are accepted when spelled in uppercase, and
   they mean the same thing no matter the case.
 
-'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
-  The suffix '@\{push}' reports the branch "where we would push to" if
+'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{p\}'::
+  The suffix '@\{push}' (short form '@\{push}') reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Since our push destination is
   in a remote repository, of course, we report the local tracking branch
@@ -124,8 +124,8 @@ Note in the example that we set up a triangular workflow, where we pull
 from one location and push to another. In a non-triangular workflow,
 '@\{push}' is the same as '@\{upstream}', and there is no need for it.
 +
-This suffix is accepted when spelled in uppercase, and means the same
-thing no matter the case.
+These suffixes are accepted when spelled in uppercase, and they mean
+the same thing no matter the case.
 
 '<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
diff --git a/sha1_name.c b/sha1_name.c
index d9d1b2fce8..2deb9bfdf6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -563,7 +563,7 @@ static inline int upstream_mark(const char *string, int len)
 
 static inline int push_mark(const char *string, int len)
 {
-	const char *suffix[] = { "@{push}" };
+	const char *suffix[] = { "@{push}", "@{p}" };
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 788cc91e45..db9aaf88f8 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -31,6 +31,8 @@ test_expect_success '@{push} with default=nothing' '
 
 test_expect_success '@{push} with default=simple' '
 	test_config push.default simple &&
+	resolve master@{p} refs/remotes/origin/master &&
+	resolve master@{P} refs/remotes/origin/master &&
 	resolve master@{push} refs/remotes/origin/master &&
 	resolve master@{PUSH} refs/remotes/origin/master &&
 	resolve master@{pUSh} refs/remotes/origin/master
-- 
2.11.0

