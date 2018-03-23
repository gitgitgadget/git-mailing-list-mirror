Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A241F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeCWVZv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:25:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45769 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeCWVZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:25:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id y63so1914282pgy.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=D/So/KqsGcwWRxmau1I/GcVL5B1WdeJ4UCS28nTAAlM=;
        b=YA5ERmBYlIT9jfrLjRLKYQzLsjaBTdrsJgho4Pp/kRKT9I7bElyHCJdSGuaNIUulOg
         37LeWBGbVZ2SSdRvvCHrAU8S/M6D8Ngc+CsEdMYsQSeFjJtQ+45JnqQDsZIBKTH93AgG
         W9fceaU5k7iNVA++N5MYYLWO6nZKT+9aeOR7KH1/IGFfuS9q3JKyTgia5CcTriRnNXd2
         Ab2rtD8q7sQCCKEFc+XZiRuwEBlIR4VkQEY7gcjkpvLNL7C3NnpukH2cw1NICXuydo1z
         L4eX4BtM+Epr4oFGHfHyFW1lmZ+TdlR9J8+R3qz9osrgawO8OPLBugxJJrVi3hT3yu0Q
         8VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D/So/KqsGcwWRxmau1I/GcVL5B1WdeJ4UCS28nTAAlM=;
        b=BZlH82K47h1z15A6eEs9xR5UWAAFGGITN+LFy/EEOiEEkQCmYpzVanaU+HdTbtA+QC
         aqbT2n+bsjHjXiuQX5H48bH33n6NrKEXP6AdyQB9svfV9JlbrjdXaFNhHzYCnaU+wFEY
         v+9ZKstgn5q3fwxMkTtKF9MTEbQx+GEBGEvC2NsuCjvKa0PUqR/AzJ8WXshug1tswsh+
         ovYc5pbDEhSNKXPhowND2z5hXI5i3XaI8LFM8v3iEOqzETkNOnLuoevj9lMZpNKwvCwG
         1mRiAKR6ebx44kKiQ61uKwshzmsQtEe7voUuHZ2WRDrQa33AAgzdm67EM/jI93IxoqJm
         6MGA==
X-Gm-Message-State: AElRT7EGAsVlug3dmHBRXPCO4up8vkeYGu9AEVM2kLOPX2Cpcbj36h/O
        /MrQyRvAw7a2YLVaE2FTaNd7xp84c4Y=
X-Google-Smtp-Source: AG47ELuRT124AT1eB+AlGNnyiKlTyyzjUHw8itlDtc9nREemcWBMFUx33W+HBs1GxpzvRH73K9ZqLg==
X-Received: by 10.98.85.197 with SMTP id j188mr25220589pfb.86.1521840348868;
        Fri, 23 Mar 2018 14:25:48 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id z28sm15380096pgc.15.2018.03.23.14.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:25:47 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gister@pobox.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v5 2/8] rebase: update invocation of rebase dot-sourced scripts
Date:   Fri, 23 Mar 2018 14:25:23 -0700
Message-Id: <693aa1c256cd7d4a22a5ac7ca5fbea386210ce49.1521839546.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521839546.git.wink@saville.com>
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to historical reasons, the backend scriptlets for "git rebase"
are structured a bit unusually. As originally designed,
dot-sourcing them from "git rebase" was sufficient to invoke the
specific backend.

However, it was later discovered that some shell implementations
(e.g. FreeBSD 9.x) misbehaved by continuing to execute statements
following a top-level "return" rather than returning control to
the next statement in "git rebase" after dot-sourcing the
scriptlet. To work around this shortcoming, the whole body of
git-rebase--$backend.sh was made into a shell function
git_rebase__$backend, and then the very last line of the scriptlet
called that function.

A more normal architecture is for a dot-sourced scriptlet merely
to define functions (thus acting as a function library), and for
those functions to be called by the script doing the dot-sourcing.
Migrate to this arrangement by moving the git_rebase__$backend
call from the end of a scriptlet into "git rebase" itself.

While at it, remove the large comment block from each scriptlet
explaining this historic anomaly since it serves no purpose under
the new normalized architecture in which a scriptlet is merely a
function library.

Signed-off-by: Wink Saville <wink@saville.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-rebase--am.sh          | 11 -----------
 git-rebase--interactive.sh | 11 -----------
 git-rebase--merge.sh       | 11 -----------
 git-rebase.sh              |  1 +
 4 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index be3f06892..e5fd6101d 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,15 +4,6 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__am () {
 
 case "$action" in
@@ -105,5 +96,3 @@ fi
 move_to_original_branch
 
 }
-# ... and then we call the whole thing.
-git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 561e2660e..213d75f43 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -740,15 +740,6 @@ get_missing_commit_check_level () {
 	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__interactive () {
 
 case "$action" in
@@ -1029,5 +1020,3 @@ fi
 do_rest
 
 }
-# ... and then we call the whole thing.
-git_rebase__interactive
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index ceb715453..685f48ca4 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -104,15 +104,6 @@ finish_rb_merge () {
 	say All done.
 }
 
-# The whole contents of this file is run by dot-sourcing it from
-# inside a shell function.  It used to be that "return"s we see
-# below were not inside any function, and expected to return
-# to the function that dot-sourced us.
-#
-# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
-# construct and continue to run the statements that follow such a "return".
-# As a work-around, we introduce an extra layer of a function
-# here, and immediately call it after defining it.
 git_rebase__merge () {
 
 case "$action" in
@@ -171,5 +162,3 @@ done
 finish_rb_merge
 
 }
-# ... and then we call the whole thing.
-git_rebase__merge
diff --git a/git-rebase.sh b/git-rebase.sh
index a1f6e5de6..6edf8c5b1 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -197,6 +197,7 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
+	git_rebase__$type
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
2.16.2

